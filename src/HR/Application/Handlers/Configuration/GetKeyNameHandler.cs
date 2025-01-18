using Core.Domain.Common;
using Core.Utils.Functions;
using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;
using Hogar.HR.Application.Abstractions;
using Core.Application.Abstractions.Management;

namespace Hogar.HR.Application.Handlers;

public sealed class GetKeyNameHandler : IRequestHandler<KeyNameRequest, ConfigurationResponse>
{
    private readonly ICacheService _cacheService;
    private readonly IConfigurationService _configurationService;

    public GetKeyNameHandler(ICacheService cacheService,
                              IConfigurationService configurationService) =>
        (_cacheService, _configurationService) = (Guard.Against.Null(cacheService), Guard.Against.Null(configurationService));

    public async Task<ConfigurationResponse> Handle(KeyNameRequest request, CancellationToken cancellationToken)
    {
        var isCached = _cacheService.TryOrGetFromCache($"session_{request.KeyName}");

        if(!isCached.CheckIsNull())
            return await Task.FromResult(Functions.FormatearJsonStringToObject<ConfigurationResponse>(isCached));

        var result = await _configurationService.GetKeyName(request);
        _cacheService.PutInCache($"session_{request.KeyName}", result);
        return await Task.FromResult(result);
    }
}
