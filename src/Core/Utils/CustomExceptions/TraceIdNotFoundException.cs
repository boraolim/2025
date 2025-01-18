namespace Core.Utils.CustomExceptions;

public class TraceIdNotFoundException : Exception
{
    public TraceIdNotFoundException(string message) : base(message) { HResult = -53; }
}
