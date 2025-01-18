using System;
using System.Net;

using Polly;
using Polly.Wrap;
using Ardalis.GuardClauses;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.AspNetCore.Mvc.Filters;

using Core.Domain.Common;
using Core.Application.Settings;
using Core.Application.Abstractions.Security;

using MainConstantsLocal = WebHooks.Domain.Constants.MainConstants;

namespace WebHooks.Api.Infrastructure.Filters;

public class ResilientActionFilter : IAsyncActionFilter
{
    private readonly IAsyncPolicy<HttpResponseMessage> _combinedPolicy;

    public ResilientActionFilter(IResilienceService pollyService)
    {
        var retryPolicy = pollyService.GetPolicy<HttpResponseMessage>(MainConstantsLocal.CFG_RETRY_POLICY);
        var circuitBreakerPolicy = pollyService.GetPolicy<HttpResponseMessage>(MainConstantsLocal.CFG_CIRCUIT_BRAKER_POLICY);
        _combinedPolicy = Policy.WrapAsync(retryPolicy, circuitBreakerPolicy);
    }
    public async Task OnActionExecutionAsync(ActionExecutingContext context, ActionExecutionDelegate next)
    {
        await _combinedPolicy.ExecuteAsync(async () =>
        {
            HttpStatusCode statusCode = HttpStatusCode.OK;
            var result = await next();

            if(result.Exception != null && !result.ExceptionHandled)
                throw result.Exception;

            if(result.Result is ObjectResult objectResult)
                statusCode = (HttpStatusCode)objectResult.StatusCode.GetValueOrDefault();

            return new HttpResponseMessage(statusCode);
        });
    }
}
