namespace Core.Domain.Common;

public class SessionCurrent
{
    public string UserId { get; set; }
    public string FullName { get; set; }
    public bool IsAuthenticated { get; set; }
    public string RefrehToken { get; set; }
    public string IpAddress { get; set; }
    public DateTime? ExpiracionUtc { get; set; }
}
