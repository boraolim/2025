using Hogar.HR.Domain.Enums;

namespace Hogar.HR.Application.DTO;

public class GroupNameDto
{
    public string GroupName { get; set; }
}

public class EnableGroupDto : GroupNameDto
{
    public bool ShutDownValue { get; set; }
    public string UpdateUser { get; set; }
}

public class SubGroupNameDto
{
    public string GroupName { get; set; }
    public string SubGroupName { get; set; }
}

public class EnableSubGroupDto : SubGroupNameDto
{
    public bool ShutDownValue { get; set; }
    public string UpdateUser { get; set; }
}

public class KeyNameDto
{
    public string GroupName { get; set; }
    public string SubGroupName { get; set; }
    public string KeyName { get; set; }
}

public class EnableKeyNameDto : KeyNameDto
{
    public bool ShutDownValue { get; set; }
    public string UpdateUser { get; set; }
}

public class KeyValueDto
{
    public string GroupName { get; set; }
    public string SubGroupName { get; set; }
    public string KeyName { get; set; }
    public string KeyValue { get; set; }
    public DataTypesEnum ValueType { get; set; }
    public string Comments { get; set; }
    public string CreateUser { get; set; }
    public string UpdateUser { get; set; }
}

public class ConfigurationDto
{
    public int Id { get; set; }
    public string GroupName { get; set; }
    public string SubGroupName { get; set; }
    public string KeyName { get; set; }
    public string KeyValue { get; set; }
    public DataTypesEnum ValueType { get; set; }
    public string KeyDescription { get; set; }
}
