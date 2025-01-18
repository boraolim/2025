using WebHooks.Domain.Requests;
using WebHooks.Domain.Responses;
using WebHooks.Application.Abstractions.Services;

namespace WebHooks.Application.Handlers;

public sealed class RefreshTokenHandler : IRequestHandler<RefreshRequest, TokenResponse>
{
    private readonly ISecurityService _securityService;

    public RefreshTokenHandler(ISecurityService securityService) =>
        (_securityService) = (Guard.Against.Null(securityService));

    public async Task<TokenResponse> Handle(RefreshRequest request, CancellationToken cancellationToken) =>
        await _securityService.RefreshTokenAsync(request);
}
