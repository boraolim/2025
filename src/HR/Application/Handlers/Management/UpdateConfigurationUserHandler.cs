using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public sealed class UpdateConfigurationUserHandler : IRequestHandler<UpdateConfigurationUserRequest, bool>
{
    private readonly IManagementService _managementService;

    public UpdateConfigurationUserHandler(IManagementService managementService) =>
        _managementService = Guard.Against.Null(managementService);

    public async Task<bool> Handle(UpdateConfigurationUserRequest request, CancellationToken cancellationToken) =>
        await _managementService.UpdateConfigurationToUser(request);
}
