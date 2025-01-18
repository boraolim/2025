using WebHooks.Domain.Requests;
using WebHooks.Domain.Responses;
using WebHooks.Application.Abstractions.Services;

namespace WebHooks.Application.Handlers;

public sealed class CredentialHandler : IRequestHandler<CredentialRequest, TokenResponse>
{
    private readonly ISecurityService _securityService;
    private readonly IHttpContextAccessor _httpContextAccessor;

    public CredentialHandler(ISecurityService securityService, IHttpContextAccessor ihca) =>
        (_securityService, _httpContextAccessor) = (Guard.Against.Null(securityService), Guard.Against.Null(ihca));

    public async Task<TokenResponse> Handle(CredentialRequest request, CancellationToken cancellationToken)
    {
        var _HttpContx = _httpContextAccessor.HttpContext;
        return await _securityService.LoginAsync(request, _HttpContx.Connection.RemoteIpAddress.ToString());
    }   
}
