using WebHooks.Application.DTO;
using WebHooks.Domain.Entities;

namespace WebHooks.Application.Abstractions.Persistence;

public interface ISecurityRepository
{
    Task<int> Register(UserEntity itemToInsert);
    Task<UserEntity> GetAccountByUserName(string userName);
    Task<UserEntity> GetAccountById(Guid id);
    Task<string> GetTokenValueToRefresh(string userName, string idToken);
    Task<bool> GetStatusExpiration(string idToken);
    Task<Guid> SaveNewToken(string refreshToken, string userName, string direccionIP, string author);
    Task<Guid> SaveRefreshToken(string idToken, string userName, string refreshToken, string direccionIP, string author);
    Task<string> SaveAndClearExpiration(string idToken, string userName, string author);
}
