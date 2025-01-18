using MediatR;
using Ardalis.GuardClauses;

using Core.Domain.Common;
using WebHooks.Domain.Requests;
using Core.Application.Abstractions.Management;

namespace WebHooks.Application.Handlers
{
    public sealed class SayHelloHandler : IRequestHandler<GreetingRequest, string>
    {
        private readonly ICacheService _cacheService;

        public SayHelloHandler(ICacheService cacheService) =>
            (_cacheService) = (Guard.Against.Null(cacheService));

        public async Task<string> Handle(GreetingRequest request, CancellationToken cancellationToken)
        {
            var sKey = $"session_{request.NamePerson}";

            var isCached = _cacheService.TryOrGetFromCache(sKey);

            if(!isCached.CheckIsNull())
                return await Task.FromResult($"Cacheado: {isCached}");

            string saludo = $"Hola {request.NamePerson}";
            _cacheService.PutInCache(sKey, saludo);
            return await Task.FromResult(saludo);
        }
    }
}
