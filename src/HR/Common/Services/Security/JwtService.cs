using Core.Domain.Common;
using Core.Application.DTO;
using Core.Application.Settings;
using Hogar.HR.Application.Abstractions;
using Core.Application.Abstractions.Helpers;
using Core.Application.Abstractions.Security;

using FormatConstantsCore = Core.Domain.Constants.FormatConstants;
using MainConstantsLocal = Hogar.HR.Domain.Constants.MainConstants;
using MessageConstantsCore = Core.Domain.Constants.MessageConstants;
using EnvironmentConstantsCore = Core.Domain.Constants.EnvironmentConstants;

using JwtRegisteredClaimNames = Microsoft.IdentityModel.JsonWebTokens.JwtRegisteredClaimNames;

namespace Hogar.HR.Common.Services;

public class JwtService : IJwtService
{
    private string SecretKey { get; set; }
    private string KeyAPILocal { get; set; }

    private readonly JwtSettings _settings;
    private readonly ICypherAes _cypherAes;
    private readonly IEnvironmentReader _environmentReader;
    private readonly ISecurityRepository _securityRepository;

    public JwtService(ICypherAes cypherAes,
                      IOptions<JwtSettings> options,
                      IEnvironmentReader environmentReader,
                      ISecurityRepository securityRepository)
    {
        (_cypherAes, _settings, _securityRepository, _environmentReader) =
        (Guard.Against.Null(cypherAes),
         Guard.Against.Null(options).Value,
         Guard.Against.Null(securityRepository),
         Guard.Against.Null(environmentReader));
        ReadValues();
    }

    private void ReadValues()
    {
        SecretKey = new string(_environmentReader.GetVariable(EnvironmentConstantsCore.CFG_BASE_KEY_WEBHOOK_APP).MessageDescription.ToArray());
        KeyAPILocal = new string(SecretKey.Take(32).ToArray());
    }

    public async Task<string> GenerateNewTokenAsync(JwtValueDto inputJwtSetting)
    {
        byte[] TokenKey; var newToken = string.Empty;

        await Task.Run(() =>
        {
            var claims = new Dictionary<string, object>();
            claims.Add(JwtRegisteredClaimNames.Sub, inputJwtSetting.UserName.Trim());
            claims.Add(JwtRegisteredClaimNames.Jti, inputJwtSetting.IdClient.ToString());
            claims.Add(MainConstantsLocal.CFG_JWT_TOKEN_ID, inputJwtSetting.TokenId.ToString());
            claims.Add(MainConstantsLocal.CFG_JWT_CREATE_AT, DateTime.Now.ToString());
            claims.Add(MainConstantsLocal.CFG_JWT_NONCE_VALUE, _cypherAes.Nonce);
            claims.Add(MainConstantsLocal.CFG_JWT_FULL_NAME_VALUE, inputJwtSetting.FullName);
            claims.Add(MainConstantsLocal.CFG_JWT_REFRESH_VALUE, _cypherAes.AESEncryptionGCM(inputJwtSetting.RefreshValue));

            var key = new SymmetricSecurityKey(Convert.FromBase64String(_settings.ClientSecretKey));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            using(var item = SHA256.Create())
            {
                TokenKey = item.ComputeHash(Convert.FromBase64String(inputJwtSetting.KeyAPI));
            }

            var EncTokenKey = new EncryptingCredentials(new SymmetricSecurityKey(TokenKey),
                SecurityAlgorithms.Aes256KW,
                SecurityAlgorithms.Aes256CbcHmacSha512);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Expires = DateTime.UtcNow.AddMinutes(_settings.DurationLifeTime),
                SigningCredentials = creds,
                EncryptingCredentials = EncTokenKey,
                Audience = _cypherAes.AESDecryptionGCM(_settings.Audience),
                Issuer = _cypherAes.AESDecryptionGCM(_settings.Issuer),
                IssuedAt = DateTime.UtcNow,
                Claims = claims
            };

            var token = new JwtSecurityTokenHandler().CreateToken(tokenDescriptor);
            newToken = new JwtSecurityTokenHandler().WriteToken(token);
        }).ConfigureAwait(false);

