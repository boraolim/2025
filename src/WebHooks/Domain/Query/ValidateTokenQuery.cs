using MediatR;

using WebHooks.Domain.Responses;

namespace WebHooks.Domain.Query;

public record ValidateTokenQuery
(
    string Token
) : IRequest<TokenValidResponse>;
