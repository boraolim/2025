using System.Reflection;

using MediatR;
using FluentValidation;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

using Core.Application.Behaviours;
using Core.Application.Abstractions.Helpers;
using Core.Application.Implementations.Helpers;

namespace WebHooks.Application.IoC;

public static class ServiceCollection
{
    public static IServiceCollection AddWebHookApplicationService(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddValidatorsFromAssembly(Assembly.GetExecutingAssembly());
        services.AddMediatR(cfg => cfg.RegisterServicesFromAssemblies(Assembly.GetExecutingAssembly()));

        services.AddScoped(typeof(IHttpRequestProcessor), typeof(HttpRequestProcessor));
        services.AddTransient(typeof(IJsonToStringHelper<>), typeof(JsonToStringHelper<>));
        services.AddTransient(typeof(IPipelineBehavior<,>), typeof(AuthorizationBehaviour<,>));
        services.AddTransient(typeof(IPipelineBehavior<,>), typeof(UnhandledExceptionBehaviour<,>));
        services.AddTransient(typeof(IPipelineBehavior<,>), typeof(ValidationBehaviour<,>));
        services.AddTransient(typeof(IPipelineBehavior<,>), typeof(PerformanceBehaviour<,>));

        return services;
    }
}
