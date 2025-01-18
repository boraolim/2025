using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public class RegisterHandler : IRequestHandler<RegisterRequest, bool>
{
    private readonly ISecurityService _securityService;

    public RegisterHandler(ISecurityService securityService) =>
        _securityService = Guard.Against.Null(securityService);

    public async Task<bool> Handle(RegisterRequest request, CancellationToken cancellationToken) =>
        await _securityService.RegisterAsync(request);
}
