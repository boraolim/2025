using Microsoft.Extensions.Options;
using Microsoft.Extensions.DependencyInjection;

using KeyGenerator.Settings;
using KeyGenerator.Abstractions;

namespace KeyGenerator.Main;

public class App
{
    private readonly IMainService _mainService;

    public App(IMainService mainService) =>
        _mainService = mainService;

    public async Task RunAsync(string[] args) =>
        await _mainService.DoActionSomethingAsync();
}
