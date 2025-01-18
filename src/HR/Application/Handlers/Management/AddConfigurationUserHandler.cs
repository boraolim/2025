using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public sealed class AddConfigurationUserHandler : IRequestHandler<AddConfigurationUserRequest, bool>
{
    private readonly IManagementService _managementService;

    public AddConfigurationUserHandler(IManagementService managementService) =>
        _managementService = Guard.Against.Null(managementService);

    public async Task<bool> Handle(AddConfigurationUserRequest request, CancellationToken cancellationToken) =>
        await _managementService.AddConfigurationToUser(request);
}
