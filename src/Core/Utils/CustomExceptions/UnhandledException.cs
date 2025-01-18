namespace Core.Utils.CustomExceptions;

public class UnhandledException : Exception
{
    public UnhandledException(string message) : base(message) { HResult = -54; }
}
