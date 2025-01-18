using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;

namespace Hogar.HR.Application.Abstractions;

public interface ISecurityService
{
    Task<bool> RegisterAsync(RegisterRequest request);
    Task<TokenResponse> LoginAsync(CredentialRequest credential, string clientNode);
    Task<TokenResponse> RefreshTokenAsync(RefreshRequest request);
    Task<(bool IsValid, bool IsExpired, bool HasRefreshToken)> ValidateTokenAsync(string token);
}
