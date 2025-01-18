using Core.Domain.Enums;
using Core.Domain.Abstractions;

namespace Core.Domain.Common;

public class BaseEntity<TKey> : IBaseEntity<TKey>
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public TKey Id { get; set; }
    public FlagState FlagState { get; set; }
    public DateTime CreateDate { get; set; }
    public string CreateUser { get; set; }
    public DateTime? UpdateDate { get; set; }
    public string? UpdateUser { get; set; }
    public DateTime? DeleteDate { get; set; }
    public string? DeleteUser { get; set; }
}
