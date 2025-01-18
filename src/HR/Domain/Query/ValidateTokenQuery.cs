using Hogar.HR.Domain.Responses;

namespace Hogar.HR.Domain.Query;

public record ValidateTokenQuery
(
    string Token
) : IRequest<TokenValidResponse>;
