using Core.Domain.Common;

namespace Hogar.HR.Domain.Entities;

public class PolicyEntity : BaseEntity<int>
{
    public string PolicyName { get; set; }
    public string PolicyDescription { get; set; }
}
