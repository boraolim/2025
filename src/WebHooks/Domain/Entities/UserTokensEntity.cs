using System.ComponentModel.DataAnnotations;

using Core.Domain.Common;

namespace WebHooks.Domain.Entities;

public class UserTokensEntity : BaseEntity<Guid>
{
    public string IdCredential { get; set; }
    public string Token { get; set; }
    public DateTime ExpirationDate { get; set; }
    public string IpAddress { get; set; }
}
