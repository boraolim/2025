using Core.Domain.Common;
using Hogar.HR.Domain.Enums;

namespace Hogar.HR.Domain.Entities;

public class ConfigurationEntity : BaseEntity<int>
{
    public string GroupName { get; set; }
    public string SubGroupName { get; set; }
    public string KeyName { get; set; }
    public string KeyValue { get; set; }
    public DataTypesEnum ValueType { get; set; }
    public string KeyDescription { get; set; }
}
