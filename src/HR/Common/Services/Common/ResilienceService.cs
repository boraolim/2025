using Core.Application.Settings;
using Core.Application.Abstractions.Security;

using MainConstantsLocal = Hogar.HR.Domain.Constants.MainConstants;

namespace Hogar.HR.Common.Services;

public class ResilienceService : IResilienceService
{
    private readonly PollySettings _settings;
    private readonly IPolicyRegistry<string> _policyRegistry;

    public ResilienceService(IOptions<PollySettings> options,
                        IMemoryCache memoryCache)
    {
        (_settings, _policyRegistry) =
        (Guard.Against.Null(options).Value, new PolicyRegistry());

        var retryPolicy = Policy.Handle<HttpRequestException>()
            .OrResult<HttpResponseMessage>(response => !response.IsSuccessStatusCode)
            .WaitAndRetryAsync(_settings.RetryCount, retryAttempt =>
                TimeSpan.FromSeconds(_settings.RetryDelayInSeconds * retryAttempt));

        _policyRegistry.Add(MainConstantsLocal.CFG_RETRY_POLICY, retryPolicy);

        var circuitBreakerPolicy = Policy.Handle<HttpRequestException>()
            .OrResult<HttpResponseMessage>(response => !response.IsSuccessStatusCode)
            .CircuitBreakerAsync(
                handledEventsAllowedBeforeBreaking: _settings.FailureThreshold,
                durationOfBreak: TimeSpan.FromSeconds(_settings.BreakDurationInSeconds));

        _policyRegistry.Add(MainConstantsLocal.CFG_CIRCUIT_BRAKER_POLICY, circuitBreakerPolicy);
    }

    public IAsyncPolicy<T> GetPolicy<T>(string policyKey) =>
        _policyRegistry.Get<IAsyncPolicy<T>>(policyKey);
}
