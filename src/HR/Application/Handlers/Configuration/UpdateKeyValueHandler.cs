using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers.Configuration;

public sealed class UpdateKeyValueHandler : IRequestHandler<UpdateKeyValueRequest, bool>
{
    private readonly IConfigurationService _configurationService;

    public UpdateKeyValueHandler(IConfigurationService configurationService) =>
        _configurationService = Guard.Against.Null(configurationService);

    public async Task<bool> Handle(UpdateKeyValueRequest request, CancellationToken cancellationToken) =>
        await _configurationService.UpdateKeyValue(request);
}
