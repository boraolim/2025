namespace Core.Application.Settings;
public class PollySettings
{
    public int CacheDurationInMinutes { get; set; }
    public int RetryCount { get; set; }
    public int RetryDelayInSeconds { get; set; }
    public int FailureThreshold { get; set; }
    public int BreakDurationInSeconds { get; set; }
    public int BreakDelayInSeconds { get; set; }
}

