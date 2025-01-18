using WebHooks.Application.DTO;
using WebHooks.Domain.Entities;
using WebHooks.Domain.Requests;

namespace WebHooks.Application.Abstractions.Mappers;

public interface IUserMapper
{
    UserEntity DtoToEntity(UserDto inputUserDto);
    UserDto EntityToDto(UserEntity inputUserEntity);
    UserDto RequestToDto(CredentialRequest inputRequest);
    UserDto RegisterToDto(RegisterRequest inputRegisterRequest);
}
