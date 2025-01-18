using Hogar.HR.Domain.Requests;
using Hogar.HR.Application.Abstractions;
using Core.Application.Abstractions.Security;
using Hogar.HR.Domain.Responses;
using Core.Domain.Common;
using Hogar.HR.Application.DTO;

namespace Hogar.HR.Common.Services;

public class ManagementService : IManagementService
{
    private readonly ICurrentUserService _currentUserService;
    private readonly IManagementMapper _managementMapper;
    private readonly IManagementRepository _managementRepository;

    public ManagementService(ICurrentUserService currentUserService,
                             IManagementMapper managementMapper,
                             IManagementRepository managementRepository)
    {
        _currentUserService = Guard.Against.Null(currentUserService);
        _managementMapper = Guard.Against.Null(managementMapper);
        _managementRepository = Guard.Against.Null(managementRepository);
    }

    #region "ConfigurationUser"

    public async Task<bool> AddConfigurationToUser(AddConfigurationUserRequest request)
    {
        var inputDto = _managementMapper.MapAddToConfigurationUserDto(request);
        inputDto.CreateUser = _currentUserService.UserId;
        return await _managementRepository.AddNewParameterUser(_managementMapper.MapToAddConfigurationEntity(inputDto), inputDto.JsonStringList);
    }

    public async Task<bool> UpdateConfigurationToUser(UpdateConfigurationUserRequest request)
    {
        var inputDto = _managementMapper.MapUpdateToConfigurationUserDto(request);
        inputDto.UpdateUser = _currentUserService.UserId;
        return await _managementRepository.UpdateParameterUser(_managementMapper.MapToUpdateConfigurationEntity(inputDto), inputDto.JsonStringList);
    }

    public async Task<bool> LockConfigurationToUser(LockConfigurationUserRequest request)
    {
        var inputDto = _managementMapper.MapLockToConfigurationUserDto(request);
        inputDto.ActionUser = _currentUserService.UserId;
        return await _managementRepository.LockAllParameterToUser(_managementMapper.MapToLockActionConfigurationEntity(inputDto));
    }

    public async Task<bool> DisableConfigurationToUser(DisableConfigurationUserRequest request)
    {
        var inputDto = _managementMapper.MapDisableToConfigurationUserDto(request);
        inputDto.ActionUser = _currentUserService.UserId;
        return await _managementRepository.DisableAllParameterToUser(_managementMapper.MapToDisableActionConfigurationEntity(inputDto));
    }

    public async Task<bool> EnableConfigurationToUser(EnableConfigurationUserRequest request)
    {
        var inputDto = _managementMapper.MapEnableToConfigurationUserDto(request);
        inputDto.ActionUser = _currentUserService.UserId;
        return await _managementRepository.EnableAllParameterToUser(_managementMapper.MapToEnableActionConfigurationEntity(inputDto));
    }

    public async Task<List<ConfigurationUserResponse>> GetConfigurationToUser(ActionConfigurationUserRequest request)
    {
        var inputDto = _managementMapper.MapToConfigurationUserDto(request);
        var entity = await _managementRepository.GetParameterUser(_managementMapper.MapToConfigurationUserEntity(inputDto));
        var resultDto = entity.MapTo<List<ConfigurationUserDto>>();
        // return _managementMapper.MapToConfigurationUserResponse(_managementMapper.MapToInfoConfigurationUserDto(entity));
        return default;
    }

    #endregion
}
