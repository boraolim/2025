using Core.Application.Wrappers;

namespace Core.Application.Abstractions.Helpers;

public interface IHttpRequestProcessor
{
    public Task<Result<TResponse>> ExecuteAsync<TRequest, TResponse>(TRequest request) where TRequest : IRequest<TResponse>;
}
