using Core.Domain.Common;
using Core.Utils.Functions;
using Core.Application.Abstractions.Helpers;
using Core.Application.Abstractions.Security;
using Core.Application.Abstractions.Management;

using FormatConstantsCore = Core.Domain.Constants.FormatConstants;
using MainConstantsLocal = Hogar.HR.Domain.Constants.MainConstants;

namespace Hogar.HR.Common.Services;

public class SessionService : ISessionService
{
    private readonly ICypherAes _cypherAes;
    private readonly ICacheService _cacheService;
    private readonly ICurrentUserService _currentUserService;

    public SessionService(ICypherAes cypherAes,
                          ICacheService cacheService,
                          ICurrentUserService currentUserService)
    {
        _cypherAes = Guard.Against.Null(cypherAes);
        _cacheService = Guard.Against.Null(cacheService);
        _currentUserService = Guard.Against.Null(currentUserService);

        if(!_currentUserService.UserId.CheckIsNull())
            GetCurrentSesion();
    }

    public SessionCurrent SessionPresent { get; private set; }

    private void GetCurrentSesion()
    {
        var ifExistById = _cacheService.TryOrGetFromCache(string.Format(FormatConstantsCore.CFG_SESSION_ID, _currentUserService.UserId));

        if(!ifExistById.CheckIsNull())
        {
            var cyphef = _cypherAes.AESDecryptionGCM(ifExistById.ToString());
            SessionPresent = JsonSerializer.Deserialize<SessionCurrent>(cyphef);
            SessionPresent.ExpiracionUtc = DateTimeUtils.GetDateFromLinuxDateTime(long.Parse(_currentUserService.Principal?.FindFirst(MainConstantsLocal.CFG_JWT_EXPIRATION_VALUE).Value, CultureInfo.InvariantCulture));
        }
        else
        {
            SessionPresent = new SessionCurrent()
            {
                UserId = _currentUserService.UserId,
                FullName = _currentUserService.FullName,
                IsAuthenticated = true,
                RefrehToken = _currentUserService.Principal?.FindFirst(MainConstantsLocal.CFG_JWT_REFRESH_VALUE).Value,
                IpAddress = _currentUserService.IpAddress,
                ExpiracionUtc = DateTimeUtils.GetDateFromLinuxDateTime(long.Parse(_currentUserService.Principal?.FindFirst(MainConstantsLocal.CFG_JWT_EXPIRATION_VALUE).Value, CultureInfo.InvariantCulture))
            };
            _cacheService.PutInCache(string.Format(FormatConstantsCore.CFG_SESSION_ID, _currentUserService.UserId),
                _cypherAes.AESEncryptionGCM(JsonSerializer.Serialize(SessionPresent,
                new JsonSerializerOptions { WriteIndented = true })));
        }
    }
}
