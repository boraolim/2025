using Core.Domain.Common;
using Core.Utils.Functions;
using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;
using Hogar.HR.Application.Abstractions;
using Core.Application.Abstractions.Management;

namespace Hogar.HR.Application.Handlers;

public sealed class GetGroupHandler : IRequestHandler<GroupRequest, List<ConfigurationResponse>>
{
    private readonly ICacheService _cacheService;
    private readonly IConfigurationService _configurationService;

    public GetGroupHandler(ICacheService cacheService,
                           IConfigurationService configurationService) =>
        (_cacheService, _configurationService) = (Guard.Against.Null(cacheService), Guard.Against.Null(configurationService));

    public async Task<List<ConfigurationResponse>> Handle(GroupRequest request, CancellationToken cancellationToken)
    {
        var isCached = _cacheService.TryOrGetFromCache($"session_{request.GroupName}");

        if(!isCached.CheckIsNull())
            return await Task.FromResult(Functions.FormatearJsonStringToObject<List<ConfigurationResponse>>(isCached));

        var result = await _configurationService.GetConfigurationByGroup(request);
        _cacheService.PutInCache($"session_{request.GroupName}", result);
        return await Task.FromResult(result);
    }
}
