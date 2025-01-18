using Core.Application.Abstractions.Persistence;

namespace WebHooks.Api.Infrastructure.Extensions;

public static class MigratorExtension
{
    public static IHost MigrateDataBase<TContext>(this IHost host)
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
        return host;
    }
}
