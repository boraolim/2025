using Core.Domain.Common;
using Core.Application.Wrappers;
using Core.Utils.CustomExceptions;
using Core.Application.Abstractions.Helpers;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using FormatConstantsCore = Core.Domain.Constants.FormatConstants;
using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Hogar.HR.Api.Infrastructure.Middleware;

public sealed class ErrorHandlerMiddleware : IMiddleware
{
    private string RequestBodyText { get; set; }
    private string ResponseBodyText { get; set; }

    private readonly IJsonToStringHelper<Result<string>> _jsonHelper;
    public ErrorHandlerMiddleware(IJsonToStringHelper<Result<string>> jsonHelper, IHostEnvironment env) =>
        (_jsonHelper) = (Guard.Against.Null(jsonHelper));

    public async Task InvokeAsync(HttpContext context, RequestDelegate next)
    {
        var originalBodyStream = context.Response.Body;
        RequestBodyText = await GetRequestResult(context.Request);

        using(var responseBody = new MemoryStream())
        {
            context.Response.Body = responseBody;

            try
            {
                await next(context);
            }
            catch(Exception error)
            {
                context.Response.Clear();
                context.Response.ContentType = MainConstantsCore.CFG_CONTENT_TYPE_JSON;

                var responseModel = new Result<string>();
                responseModel.MessageDescription = error.Message;
                responseModel.TimeStamp = DateTime.UtcNow;
                responseModel.TraceId = context.Request.Headers[MainConstantsCore.CFG_TRACE_ID_HEADER];
                responseModel.UrlPathDetail = string.Format(MessageConstantsCore.MSG_URL_PATH_DETAIL, context.Request.Path, context.Request.Method);

                switch(error)
                {
                    case CommonValidationException e:
                        context.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                        responseModel.ErrorDetail = e.errors.ToDictionary(pKey => pKey.PropertyName, pValue => pValue.ErrorMessage);
                        break;
                    case EntityNotFoundException:
                        context.Response.StatusCode = (int)HttpStatusCode.NotFound;
                        break;
                    case EntityAlreadyExistsException:
                        context.Response.StatusCode = (int)HttpStatusCode.Conflict;
                        break;
                    case KeyNotFoundException:
                        context.Response.StatusCode = (int)HttpStatusCode.NotFound;
                        break;
                    case CustomException:
                        context.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                        break;
                    case UnauthorizedAccessException:
                    case SecurityTokenExpiredException:
                    case SecurityTokenInvalidSignatureException:
                    case SecurityTokenInvalidAudienceException:
                    case SecurityTokenInvalidIssuerException:
                    case JwtValidationException:
                    case SecurityTokenException:
                        context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                        break;
                    case DbFactoryException:
                        context.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                        break;
                    case TraceIdNotFoundException:
                        context.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                        responseModel.ErrorDetail = new Dictionary<string, string>();
                        responseModel.ErrorDetail.Add(MainConstantsCore.CFG_TRACE_ID_EMPTY_LABEL, MessageConstantsCore.MSG_FAIL_TRACE_ID_DETAIL);
                        break;
                    case TimeoutException:
                        context.Response.StatusCode = (int)HttpStatusCode.RequestTimeout;
                        break;
                    default:
                        context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                        break;
                }

                responseModel.StatusCode = context.Response.StatusCode;
                await context.Response.WriteAsync(_jsonHelper.SerializeToString(responseModel));
            }

            ResponseBodyText = await GetResponseResult(context.Response);
            await responseBody.CopyToAsync(originalBodyStream);
        }

        context.Response.Body = originalBodyStream;
    }

    private static async Task<string> GetRequestResult(HttpRequest request)
    {
        try
        {
            int read = 0;
            using var ms = new MemoryStream();

            request.EnableBuffering();
            var body = request.Body;
            var buffer = new byte[Convert.ToInt32(request.ContentLength)];

            while((read = await request.Body.ReadAsync(buffer, 0, buffer.Length)) > 0)
                await ms.WriteAsync(buffer, 0, read);

            var bodyAsText = Encoding.UTF8.GetString(ms.ToArray());
            body.Seek(0, SeekOrigin.Begin);
            request.Body = body;

            return request.QueryString.HasValue switch
            {
                true => request.QueryString.ToString(),
                _ => !string.IsNullOrEmpty(bodyAsText) ? bodyAsText : string.Empty
            };
        }
        catch(Exception ex)
        {
            return string.Concat(MessageConstantsCore.CFG_TEXT_RESULT_ERROR,
                (ex.InnerException.CheckIsNull()) ? ex.Message : string.Format(FormatConstantsCore.CFG_SEPATOR_ERROR,
                    ex.Message, ex.InnerException.Message));
        }
    }

    private static async Task<string> GetResponseResult(HttpResponse response)
    {
        try
        {
            response.Body.Seek(0, SeekOrigin.Begin);
            string textResponse = await new StreamReader(response.Body).ReadToEndAsync();
            response.Body.Seek(0, SeekOrigin.Begin);

            return string.IsNullOrEmpty(textResponse) ? string.Empty : textResponse;
        }
        catch(Exception ex)
        {
            return string.Concat(MessageConstantsCore.CFG_TEXT_RESULT_ERROR,
                (ex.InnerException.CheckIsNull()) ? ex.Message : string.Format(FormatConstantsCore.CFG_SEPATOR_ERROR,
                    ex.Message, ex.InnerException.Message));
        }
    }
}
