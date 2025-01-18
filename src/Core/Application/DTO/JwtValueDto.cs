namespace Core.Application.DTO;

public class JwtValueDto
{
    public string UserName { get; set; }
    public Guid IdClient { get; set; }
    public Guid TokenId { get; set; }
    public string FullName { get; set; }
    public string RefreshValue { get; set; }
    public string KeyAPI { get; set; }
}
