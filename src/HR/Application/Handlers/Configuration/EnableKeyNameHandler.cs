using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public sealed class EnableKeyNameHandler : IRequestHandler<EnableKeyNameRequest, bool>
{
    private readonly IConfigurationService _configurationService;

    public EnableKeyNameHandler(IConfigurationService configurationService) =>
        _configurationService = Guard.Against.Null(configurationService);

    public async Task<bool> Handle(EnableKeyNameRequest request, CancellationToken cancellationToken) =>
        await _configurationService.EnableKeyName(request);
}
