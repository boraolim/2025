namespace Core.Application.Exceptions;

public class UnhandledException : Exception
{
    public UnhandledException(string message) : base(message) { HResult = -54; }
}
