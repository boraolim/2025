namespace Core.Application.Abstractions.Persistence
{
    public interface IMigratorContext : IDisposable
    {
        void GenerateMigration();
    }
}
