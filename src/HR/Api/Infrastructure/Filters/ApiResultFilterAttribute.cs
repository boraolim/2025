using Core.Domain.Constants;
using Core.Application.Wrappers;

namespace Hogar.HR.Api.Infrastructure.Filters;

[AttributeUsage(AttributeTargets.Class)]
public sealed class ApiResultFilterAttribute : ActionFilterAttribute
{

    public override void OnResultExecuting(ResultExecutingContext context)
    {
        if(context.Result is BadRequestObjectResult)
        {
            var responseModel = new Result<string>
            {
                Succeded = false,
                ErrorDetail = new Dictionary<string, string>
                {
                    { MainConstants.CFG_ATTRIBUTE_EMPTY_LABEL, MessageConstants.MSG_FAIL_VALIDATION_DETAIL }
                },
                StatusCode = (int)HttpStatusCode.BadRequest,
                MessageDescription = MessageConstants.MSG_FAIL_VALIDATION,
                TraceId = context.HttpContext.Request.Headers[MainConstants.CFG_TRACE_ID_HEADER],
                UrlPathDetail = string.Format(MessageConstants.MSG_URL_PATH_DETAIL, context.HttpContext.Request.Path, context.HttpContext.Request.Method)
            };

            context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
            context.Result = new JsonResult(responseModel);
        }
    }
}