        return newToken;
    }

    public async Task<string> GenerateTokenAsync(string userName, string direccionIp, string author)
    {
        var rnd = new Random();
        var tokenString = string.Empty;
        var newRefreshToken = new byte[40];
        rnd.NextBytes(newRefreshToken);
        tokenString = Convert.ToBase64String(newRefreshToken);
        var idToken = await _securityRepository.SaveNewToken(_cypherAes.AESEncryptionGCM(tokenString), userName, direccionIp, author);
        return string.Format(MainConstantsLocal.CFG_JWT_ARRAYTOKENS, idToken.ToString(), FormatConstantsCore.CFG_VALUE_PIPE, tokenString);
    }

    public async Task<(Guid id, ClaimsPrincipal claims)> GetDetailFromTokenAsync(string Token) =>
        await GetClaimsFromTokenAsync(new JwtValidateDto() { TokenValue = Token, KeyAPI = KeyAPILocal });

    public async Task<(Guid id, ClaimsPrincipal claims)> GetClaimsFromTokenAsync(JwtValidateDto token)
    {
        var (id, claims) = (Guid.Empty, new ClaimsPrincipal());

        try
        {
            await Task.Run(() =>
            {
                byte[] TokenKey;
                using(var item = SHA256.Create())
                {
                    TokenKey = item.ComputeHash(Convert.FromBase64String(token.KeyAPI));
                }
                var tokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidIssuer = _cypherAes.AESDecryptionGCM(_settings.Issuer),
                    ValidAudience = _cypherAes.AESDecryptionGCM(_settings.Audience),
                    IssuerSigningKey = new SymmetricSecurityKey(Convert.FromBase64String(_settings.ClientSecretKey)),
                    ValidateLifetime = false,
                    TokenDecryptionKey = new SymmetricSecurityKey(TokenKey)
                };

                var tokenHandler = new JwtSecurityTokenHandler();
                SecurityToken validatedToken;
                var principal = tokenHandler.ValidateToken(token.TokenValue, tokenValidationParameters, out validatedToken);

                if(validatedToken is not JwtSecurityToken)
                    throw new SecurityTokenException(MessageConstantsCore.MSG_ERR_JWT_IS_NOT);

                var jwtSecurityToken = validatedToken as JwtSecurityToken;

                if(!jwtSecurityToken.CheckIsNull() && !principal.CheckIsNull())
                {
                    claims = principal;
                    var idClaim = jwtSecurityToken.Claims.FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Jti);
                    id = !idClaim.CheckIsNull() ? Guid.Parse(idClaim.Value) : Guid.Empty;
                }
            }).ConfigureAwait(false);
        }
        catch(SecurityTokenExpiredException ex)
        {
            throw new SecurityTokenExpiredException(MessageConstantsCore.MSG_ERR_TOKEN_EXPIRED, ex);
        }
        catch(SecurityTokenInvalidSignatureException ex)
        {
            throw new SecurityTokenInvalidSignatureException(MessageConstantsCore.MSG_ERR_SIGN_TOKEN_INVALID, ex);
        }
        catch(SecurityTokenInvalidAudienceException ex)
        {
            throw new SecurityTokenInvalidAudienceException(MessageConstantsCore.MSG_ERR_AUDIENCIE_TOKEN_INVALID, ex);
        }
        catch(SecurityTokenInvalidIssuerException ex)
        {
            throw new SecurityTokenInvalidIssuerException(MessageConstantsCore.MSG_ERR_ISSUER_TOKEN_INVALID, ex);
        }
        catch(SecurityTokenException ex)
        {
            throw new SecurityTokenException(string.Format(MessageConstantsCore.MSG_ERR_TOKEN_GENERAL, ex.Message), ex);
        }
        catch(FormatException ex)
        {
            throw new FormatException(string.Format(MessageConstantsCore.MSG_ERR_TOKEN_WHILE_CYPHER, ex.Message), ex);
        }

        return (id, claims);
    }

    public async Task<(bool IsValid, bool IsExpired, bool HasRefreshToken)> ValidateTokenAsync(JwtValidateDto token)
    {
        var (IsValid, IsExpired, HasRefreshToken) = (false, false, false);

        try
        {
            await Task.Run(() =>
            {
                byte[] TokenKey;
                using(var item = SHA256.Create())
                {
                    TokenKey = item.ComputeHash(Convert.FromBase64String(token.KeyAPI));
                }
                var tokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidIssuer = _cypherAes.AESDecryptionGCM(_settings.Issuer),
                    ValidAudience = _cypherAes.AESDecryptionGCM(_settings.Audience),
                    IssuerSigningKey = new SymmetricSecurityKey(Convert.FromBase64String(_settings.ClientSecretKey)),
                    ValidateLifetime = false,
                    TokenDecryptionKey = new SymmetricSecurityKey(TokenKey)
                };

                var tokenHandler = new JwtSecurityTokenHandler();
                SecurityToken validatedToken;
                var principal = tokenHandler.ValidateToken(token.TokenValue, tokenValidationParameters, out validatedToken);

                if(validatedToken is not JwtSecurityToken)
                    throw new SecurityTokenException(MessageConstantsCore.MSG_ERR_JWT_IS_NOT);

                var jwtSecurityToken = validatedToken as JwtSecurityToken;

                if(!jwtSecurityToken.CheckIsNull() && !principal.CheckIsNull())
                {
                    IsValid = true;
                    IsExpired = jwtSecurityToken.ValidTo < DateTime.UtcNow;
                    var refreshClaim = jwtSecurityToken.Claims.FirstOrDefault(c => c.Type == MainConstantsLocal.CFG_JWT_REFRESH_VALUE);
                    HasRefreshToken = !refreshClaim.CheckIsNull();
                }
            }).ConfigureAwait(false);
        }
        catch(SecurityTokenExpiredException)
        {
            (IsValid, IsExpired, HasRefreshToken) = (true, true, false);
        }
        catch
        {
            (IsValid, IsExpired, HasRefreshToken) = (false, false, false);
        }

        return (IsValid, IsExpired, HasRefreshToken);
    }
}
