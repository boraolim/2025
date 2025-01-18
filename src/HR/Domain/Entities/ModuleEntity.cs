using Core.Domain.Common;

namespace Hogar.HR.Domain.Entities;

public class ModuleEntity : BaseEntity<int>
{
    public string ModuleName { get; set; }
    public string ModuleDescription { get; set; }
    public string ModulePath { get; set; }
    public string ModuleVersionApi { get; set; }
}
