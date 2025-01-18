using Core.Domain.Common;
using Core.Application.DTO;
using Core.Utils.CustomExceptions;
using Core.Application.Abstractions.Helpers;
using Core.Application.Abstractions.Security;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using RegexConstantsCore = Core.Domain.Constants.RegexConstants;
using MessageConstantsCore = Core.Domain.Constants.MessageConstants;
using EnvironmentConstantsCore = Core.Domain.Constants.EnvironmentConstants;

namespace Hogar.HR.Api.Infrastructure.Middleware;

public sealed class JwtValidationMiddleware : IMiddleware
{
    private string SecretKey { get; set; }
    private string KeyAPILocal { get; set; }

    private readonly IJwtService _jwtService;
    private readonly IEnvironmentReader _environmentReader;

    public JwtValidationMiddleware(ICypherAes cypherAes,
                                   IJwtService jwtService,
                                   IEnvironmentReader environmentReader)
    {
        _jwtService = Guard.Against.Null(jwtService);
        _environmentReader = Guard.Against.Null(environmentReader);
        ReadValues();
    }

    private void ReadValues()
    {
        SecretKey = new string(_environmentReader.GetVariable(EnvironmentConstantsCore.CFG_BASE_KEY_WEBHOOK_APP)
            .MessageDescription.ToArray());
        KeyAPILocal = new string(SecretKey.Take(32).ToArray());
    }

    public async Task InvokeAsync(HttpContext context, RequestDelegate next)
    {
        var authHeader = context.Request.Headers[MainConstantsCore.CFG_AUTHORIZATION_TAG].FirstOrDefault();
        var bearerTokenRegex = new Regex(RegexConstantsCore.RGX_JWT_TOKEN, RegexOptions.Compiled);

        if(!authHeader.CheckIsNull() && authHeader.StartsWith(MainConstantsCore.CFG_BEARER_TAG))
        {
            if(!bearerTokenRegex.IsMatch(authHeader))
                throw new JwtValidationException("El valor del token es un dato requerido");

            var token = authHeader.Substring(MainConstantsCore.CFG_BEARER_TAG.Length).Trim();


            var validate = await _jwtService.ValidateTokenAsync(new JwtValidateDto { TokenValue = token, KeyAPI = KeyAPILocal });

            if(!validate.IsValid)
                throw new JwtValidationException(MessageConstantsCore.MSG_KEY_JWT_INVALID);

            if(validate.IsExpired)
                throw new JwtValidationException(MessageConstantsCore.MSG_SESSION_FINISHED);
        }

        await next(context);
    }
}
