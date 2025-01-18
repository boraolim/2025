namespace WebHooks.Domain.Constants;

public static class DbConstants
{
    public const string DB_PROC_ADD_NEW_USER = "proc_add_new_user";
    public const string DB_PARAM_USER_NAME = "p_user_name";
    public const string DB_PARAM_USER_SECRET = "p_user_secret";
    public const string DB_PARAM_USER_FULL_NAME = "p_user_full_name";
    public const string DB_PARAM_ADD_DATE = "p_user_add_date";

    public const string DB_PROC_GET_EXISTENT_USER = "proc_get_existent_user";
    public const string DB_PARAM_USER_ID = "p_user_id";

    public const string DB_PROC_GET_EXISTENT_USER_BY_ID = "proc_get_existent_user_by_id";
    public const string DB_PARAM_CREDENTIAL_ID = "p_credential_id";

    public const string DB_PROC_SAVE_NEW_TOKEN = "proc_save_new_token";
    public const string DB_PARAM_IP_ADDRESS = "p_ip_address";
    public const string DB_PARAM_REFRESH_TOKEN = "p_new_refresh";
    public const string DB_PARAM_USER_DATE = "p_user_date";

    public const string DB_PROC_GET_USER_BY_REFRESH = "proc_get_refreshtoken";
    public const string DB_PARAM_ID_TOKEN = "p_id_token";

    public const string DB_PROC_STATUS_TOKEN_EXPIRATION = "proc_get_is_expired_token";

    public const string DB_PROC_SAVE_REFRESH_TOKEN = "proc_save_refresh_token";

    public const string DB_PROC_CLEAR_EXPIRATION = "proc_clear_token";
}
