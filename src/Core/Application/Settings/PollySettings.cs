namespace Core.Application.Settings;
public class PollySettings
{
    public string BaseUrl { get; set; }
    public int CacheDurationInMinutes { get; set; }
    public int RetryCount { get; set; }
    public int RetryDelayInSeconds { get; set; }
    public int FailureThreshold { get; set; }
    public int BreakDurationInSeconds { get; set; }
}

