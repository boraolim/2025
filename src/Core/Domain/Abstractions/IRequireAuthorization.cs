namespace Core.Domain.Abstractions;

public interface IRequireAuthorization
{
    string TokenBearer { get; set; }
}
