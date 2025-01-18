using Hogar.HR.Domain.Query;
using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;
using Core.Application.Abstractions.Helpers;

using MainConstantsCore = Core.Domain.Constants.MainConstants;

namespace Hogar.HR.Api.Controllers.v1;

[Route("api/v{version:apiVersion}/[controller]")]
[ApiVersion(MainConstantsCore.CFG_API_VERSION_V1)]
[Produces(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
public class SecurityController : BaseApiController
{
    private readonly IHttpRequestProcessor _httpRequestProcessor;

    public SecurityController(IHttpRequestProcessor httpRequestProcessor) =>
        (_httpRequestProcessor) = (Guard.Against.Null(httpRequestProcessor));

    [AllowAnonymous]
    [HttpPost("register")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    public async Task<IActionResult> RegisterNewAccount([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                        [FromBody] RegisterRequest request)
    {
        await _httpRequestProcessor.ExecuteAsync<RegisterRequest, bool>(request);
        return Created(string.Empty, default);
    }

    [AllowAnonymous]
    [HttpPost("login")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    public async Task<IActionResult> Login([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                           [FromHeader(Name = MainConstantsCore.CFG_AUTHORIZATION_TAG)] string authHeader)
    {
        var credentialBytes = Convert.FromBase64String(authHeader.Substring(MainConstantsCore.CFG_BASIC_TAG.Length).Trim());
        var credentials = Encoding.UTF8.GetString(credentialBytes).Split(':');
        var newSign = new CredentialRequest(credentials[0], credentials[1]);
        var response = await _httpRequestProcessor.ExecuteAsync<CredentialRequest, TokenResponse>(newSign);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.OK; return Ok(response);
    }

    [HttpPost("validateToken")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> ValidateToken([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                   [FromBody] ValidateTokenQuery query)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<ValidateTokenQuery, TokenValidResponse>(query);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.OK; return Ok(response);
    }

    [HttpPost("refreshToken")]
    [Consumes(MainConstantsCore.CFG_CONTENT_TYPE_JSON)]
    [Authorize(AuthenticationSchemes = MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME)]
    public async Task<IActionResult> RefreshToken([FromHeader(Name = MainConstantsCore.CFG_TRACE_ID_HEADER)][Required] string traceId,
                                                  [FromBody] RefreshRequest request)
    {
        var response = await _httpRequestProcessor.ExecuteAsync<RefreshRequest, TokenResponse>(request);
        response.TraceId = traceId; response.StatusCode = (int)HttpStatusCode.OK; return Ok(response);
    }
}
