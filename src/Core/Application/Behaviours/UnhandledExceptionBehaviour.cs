using Core.Domain.Common;
using Core.Utils.Functions;
using Core.Utils.CustomExceptions;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Core.Application.Behaviours;

public sealed class UnhandledExceptionBehaviour<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse> where TRequest : notnull
{
    private readonly ILogger<UnhandledExceptionBehaviour<TRequest, TResponse>> _logger;

    public UnhandledExceptionBehaviour(ILogger<UnhandledExceptionBehaviour<TRequest, TResponse>> logger) =>
        _logger = Guard.Against.Null(logger);

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
    {
        try
        {
            return await next();
        }
        catch(Exception ex)
        {
            var requestName = typeof(TRequest).Name;
            var requestDetails = GetRequestDetails(request);
            _logger.LogError(ex, MessageConstantsCore.MSG_UNHANDLED_EXCEPTION, requestName, requestDetails);

            var exceptions = Functions.GetExceptionsFromNamespace(Assembly.GetExecutingAssembly(), MainConstantsCore.CFG_PATH_EXCEPTIONS);

            if(exceptions.Any(item => item.Name == ex.GetType().Name))
                throw;
            else
                throw new UnhandledException(ex.Message.Trim());
        }
    }

    private static string GetRequestDetails(TRequest request)
    {
        try
        {
            return !request.CheckIsNull() ? System.Text.Json.JsonSerializer.Serialize(request) : MessageConstantsCore.MSG_NOT_DETAILS_AVAILABLE;
        }
        catch
        {
            return MessageConstantsCore.MSG_UNABLE_SERIALIZE_REQUEST;
        }
    }
}
