using Core.Domain.Common;
using Core.Utils.Functions;
using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;
using Hogar.HR.Application.Abstractions;
using Core.Application.Abstractions.Management;

namespace Hogar.HR.Application.Handlers;

public sealed class GetSubGroupHandler : IRequestHandler<SubGroupRequest, List<ConfigurationResponse>>
{
    private readonly ICacheService _cacheService;
    private readonly IConfigurationService _configurationService;

    public GetSubGroupHandler(ICacheService cacheService,
                              IConfigurationService configurationService) =>
        (_cacheService, _configurationService) = (Guard.Against.Null(cacheService), Guard.Against.Null(configurationService));

    public async Task<List<ConfigurationResponse>> Handle(SubGroupRequest request, CancellationToken cancellationToken)
    {
        var isCached = _cacheService.TryOrGetFromCache($"session_{request.SubGroupName}");

        if(!isCached.CheckIsNull())
            return await Task.FromResult(Functions.FormatearJsonStringToObject<List<ConfigurationResponse>>(isCached));

        var result = await _configurationService.GetConfigurationBySubGroup(request);
        _cacheService.PutInCache($"session_{request.SubGroupName}", result);
        return await Task.FromResult(result);
    }
}


