using Core.Application.Abstractions.Persistence;

namespace Core.Infrastructure.Implementations;

public sealed class DbFluentMigrator : IMigratorContext
{
    private readonly string _connectionString;

    public DbFluentMigrator(string ConnectionString) =>
        (_connectionString) = (Guard.Against.NullOrEmpty(ConnectionString));

    public void GenerateMigration()
    {
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls13;
        Ed25519AuthenticationPlugin.Install();

        var serviceProvider = CreateServices();

        using (var scope = serviceProvider.CreateScope())
            UpdateDatabase(scope.ServiceProvider);
    }

    public void Dispose() => GC.SuppressFinalize(this);

    #region "Private methods"

    private IServiceProvider CreateServices() =>
        new ServiceCollection()
            .AddFluentMigratorCore()
            .Configure<AssemblySourceOptions>(item => item.AssemblyNames = new[] { typeof(DbFluentMigrator).Assembly.GetName().Name })
            .ConfigureRunner(runnerBuild => runnerBuild
                .AddMySql8()
                .WithGlobalConnectionString(_connectionString)
                .ScanIn(typeof(DbFluentMigrator).Assembly).For.Migrations())
            .Configure<RunnerOptions>(options => {
                options.Tags = new[] { "Core" };
            })
            .AddLogging(lb => lb.AddFluentMigratorConsole())
            .BuildServiceProvider(false);

    private static void UpdateDatabase(IServiceProvider serviceProvider)
    {
        var runner = serviceProvider.GetRequiredService<IMigrationRunner>();
        runner.ListMigrations();
        runner.MigrateUp();
    }

    #endregion
}
