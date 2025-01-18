using Hogar.HR.Domain.Query;
using Hogar.HR.Domain.Responses;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public sealed class ValidateTokenHandler : IRequestHandler<ValidateTokenQuery, TokenValidResponse>
{
    private readonly ISecurityService _securityService;

    public ValidateTokenHandler(ISecurityService securityService) =>
        _securityService = Guard.Against.Null(securityService);

    public async Task<TokenValidResponse> Handle(ValidateTokenQuery request, CancellationToken cancellationToken)
    {
        var result = await _securityService.ValidateTokenAsync(request.Token);
        return new TokenValidResponse(result.IsValid, result.IsExpired, result.HasRefreshToken, "Token validado");
    }
}
