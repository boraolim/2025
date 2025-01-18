using Hogar.HR.Domain.Enums;

namespace Hogar.HR.Application.DTO;

#region "ConfigurationUser"

public class ManagementDto
{
    public string JsonStringList { get; set; }
}

public class AddConfigurationUserDto : ManagementDto
{
    public string CredentialId { get; set; }
    public string CreateUser { get; set; }
}

public class UpdateConfigurationUserDto : ManagementDto
{
    public string CredentialId { get; set; }
    public string UpdateUser { get; set; }
}

public class ActionConfigurationUserDto
{
    public string CredentialId { get; set; }
    public string ActionUser { get; set; }
}

public class ConfigurationUserDto
{
    public string CredentialId { get; set; }
    public string UserFullName { get; set; }
    public int ParameterId { get; set; }
    public string GroupName { get; set; }
    public string SubGroupName { get; set; }
    public string ParameterKey { get; set; }
    public string ValueParameter { get; set; }
    public DataTypesEnum ValueType { get; set; }
    public string ParameterDescription { get; set; }
}

#endregion
