using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public sealed class GetConfigurationUserHandler : IRequestHandler<ActionConfigurationUserRequest, List<ConfigurationUserResponse>>
{
    private readonly IManagementService _managementService;
    
    public GetConfigurationUserHandler(IManagementService managementService) =>
        _managementService = Guard.Against.Null(managementService);

    public async Task<List<ConfigurationUserResponse>> Handle(ActionConfigurationUserRequest request, CancellationToken cancellationToken) =>
        await _managementService.GetConfigurationToUser(request);
}
