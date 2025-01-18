using Core.Application.Wrappers;
using Core.Application.Abstractions.Helpers;

namespace Core.Application.Implementations.Helpers;

public class HttpRequestProcessor : IHttpRequestProcessor
{
    private readonly IMediator _mediator;

    public HttpRequestProcessor(IMediator mediator) =>
        _mediator = Guard.Against.Null(mediator);

    public async Task<Result<TResponse>> ExecuteAsync<TRequest, TResponse>(TRequest request) where TRequest : IRequest<TResponse>
    {
        return new Result<TResponse>()
        {
            SourceDetail = await _mediator.Send(request),
            TimeStamp = DateTime.UtcNow,
            Succeded = true
        };
    }
}
