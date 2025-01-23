using System.Reflection;
using System.Text.RegularExpressions;

using Polly;
using Polly.Caching;
using Polly.Registry;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.DependencyInjection;

using Core.Domain.Common;
using WebHooks.Common.Services;
using Core.Application.Settings;
using Core.Application.Abstractions.Helpers;
using Core.Application.Abstractions.Security;
using Core.Application.Implementations.Helpers;
using Core.Application.Implementations.Management;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using RegexConstantsCore = Core.Domain.Constants.RegexConstants;
using MainConstantsLocal = WebHooks.Domain.Constants.MainConstants;

namespace WebHooks.Common.IoC;

public static class ServiceRegistration
{
    public static IServiceCollection AddWebHooksCommon(this IServiceCollection services, IConfiguration configuration)
    {
        services.Configure<PaginationSettings>(options => configuration.GetSection(MainConstantsCore.CFG_PAGINATION_VALUES).Bind(options));
        services.Configure<PerformanceSettings>(options => configuration.GetSection(MainConstantsCore.CFG_PERFORMANCE_VALUES).Bind(options));
        services.Configure<JwtSettings>(options => configuration.GetSection(MainConstantsCore.CFG_JWT_VALUES).Bind(options));
        services.Configure<PollySettings>(options => configuration.GetSection(MainConstantsCore.CFG_POLLY_VALUES).Bind(options));

        services.AddScoped<IEnvironmentReader, EnvironmentReader>();
        services.AddScoped<ICypherAes>(sp =>
        {
            var environmentReader = sp.GetRequiredService<IEnvironmentReader>();
            return new CypherAes(new string(environmentReader.GetVariable(MainConstantsCore.CFG_BASE_KEY_WEBHOOK_APP).MessageDescription.Take(32).ToArray()));
        });

        services.AddMemoryCache();
        services.AddSingleton<IAsyncCacheProvider, MemoryCacheProvider>();
        services.AddSingleton<ISyncCacheProvider, MemoryCacheProvider>();
        services.AddSingleton<IResilienceService, ResilienceService>();

        var _assembly = Assembly.GetExecutingAssembly();
        var _getRepositoryList = _assembly.GetTypes()
            .Where(typoClazz => typoClazz.IsClass && !typoClazz.IsAbstract && Regex.IsMatch(typoClazz.Name, RegexConstantsCore.REGEX_IS_SERVICE_END_WITH)).ToList();

        foreach(var type in _getRepositoryList)
        {
            var interfaceType = Array.Find(type.GetInterfaces(), iFace => Regex.IsMatch(iFace.Name, RegexConstantsCore.REGEX_IS_INTERFACE_TO_SERVICE_START_WITH));
            if(!interfaceType.CheckIsNull())
                services.AddScoped(interfaceType, type);
        }

        var _getMapperList = _assembly.GetTypes()
            .Where(typoClazz => typoClazz.IsClass && !typoClazz.IsAbstract && Regex.IsMatch(typoClazz.Name, RegexConstantsCore.REGEX_IS_MAPPER_END_WITH)).ToList();

        foreach(var type in _getMapperList)
        {
            var interfaceType = Array.Find(type.GetInterfaces(), iFace => Regex.IsMatch(iFace.Name, RegexConstantsCore.REGEX_IS_INTERFACE_TO_MAPPER_START_WITH));
            if(!interfaceType.CheckIsNull())
                services.AddScoped(interfaceType, type);
        }

        return services;
    }
}
