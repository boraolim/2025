using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;
using Core.Application.Abstractions.Helpers;

using MainConstantsCore = Core.Domain.Constants.MainConstants;

namespace Hogar.HR.Api.Controllers.v1;

[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion(MainConstantsCore.CFG_API_VERSION_V1)]
[Produces(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
public class ManagementController : BaseApiController
{
    private readonly IHttpRequestProcessor _httpRequestProcessor;

    public ManagementController(IHttpRequestProcessor httpRequestProcessor) =>
        (_httpRequestProcessor) = (Guard.Against.Null(httpRequestProcessor));

    [HttpPost("AddConfigurationToUser")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> AddConfigurationToUser([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                            [FromBody] AddConfigurationUserRequest request)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<AddConfigurationUserRequest, bool>(request);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.Created; return Created(string.Empty, string.Empty);
    }

    [HttpPut("UpdateConfigurationToUser")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> UpdateConfigurationToUser([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                                [FromBody] UpdateConfigurationUserRequest request)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<UpdateConfigurationUserRequest, bool>(request);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.NoContent; return NoContent();
    }

    [HttpPatch("LockConfigurationToUser")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> LockConfigurationToUser([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                             [FromBody] LockConfigurationUserRequest request)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<LockConfigurationUserRequest, bool>(request);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.NoContent; return NoContent();
    }

    [HttpPatch("DisableConfigurationToUser")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> DisableConfigurationToUser([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                                [FromBody] DisableConfigurationUserRequest request)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<DisableConfigurationUserRequest, bool>(request);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.NoContent; return NoContent();
    }

    [HttpPatch("EnableConfigurationToUser")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> EnableConfigurationToUser([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                               [FromBody] EnableConfigurationUserRequest request)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<EnableConfigurationUserRequest, bool>(request);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.NoContent; return NoContent();
    }

    [HttpPost("GetConfigurationToUser")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> GetConfigurationToUser([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                            [FromBody] ActionConfigurationUserRequest request)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<ActionConfigurationUserRequest, List<ConfigurationUserResponse>>(request);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.OK; return Ok(response);
    }
}
