using WebHooks.Domain.Requests;
using Core.Application.Abstractions.Helpers;

using MainConstantsCore = Core.Domain.Constants.MainConstants;

namespace WebHooks.Api.Controllers.v1;

[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion(MainConstantsCore.CFG_API_VERSION_V1)]
[Produces(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
public class GreetingController : BaseApiController
{
    private readonly IHttpRequestProcessor _httpRequestProcessor;
    public GreetingController(IHttpRequestProcessor httpRequestProcessor) =>
        (_httpRequestProcessor) = (Guard.Against.Null(httpRequestProcessor));

    [HttpPost("printGreeting")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> RegisterNewAccount([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                        [FromBody] GreetingRequest request)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<GreetingRequest, string>(request);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.OK; return Ok(response);
    }
}
