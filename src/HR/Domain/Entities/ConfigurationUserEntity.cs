using Core.Domain.Common;
using Hogar.HR.Domain.Enums;

namespace Hogar.HR.Domain.Entities;

public class ConfigurationUserEntity : BaseEntity<Guid>
{
    public Guid CredentialId { get; set; }
    public string UserFullName { get; set; }
    public int ParameterId { get; set; }
    public string GroupName { get; set; }
    public string SubGroupName { get; set; }
    public string ParameterKey { get; set; }
    public string ValueParameter { get; set; }
    public DataTypesEnum ValueType { get; set; }
    public string ParameterDescription { get; set; }
}
