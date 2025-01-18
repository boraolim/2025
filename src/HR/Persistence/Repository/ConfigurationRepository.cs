using Hogar.HR.Domain.Entities;
using Hogar.HR.Application.Abstractions;
using Core.Application.Abstractions.Persistence;

using DbConstantsLocal = Hogar.HR.Domain.Constants.DbConstants;

namespace Hogar.HR.Persistence.Repository;

public class ConfigurationRepository : IConfigurationRepository
{
    private int _rowsAffected;
    private readonly IDbFactory _dbFactory;
    private readonly IUnitOfWork _unitOfWork;

    public ConfigurationRepository(IDbFactory dbFactory, IUnitOfWork unitOfWork) =>
        (_dbFactory, _unitOfWork) = (Guard.Against.Null(dbFactory), Guard.Against.Null(unitOfWork));

    public async Task<bool> AddConfiguration(ConfigurationEntity itemToInsert)
    {
        await _unitOfWork.BeginTransactionAsync();

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(DbConstantsLocal.DB_PROC_ADD_NEW_CONFIGURATION, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_GROUP, itemToInsert.GroupName.ToUpper().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_SUB_GROUP, itemToInsert.SubGroupName.Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_KEY_NAME, itemToInsert.KeyName.ToUpper().Trim(), 100, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_KEY_VALUE, itemToInsert.KeyValue.ToUpper().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_TYPE_DATA, itemToInsert.ValueType.ToString().Trim(), 20, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_COMMENTS, itemToInsert.KeyDescription.Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_ADD_DATE, itemToInsert.CreateUser, 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);

            _rowsAffected = await _dbFactory.ExecuteCommandAsync();
        }

        return (_rowsAffected > 0);
    }

    public async Task<bool> UpdateConfiguration(ConfigurationEntity itemToUpdate)
    {
        await _unitOfWork.BeginTransactionAsync();

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(DbConstantsLocal.DB_UPDATE_INFO_ACTIVE_CONFIGURATION, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_GROUP, itemToUpdate.GroupName.ToUpper().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_SUB_GROUP, itemToUpdate.SubGroupName.Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_KEY_NAME, itemToUpdate.KeyName.ToUpper().Trim(), 100, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_KEY_VALUE, itemToUpdate.KeyValue.ToUpper().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_TYPE_DATA, itemToUpdate.ValueType.ToString().Trim(), 20, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_COMMENTS, itemToUpdate.KeyDescription.Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_UPDATE_DATE, itemToUpdate.UpdateUser, 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);

            _rowsAffected = await _dbFactory.ExecuteCommandAsync();
        }

        return (_rowsAffected > 0);
    }

    public async Task<bool> EnableConfiguracionForGroup(ConfigurationEntity inputToUpdate, bool ShutDownValue)
    {
        await _unitOfWork.BeginTransactionAsync();

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(DbConstantsLocal.DB_ENABLE_GROUP_CONFIGURATION, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_GROUP, inputToUpdate.GroupName.ToLower().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_ENABLE_FLAG_CONFIGURATION, ShutDownValue, 0, System.Data.DbType.Boolean, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_UPDATE_DATE, inputToUpdate.UpdateUser, 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);

            _rowsAffected = await _dbFactory.ExecuteCommandAsync();
        }

        return (_rowsAffected > 0);
    }

    public async Task<bool> EnableConfiguracionForSubGroup(ConfigurationEntity inputToUpdate, bool ShutDownValue)
    {
        await _unitOfWork.BeginTransactionAsync();

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(DbConstantsLocal.DB_ENABLE_SUBGROUP_CONFIGURATION, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_GROUP, inputToUpdate.GroupName.ToLower().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_SUB_GROUP, inputToUpdate.SubGroupName.Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_ENABLE_FLAG_CONFIGURATION, ShutDownValue, 0, System.Data.DbType.Boolean, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_UPDATE_DATE, inputToUpdate.UpdateUser, 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);

            _rowsAffected = await _dbFactory.ExecuteCommandAsync();
        }

        return (_rowsAffected > 0);
    }

    public async Task<bool> EnableConfigurationForKeyName(ConfigurationEntity itemToUpdate, bool ShutDownValue)
    {
        await _unitOfWork.BeginTransactionAsync();

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(DbConstantsLocal.DB_ENABLE_KEYNAME_CONFIGURATION, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_GROUP, itemToUpdate.GroupName.ToLower().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_SUB_GROUP, itemToUpdate.SubGroupName.Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_KEY_NAME, itemToUpdate.KeyName.ToUpper().Trim(), 100, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_ENABLE_FLAG_CONFIGURATION, ShutDownValue, 0, System.Data.DbType.Boolean, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_UPDATE_DATE, itemToUpdate.UpdateUser, 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);

            _rowsAffected = await _dbFactory.ExecuteCommandAsync();
        }

        return (_rowsAffected > 0);
    }

    public async Task<List<ConfigurationEntity>> GetConfigurationByGroup(ConfigurationEntity inputEntity)
    {
        List<ConfigurationEntity> _cfgExist;

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(DbConstantsLocal.DB_GET_GROUP_ACTIVE_CONFIGURATION, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_GROUP, inputEntity.GroupName.ToLower().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _cfgExist = await _dbFactory.GetDataMappingFromSingleListAsync<ConfigurationEntity>();
        }

        return (!_cfgExist.Any()) ? default : _cfgExist;
    }

    public async Task<List<ConfigurationEntity>> GetConfigurationBySubGroup(ConfigurationEntity inputEntity)
    {
        List<ConfigurationEntity> _cfgExist;

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(DbConstantsLocal.DB_GET_SUBGROUP_ACTIVE_CONFIGURATION, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_GROUP, inputEntity.GroupName.ToLower().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_SUB_GROUP, inputEntity.SubGroupName.ToLower().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _cfgExist = await _dbFactory.GetDataMappingFromSingleListAsync<ConfigurationEntity>();
        }

        return (!_cfgExist.Any()) ? default : _cfgExist;
    }

    public async Task<ConfigurationEntity> GetConfigurationByKeyName(ConfigurationEntity inputEntity)
    {
        List<ConfigurationEntity> _cfgExist;

        using(var connection = _dbFactory.CreateConnection())
        {
            _dbFactory.CreateCommand(DbConstantsLocal.DB_GET_INFO_ACTIVE_CONFIGURATION, System.Data.CommandType.StoredProcedure);

            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_GROUP, inputEntity.GroupName.ToLower().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_SUB_GROUP, inputEntity.SubGroupName.ToLower().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_KEY_NAME, inputEntity.KeyName.ToUpper().Trim(), 100, System.Data.DbType.String, System.Data.ParameterDirection.Input);
            _cfgExist = await _dbFactory.GetDataMappingFromSingleListAsync<ConfigurationEntity>();
        }

        return (!_cfgExist.Any()) ? default : _cfgExist.FirstOrDefault();
    }
}
