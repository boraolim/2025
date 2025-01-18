namespace Core.Application.Abstractions.Management;

public interface ICacheService
{
    object? TryOrGetFromCache(string cacheKey);
    void PutInCache(string cacheKey, object? value);
}

