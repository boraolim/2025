namespace Core.Application.Exceptions;

public class TraceIdNotFoundException : Exception
{
    public TraceIdNotFoundException(string message) : base(message) { HResult = -53; }
}
