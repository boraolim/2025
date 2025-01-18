using Core.Domain.Common;
using Core.Application.DTO;
using Core.Utils.Functions;
using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;
using Core.Utils.CustomExceptions;
using Hogar.HR.Application.Abstractions;
using Core.Application.Abstractions.Helpers;
using Core.Application.Abstractions.Security;
using Core.Application.Abstractions.Management;

using FormatConstantsCore = Core.Domain.Constants.FormatConstants;
using MainConstantsLocal = Hogar.HR.Domain.Constants.MainConstants;
using MessageConstantsLocal = Hogar.HR.Domain.Constants.MessageConstants;
using EnvironmentConstantsCore = Core.Domain.Constants.EnvironmentConstants;

namespace Hogar.HR.Common.Services;

public class SecurityService : ISecurityService
{
    private string SecretKey { get; set; }
    private string KeyAPILocal { get; set; }

    private readonly ICypherAes _cypherAes;
    private readonly IJwtService _jwtService;
    private readonly ICacheService _cacheService;
    private readonly IUserMapper _userMapper;
    private readonly IEnvironmentReader _environmentReader;
    private readonly ICurrentUserService _currentUserService;
    private readonly ISecurityRepository _securityRepository;

    public SecurityService(ICypherAes cypherAes,
                           IJwtService jwtService,
                           ICacheService cacheService,
                           IUserMapper userMapper,
                           IEnvironmentReader environmentReader,
                           ICurrentUserService currentUserService,
                           ISecurityRepository securityRepository)
    {
        _cypherAes = Guard.Against.Null(cypherAes);
        _jwtService = Guard.Against.Null(jwtService);
        _cacheService = Guard.Against.Null(cacheService);
        _userMapper = Guard.Against.Null(userMapper);
        _environmentReader = Guard.Against.Null(environmentReader);
        _currentUserService = Guard.Against.Null(currentUserService);
        _securityRepository = Guard.Against.Null(securityRepository);
        ReadValues();
    }

    private void ReadValues()
    {
        SecretKey = new string(_environmentReader.GetVariable(EnvironmentConstantsCore.CFG_BASE_KEY_WEBHOOK_APP).MessageDescription.ToArray());
        KeyAPILocal = new string(SecretKey.Take(32).ToArray());
    }

    public async Task<bool> RegisterAsync(RegisterRequest request)
    {
        var existeUsuario = await _securityRepository.GetAccountByUserName(request.Username);

        if(!existeUsuario.CheckIsNull())
            throw new CustomException(MessageConstantsLocal.MSG_ALREADY_EXIST_ACCOUNT);

        return await _securityRepository.Register(_userMapper.DtoToEntity(_userMapper.RegisterToDto(request))) > 0;
    }

    public async Task<TokenResponse> LoginAsync(CredentialRequest credential, string clientNode)
    {
        var existeUsuario = await _securityRepository.GetAccountByUserName(credential.UserName);

        if(existeUsuario.CheckIsNull())
            throw new EntityNotFoundException(MessageConstantsLocal.MSG_USER_NAME_NOT_FOUND);

        if(credential.PasswordValue != _cypherAes.AESDecryptionGCM(existeUsuario.UserSecret))
            throw new UnauthorizedAccessException(MessageConstantsLocal.MSG_PASSWORD_MISMATCH);

        if(existeUsuario.FlagState != Core.Domain.Enums.FlagState.ACTIVE)
            throw new UnauthorizedAccessException(MessageConstantsLocal.MSG_USER_INACTIVE);

        var refreshTokenData = await _jwtService.GenerateTokenAsync(credential.UserName, clientNode, existeUsuario.Id.ToString());
        var arrayRefresh = refreshTokenData.Split(FormatConstantsCore.CFG_VALUE_PIPE);
        var newTokenSettings = new JwtValueDto()
        {
            UserName = credential.UserName,
            IdClient = existeUsuario.Id,
            RefreshValue = arrayRefresh[1],
            FullName = existeUsuario.UserFullName.ToUpper(),
            TokenId = Guid.Parse(arrayRefresh[0], CultureInfo.InvariantCulture),
            KeyAPI = KeyAPILocal
        };
        var newToken = await _jwtService.GenerateNewTokenAsync(newTokenSettings);

        _cacheService.PutInCache(string.Format(FormatConstantsCore.CFG_SESSION_ID, newTokenSettings.IdClient.ToString()),
            _cypherAes.AESEncryptionGCM(JsonSerializer.Serialize(new SessionCurrent()
            {
                UserId = newTokenSettings.IdClient.ToString(),
                FullName = newTokenSettings.FullName,
                IsAuthenticated = true,
                RefrehToken = newTokenSettings.RefreshValue,
                IpAddress = _currentUserService.IpAddress
            }, new JsonSerializerOptions { WriteIndented = true })));

        return new TokenResponse(newToken, arrayRefresh[1]);
    }

