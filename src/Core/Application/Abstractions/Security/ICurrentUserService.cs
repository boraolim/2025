namespace Core.Application.Abstractions.Security;

public interface ICurrentUserService
{
    string UserId { get; }
    string UserName { get; }
    string FullName { get; }
    long? Nonce { get; }
    string IpAddress { get; }
    string ApiUrl { get; }
    string Method { get; }
    ClaimsPrincipal Principal { get; }
}
