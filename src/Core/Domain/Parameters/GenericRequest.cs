namespace Core.Domain.Parameters;

public sealed record GenericRequest
(
    string Cadena
) : IRequest<bool>;
