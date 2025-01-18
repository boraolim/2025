using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;
using Core.Application.Abstractions.Helpers;

using MainConstantsCore = Core.Domain.Constants.MainConstants;

namespace Hogar.HR.Api.Controllers.v1;

[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion(MainConstantsCore.CFG_API_VERSION_V1)]
[Produces(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
public class ConfigurationController : BaseApiController
{
    private readonly IHttpRequestProcessor _httpRequestProcessor;

    public ConfigurationController(IHttpRequestProcessor httpRequestProcessor) =>
        (_httpRequestProcessor) = (Guard.Against.Null(httpRequestProcessor));

    [HttpPost("ConfigurationByGroup")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> ConfigurationByGroup([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                          [FromBody] GroupRequest request)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<GroupRequest, List<ConfigurationResponse>>(request);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.Created; return Created(string.Empty, response);
    }

    [HttpPost("ConfigurationBySubGroup")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> ConfigurationBySubGroup([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                             [FromBody] SubGroupRequest request)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<SubGroupRequest, List<ConfigurationResponse>>(request);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.Created; return Created(string.Empty, response);
    }

    [HttpPost("ConfigurationByKeyName")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> ConfigurationByKeyName([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                            [FromBody] KeyNameRequest request)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<KeyNameRequest, ConfigurationResponse>(request);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.Created; return Created(string.Empty, response);
    }

    [HttpPost("SaveConfigurationByKeyValue")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> SaveConfigurationByKeyValue([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                                 [FromBody] AddKeyValueRequest request)
    {
        await _httpRequestProcessor.ExecuteAsync<AddKeyValueRequest, bool>(request);
        return Created(string.Empty, string.Empty);
    }

    [HttpPatch("UpdateConfigurationByKeyValue")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> UpdateConfigurationByKeyValue([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                                   [FromBody] UpdateKeyValueRequest request)
    {
        await _httpRequestProcessor.ExecuteAsync<UpdateKeyValueRequest, bool>(request);
        return NoContent();
    }

    [HttpPatch("EnableGroup")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> EnableConfigurationGroup([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                              [FromBody] EnableGroupRequest request)
    {
        await _httpRequestProcessor.ExecuteAsync<EnableGroupRequest, bool>(request);
        return NoContent();
    }

    [HttpPatch("EnableSubGroup")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> EnableConfigurationSubGroup([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                                 [FromBody] EnableSubGroupRequest request)
    {
        await _httpRequestProcessor.ExecuteAsync<EnableSubGroupRequest, bool>(request);
        return NoContent();
    }

    [HttpPatch("EnableKeyName")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> EnableConfigurationKeyName([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                                [FromBody] EnableKeyNameRequest request)
    {
        await _httpRequestProcessor.ExecuteAsync<EnableKeyNameRequest, bool>(request);
        return NoContent();
    }
}
