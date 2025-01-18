using MediatR;
using Ardalis.GuardClauses;

using WebHooks.Domain.Requests;
using WebHooks.Application.Abstractions.Mappers;
using WebHooks.Application.Abstractions.Services;

namespace WebHooks.Application.Handlers;

public class RegisterHandler : IRequestHandler<RegisterRequest, bool>
{
    private readonly ISecurityService _securityService;

    public RegisterHandler(ISecurityService securityService) =>
        (_securityService) = (Guard.Against.Null(securityService));

    public async Task<bool> Handle(RegisterRequest request, CancellationToken cancellationToken) =>
        await _securityService.RegisterAsync(request);
}
