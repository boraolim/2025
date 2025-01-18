using Hogar.HR.Api.IoC;

var builder = WebApplication.CreateBuilder(args);
builder.Configuration.AddEnvironmentVariables();
ConfigureServicesExtension.ConfigureServices(builder.Services, builder.Host, builder.Configuration);
var app = builder.Build();
AppBuilderExtension.ConfigureMiddleware(app);
await app.RunAsync();
