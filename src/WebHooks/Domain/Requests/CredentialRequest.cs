using WebHooks.Domain.Responses;

namespace WebHooks.Domain.Requests;

public record CredentialRequest
(
    string UserName,
    string PasswordValue
) : IRequest<TokenResponse>;
