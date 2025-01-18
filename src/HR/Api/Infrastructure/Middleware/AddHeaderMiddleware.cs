using MainConstantsCore = Core.Domain.Constants.MainConstants;
using FormatConstantsCore = Core.Domain.Constants.FormatConstants;

namespace Hogar.HR.Api.Infrastructure.Middleware;

public sealed class AddHeaderMiddleware : IMiddleware
{
    public async Task InvokeAsync(HttpContext context, RequestDelegate next)
    {
        var customHeader = context.Request.Headers[MainConstantsCore.CFG_TRACE_ID_HEADER].ToString();

        using(LogContext.PushProperty(MainConstantsCore.CFG_TRACE_ID_LABEL_SERILOG,
            string.Format(FormatConstantsCore.CFG_TRACE_ID_IN_MESSAGE_LOG, customHeader)))
        {
            await next(context);
        }
    }
}
