namespace Core.Domain.Constants;

public static class RegexConstants
{
    public const string REGEX_IS_REPOSITORY_END_WITH = @"^.*Repository$";
    public const string REGEX_IS_INTERFACE_TO_REPOSITORY_START_WITH = @"^I.*Repository$";
    public const string REGEX_IS_SERVICE_END_WITH = @"^.*Service$";
    public const string REGEX_IS_INTERFACE_TO_SERVICE_START_WITH = @"^I.*Service$";
    public const string REGEX_IS_MAPPER_END_WITH = @"^.*Mapper$";
    public const string REGEX_IS_INTERFACE_TO_MAPPER_START_WITH = @"^I.*Mapper$";
    public const string REGEX_IS_VALIDATOR_END_WITH = @"^.*Validator$";
    public const string RGX_ALPHA_PATTERN = @"^[\w\s]{10,255}$";
    public const string RGX_USERNAME_PATTERN = @"^(?!.*[._]{2})(?!.*[._]$)[a-zA-Z0-9._]{8,15}$";
    public const string RGX_PASSWORD_PATTERN_V1 = @"^(?=.*[a-zA-Z])(?=.*\d)(?=.*[^\w\s]).{8,25}$";
    public const string RGX_PASSWORD_PATTERN_V2 = @"^(?!.*(.).*\1)(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#!_?¿¡\-])[A-Za-z\d@#!_?¿¡\-]{8,}$";
    public const string RGX_PIN_PATTERN = @"^\d{4}$|^\d{6}$";
    public const string RGX_LOCATION_PATTERN = @"^([-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)),\s*([-+]?(180(\.0+)?|(1[0-7]\d|\d{1,2})(\.\d+)?))$";
    public const string RGX_CURP_PATTERN = @"^[A-Z]{1}[AEIOUX]{1}[A-Z]{2}\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])[HM]{1}(AS|BC|BS|CC|CL|CM|CS|CH|DF|DG|GT|GR|HG|JC|MC|MN|MS|NT|NL|OC|PL|QT|QR|SP|SL|SR|TC|TS|TL|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d]{1}\d{1}$";
    public const string RGX_RFC_PATTERN = @"^[A-ZÑ&]{3,4}\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])[A-Z\d]{3}$";
    public const string RGX_GENRE_PATTERN = @"^[MF]$";
    public const string RGX_CIC_MINUS_THAN_2013 = @"^\d{9}$";
    public const string RGX_CIC_MORE_THAN_2013 = @"^\d{9,10}$";
    public const string RGX_OCR_MORE_THAN_2013 = @"^\d{12,13}$";
    public const string RGX_CODE_CONSTITUENT = @"^[A-Z0-9]{18}$";
    public const string RGX_CODE_EMISSION = @"^\d{2}$";
    public const string RGX_UUID_V4_PATTERN = @"^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$";
    public const string RGX_JWT_TOKEN = @"^Bearer\s[a-zA-Z0-9\-\._~\+\/]+=*$";
    public const string RGX_SPACE_CLEAR = @"\s+";
}
