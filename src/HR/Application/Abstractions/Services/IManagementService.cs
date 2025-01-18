using Hogar.HR.Application.DTO;
using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;

namespace Hogar.HR.Application.Abstractions;

public interface IManagementService
{
    #region "ConfigurationUser"
    Task<bool> AddConfigurationToUser(AddConfigurationUserRequest request);
    Task<bool> UpdateConfigurationToUser(UpdateConfigurationUserRequest request);
    Task<bool> LockConfigurationToUser(LockConfigurationUserRequest request);
    Task<bool> DisableConfigurationToUser(DisableConfigurationUserRequest request);
    Task<bool> EnableConfigurationToUser(EnableConfigurationUserRequest request);
    Task<List<ConfigurationUserResponse>> GetConfigurationToUser(ActionConfigurationUserRequest request);

    #endregion
}
