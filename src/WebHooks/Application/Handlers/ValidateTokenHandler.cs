using MediatR;
using Ardalis.GuardClauses;

using Core.Domain.Common;
using WebHooks.Domain.Query;
using WebHooks.Domain.Requests;
using WebHooks.Domain.Responses;
using WebHooks.Application.Abstractions.Services;

namespace WebHooks.Application.Handlers;

public sealed class ValidateTokenHandler : IRequestHandler<ValidateTokenQuery, TokenValidResponse>
{
    private readonly ISecurityService _securityService;

    public ValidateTokenHandler(ISecurityService securityService) =>
        (_securityService) = (Guard.Against.Null(securityService));

    public async Task<TokenValidResponse> Handle(ValidateTokenQuery request, CancellationToken cancellationToken)
    {
        var result = await _securityService.ValidateTokenAsync(request.Token);
        return new TokenValidResponse(result.IsValid, result.IsExpired, result.HasRefreshToken, "Token validado");
    }
}
