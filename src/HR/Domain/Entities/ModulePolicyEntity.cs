using Core.Domain.Common;

namespace Hogar.HR.Domain.Entities;

public class ModulePolicyEntity : BaseEntity<int>
{
    public int ModuleId { get; set; }
    public string ModuleName { get; set; }
    public string ModuleDescription { get; set; }
    public string ModulePath { get; set; }
    public string ModuleVersionApi { get; set; }
    public int PolicyId { get; set; }
    public string PolicyName { get; set; }
    public string PolicyDescription { get; set; }
    public bool IsSystemPolicy { get; set; }
}
