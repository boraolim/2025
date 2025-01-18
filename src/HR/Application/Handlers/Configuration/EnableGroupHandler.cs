using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public sealed class EnableGroupHandler : IRequestHandler<EnableGroupRequest, bool>
{
    private readonly IConfigurationService _configurationService;

    public EnableGroupHandler(IConfigurationService configurationService) =>
        _configurationService = Guard.Against.Null(configurationService);

    public async Task<bool> Handle(EnableGroupRequest request, CancellationToken cancellationToken) =>
        await _configurationService.EnableGroup(request);
}
