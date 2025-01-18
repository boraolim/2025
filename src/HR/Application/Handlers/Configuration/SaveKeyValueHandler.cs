using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Application.Handlers;

public sealed class SaveKeyValueHandler : IRequestHandler<AddKeyValueRequest, bool>
{
    private readonly IConfigurationService _configurationService;

    public SaveKeyValueHandler(IConfigurationService configurationService) =>
        _configurationService = Guard.Against.Null(configurationService);

    public async Task<bool> Handle(AddKeyValueRequest request, CancellationToken cancellationToken) =>
        await _configurationService.SaveKeyValue(request);
}
