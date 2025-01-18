using Core.Application.Abstractions.Persistence;

namespace Hogar.HR.Api.Infrastructure.Extensions;

public static class MigratorExtension
{
    public static IHost MigrateDataBase<TContext>(this IHost host)
    {
        try
        {
            using(var scope = host.Services.CreateScope())
            {
                var services = scope.ServiceProvider;
                var logger = services.GetRequiredService<ILogger<TContext>>();
                logger.LogInformation("Migrating database associated with context {DbContextName}", typeof(TContext).Name);
                var migrator = services.GetRequiredService<IMigratorContext>();
                migrator.GenerateMigration();
                logger.LogInformation("Migrated database associated with context {DbContextName}", typeof(TContext).Name);
            }
        }
        catch(Exception ex)
        {
            var logger = host.Services.GetRequiredService<ILogger<TContext>>();
            logger.LogError(ex, "An error occurred while migrating the database used on context {DbContextName}", typeof(TContext).Name);
            host.StopAsync().Wait();
        }

        return host;
    }
}
