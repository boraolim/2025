using System.Reflection;
using System.Text.RegularExpressions;

using Core.Domain.Common;
using Core.Application.Utils;
using Core.Infrastructure.Implementations;
using Core.Application.Abstractions.Persistence;

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using RegexConstantsCore = Core.Domain.Constants.RegexConstants;

namespace WebHooks.Persistence.IoC;

public static class ServiceCollection
{
    public static IServiceCollection AddWebHookPersistence(this IServiceCollection services, IConfiguration configuration)
    {
        var isLocalEnvironment = Environment.GetEnvironmentVariable(MainConstantsCore.CFG_ENVIRONMENT_ASPNETCORE_NAME);

        var connectionString = (isLocalEnvironment.Equals(MainConstantsCore.CFG_ENVIRONMENT_LOCAL_NAME) ?
            configuration.GetConnectionString(MainConstantsCore.CFG_CONNECTION_DB_NAME) :
            Functions.GetEnvironmentConnectionString(Environment.GetEnvironmentVariable(MainConstantsCore.CFG_ENVIRONMENT_DATABASE_URL)))
            ?? throw new ArgumentNullException(nameof(configuration));

        services.AddScoped<IDbFactory>(provider => new MySqlConnectorDbContext(connectionString));
        services.AddScoped<IUnitOfWork>(provider => new UnitOfWork(new MySqlConnectorDbContext(connectionString)));

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
