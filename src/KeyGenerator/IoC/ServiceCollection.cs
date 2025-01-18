using KeyGenerator.Main;
using Core.Utils.Functions;
using KeyGenerator.Settings;
using KeyGenerator.Abstractions;
using KeyGenerator.Implementations;

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

using Core.Domain.Common;
using Core.Application.Abstractions.Helpers;
using Core.Application.Implementations.Helpers;

namespace KeyGenerator.IoC;

public static class ServiceCollection
{
    public static IServiceCollection ConfigurationServices()
    {
        var services = new Microsoft.Extensions.DependencyInjection.ServiceCollection();
        var config = LoadConfiguration();

        services.AddSingleton(config);
        services.Configure<AppSettings>(options => config.GetSection("AppSettings").Bind(options));

        services.AddSingleton<App>();

        services.AddScoped<ICypherAes>(sp =>
        {
            var appSettings = config.GetSection("AppSettings").Get<AppSettings>();
            var environmentReader = appSettings.VariableEntorno.CheckIsNull() ? 
                Functions.GenerateRandomString(512) : appSettings.VariableEntorno;
            var hashes = Functions.GenerateHash512(environmentReader);
            var apiKey = new string(hashes.HexHash.ToArray());
            return new CypherAes(new string(apiKey.Take(32).ToArray()));
        });

        services.AddTransient<IMainService, MainService>();

        return services;
    }

    public static IConfiguration LoadConfiguration()
    {
        var builder = new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("AppSettings.json", optional: true, reloadOnChange: true);
        return builder.Build();
    }
}
