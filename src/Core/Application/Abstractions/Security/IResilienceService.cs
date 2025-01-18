namespace Core.Application.Abstractions.Security;

public interface IResilienceService
{
    IAsyncPolicy<T> GetPolicy<T>(string policyKey);
}
