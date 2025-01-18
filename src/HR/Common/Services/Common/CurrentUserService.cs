using Core.Domain.Common;
using Core.Application.DTO;
using Core.Application.Abstractions.Helpers;
using Core.Application.Abstractions.Security;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using MainConstantsLocal = Hogar.HR.Domain.Constants.MainConstants;
using EnvironmentConstantsCore = Core.Domain.Constants.EnvironmentConstants;

namespace Hogar.HR.Common.Services;

public class CurrentUserService : ICurrentUserService
{
    private string SecretKey { get; set; }
    private string KeyAPILocal { get; set; }

    private readonly IJwtService _jwtService;
    private readonly IEnvironmentReader _environmentReader;
    private readonly IHttpContextAccessor _httpContextAccessor;

    public CurrentUserService(IHttpContextAccessor httpContextAccessor,
                              IEnvironmentReader environmentReader,
                              IJwtService jwtService)
    {
        _httpContextAccessor = Guard.Against.Null(httpContextAccessor);
        _environmentReader = Guard.Against.Null(environmentReader);
        _jwtService = Guard.Against.Null(jwtService);
        ReadValues(); GetPrincipal();
    }

    private void ReadValues()
    {
        SecretKey = new string(_environmentReader.GetVariable(EnvironmentConstantsCore.CFG_BASE_KEY_WEBHOOK_APP).MessageDescription.ToArray());
        KeyAPILocal = new string(SecretKey.Take(32).ToArray());
    }

    public string UserId => _httpContextAccessor.HttpContext?.User?.FindFirstValue(MainConstantsLocal.CFG_JWT_USER_ID);
    public string UserName => _httpContextAccessor.HttpContext?.User?.FindFirstValue(ClaimTypes.NameIdentifier);
    public string FullName => _httpContextAccessor.HttpContext?.User?.FindFirstValue(MainConstantsLocal.CFG_JWT_FULL_NAME_VALUE);
    public long? Nonce
    {
        get
        {
            var nonce = _httpContextAccessor.HttpContext?.User?.FindFirstValue(MainConstantsLocal.CFG_JWT_NONCE_VALUE);
            return !nonce.CheckIsNull() ? long.Parse(nonce, CultureInfo.InvariantCulture) : (long?)default;
        }
    }

    public string ApiUrl => _httpContextAccessor.HttpContext?.Request?.Path.Value;
    public string Method => _httpContextAccessor.HttpContext?.Request?.Method;
    public ClaimsPrincipal Principal => _httpContextAccessor.HttpContext?.User;

    public string IpAddress
    {
        get { return _httpContextAccessor.HttpContext?.Connection?.RemoteIpAddress?.ToString(); }
    }

    private void GetPrincipal()
    {
        if(!_httpContextAccessor.CheckIsNull() &&
           !_httpContextAccessor.HttpContext.CheckIsNull() &&
           _httpContextAccessor.HttpContext.Request.Headers[MainConstantsCore.CFG_AUTHORIZATION_TAG].ToString().Contains(MainConstantsCore.CFG_BEARER_TAG))
        {
            var token = _httpContextAccessor.HttpContext.Request.Headers[MainConstantsCore.CFG_AUTHORIZATION_TAG].ToString().Replace(MainConstantsCore.CFG_BEARER_TAG, string.Empty);
            var principal = _jwtService.GetClaimsFromTokenAsync(new JwtValidateDto { TokenValue = token, KeyAPI = KeyAPILocal }).Result;

            if(!principal.CheckIsNull())
            {
                _httpContextAccessor.HttpContext.User = principal.claims;
            }
        }
    }
}

