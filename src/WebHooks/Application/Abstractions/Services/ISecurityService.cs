using WebHooks.Domain.Requests;
using WebHooks.Domain.Responses;

namespace WebHooks.Application.Abstractions.Services;

public interface ISecurityService
{
    Task<bool> RegisterAsync(RegisterRequest request);
    Task<TokenResponse> LoginAsync(CredentialRequest credential, string clientNode);
    Task<TokenResponse> RefreshTokenAsync(RefreshRequest request);
    Task<(bool IsValid, bool IsExpired, bool HasRefreshToken)> ValidateTokenAsync(string token);
}
