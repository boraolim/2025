using Hogar.HR.Domain.Entities;
using Hogar.HR.Domain.Constants;
using Hogar.HR.Application.Abstractions;
using Core.Application.Abstractions.Persistence;

namespace Hogar.HR.Persistence.Repository;

public class ManagementRepository : IManagementRepository
{
    private int _rowsAffected;
    private readonly IDbFactory _dbFactory;
    private readonly IUnitOfWork _unitOfWork;

    public ManagementRepository(IDbFactory dbFactory, IUnitOfWork unitOfWork) =>
        (_dbFactory, _unitOfWork) = (Guard.Against.Null(dbFactory), Guard.Against.Null(unitOfWork));

    #region "ConfigurationUser"

    public async Task<bool> AddNewParameterUser(ConfigurationUserEntity itemToInsert, string jsonString)
    {
        await _unitOfWork.BeginTransactionAsync();

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(ManagementConstants.DB_PROC_ADD_NEW_PARAMETER_USER, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_CREDENTIAL_ID, itemToInsert.CredentialId.ToString().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_DEFAIL_PARAMETERS_JSON, jsonString.Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_ADD_DATE, itemToInsert.CreateUser, 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);

            _rowsAffected = await _dbFactory.ExecuteCommandAsync();
        }

        return (_rowsAffected > 0);
    }

    public async Task<bool> UpdateParameterUser(ConfigurationUserEntity itemToUpdate, string jsonString)
    {
        await _unitOfWork.BeginTransactionAsync();

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(ManagementConstants.DB_PROC_UPDATE_PARAMETER_USER, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_CREDENTIAL_ID, itemToUpdate.CredentialId.ToString().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_DEFAIL_PARAMETERS_JSON, jsonString.Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_ADD_DATE, itemToUpdate.UpdateUser, 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);

            _rowsAffected = await _dbFactory.ExecuteCommandAsync();
        }

        return (_rowsAffected > 0);
    }

    public async Task<bool> LockAllParameterToUser(ConfigurationUserEntity itemToUpdate)
    {
        await _unitOfWork.BeginTransactionAsync();

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(ManagementConstants.DB_PROC_LOCK_ALL_PARAMETER_TO_USER, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_CREDENTIAL_ID, itemToUpdate.CredentialId.ToString().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_UPDATE_DATE, itemToUpdate.UpdateUser, 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);

            _rowsAffected = await _dbFactory.ExecuteCommandAsync();
        }

        return (_rowsAffected > 0);
    }

    public async Task<bool> DisableAllParameterToUser(ConfigurationUserEntity itemToDelete)
    {
        await _unitOfWork.BeginTransactionAsync();

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(ManagementConstants.DB_PROC_DISABLE_ALL_PARAMETER_TO_USER, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_CREDENTIAL_ID, itemToDelete.CredentialId.ToString().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_DELETE_DATE, itemToDelete.DeleteUser, 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);

            _rowsAffected = await _dbFactory.ExecuteCommandAsync();
        }

        return (_rowsAffected > 0);
    }

    public async Task<bool> EnableAllParameterToUser(ConfigurationUserEntity itemToUpdate)
    {
        await _unitOfWork.BeginTransactionAsync();

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(ManagementConstants.DB_PROC_ENABLE_ALL_PARAMETER_TO_USER, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_CREDENTIAL_ID, itemToUpdate.CredentialId.ToString().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_UPDATE_DATE, itemToUpdate.UpdateUser, 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);

            _rowsAffected = await _dbFactory.ExecuteCommandAsync();
        }

        return (_rowsAffected > 0);
    }

    public async Task<List<ConfigurationUserEntity>> GetParameterUser(ConfigurationUserEntity inputEntity)
    {
        List<ConfigurationUserEntity> _cfgExist;

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(ManagementConstants.DB_PROC_GET_PARAMETER_USER, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(ManagementConstants.DB_PARAM_CREDENTIAL_ID, inputEntity.CredentialId.ToString().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _cfgExist = await _dbFactory.GetDataMappingFromSingleListAsync<ConfigurationUserEntity>();
        }

        return (!_cfgExist.Any()) ? default : _cfgExist;
    }

    #endregion
    public async Task<bool> AddPolicyToUser(PolicyUserEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> LockAllPolicyToUser(PolicyUserEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DisableAllPolicyToUser(PolicyUserEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> EnableAllPolicyToUser(PolicyUserEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<List<PolicyUserEntity>> GetPolicyUser(string CredentialId)
    {
        throw new NotImplementedException();
    }

    public async Task<List<ModuleEntity>> GetAllModules()
    {
        throw new NotImplementedException();
    }

    public async Task<List<ModuleEntity>> GetExistentModule(int moduleId)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> AddNewModule(ModuleEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> UpdateNewModule(ModuleEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteExistentModule(ModuleEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<List<PolicyEntity>> GetAllPolicies()
    {
        throw new NotImplementedException();
    }

    public async Task<List<PolicyEntity>> GetExistentPolicy(int PolicyId)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> AddNewPolicy(PolicyEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> UpdateExistentPolicy(PolicyEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteExistentPolicy(PolicyEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> AddNewModulePolicy(ModulePolicyEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteModulePolicy(ModulePolicyEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<List<ModulePolicyEntity>> GetAllModulePolicy()
    {
        throw new NotImplementedException();
    }

    public async Task<List<ModulePolicyEntity>> GetModulePolicy(int ModulePolicyId)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> AddUserModulePolicy(PolicyUserEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<bool> DeleteUserModulePolicy(PolicyUserEntity Input)
    {
        throw new NotImplementedException();
    }

    public async Task<List<PolicyUserEntity>> GetAllUserModulePolicies()
    {
        throw new NotImplementedException();
    }

    public async Task<List<PolicyUserEntity>> GetUserModulePolicies(int UserPolicyId)
    {
        throw new NotImplementedException();
    }
}
