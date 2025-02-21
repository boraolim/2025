using System.Reflection;
using System.Text.RegularExpressions;

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

using Core.Domain.Common;
using Core.Application.Utils;
using Core.Infrastructure.Implementations;
using Core.Application.Abstractions.Helpers;
using Core.Application.Implementations.Helpers;
using Core.Application.Abstractions.Persistence;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using RegexConstantsCore = Core.Domain.Constants.RegexConstants;
using EnvironmentConstantsCore = Core.Domain.Constants.EnvironmentConstants;

namespace WebHooks.Persistence.IoC;

public static class ServiceCollection
{
    public static IServiceCollection AddWebHookPersistence(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddScoped<IDbFactory>(provider =>
        {
            var environmentReader = provider.GetRequiredService<IEnvironmentReader>();
            var cypher = new CypherAes(new string(environmentReader.GetVariable(EnvironmentConstantsCore.CFG_BASE_KEY_WEBHOOK_APP).MessageDescription.Take(32).ToArray()));
            var connectionString = Functions.GetEnvironmentConnectionString(cypher.AESDecryptionGCM(Environment.GetEnvironmentVariable(EnvironmentConstantsCore.CFG_BASE_KEY_DB_COONECTION)));
            return new MySqlConnectorDbContext(connectionString);
        });

        services.AddScoped<IUnitOfWork>(provider => {
            var environmentReader = provider.GetRequiredService<IEnvironmentReader>();
            var cypher = new CypherAes(new string(environmentReader.GetVariable(EnvironmentConstantsCore.CFG_BASE_KEY_WEBHOOK_APP).MessageDescription.Take(32).ToArray()));
            var connectionString = Functions.GetEnvironmentConnectionString(cypher.AESDecryptionGCM(Environment.GetEnvironmentVariable(EnvironmentConstantsCore.CFG_BASE_KEY_DB_COONECTION)));
            return new UnitOfWork(new MySqlConnectorDbContext(connectionString));
        });

        var _assembly = Assembly.GetExecutingAssembly();
        var _getRepositoryList = _assembly.GetTypes()
            .Where(typoClazz => typoClazz.IsClass && !typoClazz.IsAbstract && Regex.IsMatch(typoClazz.Name, RegexConstantsCore.REGEX_IS_REPOSITORY_END_WITH)).ToList();

        foreach(var type in _getRepositoryList)
        {
            var interfaceType = Array.Find(type.GetInterfaces(), iFace => Regex.IsMatch(iFace.Name, RegexConstantsCore.REGEX_IS_INTERFACE_TO_REPOSITORY_START_WITH));
            if(!interfaceType.CheckIsNull())
                services.AddScoped(interfaceType, type);
        }

        return services;
    }
}
