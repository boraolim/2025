using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public sealed class EnableConfigurationHandler : IRequestHandler<EnableConfigurationUserRequest, bool>
{
    private readonly IManagementService _managementService;

    public EnableConfigurationHandler(IManagementService managementService) =>
        _managementService = Guard.Against.Null(managementService);

    public async Task<bool> Handle(EnableConfigurationUserRequest request, CancellationToken cancellationToken) =>
        await _managementService.EnableConfigurationToUser(request);
}
