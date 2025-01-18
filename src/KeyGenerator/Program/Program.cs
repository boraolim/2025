using KeyGenerator.Main;
using KeyGenerator.Settings;

using Microsoft.Extensions.Options;
using Microsoft.Extensions.DependencyInjection;

public class Program
{
    public static async Task Main(string[] args)
    {
        var services = KeyGenerator.IoC.ServiceCollection.ConfigurationServices();
        var serviceProvider = services.BuildServiceProvider();
        await serviceProvider.GetService<App>().RunAsync(args);
    }
}
