namespace Core.Application.Exceptions;

public class JwtValidationException : Exception
{
    public JwtValidationException(string message) : base(message) { }
}
