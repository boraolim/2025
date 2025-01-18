using Core.Domain.Abstractions;

namespace Core.Application.Wrappers;

public class Result<T> : IResult<T>
{
    public bool Succeded { get; set; }
    public string TraceId { get; set; }
    public string MessageDescription { get; set; }
    public int StatusCode { get; set; }
    public DateTime? TimeStamp { get; set; }
    public Dictionary<string, string> ErrorDetail { get; set; }
    public T SourceDetail { get; set; }
    public Exception ExceptionObject { get; set; }
    public string UrlPathDetail { get; set; }

    #region Non Async Methods

    #region Success Methods

    public static Result<T> Success() =>
        new Result<T> { Succeded = true };
    public static Result<T> Success(string message) =>
        new Result<T> { Succeded = true, MessageDescription = message };
    public static Result<T> Success(T data) =>
        new Result<T> { Succeded = true, SourceDetail = data };
    public static Result<T> Success(T data, string message, int statusCode = (int)HttpStatusCode.Created) =>
        new Result<T> { Succeded = true, MessageDescription = message, SourceDetail = data, StatusCode = statusCode };

    #endregion

    #region Failure Methods

    public static Result<T> Failure() =>
        new Result<T> { Succeded = false };
    public static Result<T> Failure(string message, int statusCode = (int)HttpStatusCode.BadRequest) =>
        new Result<T> { Succeded = false, MessageDescription = message, StatusCode = statusCode };
    public static Result<T> Failure(Dictionary<string, string> errors) =>
        new Result<T> { Succeded = false, ErrorDetail = errors };
    public static Result<T> Failure(T data) =>
        new Result<T> { Succeded = false, SourceDetail = data };
    public static Result<T> Failure(T data, string message) =>
        new Result<T> { Succeded = false, MessageDescription = message, SourceDetail = data };
    public static Result<T> Failure(T data, Dictionary<string, string> errors) =>
        new Result<T> { Succeded = false, ErrorDetail = errors, SourceDetail = data };
    public static Result<T> Failure(string message, Dictionary<string, string> errors) =>
        new Result<T> { Succeded = false, ErrorDetail = errors, MessageDescription = message };
    public static Result<T> Failure(string message, Exception exceptionInfo, Dictionary<string, string> errors) =>
        new Result<T> { Succeded = false, ErrorDetail = errors, MessageDescription = message, ExceptionObject = exceptionInfo };
    public static Result<T> Failure(Exception exceptionInfo) =>
        new Result<T> { Succeded = false, ExceptionObject = exceptionInfo };

    #endregion

    #endregion

    #region Async Methods

    #region Success Methods

    public static Task<Result<T>> SuccessAsync() =>
        Task.FromResult(Success());
    public static Task<Result<T>> SuccessAsync(string message) =>
        Task.FromResult(Success(message));
    public static Task<Result<T>> SuccessAsync(T data) =>
        Task.FromResult(Success(data));
    public static Task<Result<T>> SuccessAsync(T data, string message) =>
        Task.FromResult(Success(data, message));

    #endregion

    #region Failure Methods

    public static Task<Result<T>> FailureAsync() =>
        Task.FromResult(Failure());
    public static Task<Result<T>> FailureAsync(string message) =>
        Task.FromResult(Failure(message));
    public static Task<Result<T>> FailureAsync(Dictionary<string, string> errors) =>
        Task.FromResult(Failure(errors));
    public static Task<Result<T>> FailureAsync(T data) =>
        Task.FromResult(Failure(data));
    public static Task<Result<T>> FailureAsync(T data, string message) =>
        Task.FromResult(Failure(data, message));
    public static Task<Result<T>> FailureAsync(T data, Dictionary<string, string> errors) =>
        Task.FromResult(Failure(data, errors));
    public static Task<Result<T>> FailureAsync(string message, Dictionary<string, string> errors) =>
        Task.FromResult(Failure(message, errors));
    public static Task<Result<T>> FailureAsync(string message, Exception exception, Dictionary<string, string> errors) =>
        Task.FromResult(Failure(message, exception, errors));
    public static Task<Result<T>> FailureAsync(Exception exception) =>
        Task.FromResult(Failure(exception));

    #endregion

    #endregion

    #region "Bind"

    public Result<U> Bind<U>(Func<T, Result<U>> next)
    {
        if(!Succeded) return Result<U>.Failure(MessageDescription);
        return next(SourceDetail);
    }

    public async Task<Result<U>> BindAsync<U>(Func<T, Task<Result<U>>> next)
    {
        if (!Succeded) return await Result<U>.FailureAsync(MessageDescription);
        return await next(SourceDetail);
    }

    #endregion

    #region "Map"

    public Result<U> Map<U>(Func<T, U> transform)
    {
        if(!Succeded) return Result<U>.Failure(MessageDescription);
        return Result<U>.Success(transform(SourceDetail));
    }

    public async Task<Result<U>> MapAsync<U>(Func<T, Task<U>> transform)
    {
        if(!Succeded) return await Result<U>.FailureAsync(MessageDescription);
        var newData = await transform(SourceDetail);
        return await Result<U>.SuccessAsync(newData);
    }

    #endregion

    #region "TryCatch"

    public static Result<T> TryCatch(Func<T> next, string Message = "Ocurrió un error inesperadp")
    {
        try
        {
            var data = next();
            return Success(data);
        }
        catch(Exception error)
        {
            return Failure($"{Message} : {error.Message}");
        }
    }

    public static async Task<Result<T>> TryCatchAsync(Func<Task<T>> next, string Message = "Ocurrió un error inesperado")
    {
        try
        {
            var data = await next();
            return await SuccessAsync(data);
        }
        catch(Exception error)
        {
            return await FailureAsync($"{Message}: {error.Message}");
        }
    }

    #endregion

    #region "Match"

    public void Match(Action<T> onSuccess, Action<string> onFailure)
    {
        if(Succeded)
        {
            onSuccess?.Invoke(SourceDetail);
        }
        else
        {
            onFailure?.Invoke(MessageDescription);
        }
    }

    public async Task MatchAsync(Func<T, Task> onSuccess, Func<string, Task> onFailure)
    {
        if(Succeded)
        {
            if(onSuccess != null) await onSuccess(SourceDetail);
        }
        else
        {
            if(onFailure != null) await onFailure(MessageDescription);
        }
    }

    #endregion
}
