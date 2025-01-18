using Core.Utils.CustomExceptions;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using RegexConstantsCore = Core.Domain.Constants.RegexConstants;
using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Hogar.HR.Api.Infrastructure.Middleware;

public sealed class TraceIdDetectionMiddleware : IMiddleware
{
    private readonly ILoggerMextLog _logger;

    public TraceIdDetectionMiddleware(ILogger<TraceIdDetectionMiddleware> logger) =>
        _logger = Guard.Against.Null(logger);

    public async Task InvokeAsync(HttpContext context, RequestDelegate next)
    {
        _logger.LogInformation(MessageConstantsCore.MSG_VALIDATE_CURRENT_TRACE_ID);
        if(!context.Request.Headers.ContainsKey(MainConstantsCore.CFG_TRACE_ID_HEADER)
            || string.IsNullOrEmpty(context.Request.Headers[MainConstantsCore.CFG_TRACE_ID_HEADER])
            || !Regex.IsMatch(context.Request.Headers[MainConstantsCore.CFG_TRACE_ID_HEADER], RegexConstantsCore.RGX_UUID_V4_PATTERN))
        {
            _logger.LogError(MessageConstantsCore.MSG_WARNING_MISSING_TRACE_ID);
            throw new TraceIdNotFoundException(MessageConstantsCore.MSG_FAIL_VALIDATION);
        }

        _logger.LogInformation(MessageConstantsCore.MSG_TRACE_ID_SETTED, context.Request.Headers[MainConstantsCore.CFG_TRACE_ID_HEADER].ToString());
        await next(context);
    }
}
