using Core.Application.Settings;
using Core.Application.Abstractions.Management;

namespace Hogar.HR.Common.Services;

public class CacheService : ICacheService
{
    private readonly PollySettings _settings;
    private readonly ISyncCacheProvider _cacheProvider;

    public CacheService(ISyncCacheProvider cacheProvider,
                        IOptions<PollySettings> options) =>
        (_cacheProvider, _settings) = (Guard.Against.Null(cacheProvider), Guard.Against.Null(options).Value);

    public void PutInCache(string cacheKey, object? value)
    {
        var ttl = new Ttl(TimeSpan.FromMinutes(_settings.CacheDurationInMinutes), slidingExpiration: false);
        _cacheProvider.Put(cacheKey, value, ttl);
    }

    public object? TryOrGetFromCache(string cacheKey)
    {
        var (cacheHit, cachedObject) = _cacheProvider.TryGet(cacheKey);

        if(cacheHit && cachedObject != null)
            return cachedObject;

        return default;
    }
}

