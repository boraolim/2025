using Hogar.HR.Domain.Responses;

namespace Hogar.HR.Domain.Requests;

public record CredentialRequest
(
    string UserName,
    string PasswordValue
) : IRequest<TokenResponse>;

public record RefreshRequest
(
    string AccessToken,
    string RefreshToken
) : IRequest<TokenResponse>;

public record RegisterRequest
(
    string Username,
    string Password,
    string Fullname
) : IRequest<bool>;
