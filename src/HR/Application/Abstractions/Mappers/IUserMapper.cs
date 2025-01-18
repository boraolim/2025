using Hogar.HR.Application.DTO;
using Hogar.HR.Domain.Entities;
using Hogar.HR.Domain.Requests;

namespace Hogar.HR.Application.Abstractions;

public interface IUserMapper
{
    UserEntity DtoToEntity(UserDto inputUserDto);
    UserDto EntityToDto(UserEntity inputUserEntity);
    UserDto RequestToDto(CredentialRequest inputRequest);
    UserDto RegisterToDto(RegisterRequest inputRegisterRequest);
}
