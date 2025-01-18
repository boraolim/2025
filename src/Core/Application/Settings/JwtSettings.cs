namespace Core.Application.Settings;

public class JwtSettings
{
    public string ClientSecretKey { get; set; }
    public string Issuer { get; set; }
    public string Audience { get; set; }
    public uint DurationLifeTime { get; set; }
}
