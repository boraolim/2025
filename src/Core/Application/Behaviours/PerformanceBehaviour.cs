using Core.Application.Settings;

using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Core.Application.Behaviours
{
    public sealed class PerformanceBehaviour<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse> where TRequest : notnull
    {
        private readonly int _timeoutMilliseconds;
        private readonly int _warningThresholdMilliseconds;
        private readonly ILogger<PerformanceBehaviour<TRequest, TResponse>> _logger;

        public PerformanceBehaviour(ILogger<PerformanceBehaviour<TRequest, TResponse>> logger, IOptions<PerformanceSettings> settings) =>
            (_logger, _warningThresholdMilliseconds, _timeoutMilliseconds) = 
            (Guard.Against.Null(logger), 
             Guard.Against.NegativeOrZero(settings.Value.WarningThresholdMilliseconds),
             Guard.Against.NegativeOrZero(settings.Value.TimeoutMilliseconds));

        public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
        {
            var stopwatch = Stopwatch.StartNew();
            using var timeoutCancellationTokenSource = new CancellationTokenSource(_timeoutMilliseconds);

            try
            {
                using var linkedCts = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken, timeoutCancellationTokenSource.Token);

                var result = await next().ConfigureAwait(false);

                stopwatch.Stop();
                var elapsedMilliseconds = stopwatch.ElapsedMilliseconds;

                if(elapsedMilliseconds > _warningThresholdMilliseconds)
                    _logger.LogWarning(MessageConstantsCore.MSG_LONG_RUNNING_REQUEST, typeof(TRequest).Name, elapsedMilliseconds);

                return result;
            }
            catch(OperationCanceledException ex) when(timeoutCancellationTokenSource.Token.IsCancellationRequested)
            {
                stopwatch.Stop();
                _logger.LogError(ex, MessageConstantsCore.MSG_TIMEOUT_REQUEST, typeof(TRequest).Name, _timeoutMilliseconds);
                throw new TimeoutException(string.Format(MessageConstantsCore.MSG_TIMEOUT_DESCRIPTION, typeof(TRequest).Name, _timeoutMilliseconds));
            }
        }
    }
}
