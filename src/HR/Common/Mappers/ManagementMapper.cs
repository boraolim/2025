using Core.Utils.Functions;
using Hogar.HR.Application.DTO;
using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Entities;
using Hogar.HR.Application.Abstractions;
using Hogar.HR.Domain.Responses;

namespace Hogar.HR.Common.Mappers;

public class ManagementMapper : IManagementMapper
{

    #region "ConfigurationUser"

    public AddConfigurationUserDto MapAddToConfigurationUserDto(AddConfigurationUserRequest Input) =>
        new AddConfigurationUserDto()
        {
            CredentialId = Input.CredentialId,
            JsonStringList = Functions.FormatearObjectToJson(Input.ConfigurationIdList)
        };
    public UpdateConfigurationUserDto MapUpdateToConfigurationUserDto(UpdateConfigurationUserRequest Input) =>
        new UpdateConfigurationUserDto()
        {
            CredentialId = Input.CredentialId,
            JsonStringList = Functions.FormatearObjectToJson(Input.ConfigurationIdList)
        };
    public ActionConfigurationUserDto MapLockToConfigurationUserDto(LockConfigurationUserRequest Input) =>
        new ActionConfigurationUserDto()
        {
            CredentialId = Input.CredentialId
        };

    public ActionConfigurationUserDto MapDisableToConfigurationUserDto(DisableConfigurationUserRequest Input) =>
        new ActionConfigurationUserDto()
        {
            CredentialId = Input.CredentialId
        };

    public ActionConfigurationUserDto MapEnableToConfigurationUserDto(EnableConfigurationUserRequest Input) => 
        new ActionConfigurationUserDto()
        {
            CredentialId = Input.CredentialId
        };

    public ConfigurationUserEntity MapToAddConfigurationEntity(AddConfigurationUserDto Input) =>
        new ConfigurationUserEntity()
        {
            CredentialId = Guid.Parse(Input.CredentialId),
            CreateUser = Input.CreateUser
        };

    public ConfigurationUserEntity MapToUpdateConfigurationEntity(UpdateConfigurationUserDto Input) =>
        new ConfigurationUserEntity()
        {
            CredentialId = Guid.Parse(Input.CredentialId),
            UpdateUser = Input.UpdateUser
        };

    public ConfigurationUserEntity MapToLockActionConfigurationEntity(ActionConfigurationUserDto Input) =>
        new ConfigurationUserEntity()
        {
            CredentialId = Guid.Parse(Input.CredentialId),
            UpdateUser = Input.ActionUser
        };

    public ConfigurationUserEntity MapToDisableActionConfigurationEntity(ActionConfigurationUserDto Input) =>
        new ConfigurationUserEntity()
        {
            CredentialId = Guid.Parse(Input.CredentialId),
            DeleteUser = Input.ActionUser
        };

    public ConfigurationUserEntity MapToEnableActionConfigurationEntity(ActionConfigurationUserDto Input) =>
        new ConfigurationUserEntity()
        {
            CredentialId = Guid.Parse(Input.CredentialId),
            UpdateUser = Input.ActionUser
        };

    public ConfigurationUserDto MapToInfoConfigurationUserDto(ConfigurationUserEntity Input) =>
        new ConfigurationUserDto()
        {
            CredentialId = Input.CredentialId.ToString(),
            UserFullName = Input.UserFullName,
            ParameterId = Input.ParameterId,
            GroupName = Input.GroupName,
            SubGroupName = Input.SubGroupName,
            ParameterKey = Input.ParameterKey,
            ValueParameter = Input.ValueParameter,
            ValueType = Input.ValueType,
            ParameterDescription = Input.ParameterDescription
        };

    public ConfigurationUserDto MapToConfigurationUserDto(ActionConfigurationUserRequest Input) =>
        new ConfigurationUserDto()
        {
            CredentialId = Input.CredentialId
        };

    public ConfigurationUserEntity MapToConfigurationUserEntity(ConfigurationUserDto Input) =>
        new ConfigurationUserEntity()
        {
            CredentialId = Guid.Parse(Input.CredentialId)
        };

    public ConfigurationUserResponse MapToConfigurationUserResponse(ConfigurationUserDto Input) =>
        new ConfigurationUserResponse
        (
            Input.CredentialId,
            Input.UserFullName,
            Input.ParameterId,
            Input.GroupName,
            Input.SubGroupName,
            Input.ParameterKey,
            Input.ValueParameter,
            Input.ValueType,
            Input.ParameterDescription
        );

    #endregion
}
