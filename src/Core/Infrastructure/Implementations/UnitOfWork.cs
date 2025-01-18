using Core.Domain.Common;
using Core.Application.Abstractions.Persistence;

namespace Core.Infrastructure.Implementations;

public sealed class UnitOfWork : IUnitOfWork
{
    private bool _disposed;
    private IDbConnection _connection;
    private IDbTransaction _transaction;
    private readonly IDbFactory _dbFactory;

    public IDbFactory DbFactory => _dbFactory;

    public UnitOfWork(IDbFactory dbFactory)
    {
        _dbFactory = dbFactory;
    }

    public async Task BeginTransactionAsync()
    {
        await Task.Run(() => BeginTransaction()).ConfigureAwait(false);
    }

    public async Task CommitTransactionAsync()
    {
        await Task.Run(() => Commit()).ConfigureAwait(false);
    }

    private void BeginTransaction()
    {
        _connection = _dbFactory.CreateConnection();
        _transaction = _connection.BeginTransaction();
    }

    private void Commit()
    {
        try
        {
            _transaction.Commit();
        }
        catch
        {
            _transaction.Rollback();
            throw;
        }
        finally
        {
            _transaction.Dispose();
            _transaction = _connection.BeginTransaction();
        }
    }

    public void Dispose()
    {
        DisposedObject(true); GC.SuppressFinalize(this);
    }

    private void DisposedObject(bool disposing)
    {
        if (!_disposed)
        {
            if(disposing)
            {
                if (!_transaction.CheckIsNull())
                {
                    _transaction.Dispose();
                    _transaction = null;
                }

                if (!_connection.CheckIsNull() && _connection.State == ConnectionState.Open)
                {
                    _connection.Dispose();
                    _connection.Close();
                    _connection = null;
                }

                if(!_dbFactory.CheckIsNull())
                {
                    _dbFactory.Dispose();
                }
            }
            _disposed = true;
        }
    }
}
