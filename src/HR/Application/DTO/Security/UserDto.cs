namespace Hogar.HR.Application.DTO;

public class UserDto
{
    public Guid IdCredential { get; set; }
    public string NameFull { get; set; }
    public string IdUser { get; set; }
    public string SecretUser { get; set; }
    public DateTime? LastRefreshDate { get; set; }
}
