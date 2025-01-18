namespace WebHooks.Domain.Responses;

public record TokenResponse
(
    string AccessToken,
    string RefreshToken
);
