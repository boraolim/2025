namespace WebHooks.Domain.Requests;

public record RegisterRequest
(
    string Username,
    string Password,
    string Fullname
) : IRequest<bool>;