    public async Task<TokenResponse> RefreshTokenAsync(RefreshRequest request)
    {
        var refreshTokenData = await _jwtService.GetDetailFromTokenAsync(request.AccessToken);

        var userName = refreshTokenData.claims.Claims.ToArray()[0].Value;
        var userId = refreshTokenData.claims.Claims.ToArray()[1].Value;
        var tokenId = refreshTokenData.claims.Claims.ToArray()[2].Value;
        var fullName = refreshTokenData.claims.Claims.ToArray()[5].Value;
        var encryptedRefreshToken = await _securityRepository.GetTokenValueToRefresh(userName, tokenId);

        if(string.IsNullOrEmpty(encryptedRefreshToken))
            throw new CustomException(string.Format(MessageConstantsLocal.MSG_TOKEN_CURRENT_NOT_FOUND, userName));

        var refreshToken = _cypherAes.AESDecryptionGCM(encryptedRefreshToken);

        if(request.RefreshToken != refreshToken)
            throw new CustomException(MessageConstantsLocal.MSG_TOKEN_REFREST_MISMATCH);

        var isExpiredFromDb = await _securityRepository.GetStatusExpiration(tokenId);

        if(isExpiredFromDb != DateTime.UtcNow > DateTimeUtils.GetDateFromLinuxDateTime(long.Parse(refreshTokenData.claims.Claims.SingleOrDefault(t => t.Type.ToString() == "exp").Value, CultureInfo.InvariantCulture)))
            throw new CustomException(MessageConstantsLocal.MSG_TOKEN_EXPIRED_MISMATCH);

        var resultUpdated = await UpdateRefreshToken(tokenId, userName, isExpiredFromDb, _currentUserService.IpAddress, _currentUserService.UserId);
        var arrayTokens = resultUpdated.Split(FormatConstantsCore.CFG_VALUE_PIPE);

        var newTokenSettings = new JwtValueDto()
        {
            UserName = userName,
            IdClient = Guid.Parse(userId, CultureInfo.InvariantCulture),
            RefreshValue = arrayTokens[1],
            FullName = fullName.ToUpper(),
            TokenId = Guid.Parse(arrayTokens[0], CultureInfo.InvariantCulture),
            KeyAPI = KeyAPILocal
        };
        var newToken = await _jwtService.GenerateNewTokenAsync(newTokenSettings);

        _cacheService.PutInCache(string.Format(FormatConstantsCore.CFG_SESSION_ID, newTokenSettings.IdClient.ToString()),
            _cypherAes.AESEncryptionGCM(JsonSerializer.Serialize(new SessionCurrent()
            {
                UserId = newTokenSettings.IdClient.ToString(),
                FullName = newTokenSettings.FullName,
                IsAuthenticated = true,
                RefrehToken = newTokenSettings.RefreshValue,
                IpAddress = _currentUserService.IpAddress
            }, new JsonSerializerOptions { WriteIndented = true })));

        return new TokenResponse(newToken, arrayTokens[1]);
    }

    public async Task<(bool IsValid, bool IsExpired, bool HasRefreshToken)> ValidateTokenAsync(string token) =>
        await _jwtService.ValidateTokenAsync(new JwtValidateDto { TokenValue = token, KeyAPI = KeyAPILocal });

    #region "Métodos privados."

    private async Task<string> UpdateRefreshToken(string idToken, string userName, bool isExpired, string direccionIp, string author)
    {
        var updateIdToken = string.Empty;

        if(isExpired)
        {
            var rnd = new Random();
            var tokenString = string.Empty;
            var newRefreshToken = new byte[40];
            rnd.NextBytes(newRefreshToken);
            tokenString = Convert.ToBase64String(newRefreshToken);
            var updateGuidToken = await _securityRepository.SaveRefreshToken(idToken, userName, _cypherAes.AESEncryptionGCM(tokenString), direccionIp, author);
            updateIdToken = string.Format(MainConstantsLocal.CFG_JWT_ARRAYTOKENS, updateGuidToken.ToString(), FormatConstantsCore.CFG_VALUE_PIPE, tokenString);
        }
        else
        {
            updateIdToken = await _securityRepository.SaveAndClearExpiration(idToken, userName, author);
            var arrayTokens = updateIdToken.Split(FormatConstantsCore.CFG_VALUE_PIPE);
            updateIdToken = string.Format(MainConstantsLocal.CFG_JWT_ARRAYTOKENS, arrayTokens[0], FormatConstantsCore.CFG_VALUE_PIPE, _cypherAes.AESDecryptionGCM(arrayTokens[1]));
        }

        return updateIdToken;
    }

    #endregion
}
