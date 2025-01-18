namespace Core.Utils.CustomExceptions;

public class EntityAlreadyExistsException : Exception
{
    public EntityAlreadyExistsException(string message) : base(message) { HResult = -50; }
}
