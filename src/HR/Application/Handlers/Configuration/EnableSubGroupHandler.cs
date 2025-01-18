using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public sealed class EnableSubGroupHandler : IRequestHandler<EnableSubGroupRequest, bool>
{
    private readonly IConfigurationService _configurationService;

    public EnableSubGroupHandler(IConfigurationService configurationService) =>
        _configurationService = Guard.Against.Null(configurationService);

    public async Task<bool> Handle(EnableSubGroupRequest request, CancellationToken cancellationToken) =>
        await _configurationService.EnableSubGroup(request);
}
