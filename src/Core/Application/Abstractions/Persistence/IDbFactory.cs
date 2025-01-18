namespace Core.Application.Abstractions.Persistence;

public interface IDbFactory : IDisposable
{
    IDbConnection CreateConnection();
    void CreateCommand(string commandText, CommandType commandType);
    void CreateParameter(string parameterName, object valueObject, int sizeLength, DbType dbType, ParameterDirection direction);
    Task<List<T>> GetDataMappingFromSingleListAsync<T>();
    Task<int> ExecuteCommandAsync();
    Task<R> ExecuteScalarForTypeAsync<R>();
}
