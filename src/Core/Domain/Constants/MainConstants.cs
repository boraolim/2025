namespace Core.Domain.Constants;

public static class MainConstants
{
    public const int CFG_ZERO = 0;
    public const int CFG_ONE_PLUS = 1;
    public const int CFG_ONE_MINUS = -1;
    public const ushort CFG_VALUE_DELAY = 250;
    public const uint CFG_LAST_HOUR_OF_DAY = 23;
    public const ushort CFG_MAX_KEY_NUMBER = 32;
    public const ushort CFG_BUFFER_VALUE = 1024;
    public const uint CFG_LAST_MINUTE_OR_SECOND = 59;
    public const uint CFG_MINIMUM_PASSWORD_LENGHT = 8;
    public const uint CFG_MAXIMUM_PASSWORD_LENGHT = 16;
    
    public const string CFG_SYSTEM_AUTHOR = "SYSTEM";
    public const string CFG_API_VERSION_V1 = "1";
    public const string CFG_VALUE_CORS = "Any";
    public const string CFG_PATH_HEALTH = "/health";
    public const string CFG_PATH_ERRORS = "/error";
    public const string CFG_CONTENT_TYPE_JSON = "application/json;";
    public const string CFG_BEARER_TAG = "Bearer ";
    public const string CFG_BASIC_TAG = "Basic ";
    public const string CFG_AUTHORIZATION_TAG = "Authorization";
    public const string CFG_SWAGGER_END_POINT = "/swagger/v{0}/swagger.json";
    public const string CFG_PATH_EXCEPTIONS = "Core.Application.Exceptions";
    public const string CFG_PATH_SCRIPTS_NAME = $"Core.Infrastructure.Scripts";
    public const string CFG_ALPHA_COLLECTION = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    public const string CFG_DOMAIN_EVENT_LAB = "DomainEvents";
    public const string CFG_ATTRIBUTE_EMPTY_LABEL = "emptyRequest";
    public const string CFG_TRACE_ID_HEADER = "X-Trace-Id";
    public const string CFG_TRACE_ID_LABEL_SERILOG = "TraceId";
    public const string CFG_TRACE_ID_EMPTY_LABEL = "emptyTraceId";
    public const string CFG_X_PAGINATION_TOTAL_COUNT = "X-Pagination-TotalCount";
    public const string CFG_X_PAGINATION_PAGE_SIZE = "X-Pagination-PageSize";
    public const string CFG_X_PAGINATION_CURRENT_PAGE = "X-Pagination-CurrentPage";
    public const string CFG_X_PAGINATION_TOTAL_PAGES = "X-Pagination-TotalPages";
    public const string CFG_MAIN_AUTHENTICATION_SCHEME_NAME = "AppWebHook";
}

