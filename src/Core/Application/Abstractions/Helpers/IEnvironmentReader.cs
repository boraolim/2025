using Core.Application.Wrappers;

namespace Core.Application.Abstractions.Helpers;

public interface IEnvironmentReader
{
    Result<string> GetVariable(string keyValue);
    Result<string> GetVariable(string keyValue, string defaultValue);
}
