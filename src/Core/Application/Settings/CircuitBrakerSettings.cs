namespace Core.Application.Settings;

public class CircuitBrakerSettings
{
    public int FailureThreshold { get; set; }
    public int BreakDurationInSeconds { get; set; }
}

