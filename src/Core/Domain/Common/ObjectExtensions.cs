namespace Core.Domain.Common;

public static class ObjectExtensions
{
    public static bool CheckIsNull(this object input) => input is null;
    public static object? GetToNull(this object input) => null;
    public static object ToObject(this object input) => input;
    public static List<TSource> ConvertTo<TSource, TDestination>(this List<TDestination> source, Func<TDestination, TSource> converter) =>
        source.Select(converter).ToList();
}
