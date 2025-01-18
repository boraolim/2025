using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public sealed class DisableConfigurationHandler : IRequestHandler<DisableConfigurationUserRequest, bool>
{
    private readonly IManagementService _managementService;

    public DisableConfigurationHandler(IManagementService managementService) =>
        _managementService = Guard.Against.Null(managementService);

    public async Task<bool> Handle(DisableConfigurationUserRequest request, CancellationToken cancellationToken) =>
        await _managementService.DisableConfigurationToUser(request);
}
