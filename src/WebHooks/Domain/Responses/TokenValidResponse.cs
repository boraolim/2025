namespace WebHooks.Domain.Responses;

public record TokenValidResponse
(
    bool IsValid,
    bool IsExpired,
    bool HasRefreshToken,
    string MessageResult
);
