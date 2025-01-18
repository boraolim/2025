using MainConstantsCore = Core.Domain.Constants.MainConstants;
using FormatConstantsCore = Core.Domain.Constants.FormatConstants;

namespace Hogar.HR.Api.Infrastructure.Extensions;

public static class LogEnricherExtension
{
    public static void EnrichFromRequest(IDiagnosticContext context, HttpContext httpContext)
    {
        context.Set(MainConstantsCore.CFG_TRACE_ID_LABEL_SERILOG, string.Format(FormatConstantsCore.CFG_TRACE_ID_IN_MESSAGE_LOG,
            httpContext.Request.Headers[MainConstantsCore.CFG_TRACE_ID_HEADER].FirstOrDefault()));
    }
}
