using MessageConstantsCore = Core.Domain.Constants.MessageConstants;

namespace Core.Utils.CustomExceptions;

public class EntityNotFoundException : Exception
{
    public Type EntityType { get; set; }
    public object Id { get; set; }
    public EntityNotFoundException() : base() { HResult = -51; }
    public EntityNotFoundException(Type entityType) : this(entityType, null, null) { HResult = -51; }
    public EntityNotFoundException(Type entityType, object IdValue) : this(entityType, IdValue, null) { HResult = -52; }
    public EntityNotFoundException(Type entityType, object IdValue, Exception innerException) : base(
        IdValue == null ? string.Format(MessageConstantsCore.MSG_ENTITY_NOT_FOUND, entityType.FullName.Trim()) :
                    string.Format(MessageConstantsCore.MSG_ENTITY_BY_ID_NOT_FOUND, entityType.FullName.Trim(), IdValue), innerException)
    { EntityType = entityType; Id = IdValue; }
    public EntityNotFoundException(string message) : base(message) { HResult = -51; }
    public EntityNotFoundException(string message, Exception innerException) : base(message, innerException) { HResult = -51; }
}
