using Core.Application.DTO;

namespace Core.Application.Abstractions.Security;

public interface IJwtService
{
    Task<string> GenerateTokenAsync(string userName, string direccionIp, string author);
    Task<string> GenerateNewTokenAsync(JwtValueDto inputJwtSetting);
    Task<(bool IsValid, bool IsExpired, bool HasRefreshToken)> ValidateTokenAsync(JwtValidateDto token);
    Task<(Guid id, ClaimsPrincipal claims)> GetClaimsFromTokenAsync(JwtValidateDto token);
    Task<(Guid id, ClaimsPrincipal claims)> GetDetailFromTokenAsync(string Token);
}
