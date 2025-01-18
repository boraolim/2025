namespace Core.Application.Implementations.Management;

public class MemoryCacheProvider : IAsyncCacheProvider, ISyncCacheProvider
{
    private readonly IMemoryCache _memoryCache;

    public MemoryCacheProvider(IMemoryCache memoryCache) =>
        _memoryCache = Guard.Against.Null(memoryCache);

    public void Put(string key, object? value, Ttl ttl)
    {
        var options = new MemoryCacheEntryOptions();
        var remaining = DateTimeOffset.MaxValue - DateTimeOffset.UtcNow;

        if(ttl.SlidingExpiration)
        {
            options.SlidingExpiration = (ttl.Timespan < remaining ? ttl.Timespan : remaining);
        }
        else
        {
            if(ttl.Timespan == TimeSpan.MaxValue)
                options.AbsoluteExpiration = DateTimeOffset.MaxValue;
            else
                options.AbsoluteExpirationRelativeToNow = ttl.Timespan < remaining ? ttl.Timespan : remaining;

            _memoryCache.Set(key, value, options);
        }
    }

    public Task PutAsync(string key, object? value, Ttl ttl, CancellationToken cancellationToken, bool continueOnCapturedContext)
    {
        cancellationToken.ThrowIfCancellationRequested();
        Put(key, value, ttl);
        return Task.CompletedTask;
    }

    public (bool, object?) TryGet(string key)
    {
        bool cacheHit = _memoryCache.TryGetValue(key, out var value);
        return (cacheHit, value);
    }

    public Task<(bool, object?)> TryGetAsync(string key, CancellationToken cancellationToken, bool continueOnCapturedContext)
    {
        cancellationToken.ThrowIfCancellationRequested();
        return Task.FromResult(TryGet(key));
    }
}
