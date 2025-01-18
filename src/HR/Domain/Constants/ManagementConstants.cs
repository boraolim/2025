namespace Hogar.HR.Domain.Constants;

public static class ManagementConstants
{
    public const string DB_PROC_ADD_NEW_PARAMETER_USER = "proc_add_parameter_to_user";
    public const string DB_PARAM_CREDENTIAL_ID = "p_credential_id";
    public const string DB_PARAM_DEFAIL_PARAMETERS_JSON = "p_detail_parameters_json";
    public const string DB_PARAM_ADD_DATE = "p_user_add_date";
    public const string DB_PARAM_UPDATE_DATE = "p_user_update_date";
    public const string DB_PARAM_DELETE_DATE = "p_user_deleted_date";

    public const string DB_PROC_UPDATE_PARAMETER_USER = "proc_update_parameter_to_user";

    public const string DB_PROC_LOCK_ALL_PARAMETER_TO_USER = "proc_lock_all_parameter_to_user";

    public const string DB_PROC_DISABLE_ALL_PARAMETER_TO_USER = "proc_disable_all_parameter_to_user";

    public const string DB_PROC_ENABLE_ALL_PARAMETER_TO_USER = "proc_enable_all_parameter_to_user";

    public const string DB_PROC_GET_PARAMETER_USER = "proc_get_parameter_user";

    public const string DB_PROC_ADD_POLICY_TO_USER = "proc_add_policy_to_user";
    public const string DB_PARAM_DETAIL_POLICY_JSON = "p_detail_policy_json";

    public const string DB_PROC_UPDATE_POLICY_TO_USER = "proc_update_policy_to_user";

    public const string DB_PROC_LOCK_ALL_POLICY_TO_USER = "proc_lock_all_policies_to_user";

    public const string DB_PROC_DISABLE_ALL_POLICY_TO_USER = "proc_disable_all_policies_to_user";

    public const string DB_PROC_ENABLE_ALL_POLICY_TO_USER = "proc_enable_all_policy_to_user";

    public const string DB_PROC_GET_POLICY_USER = "proc_get_policy_user";

    public const string DB_PROC_GET_ALL_MODULES = "proc_get_all_modules";

    public const string DB_PROC_GET_EXISTENT_MODULE = "proc_get_existent_module";
    public const string DB_PARAM_MODULE_NAME = "p_module_name";

    public const string DB_PROC_ADD_NEW_MODULE = "proc_add_new_module";
    public const string DB_PARAM_MODULE_MODULE = "p_module_name";
    public const string DB_PARAM_MODULE_DESCRIPTION = "p_module_description";
    public const string DB_PARAM_MODULE_PATH = "p_module_path";
    public const string DB_PARAM_MODULE_VERSION_API = "p_module_version_api";

    public const string DB_PROC_UPDATE_NEW_MODULE = "proc_update_existent_module";
    public const string DB_PARAM_MODULE_ID = "p_module_id";

    public const string DB_PROC_DELETE_EXISTENT_MODULE = "proc_delete_existent_module";

    public const string DB_PROC_GET_ALL_POLICIES = "proc_get_all_policies";

    public const string DB_PROC_GET_EXISTENT_POLICY = "proc_get_existent_policy";
    public const string DB_PARAM_POLICY_NAME = "p_policy_name";

    public const string DB_PROC_ADD_NEW_POLICY = "proc_add_new_policy";
    public const string DB_PARAM_POLICY_DESCRIPTION = "p_policy_description";

    public const string DB_PROC_UPDATE_EXISTENT_POLICY = "proc_update_existent_policy";
    public const string DB_PARAM_POLICY_ID = "p_policy_id";

    public const string DB_PROC_DELETE_EXISTENT_POLICY = "proc_delete_existent_policy";

    public const string DB_PROC_ADD_NEW_MODULE_POLICY = "proc_add_new_module_policy";
    public const string DB_PARAM_SYSTEM_POLICY = "p_is_system_policy";

    public const string DB_PROC_DELETE_MODULE_POLICY = "proc_delete_module_policy";
    public const string DB_PARAM_MODULE_POLICY_ID = "p_module_policy_id";

    public const string DB_PROC_GET_ALL_MODULE_POLICY = "proc_get_all_module_policies";

    public const string DB_PROC_GET_MODULE_POLICY = "proc_get_module_policies";

    public const string DB_PROC_ADD_USER_MODULE_POLICY = "proc_add_user_module_policy";

    public const string DB_PROC_DELETE_USER_MODULE_POLICY = "proc_delete_user_module_policy";

    public const string DB_PROC_GET_ALL_USER_MODULE_POLICIES = "proc_get_all_user_module_policies";

    public const string B_PROC_GET_USER_MODULE_POLICIES = "proc_get_user_module_policies";
}
