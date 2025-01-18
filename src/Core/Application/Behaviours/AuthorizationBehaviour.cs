using Core.Domain.Common;
using Core.Application.Attributes;
using Core.Application.Abstractions.Security;

namespace Core.Application.Behaviours;

public sealed class AuthorizationBehaviour<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse> 
    where TRequest : notnull
{
    private readonly ISessionService _sessionService;
    private readonly ICurrentUserService _currentUserService;

    public AuthorizationBehaviour(ISessionService sessionService,
                                  ICurrentUserService currentUserService) =>
        (_sessionService, _currentUserService) = 
        (Guard.Against.Null(sessionService), Guard.Against.Null(currentUserService));

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
    {
        var authorizationAttributes = request.GetType()
            .GetCustomAttributes<AuthorizeAttribute>()
            .ToList();

        if(authorizationAttributes.Any())
        {
            var session = _sessionService.SessionPresent;
            if(session.CheckIsNull())
            {
                throw new UnauthorizedAccessException();
            }
        }

        return await next();
    }
}
