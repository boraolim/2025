-- Generación de las tablas de la base de datos para la aplicación.
USE HR;

CREATE TABLE IF NOT EXISTS HR.TBL_USERS
    ( `credential_id`           CHAR     (36)                           NOT NULL DEFAULT (UUID())
    , `user_name`               VARCHAR  (15)                           NOT NULL
    , `user_secret`             VARCHAR  (255)                          NOT NULL
    , `user_full_name`          VARCHAR  (255)                          NOT NULL
    , `last_refresh_date`       TIMESTAMP                               NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `CREDENTIAL_ID` (`credential_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_USER_TOKENS
    ( `id_token`                CHAR     (36)                           NOT NULL DEFAULT (UUID())
    , `credential_id`           CHAR     (36)                           NOT NULL
    , `token_value`             VARCHAR  (255)                          NOT NULL
    , `expiration_date`         TIMESTAMP                               NOT NULL
    , `ip_address`              VARCHAR  (100)                          NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    ,  PRIMARY KEY `TOKEN_ID_PK` (`id_token`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_PARAMETERS
    ( `parameter_id`            INT                                     NOT NULL AUTO_INCREMENT
    , `group_name`              VARCHAR  (255)                          NOT NULL
    , `sub_group_name`          VARCHAR  (255)                          NOT NULL
    , `parameter_key`           VARCHAR  (100)                          NOT NULL
    , `value_parameter`         TEXT                                    NOT NULL
    , `value_type`              ENUM     ('STRING','INT','LONG', 'BOOLEAN', 'DECIMAL', 'UUID')  NOT NULL DEFAULT 'STRING'
    , `parameter_description`   VARCHAR  (255)                          NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `PARAMETER_ID_PK` (`parameter_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_MODULES
    ( `module_id`               INT                                     NOT NULL AUTO_INCREMENT
    , `module_name`             VARCHAR  (255)                          NOT NULL
    , `module_description`      VARCHAR  (255)                          NOT NULL
    , `module_path`             VARCHAR  (512)                          NOT NULL
    , `module_version_api`      VARCHAR  (30)                           NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `MODULE_ID_PK` (`module_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_POLICIES
    ( `policy_id`               INT                                     NOT NULL AUTO_INCREMENT
    , `policy_name`             VARCHAR  (255)                          NOT NULL
    , `policy_description`      VARCHAR  (255)                          NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                                NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `MODULE_ID_PK` (`policy_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_MODULE_POLICY
    ( `module_policy_id`        INT                                     NOT NULL AUTO_INCREMENT
    , `module_id`               INT                                     NOT NULL
    , `policy_id`               INT                                     NOT NULL
    , `is_system_policy`        BIT                                     NOT NULL DEFAULT 0
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `MODULE_POLICY_PK` (`module_policy_id`, `module_id`, `policy_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_USERS_MODULE_POLICY
    ( `policy_credential_id`    CHAR     (36)                           NOT NULL DEFAULT (UUID())
    , `credential_id`           CHAR     (36)                           NOT NULL
    , `module_policy_id`        INT                                     NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `USER_MODULE_POLICY_PK` (`policy_credential_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_USERS_PARAMETERS
    ( `parameter_credential_id` CHAR     (36)                           NOT NULL DEFAULT (UUID())
    , `credential_id`           CHAR     (36)                           NOT NULL
    , `parameter_id`            INT                                     NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `USER_PARAMETER_PK` (`parameter_credential_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_REGIONS
    ( `region_id`               INT                                     NOT NULL AUTO_INCREMENT
    , `region_name`             VARCHAR  (255)                          NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `REGION_ID_PK` (`region_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_COUNTRIES
    ( `country_id`              CHAR     (2)                            NOT NULL
    , `country_name`            VARCHAR  (255)                          NOT NULL
    , `region_id`               INT                                     NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `COUNTRY_ID_PK` (`country_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_LOCATIONS
    ( `location_id`             INT                                     NOT NULL AUTO_INCREMENT
    , `street_address`          VARCHAR  (255)                          NOT NULL
    , `postal_code`             VARCHAR  (12)                           NULL
    , `city`                    VARCHAR  (255)                          NULL
    , `state_province`          VARCHAR  (255)                          NULL
    , `country_id`              CHAR     (2)                            NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `LOCATION_ID_PK` (`location_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_DEPARTMENTS
    ( `department_id`           INT                                     NOT NULL AUTO_INCREMENT
    , `department_name`         VARCHAR  (255)                          NOT NULL
    , `manager_id`              INT                                     NULL
    , `location_id`             INT                                     NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `DEPARTMENT_ID_PK` (`department_id`, `location_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_JOBS
    ( `job_id`                  VARCHAR  (10)                           NOT NULL
    , `job_title`               VARCHAR  (255)                          NOT NULL
    , `min_salary`              DECIMAL  (10, 2)                        NOT NULL
    , `max_salary`              DECIMAL  (10, 2)                        NOT NULL
    , `working_mode`            ENUM     ('OFFICE', 'REMOTE', 'HYBRID') NOT NULL DEFAULT 'OFFICE'
    , `flag_state`              ENUM     ('ACTIVE', 'LOCKED', 'DELETED') NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `JOB_ID_PK` (`job_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_EMPLOYEES
    ( `employee_id`             INT                                     NOT NULL AUTO_INCREMENT
    , `first_name`              VARCHAR  (255)                          NOT NULL
    , `last_name`               VARCHAR  (255)                          NOT NULL
    , `email`                   VARCHAR  (255)                          NOT NULL
    , `phone_number`            VARCHAR  (100)                          NOT NULL
    , `hire_date`               DATE                                    NULL
    , `identity_code`           VARCHAR  (100)                          NULL
    , `social_safety_code`      VARCHAR  (100)                          NULL
    , `business_code`           VARCHAR  (100)                          NULL
    , `job_id`                  VARCHAR  (10)                           NOT NULL
    , `salary`                  INT                                     NOT NULL
    , `commission_pct`          DECIMAL  (10, 2)                        NULL
    , `manager_id`              INT                                     NULL
    , `department_id`           INT                                     NOT NULL
    , `type_contract`           ENUM     ('FULLTIME', 'PARTTIME', 'TEMPORARY', 'FREELANCE', 'TRIAL') NOT NULL DEFAULT 'FULLTIME'
    , `relationship_company`    ENUM     ('ACTIVE', 'SUSPENDED', 'LEAVE', 'EXONERATED', 'FIRED', 'RETIRED') NOT NULL DEFAULT 'ACTIVE'
    , `salary_scheme`           ENUM     ('PAYROLL', 'MIXED', 'FEE') NOT NULL DEFAULT 'PAYROLL'
    , `flag_state`              ENUM     ('ACTIVE', 'LOCKED', 'DELETED') NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `EMPLOYEE_ID_PK` (`employee_id`, `department_id`)
    ) AUTO_INCREMENT = 100;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_JOB_HISTORY
    ( `employee_id`             INT                                     NOT NULL
    , `start_date`              DATE                                    NOT NULL
    , `end_date`                DATE                                    NOT NULL
    , `job_id`                  VARCHAR  (10)                           NOT NULL
    , `department_id`           INT                                     NOT NULL
    , `relationship_company`    ENUM     ('ACTIVE', 'SUSPENDED', 'LEAVE', 'EXONERATED', 'FIRED', 'RETIRED') NOT NULL DEFAULT 'FIRED'
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                TIMESTAMP                               NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              TIMESTAMP                               NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              TIMESTAMP                               NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `EMPLOYEE_JOB_ID_PK` (`employee_id`, `job_id`, `department_id`)
    ) ;

COMMIT;

ALTER TABLE HR.TBL_USERS
    ADD UNIQUE `UX_USER_NAME` (`user_name`),
    ADD INDEX `IX_REGISTER_DATE` (`added_at`),
    ADD INDEX `IX_LAST_REFRESH_DATE` (`last_refresh_date`),
    ADD INDEX `IX_USER_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_USER_TOKENS
    ADD UNIQUE `UX_ID_CREDENTIAL_TOKEN_VALUE` (`id_token`, `credential_id`, `token_value`),
    ADD INDEX `IX_CREATED_DATE` (`added_at`),
    ADD INDEX `IX_EXPIRATION_DATE` (`expiration_date`),
    ADD INDEX `IX_USER_TKN_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_PARAMETERS
    ADD UNIQUE INDEX `UX_PARAMETER_DESCRIPTION` (`group_name`, `sub_group_name`, `parameter_key`),
    ADD INDEX `IX_PARAMETER_GROUP_NAME` (`group_name`),
    ADD INDEX `IX_PARAMETER_SUB_GROUP_NAME` (`sub_group_name`),
    ADD INDEX `IX_PARAMETER_KEY_VALUE` (`parameter_key`),
    ADD INDEX `IX_PARAMETER_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_MODULES
    ADD UNIQUE INDEX `UX_MODULE_NAME` (`module_name`),
    ADD INDEX `IX_MODULE_DESCRIPTION` (`module_description`),
    ADD INDEX `IX_MODULE_PATH` (`module_path`),
    ADD INDEX `IX_MODULE_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_POLICIES
    ADD UNIQUE INDEX `UX_POLICY_NAME` (`policy_name`),
    ADD INDEX `IX_POLICY_DESCRIPTION` (`policy_description`),
    ADD INDEX `IX_POLICY_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_MODULE_POLICY
    ADD UNIQUE INDEX `UX_POLICY_NAME` (`policy_id`, `module_id`),
    ADD INDEX `IX_MODULE_POLICY_MODULE_ID` (`module_id`),
    ADD INDEX `IX_USER_MODULE_POLICY_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_USERS_MODULE_POLICY
    ADD UNIQUE INDEX `UX_POLICY_CREDENTIAL_ID` (`policy_credential_id`, `credential_id`, `module_policy_id`),
    ADD INDEX `IX_MODULE_POLICY_ID` (`module_policy_id`),
    ADD INDEX `IX_USER_MODULE_POLICY_FLAG_STATE` (`flag_state`);
COMMIT;

ALTER TABLE HR.TBL_REGIONS
    ADD UNIQUE INDEX `UX_REGION_NAME` (`region_name`),
    ADD INDEX `IX_REGION_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_COUNTRIES
    ADD UNIQUE INDEX `UX_COUNTRY_NAME` (`country_name`),
    ADD INDEX `IX_COUNTRY_REGION_ID` (`region_id`),
    ADD INDEX `IX_COUNTRY_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_LOCATIONS
    ADD INDEX `IX_COUNTRY_ID` (`country_id`),
    ADD INDEX `IX_CITY_STATE` (`city`, `state_province`, `postal_code`),
    ADD INDEX `IX_LOCATION_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_DEPARTMENTS
    ADD INDEX `IX_MANAGER_ID` (`manager_id`),
    ADD INDEX `IX_DEPARTMENT_NAME` (`department_name`),
    ADD INDEX `IX_LOCATION_ID` (`location_id`),
    ADD INDEX `IX_DEPARTMENT_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_JOBS
    ADD INDEX `IX_JOB_TITLE` (`job_title`),
    ADD INDEX `IX_WORKING_MODE` (`working_mode`),
    ADD INDEX `IX_JOB_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_EMPLOYEES
    ADD UNIQUE INDEX `UX_EMAIL` (`email`),
    ADD INDEX `IX_JOB_ID` (`job_id`),
    ADD INDEX `IX_DEPARTMENT_ID` (`department_id`),
    ADD INDEX `IX_IDENTITY_CODE` (`identity_code`),
    ADD INDEX `IX_SOCIAL_SAFETY_CODE` (`social_safety_code`),
    ADD INDEX `IX_BUSSINESS_CODE` (`business_code`),
    ADD INDEX `IX_MANAGER_ID` (`manager_id`),
    ADD INDEX `IX_RELATIONSHIP_COMPANY` (`relationship_company`),
    ADD INDEX `IX_FLAG_STATE` (`flag_state`);

COMMIT;

ALTER TABLE HR.TBL_JOB_HISTORY
    ADD INDEX `IX_JOB_ID` (`job_id`),
    ADD INDEX `IX_DEPARTMENT_ID` (`department_id`),
    ADD INDEX `IX_RELATIONSHIP_COMPANY` (`relationship_company`),
    ADD INDEX `IX_JOB_HISTORY_FLAG_STATE` (`flag_state`);

COMMIT;