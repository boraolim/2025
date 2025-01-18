CREATE TABLE IF NOT EXISTS HR.TBL_USERS
    ( `credential_id`           CHAR     (36)                           NOT NULL DEFAULT (UUID())
    , `user_name`               VARCHAR  (15)                           NOT NULL
    , `user_secret`             VARCHAR  (255)                          NOT NULL
    , `user_full_name`          VARCHAR  (255)                          NOT NULL
    , `last_refresh_date`       DATETIME                                NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                DATETIME                                NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              DATETIME                                NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              DATETIME                                NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `CREDENTIAL_ID` (`credential_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_USER_TOKENS
    ( `id_token`                CHAR     (36)                           NOT NULL DEFAULT (UUID())
    , `credential_id`           VARCHAR  (100)                          NOT NULL
    , `token_value`             VARCHAR  (255)                          NOT NULL
    , `expiration_date`         DATETIME                                NOT NULL
    , `ip_address`              VARCHAR  (100)                          NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                DATETIME                                NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              DATETIME                                NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              DATETIME                                NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    ,  PRIMARY KEY `TOKEN_ID_PK` (`id_token`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_PARAMETERS
    ( `parameter_id`            INT                                     NOT NULL AUTO_INCREMENT
    , `parameter_description`   VARCHAR  (255)                          NOT NULL
    , `value_parameter`         TEXT                                    NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                DATETIME                                NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              DATETIME                                NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              DATETIME                                NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `PARAMETER_ID_PK` (`parameter_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_REGIONS
    ( `region_id`               INT                                     NOT NULL AUTO_INCREMENT
    , `region_name`             VARCHAR  (255)                          NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                DATETIME                                NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              DATETIME                                NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              DATETIME                                NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `REGION_ID_PK` (`region_id`)
    ) ;

COMMIT;

CREATE TABLE IF NOT EXISTS HR.TBL_COUNTRIES
    ( `country_id`              CHAR     (2)                            NOT NULL
    , `country_name`            VARCHAR  (255)                          NOT NULL
    , `region_id`               INT                                     NOT NULL
    , `flag_state`              ENUM     ('ACTIVE','LOCKED','DELETED')  NOT NULL DEFAULT 'ACTIVE'
    , `added_at`                DATETIME                                NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              DATETIME                                NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              DATETIME                                NULL
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
    , `added_at`                DATETIME                                NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              DATETIME                                NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              DATETIME                                NULL
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
    , `added_at`                DATETIME                                NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              DATETIME                                NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              DATETIME                                NULL
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
    , `added_at`                DATETIME                                NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              DATETIME                                NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              DATETIME                                NULL
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
    , `added_at`                DATETIME                                NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              DATETIME                                NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              DATETIME                                NULL
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
    , `added_at`                DATETIME                                NOT NULL DEFAULT CURRENT_TIMESTAMP
    , `user_add_date`           VARCHAR  (255)                          NOT NULL
    , `updated_at`              DATETIME                                NULL
    , `user_update_date`        VARCHAR  (255)                          NULL
    , `deleted_at`              DATETIME                                NULL
    , `user_delete_date`        VARCHAR  (255)                          NULL
    , PRIMARY KEY `EMPLOYEE_JOB_ID_PK` (`employee_id`, `job_id`, `department_id`)
    ) ;

COMMIT;