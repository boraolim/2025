namespace Hogar.HR.Domain.Responses;

public record TokenResponse
(
    string AccessToken,
    string RefreshToken
);

public record TokenValidResponse
(
    bool IsValid,
    bool IsExpired,
    bool HasRefreshToken,
    string MessageResult
);
