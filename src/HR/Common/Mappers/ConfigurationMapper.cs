using Core.Domain.Common;
using Hogar.HR.Application.DTO;
using Hogar.HR.Domain.Entities;
using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;
using Hogar.HR.Application.Abstractions;

namespace Hogar.HR.Common.Mappers;

public sealed class ConfigurationMapper : IConfigurationMapper
{
    public List<ConfigurationDto> MapEntityToDto(List<ConfigurationEntity> inputEntity) =>
        inputEntity.Select(item => item.MapTo<ConfigurationDto>()).ToList();

    public ConfigurationEntity MapToEntityFromGroup(GroupNameDto inputDto) =>
        new ConfigurationEntity()
        {
            GroupName = inputDto.GroupName
        };

    public ConfigurationEntity MapToEntityFromKey(KeyNameDto inputDto) =>
        new ConfigurationEntity()
        {
            GroupName = inputDto.GroupName,
            SubGroupName = inputDto.SubGroupName,
            KeyName = inputDto.KeyName
        };

    public ConfigurationEntity MapToEntityFromSubGroup(SubGroupNameDto inputDto) =>
        new ConfigurationEntity()
        {
            GroupName = inputDto.GroupName,
            SubGroupName = inputDto.SubGroupName
        };

    public ConfigurationEntity MapAddToEntityFromKeyValue(KeyValueDto inputDto) =>
        new ConfigurationEntity()
        {
            GroupName = inputDto.GroupName,
            SubGroupName = inputDto.SubGroupName,
            KeyName = inputDto.KeyName,
            KeyValue = inputDto.KeyValue,
            ValueType = inputDto.ValueType,
            KeyDescription = inputDto.Comments,
            CreateUser = inputDto.CreateUser
        };

    public ConfigurationEntity MapUpdateToEntityFromKeyValue(KeyValueDto inputDto) =>
        new ConfigurationEntity()
        {
            GroupName = inputDto.GroupName,
            SubGroupName = inputDto.SubGroupName,
            KeyName = inputDto.KeyName,
            KeyValue = inputDto.KeyValue,
            ValueType = inputDto.ValueType,
            KeyDescription = inputDto.Comments,
            UpdateUser = inputDto.UpdateUser
        };

    public ConfigurationEntity MapToEntityFromEnableGroup(EnableGroupDto inputDto) =>
        new ConfigurationEntity()
        {
            GroupName = inputDto.GroupName,
            UpdateUser = inputDto.UpdateUser            
        };

    public ConfigurationEntity MapToEntityFromEnableSubGroup(EnableSubGroupDto inputDto) =>
        new ConfigurationEntity()
        {
            GroupName = inputDto.GroupName,
            SubGroupName = inputDto.SubGroupName,
            UpdateUser = inputDto.UpdateUser
        };

    public ConfigurationEntity MapToEntityFromEnableKeyName(EnableKeyNameDto inputDto) =>
        new ConfigurationEntity()
        {
            GroupName = inputDto.GroupName,
            SubGroupName = inputDto.SubGroupName,
            KeyName = inputDto.KeyName,
            UpdateUser = inputDto.UpdateUser
        };

    public GroupNameDto MapToGroupNameDto(GroupRequest requestInput) =>
        new GroupNameDto()
        {
            GroupName = requestInput.GroupName
        };

    public SubGroupNameDto MapToSubGroupNameDto(SubGroupRequest requestInput) =>
        new SubGroupNameDto()
        {
            GroupName = requestInput.GroupName,
            SubGroupName = requestInput.SubGroupName
        };

    public KeyNameDto MapToKeyNameDto(KeyNameRequest requestInput) =>
        new KeyNameDto()
        {
            GroupName = requestInput.GroupName,
            SubGroupName = requestInput.SubGroupName,
            KeyName = requestInput.KeyName
        };

    public KeyValueDto MapAddToKeyValueDto(AddKeyValueRequest requestInput) =>
        new KeyValueDto()
        {
            GroupName = requestInput.GroupName,
            SubGroupName = requestInput.SubGroupName,
            KeyName = requestInput.KeyName,
            KeyValue = requestInput.KeyValue,
            ValueType = requestInput.ValueType,
            Comments = requestInput.Comments
        };

    public KeyValueDto MapUpdateToKeyValueDto(UpdateKeyValueRequest requestInput) =>
        new KeyValueDto()
        {
            GroupName = requestInput.GroupName,
            SubGroupName = requestInput.SubGroupName,
            KeyName = requestInput.KeyName,
            KeyValue = requestInput.KeyValue,
            ValueType = requestInput.ValueType,
            Comments = requestInput.Comments
        };

    public List<ConfigurationResponse> MapDtoToResponse(List<ConfigurationDto> inputDto) =>
        inputDto.Select(item => item.MapTo<ConfigurationResponse>()).ToList();

    public ConfigurationResponse MapDtoFromUniqueResponse(ConfigurationDto inputDto) =>
        inputDto.MapTo<ConfigurationResponse>();

    public ConfigurationDto MapToUniqueDto(ConfigurationEntity inputEntity) =>
        inputEntity.MapTo<ConfigurationDto>();

    public EnableGroupDto MapToEnableGroupDto(EnableGroupRequest requestInput) =>
        new EnableGroupDto()
        {
            GroupName = requestInput.GroupName,
            ShutDownValue = requestInput.ShutDownValue
        };

    public EnableSubGroupDto MapToEnableSubGroupDto(EnableSubGroupRequest requestInput) =>
        new EnableSubGroupDto()
        {
            GroupName = requestInput.GroupName,
            SubGroupName = requestInput.SubGroupName,
            ShutDownValue = requestInput.ShutDownValue
        };

    public EnableKeyNameDto MapToEnableKeyNameDto(EnableKeyNameRequest requestInput) =>
        new EnableKeyNameDto()
        {
            GroupName = requestInput.GroupName,
            SubGroupName = requestInput.SubGroupName,
            KeyName = requestInput.KeyName,
            ShutDownValue = requestInput.ShutDownValue
        };
}
