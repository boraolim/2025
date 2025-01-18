using Hogar.HR.Api.Infrastructure.Extensions;
using Hogar.HR.Api.Infrastructure.Middleware;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using FormatConstantsCore = Core.Domain.Constants.FormatConstants;

namespace Hogar.HR.Api.IoC;

public static class AppBuilderExtension
{
    public static void ConfigureMiddleware(WebApplication app)
    {
        if(app.Environment.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
            app.UseSwagger();
            app.UseSwaggerUI(c => c.SwaggerEndpoint(string.Format(MainConstantsCore.CFG_SWAGGER_END_POINT, MainConstantsCore.CFG_API_VERSION_V1),
                string.Format(FormatConstantsCore.CFG_API_NAME, MainConstantsCore.CFG_API_VERSION_V1)));
        }
        else
        {
            app.UseExceptionHandler(MainConstantsCore.CFG_PATH_ERRORS);
            app.UseHsts();
        }
        app.UseCors(MainConstantsCore.CFG_VALUE_CORS);
        app.UseRouting();
        app.UseMiddleware<AddHeaderMiddleware>();
        app.UseMiddleware<ErrorHandlerMiddleware>();
        app.UseMiddleware<TraceIdDetectionMiddleware>();
        app.UseMiddleware<JwtValidationMiddleware>();
        app.UseHealthChecks(MainConstantsCore.CFG_PATH_HEALTH);
        app.UseAuthentication();
        app.UseAuthorization();
        app.MapControllers();
        app.UseSerilogRequestLogging(options => options.EnrichDiagnosticContext = LogEnricherExtension.EnrichFromRequest);
        app.MigrateDataBase<Program>();
    }
}
