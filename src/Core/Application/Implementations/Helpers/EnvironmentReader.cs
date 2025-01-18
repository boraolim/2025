using Ardalis.GuardClauses;

using Core.Domain.Common;
using Core.Application.Wrappers;
using Core.Application.Abstractions.Helpers;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Core.Application.Implementations.Helpers
{
    public class EnvironmentReader : IEnvironmentReader
    {
        public Result<string> GetVariable(string keyValue)
        {
            var valueEnv = (Environment.OSVersion.Platform.ToString().Equals(MainConstantsCore.CFG_OS_PLATFORM_WIN)) ?
                Environment.GetEnvironmentVariable(keyValue, EnvironmentVariableTarget.Machine) :
                Environment.GetEnvironmentVariable(keyValue);
            if(string.IsNullOrEmpty(valueEnv))
                return Result<string>.Failure(string.Format(MessageConstantsCore.MSG_ENVIRONMENT_VAR_NOT_FOUND, keyValue));

            return Result<string>.Success(valueEnv);
        }

        public Result<string> GetVariable(string keyValue, string defaultValue)
        {
            return Result<string>.TryCatch(() =>
            {
                var valueEnv = (Environment.OSVersion.Platform.ToString().Equals(MainConstantsCore.CFG_OS_PLATFORM_WIN)) ?
                    Environment.GetEnvironmentVariable(keyValue, EnvironmentVariableTarget.Machine) :
                    Environment.GetEnvironmentVariable(keyValue);
                return valueEnv;
            }, string.Format(MessageConstantsCore.MSG_ENVIRONMENT_VAR_NOT_FOUND, keyValue));
        }
    }
}
