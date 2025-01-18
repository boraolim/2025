namespace Core.Application.Settings;
public class PollySettings
{
    public string BaseUrl { get; set; }
    public int CacheDurationInMinutes { get; set; }
    public int RetryCount { get; set; }
    public int RetryDelayInSeconds { get; set; }
    public CircuitBrakerSettings CircuitBraker { get; set; }
}

