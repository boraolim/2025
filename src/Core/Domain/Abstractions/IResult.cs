namespace Core.Domain.Abstractions;

public interface IResult<T>
{
    bool Succeded { get; set; }
    string TraceId { get; set; }
    string MessageDescription { get; set; }
    int StatusCode { get; set; }
    DateTime? TimeStamp { get; set; }
    Exception ExceptionObject { get; set; }
    T SourceDetail { get; set; }
    Dictionary<string, string> ErrorDetail { get; set; }
    string UrlPathDetail { get; set; }
}
