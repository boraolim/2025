using Core.Domain.Common;

namespace Hogar.HR.Domain.Entities;

public class UserTokensEntity : BaseEntity<Guid>
{
    public string IdCredential { get; set; }
    public string Token { get; set; }
    public DateTime ExpirationDate { get; set; }
    public string IpAddress { get; set; }
}
