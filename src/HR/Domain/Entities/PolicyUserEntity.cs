using Core.Domain.Common;

namespace Hogar.HR.Domain.Entities;

public class PolicyUserEntity : BaseEntity<Guid>
{
    public Guid CredentialId { get; set; }
    public string FullName { get; set; }
    public int ModulePolicyId { get; set; }
    public int ModuleId { get; set; }
    public string ModuleName { get; set; }
    public int PolicyId { get; set; }
    public string PolicyName { get; set; }
    public bool IsSystemPolicy { get; set; }
}
