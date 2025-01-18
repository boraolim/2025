using Hogar.HR.Domain.Entities;
using Hogar.HR.Application.Abstractions;
using Core.Application.Abstractions.Persistence;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using DbConstantsLocal = Hogar.HR.Domain.Constants.DbConstants;

namespace Hogar.HR.Persistence.Repository
{
    public class SecurityRepository : ISecurityRepository
    {
        private int _rowsAffected;
        private readonly IDbFactory _dbFactory;
        private readonly IUnitOfWork _unitOfWork;

        public SecurityRepository(IDbFactory dbFactory, IUnitOfWork unitOfWork) =>
            (_dbFactory, _unitOfWork) = (Guard.Against.Null(dbFactory), Guard.Against.Null(unitOfWork));

        public async Task<int> Register(UserEntity itemToInsert)
        {
            await _unitOfWork.BeginTransactionAsync();

            using(var connection = _dbFactory.CreateConnection())
            {
                _dbFactory.CreateCommand(DbConstantsLocal.DB_PROC_ADD_NEW_USER, System.Data.CommandType.StoredProcedure);

                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_NAME, itemToInsert.UserName.ToLower().Trim(), 15, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_SECRET, itemToInsert.UserSecret.Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_FULL_NAME, itemToInsert.UserFullName.ToUpper().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_ADD_DATE, MainConstantsCore.CFG_SYSTEM_AUTHOR, 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);

                _rowsAffected = await _dbFactory.ExecuteCommandAsync();
            }

            return _rowsAffected;
        }

        public async Task<UserEntity> GetAccountByUserName(string userName)
        {
            List<UserEntity> _userExist;

            using(var connection = _dbFactory.CreateConnection())
            {
                _dbFactory.CreateCommand(DbConstantsLocal.DB_PROC_GET_EXISTENT_USER, System.Data.CommandType.StoredProcedure);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_NAME, userName.ToLower().Trim(), 15, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _userExist = await _dbFactory.GetDataMappingFromSingleListAsync<UserEntity>();
            }

            return (!_userExist.Any()) ? default : _userExist.SingleOrDefault();
        }

        public async Task<UserEntity> GetAccountById(Guid id)
        {
            List<UserEntity> _userExist;

            using(var connection = _dbFactory.CreateConnection())
            {
                _dbFactory.CreateCommand(DbConstantsLocal.DB_PROC_GET_EXISTENT_USER_BY_ID, System.Data.CommandType.StoredProcedure);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_ID, id.ToString().ToLower().Trim(), 36, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _userExist = await _dbFactory.GetDataMappingFromSingleListAsync<UserEntity>();
            }

            return (!_userExist.Any()) ? default : _userExist.SingleOrDefault();
        }

        public async Task<Guid> SaveNewToken(string refreshToken, string userName, string direccionIP, string author)
        {
            Guid _newToken;

            using(var connection = _dbFactory.CreateConnection())
            {
                _dbFactory.CreateCommand(DbConstantsLocal.DB_PROC_SAVE_NEW_TOKEN, System.Data.CommandType.StoredProcedure);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_NAME, userName.ToLower().Trim(), 15, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_IP_ADDRESS, direccionIP.Trim(), 100, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_REFRESH_TOKEN, refreshToken.ToLower().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_DATE, author.Trim(), 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _newToken = await _dbFactory.ExecuteScalarForTypeAsync<Guid>();
            }

            return _newToken;
        }

        public async Task<string> GetTokenValueToRefresh(string userName, string idToken)
        {
            string _tokenValue;
            using(var connection = _dbFactory.CreateConnection())
            {
                _dbFactory.CreateCommand(DbConstantsLocal.DB_PROC_GET_USER_BY_REFRESH, System.Data.CommandType.StoredProcedure);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_NAME, userName.ToLower().Trim(), 15, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_ID_TOKEN, idToken.Trim(), 36, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _tokenValue = await _dbFactory.ExecuteScalarForTypeAsync<string>();
            }
            return _tokenValue;
        }

        public async Task<bool> GetStatusExpiration(string idToken)
        {
            bool _isExpired;
            using(var connection = _dbFactory.CreateConnection())
            {
                _dbFactory.CreateCommand(DbConstantsLocal.DB_PROC_STATUS_TOKEN_EXPIRATION, System.Data.CommandType.StoredProcedure);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_ID_TOKEN, idToken.Trim(), 36, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _isExpired = await _dbFactory.ExecuteScalarForTypeAsync<bool>();
            }

            return _isExpired;
        }

        public async Task<Guid> SaveRefreshToken(string idToken, string userName, string refreshToken, string direccionIP, string author)
        {
            Guid _newToken;

            using(var connection = _dbFactory.CreateConnection())
            {
                _dbFactory.CreateCommand(DbConstantsLocal.DB_PROC_SAVE_REFRESH_TOKEN, System.Data.CommandType.StoredProcedure);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_ID_TOKEN, idToken.Trim(), 36, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_NAME, userName.ToLower().Trim(), 15, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_REFRESH_TOKEN, refreshToken.ToLower().Trim(), 255, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_IP_ADDRESS, direccionIP.Trim(), 100, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_DATE, author.Trim(), 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _newToken = await _dbFactory.ExecuteScalarForTypeAsync<Guid>();
            }

            return _newToken;
        }

        public async Task<string> SaveAndClearExpiration(string idToken, string userName, string author)
        {
            string _arrayTokens;
            using(var connection = _dbFactory.CreateConnection())
            {
                _dbFactory.CreateCommand(DbConstantsLocal.DB_PROC_CLEAR_EXPIRATION, System.Data.CommandType.StoredProcedure);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_ID_TOKEN, idToken.Trim(), 36, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_NAME, userName.ToLower().Trim(), 15, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _dbFactory.CreateParameter(DbConstantsLocal.DB_PARAM_USER_DATE, author.Trim(), 40, System.Data.DbType.String, System.Data.ParameterDirection.Input);
                _arrayTokens = await _dbFactory.ExecuteScalarForTypeAsync<string>();
            }
            return _arrayTokens;
        }
    }
}
