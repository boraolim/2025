namespace Core.Application.Attributes;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = true)]
public class AuthorizeAttribute : Attribute
{
    public AuthorizeAttribute() { }

    public string Roles { get; set; } = string.Empty;
    public string Policy { get; set; } = string.Empty;
}

