namespace Core.Application.Abstractions.Persistence;

public interface IUnitOfWork : IDisposable
{
    IDbFactory DbFactory { get; }
    Task BeginTransactionAsync();
    Task CommitTransactionAsync();
}
