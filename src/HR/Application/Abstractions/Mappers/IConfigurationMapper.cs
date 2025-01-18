using Hogar.HR.Application.DTO;
using Hogar.HR.Domain.Entities;
using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;

namespace Hogar.HR.Application.Abstractions;

public interface IConfigurationMapper
{
    GroupNameDto MapToGroupNameDto(GroupRequest requestInput);
    SubGroupNameDto MapToSubGroupNameDto(SubGroupRequest requestInput);
    KeyNameDto MapToKeyNameDto(KeyNameRequest requestInput);
    KeyValueDto MapAddToKeyValueDto(AddKeyValueRequest requestInput);
    KeyValueDto MapUpdateToKeyValueDto(UpdateKeyValueRequest requestInput);
    EnableGroupDto MapToEnableGroupDto(EnableGroupRequest requestInput);
    EnableSubGroupDto MapToEnableSubGroupDto(EnableSubGroupRequest requestInput);
    ConfigurationEntity MapToEntityFromGroup(GroupNameDto inputDto);
    ConfigurationEntity MapToEntityFromSubGroup(SubGroupNameDto inputDto);
    ConfigurationEntity MapToEntityFromKey(KeyNameDto inputDto);
    ConfigurationEntity MapAddToEntityFromKeyValue(KeyValueDto inputDto);
    List<ConfigurationResponse> MapDtoToResponse(List<ConfigurationDto> inputDto);
    List<ConfigurationDto> MapEntityToDto(List<ConfigurationEntity> inputEntity);
    ConfigurationResponse MapDtoFromUniqueResponse(ConfigurationDto inputDto);
    ConfigurationDto MapToUniqueDto(ConfigurationEntity inputEntity);
    ConfigurationEntity MapToEntityFromEnableGroup(EnableGroupDto inputDto);
    ConfigurationEntity MapToEntityFromEnableSubGroup(EnableSubGroupDto inputDto);
    EnableKeyNameDto MapToEnableKeyNameDto(EnableKeyNameRequest requestInput);
    ConfigurationEntity MapToEntityFromEnableKeyName(EnableKeyNameDto inputDto);
    ConfigurationEntity MapUpdateToEntityFromKeyValue(KeyValueDto inputDto);
}
