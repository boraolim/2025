using MediatR;

using WebHooks.Domain.Responses;

namespace WebHooks.Domain.Requests;

public record RefreshRequest
(
    string AccessToken,
    string RefreshToken
) : IRequest<TokenResponse>;
