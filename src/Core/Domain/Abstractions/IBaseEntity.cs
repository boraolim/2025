using Core.Domain.Enums;

namespace Core.Domain.Abstractions;

public interface IBaseEntity<TKey>
{
    public TKey Id { get; set; }
    public FlagState FlagState { get; set; }
    public DateTime CreateDate { get; set; }
    public string CreateUser { get; set; }
    public DateTime? UpdateDate { get; set; }
    public string? UpdateUser { get; set; }
    public DateTime? DeleteDate { get; set; }
    public string? DeleteUser { get; set; }
}
