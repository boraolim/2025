using Core.Domain.Common;
using Core.Utils.Functions;
using Core.Utils.CustomExceptions;
using Core.Application.Abstractions.Persistence;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Core.Infrastructure.Implementations;

public sealed class MySqlConnectorDbContext : IDbFactory
{
    private bool _disposed;
    private IDbCommand _command;
    private IDbConnection _connection;
    private readonly string _connectionString;
    public MySqlConnectorDbContext(string connectionString) =>
        _connectionString = Guard.Against.Null(connectionString);

    ~MySqlConnectorDbContext() => DisposeObject(false);

    public void CreateCommand(string commandText, CommandType commandType) =>
        _command = new MySqlCommand() { CommandText = commandText, CommandType = commandType, Connection = (MySqlConnection)_connection, };

    public IDbConnection CreateConnection()
    {
        try
        {
            _connection = new MySqlConnection(_connectionString); _connection.Open(); return _connection;
        }
        catch(MySqlException ex)
        {
            throw new DbFactoryException($"{string.Format(MessageConstantsCore.MSG_DB_CONNECTION_FAIL, ex.Message.Trim())}");
        }
    }

    public void CreateParameter(string parameterName, object valueObject, int sizeLength, DbType dbType, ParameterDirection direction)
    {
        _command.Parameters.Add(new MySqlParameter
        {
            DbType = dbType,
            Size = sizeLength,
            ParameterName = parameterName.Trim(),
            Direction = direction,
            Value = valueObject
        });
    }

    public void Dispose()
    {
        DisposeObject(true); GC.SuppressFinalize(this);
    }

    private void DisposeObject(bool disposing)
    {
        if(!_disposed && disposing && !_connection.CheckIsNull())
        {
            _connection.Dispose();
            _connection.Close();
            _connection = null;
            _disposed = true;
        }
    }

    public async Task<int> ExecuteCommandAsync()
    {
        try
        {
            var _recordsAffecteds = 0; 
            await Task.Delay(MainConstantsCore.CFG_VALUE_DELAY); 
            _recordsAffecteds = _command.ExecuteNonQuery(); 
            return _recordsAffecteds;
        }
        catch(MySqlException ex)
        {
            throw new DbFactoryException($"{string.Format(MessageConstantsCore.MSG_DB_OPERATION_FAIL, ex.Message.Trim())}");
        }
    }

    public async Task<R> ExecuteScalarForTypeAsync<R>()
    {
        try
        {
            await Task.Delay(MainConstantsCore.CFG_VALUE_DELAY);
            object result = _command.ExecuteScalar();

            if(result != null && result != DBNull.Value)
                return (R)Convert.ChangeType(result, typeof(R));

            return default;
        }
        catch(MySqlException ex)
        {
            throw new DbFactoryException($"{string.Format(MessageConstantsCore.MSG_DB_OPERATION_FAIL, ex.Message.Trim())}");
        }
    }

    public async Task<List<T>> GetDataMappingFromSingleListAsync<T>()
    {
        var ret = new List<T>();
        await Task.Run(() => { 
            ret = Functions.DataReaderMapToListAsync<T>(_command.ExecuteReader()).ToList(); 
        }).ConfigureAwait(false);
        return ret;
    }
}
