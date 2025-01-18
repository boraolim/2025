using Hogar.HR.Domain.Entities;
using Hogar.HR.Domain.Requests;

using Hogar.HR.Application.DTO;
using Hogar.HR.Application.Abstractions;
using Core.Application.Abstractions.Helpers;
using Core.Application.Implementations.Helpers;

namespace Hogar.HR.Common.Mappers;

public class UserMapper : IUserMapper
{
    private readonly ICypherAes _cypherAes;
    public UserMapper(ICypherAes cypherAes)
    {
        _cypherAes = cypherAes;
    }

    public UserEntity DtoToEntity(UserDto inputUserDto)
    {
        return new UserEntity()
        {
            UserName = inputUserDto.IdUser.ToLower().Trim(),
            UserSecret = inputUserDto.SecretUser.Trim(),
            UserFullName = inputUserDto.NameFull.ToUpper().Trim()
        };
    }

    public UserDto EntityToDto(UserEntity inputUserEntity)
    {
        return new UserDto()
        {
            IdCredential = inputUserEntity.Id,
            IdUser = inputUserEntity.UserName,
            SecretUser = inputUserEntity.UserSecret,
            NameFull = inputUserEntity.UserFullName,
            LastRefreshDate = inputUserEntity.LastRefreshDate
        };
    }

    public UserDto RegisterToDto(RegisterRequest inputRegisterRequest)
    {
        return new UserDto()
        {
            IdUser = inputRegisterRequest.Username,
            SecretUser = _cypherAes.AESEncryptionGCM(inputRegisterRequest.Password),
            NameFull = inputRegisterRequest.Fullname
        };
    }

    public UserDto RequestToDto(CredentialRequest inputRequest)
    {
        return new UserDto()
        {
            IdUser = inputRequest.UserName,
            SecretUser = inputRequest.PasswordValue
        };
    }
}
