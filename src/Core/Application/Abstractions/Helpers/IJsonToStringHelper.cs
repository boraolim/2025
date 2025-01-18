namespace Core.Application.Abstractions.Helpers;

public interface IJsonToStringHelper<T>
{
    string SerializeToString(in T objSource);
}
