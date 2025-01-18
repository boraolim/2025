using KeyGenerator.Abstractions;
using KeyGenerator.Settings;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;

namespace KeyGenerator.Main;

public class App
{
    private readonly IMainService _mainService;

    public App(IMainService mainService) =>
        _mainService = mainService;

    public async Task RunAsync(string[] args) =>
        await _mainService.DoActionSomethingAsync();
}
