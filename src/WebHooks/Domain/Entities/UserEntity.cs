using System.ComponentModel.DataAnnotations;

using Core.Domain.Common;

namespace WebHooks.Domain.Entities;

public class UserEntity : BaseEntity<Guid>
{
    public string UserName { get; set; }
    public string UserSecret { get; set; }
    public string UserFullName { get; set; }
    public DateTime? LastRefreshDate { get; set; }
}
