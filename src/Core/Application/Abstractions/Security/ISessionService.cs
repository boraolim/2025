using Core.Domain.Common;

namespace Core.Application.Abstractions.Security;

public interface ISessionService
{
    SessionCurrent SessionPresent { get; }
}

