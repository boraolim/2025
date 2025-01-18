namespace Core.Utils.CustomExceptions;

public class DbFactoryException : Exception
{
    public DbFactoryException(string message) : base(message) { HResult = -49; }
}
