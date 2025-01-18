using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public sealed class LockConfigurationUserHandler : IRequestHandler<LockConfigurationUserRequest, bool>
{
    private readonly IManagementService _managementService;

    public LockConfigurationUserHandler(IManagementService managementService) =>
        _managementService = Guard.Against.Null(managementService);

    public async Task<bool> Handle(LockConfigurationUserRequest request, CancellationToken cancellationToken) =>
        await _managementService.LockConfigurationToUser(request);
}
