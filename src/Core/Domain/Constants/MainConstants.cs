﻿using System.Net;

namespace Core.Domain.Constants;

public static class MainConstants
{
    public const ushort CFG_VALUE_DELAY = 250;
    public const ushort CFG_MAX_KEY_NUMBER = 32;
    public const ushort CFG_BUFFER_VALUE = 1024;
    public const string CFG_ZERO_HEX = "0x";
    public const string CFG_VALUE_DASH = "-";
    public const string CFG_VALUE_PIPE = "|";
    public const string CFG_SEPATOR_ERROR = "{0} : {1}";
    public const string CFG_OS_PLATFORM_WIN = "Win32NT";
    public const string CFG_SYSTEM_AUTHOR = "SYSTEM";
    public const string CFG_DATE_ISO_8601 = "dd/MM/yyyyTHH:mm:ss";
    public const string CFG_DATE_SHORT_MONTH = "MM/yyyy";
    public const string CFG_API_VERSION_V1 = "1";
    public const string CFG_VALUE_CORS = "Any";
    public const string CFG_API_NAME = "CA.WebApi v{0}";
    public const string CFG_SESSION_ID = "sessionService_{0}";
    public const string CFG_PATH_HEALTH = "/health";
    public const string CFG_PATH_ERRORS = "/error";
    public const string CFG_CONNECTION_DB_NAME = "HrDbContext";
    public const string CFG_CONNECTION_DB_BLOB_NAME = "ProductsStorageDbContext";
    public const string CFG_ENVIRONMENT_LOCAL_NAME = "Development";
    public const string CFG_ENVIRONMENT_STAGING_NAME = "Staging";
    public const string CFG_ENVIRONMENT_PRODUCTION_NAME = "Production";
    public const string CFG_ENVIRONMENT_ASPNETCORE_NAME = "ASPNETCORE_ENVIRONMENT";
    public const string CFG_ENVIRONMENT_DATABASE_URL = "DATABASE_URL";
    public const string CFG_ENVIRONMENT_DATABASE_STORAGE_URL = "DATABASE_STORAGE_URL";
    public const string CFG_HEADER_ACCEPT = "Accept";
    public const string CFG_CONTENT_TYPE_JSON = "application/json;";
    public const string CFG_MULTIPART_FORM_DATA = "multipart/form-data";
    public const string CFG_OCTET_STREAM = "application/octet-stream";
    public const string CFG_CONTENT_TYPE_JPEG = "image/jpeg";
    public const string CFG_CONTENT_TYPE_JPG = "image/jpeg";
    public const string CFG_CONTENT_TYPE_GIF = "image/gif";
    public const string CFG_CONTENT_TYPE_PNG = "image/png";
    public const string CFG_CONTENT_TYPE_PDF = "application/pdf";
    public const string CFG_GROUP_NAME_FORMAT = "'v'VVV";
    public const string CFG_BEARER_TAG = "Bearer ";
    public const string CFG_BASIC_TAG = "Basic ";
    public const string CFG_BEARER_BASE_FORMAT = "JWT";
    public const string CFG_AUTHORIZATION_TAG = "Authorization";
    public const string CFG_SWAGGER_END_POINT = "/swagger/v{0}/swagger.json";
    public const string CFG_PATH_EXCEPTIONS = "Core.Application.Exceptions";
    public const string CFG_PATH_SCRIPTS_NAME = $"CA.Infrastructure.Persistence.Core.Scripts.Srv";
    public const string CFG_PATH_SCRIPTS_FILE_NAME = $"CA.Infrastructure.Persistence.Core.Scripts.SrvFile";
    public const string CFG_ALPHA_COLLECTION = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    public const string CFG_DOMAIN_EVENT_LAB = "DomainEvents";
    public const string CFG_ATTRIBUTE_EMPTY_LABEL = "emptyRequest";
    public const string CFG_TRACE_ID_HEADER = "X-Trace-Id";
    public const string CFG_TRACE_ID_LABEL_SERILOG = "TraceId";
    public const string CFG_TRACE_ID_IN_MESSAGE_LOG = "{0}";
    public const string CFG_TRACE_ID_EMPTY_LABEL = "emptyTraceId";
    public const string CFG_X_PAGINATION_TOTAL_COUNT = "X-Pagination-TotalCount";
    public const string CFG_X_PAGINATION_PAGE_SIZE = "X-Pagination-PageSize";
    public const string CFG_X_PAGINATION_CURRENT_PAGE = "X-Pagination-CurrentPage";
    public const string CFG_X_PAGINATION_TOTAL_PAGES = "X-Pagination-TotalPages";
    public const string CFG_PAGINATION_VALUES = "PaginationSettings";
    public const string CFG_PERFORMANCE_VALUES = "PerformanceSettings";
    public const string CFG_JWT_VALUES = "JWTSettings";
    public const string CFG_POLLY_VALUES = "PollySettings";
    public const string CFG_ID_DETAIL_STRING = "{0} - {1}";
    public const string CFG_NO_INNER_MESSAGE = "There is no inner message.";
    public const string CFG_MAIN_AUTHENTICATION_SCHEME_NAME = "AppWebHook";

