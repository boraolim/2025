namespace Hogar.HR.Domain.Constants;

public static class MessageConstants
{
    public const string MSG_USER_NAME_REQUIRED = "El nombre de usuario es requerido.";
    public const string MSG_USER_NAME_MALFORMED = "Formato de cuenta de usuario incorrecta.";
    public const string MSG_PASSWORD_REQUIRED = "La contraseña es requerida.";
    public const string MSG_PASSWORD_MALFORMED = "Formato de contraseña incorrecta.";
    public const string MSG_FULLNAME_REQUIRED = "El nombre completo es requerido.";
    public const string MSG_FULLNAME_MALFORMED = "Formato de nombre completo incorrecto.";
    public const string MSG_USER_NAME_NOT_FOUND = "La cuenta de usuario no existe.";
    public const string MSG_PASSWORD_MISMATCH = "La contraseña de usuario es incorrecta";
    public const string MSG_USER_INACTIVE = "La cuenta de usuario está inactiva o bloqueada. Consulte con el asministrador del sistema.";
    public const string MSG_ALREADY_EXIST_ACCOUNT = "Ya existe una cuenta de usuario con el nombre de usuario proporcionado";
    public const string MSG_ACCESS_TOKEN_REQUIRED = "El token de acceso es requerido.";
    public const string MSG_REFRESH_TOKEN_REQUIRED = "El token de refresco es requerido.";
    public const string MSG_TOKEN_CURRENT_NOT_FOUND = "No existe token activo asociado a la cuenta de usuario {0}.";
    public const string MSG_TOKEN_REFREST_MISMATCH = "El token de refresco no es válido o bien, no coincide con el token de refresco introducido en Base de Datos.";
    public const string MSG_TOKEN_EXPIRED_MISMATCH = "La fecha de expiración del token no coincide con el verificado en Base de Datos";
}
