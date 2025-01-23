using System.Security.Cryptography;

using Serilog;
using Asp.Versioning;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Serialization;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Authentication.JwtBearer;

using WebHooks.Common.IoC;
using Core.Domain.Constants;
using WebHooks.Persistence.IoC;
using WebHooks.Application.IoC;
using Core.Application.Settings;
using WebHooks.Api.Infrastructure.Filters;
using WebHooks.Api.Infrastructure.Middleware;
using Core.Application.Implementations.Helpers;

using MainConstantsCore = Core.Domain.Constants.MainConstants;

namespace WebHooks.Api.IoC;

public static class ConfigureServicesExtension
{
    public static void ConfigureServices(IServiceCollection services, IHostBuilder hostBuilder, IConfiguration configuration)
    {
        services.AddWebHookApplicationService(configuration);
        services.AddWebHookPersistence(configuration);
        services.AddWebHooksCommon(configuration);
        services.AddDistributedMemoryCache();
        services.AddTransient<AddHeaderMiddleware>();
        services.AddTransient<JwtValidationMiddleware>();
        services.AddTransient<ErrorHandlerMiddleware>();
        services.AddTransient<TraceIdDetectionMiddleware>();
        services.AddScoped<ResilientActionFilter>();

        var environmentReader = new EnvironmentReader();
        var jwtSettings = configuration.GetSection(MainConstantsCore.CFG_JWT_VALUES).Get<JwtSettings>();
        var apiKeyEnv = new string(environmentReader.GetVariable(MainConstantsCore.CFG_BASE_KEY_WEBHOOK_APP).MessageDescription.Take(32).ToArray());
        var cifrado = new CypherAes(apiKeyEnv);

        byte[] TokenKeyWebApi;
        using (var itemHash = SHA256.Create())
        {
            TokenKeyWebApi = itemHash.ComputeHash(Convert.FromBase64String(apiKeyEnv));
        }

        services.AddAuthentication(opt =>
        {
            opt.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            opt.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            opt.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
        }).AddJwtBearer(MainConstantsCore.CFG_MAIN_AUTHENTICATION_SCHEME_NAME, options =>
        {
            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuer = true,
                ValidateAudience = true,
                ValidateLifetime = true,
                ValidateIssuerSigningKey = true,
                ValidIssuer = cifrado.AESDecryptionGCM(jwtSettings.Issuer),
                ValidAudience = cifrado.AESDecryptionGCM(jwtSettings.Audience),
                IssuerSigningKey = new SymmetricSecurityKey(Convert.FromBase64String(jwtSettings.ClientSecretKey)),
                TokenDecryptionKey = new SymmetricSecurityKey(TokenKeyWebApi),
            };
        });

        services.AddApiVersioning(options =>
        {
            options.AssumeDefaultVersionWhenUnspecified = true;
            options.DefaultApiVersion = new ApiVersion(1, 0);
            options.ReportApiVersions = true;
        }).AddMvc().AddApiExplorer(options =>
        {
            options.GroupNameFormat = MainConstantsCore.CFG_GROUP_NAME_FORMAT;
            options.SubstituteApiVersionInUrl = true;
        });

        services.AddControllers(options =>
        {
            options.Filters.Add<ResilientActionFilter>();
            options.Filters.Add<ApiResultFilterAttribute>();
        }).AddNewtonsoftJson(options =>
        {
            options.UseCamelCasing(true);
            options.SerializerSettings.Formatting = Formatting.Indented;
            options.SerializerSettings.Culture = System.Globalization.CultureInfo.CurrentCulture;
            options.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
            options.SerializerSettings.NullValueHandling = NullValueHandling.Ignore;
            options.SerializerSettings.DateTimeZoneHandling = DateTimeZoneHandling.Local;
            options.SerializerSettings.FloatFormatHandling = FloatFormatHandling.DefaultValue;
            options.SerializerSettings.FloatParseHandling = FloatParseHandling.Decimal;
            options.SerializerSettings.Converters.Add(new StringEnumConverter());
            options.SerializerSettings.ContractResolver = new CamelCasePropertyNamesContractResolver();
        });
        services.AddHttpContextAccessor();
        services.AddEndpointsApiExplorer();
        services.AddSwaggerGen();

        services.AddCors(x =>
        {
            x.AddPolicy(MainConstants.CFG_VALUE_CORS, b =>
            {
                b.AllowAnyOrigin();
                b.AllowAnyHeader();
                b.AllowAnyMethod();
            });
        });

        services.AddHealthChecks();
        hostBuilder.UseSerilog((context, configuration) =>
        {
            configuration.ReadFrom.Configuration(context.Configuration);
            configuration.Enrich.FromLogContext();
        });
    }
}