    public const string CFG_FILE_UPLOAD_LABEL = "FileUploadSettings";
    public const string CFG_ENDPOINT_NOT_FOUND = "Endpoint '{0}' does not exist.";
    public const string CFG_ENDPOINT_NOT_ALLOWED = "Endpoint '{0}' not allowed.";

    public const uint CFG_MINIMUM_PASSWORD_LENGHT = 8;
    public const string CFG_NAME_COMPANY = "Bankaool";
    public const string CFG_EXT_PDF_FILE = ".pdf";
    public const string CFG_EXT_ZIP_FILE = ".zip";
    public const string CFG_EXT_JPG_FILE = ".jpg";
    public const string CFG_EXT_JPEG_FILE = ".jpeg";
    public const string CFG_EXT_PNG_FILE = ".png";
    public const string CFG_EXT_GIF_FILE = ".gif";
    public const string CFG_EXT_MPFOUR_FILE = ".mp4";
    public const string CFG_EXT_THREEGP_FILE = ".3gp";
    public const string CFG_EXT_QUICK_TIME_FILE = ".mov";
    public const string CFG_BASE_KEY_APP = "key_MAIN_SECRET_API";
    public const string CFG_BASE_KEY_WEBHOOK_APP = "key_MAIN_SECRET_API";
    public const string CFG_TRUNCATED_MAX_STRING = "[TruncadoPorCodigo] {0}";
    public const int CFG_BYTE_OFFSET_MP4 = 4;
    public const string CFG_HEX_FILE_JPG = "FFD8FFE0";
    public const string CFG_HEX_FILE_JPG_V0 = "EFBFBDEFBF";
    public const string CFG_HEX_FILE_JPG_V1 = "FFD8FFE1";
    public const string CFG_HEX_FILE_JPG_V2 = "FFD8FFE2";
    public const string CFG_HEX_FILE_JPG_V3 = "FFD8FFE3";
    public const string CFG_HEX_FILE_JPG_V8 = "FFD8FFE8";
    public const string CFG_HEX_FILE_PDF = "255044462D";
    public const string CFG_HEX_FILE_GIF = "47494638";
    public const string CFG_HEX_FILE_PNG = "89504E470D0A1A0A";
    public const string CFG_HEX_FILE_PNG_V0 = "EFBFBD504E470D0A1A0A";
    public const string CFG_HEX_FILE_FTYPISOM = "6674797069736F6D";
    public const string CFG_HEX_FILE_FTYPMSNV = "667479704D534E56";
    public const string CFG_HEX_FILE_FTYP3GP = "667479703367";
    public const string CFG_HEX_FILE_FTYPMP42 = "667479706D703432";
    public const string CFG_HEX_FILE_FTYPQT = "667479707174";
}

