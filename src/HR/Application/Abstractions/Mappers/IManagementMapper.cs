using Hogar.HR.Application.DTO;
using Hogar.HR.Domain.Entities;
using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;

namespace Hogar.HR.Application.Abstractions;

public interface IManagementMapper
{
    #region "ConfigurationUser"
    
    AddConfigurationUserDto MapAddToConfigurationUserDto(AddConfigurationUserRequest Input);
    UpdateConfigurationUserDto MapUpdateToConfigurationUserDto(UpdateConfigurationUserRequest Input);
    ActionConfigurationUserDto MapLockToConfigurationUserDto(LockConfigurationUserRequest Input);
    ActionConfigurationUserDto MapDisableToConfigurationUserDto(DisableConfigurationUserRequest Input);
    ActionConfigurationUserDto MapEnableToConfigurationUserDto(EnableConfigurationUserRequest Input);
    ConfigurationUserEntity MapToAddConfigurationEntity(AddConfigurationUserDto Input);
    ConfigurationUserEntity MapToUpdateConfigurationEntity(UpdateConfigurationUserDto Input);
    ConfigurationUserEntity MapToLockActionConfigurationEntity(ActionConfigurationUserDto Input);
    ConfigurationUserEntity MapToDisableActionConfigurationEntity(ActionConfigurationUserDto Input);
    ConfigurationUserEntity MapToEnableActionConfigurationEntity(ActionConfigurationUserDto Input);
    ConfigurationUserDto MapToInfoConfigurationUserDto(ConfigurationUserEntity Input);
    ConfigurationUserDto MapToConfigurationUserDto(ActionConfigurationUserRequest Input);
    ConfigurationUserEntity MapToConfigurationUserEntity(ConfigurationUserDto Input);
    ConfigurationUserResponse MapToConfigurationUserResponse(ConfigurationUserDto Input);

    #endregion
}
