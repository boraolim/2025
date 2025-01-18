using Core.Domain.Common;
using Hogar.HR.Domain.Requests;
using Hogar.HR.Domain.Responses;
using Hogar.HR.Application.Abstractions;
using Core.Application.Abstractions.Security;

namespace Hogar.HR.Common.Services;

public class ConfigurationService : IConfigurationService
{
    private readonly ICurrentUserService _currentUserService;
    private readonly IConfigurationMapper _configurationMapper;
    private readonly IConfigurationRepository _configurationRepository;

    public ConfigurationService(ICurrentUserService currentUserService,
                                IConfigurationMapper configurationMapper, 
                                IConfigurationRepository configurationRepository)
    {
        _currentUserService = Guard.Against.Null(currentUserService);
        _configurationMapper = Guard.Against.Null(configurationMapper);
        _configurationRepository = Guard.Against.Null(configurationRepository);
    }

    public async Task<List<ConfigurationResponse>> GetConfigurationByGroup(GroupRequest request)
    {
        var inputEntity = _configurationMapper.MapToEntityFromGroup(_configurationMapper.MapToGroupNameDto(request));
        var fromEntity = await _configurationRepository.GetConfigurationByGroup(inputEntity);
        return _configurationMapper.MapDtoToResponse(_configurationMapper.MapEntityToDto(fromEntity));
    }

    public async Task<List<ConfigurationResponse>> GetConfigurationBySubGroup(SubGroupRequest request)
    {
        var inputEntity = _configurationMapper.MapToEntityFromSubGroup(_configurationMapper.MapToSubGroupNameDto(request));
        var fromEntity = await _configurationRepository.GetConfigurationBySubGroup(inputEntity);
        return _configurationMapper.MapDtoToResponse(_configurationMapper.MapEntityToDto(fromEntity));
    }

    public async Task<ConfigurationResponse> GetKeyName(KeyNameRequest request)
    {
        var inputEntity = _configurationMapper.MapToEntityFromKey(_configurationMapper.MapToKeyNameDto(request));
        var fromEntity = await _configurationRepository.GetConfigurationByKeyName(inputEntity);
        return _configurationMapper.MapDtoFromUniqueResponse(_configurationMapper.MapToUniqueDto(fromEntity));
    }

    public async Task<bool> SaveKeyValue(AddKeyValueRequest request)
    {
        var inputDto = _configurationMapper.MapAddToKeyValueDto(request);
        inputDto.CreateUser = _currentUserService.UserId;
        return await _configurationRepository.AddConfiguration(_configurationMapper.MapAddToEntityFromKeyValue(inputDto));
    }

    public async Task<bool> UpdateKeyValue(UpdateKeyValueRequest request)
    {
        var inputDto = _configurationMapper.MapUpdateToKeyValueDto(request);
        inputDto.UpdateUser = _currentUserService.UserId;
        return await _configurationRepository.UpdateConfiguration(_configurationMapper.MapUpdateToEntityFromKeyValue(inputDto));
    }

    public async Task<bool> EnableGroup(EnableGroupRequest request)
    {
        var inputDto = _configurationMapper.MapToEnableGroupDto(request);
        inputDto.UpdateUser = _currentUserService.UserId;
        return await _configurationRepository.EnableConfiguracionForGroup(_configurationMapper.MapToEntityFromEnableGroup(inputDto), inputDto.ShutDownValue);
    }

    public async Task<bool> EnableSubGroup(EnableSubGroupRequest request)
    {
        var inputDto = _configurationMapper.MapToEnableSubGroupDto(request);
        inputDto.UpdateUser = _currentUserService.UserId;
        return await _configurationRepository.EnableConfiguracionForSubGroup(_configurationMapper.MapToEntityFromEnableSubGroup(inputDto), inputDto.ShutDownValue);
    }

    public async Task<bool> EnableKeyName(EnableKeyNameRequest request)
    {
        var inputDto = _configurationMapper.MapToEnableKeyNameDto(request);
        inputDto.UpdateUser = _currentUserService.UserId;
        return await _configurationRepository.EnableConfigurationForKeyName(_configurationMapper.MapToEntityFromEnableKeyName(inputDto), inputDto.ShutDownValue);
    }
}
