CREATE SCHEMA IF NOT EXISTS `HR` DEFAULT CHARACTER SET UTF8;

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

USE HR;

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
  ADD UNIQUE INDEX `UX_PARAMETER_DESCRIPTION` (`parameter_description`),
  ADD INDEX `IX_PARAMETER_FLAG_STATE` (`flag_state`);

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

USE HR;

-- Root acount.
INSERT INTO HR.TBL_USERS (user_name, user_secret, user_full_name, flag_state, user_add_date)
VALUES('root', HEX('Password cyphered here in AES256-GCM'), 'ADMINISTRADOR DEL SISTEMA', 'ACTIVE', 'root');
UPDATE HR.TBL_USERS SET user_add_date = credential_id WHERE (user_name = 'root');

COMMIT;

-- Parameters.
INSERT INTO HR.TBL_PARAMETERS(parameter_description, value_parameter, user_add_date)
VALUES ('CFG_EXPIRATION_TOKEN_MINUTES', '15', 'SYSTEM');

COMMIT;

-- Regions
INSERT INTO HR.TBL_REGIONS (region_name, user_add_date) VALUES ( 'Europe', 'SYSTEM');
INSERT INTO HR.TBL_REGIONS (region_name, user_add_date) VALUES ( 'Americas', 'SYSTEM');
INSERT INTO HR.TBL_REGIONS (region_name, user_add_date) VALUES ( 'Asia', 'SYSTEM');
INSERT INTO HR.TBL_REGIONS (region_name, user_add_date) VALUES ( 'Middle East and Africa', 'SYSTEM');

COMMIT;

-- Contries
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'IT' , 'Italy' , 1, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'JP' , 'Japan' , 3, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'US' , 'United States of America' , 2, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'CA' , 'Canada' , 2, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'CN' , 'China' , 3, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'IN' , 'India' , 3, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'AU' , 'Australia' , 3, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'ZW' , 'Zimbabwe' , 4, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'SG' , 'Singapore' , 3, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'UK' , 'United Kingdom' , 1, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'FR' , 'France' , 1, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'DE' , 'Germany' , 1, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'ZM' , 'Zambia' , 4, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'EG' , 'Egypt' , 4, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'BR' , 'Brazil' , 2, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'CH' , 'Switzerland' , 1, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'NL' , 'Netherlands' , 1, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'MX' , 'Mexico' , 2, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'KW' , 'Kuwait' , 4, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'IL' , 'Israel' , 4, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'DK' , 'Denmark' , 1, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'ML' , 'Malaysia' , 3, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'NG' , 'Nigeria' , 4, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'AR' , 'Argentina' , 2, 'SYSTEM');
INSERT INTO HR.TBL_COUNTRIES (country_id, country_name, region_id, user_add_date) VALUES ( 'BE' , 'Belgium' , 1, 'SYSTEM');

COMMIT;

-- Locations
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '1297 Via Cola di Rie' , '00989' , 'Roma' , NULL , 'IT', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '93091 Calle della Testa' , '10934' , 'Venice' , NULL , 'IT', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '2017 Shinjuku-ku' , '1689' , 'Tokyo' , 'Tokyo Prefecture' , 'JP', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '9450 Kamiya-cho' , '6823' , 'Hiroshima' , NULL , 'JP', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '2014 Jabberwocky Rd' , '26192' , 'Southlake' , 'Texas' , 'US', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '2011 Interiors Blvd' , '99236' , 'South San Francisco' , 'California' , 'US', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '2007 Zagora St' , '50090' , 'South Brunswick' , 'New Jersey' , 'US', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '2004 Charade Rd' , '98199' , 'Seattle' , 'Washington' , 'US', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '147 Spadina Ave' , 'M5V 2L7' , 'Toronto' , 'Ontario' , 'CA', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '6092 Boxwood St' , 'YSW 9T2' , 'Whitehorse' , 'Yukon' , 'CA', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '40-5-12 Laogianggen' , '190518' , 'Beijing' , NULL , 'CN', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '1298 Vileparle (E)' , '490231' , 'Bombay' , 'Maharashtra' , 'IN', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '12-98 Victoria Street' , '2901' , 'Sydney' , 'New South Wales' , 'AU', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '198 Clementi North' , '540198' , 'Singapore' , NULL , 'SG', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '8204 Arthur St' , NULL , 'London' , NULL , 'UK', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( 'Magdalen Centre, The Oxford Science Park' , 'OX9 9ZB' , 'Oxford' , 'Oxford' , 'UK', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '9702 Chester Road' , '09629850293' , 'Stretford' , 'Manchester' , 'UK', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( 'Schwanthalerstr. 7031' , '80925' , 'Munich' , 'Bavaria' , 'DE', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( 'Rua Frei Caneca 1360 ' , '01307-002' , 'Sao Paulo' , 'Sao Paulo' , 'BR', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( '20 Rue des Corps-Saints' , '1730' , 'Geneva' , 'Geneve' , 'CH', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( 'Murtenstrasse 921' , '3095' , 'Bern' , 'BE' , 'CH', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( 'Pieter Breughelstraat 837' , '3029SK' , 'Utrecht' , 'Utrecht' , 'NL', 'SYSTEM');
INSERT INTO HR.TBL_LOCATIONS (street_address, postal_code, city, state_province, country_id, user_add_date) VALUES ( 'Mariano Escobedo 9991' , '11932' , 'Mexico city' , 'Distrito Federal,' , 'MX', 'SYSTEM');

COMMIT;

-- Departments
INSERT INTO HR.TBL_DEPARTMENTS (department_name, manager_id, location_id, user_add_date) VALUES ( 'Administration' , 200 , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, manager_id, location_id, user_add_date) VALUES ( 'Marketing' , 201 , 8, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, manager_id, location_id, user_add_date) VALUES ( 'Purchasing' , 114 , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, manager_id, location_id, user_add_date) VALUES ( 'Human Resources' , 203 , 14, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, manager_id, location_id, user_add_date) VALUES ( 'Shipping' , 121 , 6, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, manager_id, location_id, user_add_date) VALUES ( 'IT' , 103 , 5, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, manager_id, location_id, user_add_date) VALUES ( 'Public Relations' , 204 , 14, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, manager_id, location_id, user_add_date) VALUES ( 'Sales' , 145 , 14, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, manager_id, location_id, user_add_date) VALUES ( 'Executive' , 100 , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, manager_id, location_id, user_add_date) VALUES ( 'Finance' , 108 , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, manager_id, location_id, user_add_date) VALUES ( 'Accounting' , 205 , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Treasury' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Corporate Tax' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Control And Credit' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Shareholder Services' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Benefits' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Manufacturing' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Construction' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Contracting' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Operations' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'IT Support' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'NOC' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'IT Helpdesk' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Government Sales' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Retail Sales' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Recruiting' , 7, 'SYSTEM');
INSERT INTO HR.TBL_DEPARTMENTS (department_name, location_id, user_add_date) VALUES ( 'Payroll' , 7, 'SYSTEM');

COMMIT;

-- Jobs
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'AD_PRES' , 'President' , 20080 , 40000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'AD_VP' , 'Administration Vice President' , 15000 , 30000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'AD_ASST' , 'Administration Assistant' , 3000 , 6000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'FI_MGR' , 'Finance Manager' , 8200 , 16000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'FI_ACCOUNT' , 'Accountant' , 4200 , 9000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'AC_MGR' , 'Accounting Manager' , 8200 , 16000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'AC_ACCOUNT' , 'Public Accountant' , 4200 , 9000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'SA_MAN' , 'Sales Manager' , 10000 , 20080, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'SA_REP' , 'Sales Representative' , 6000 , 12008, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'PU_MAN' , 'Purchasing Manager' , 8000 , 15000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'PU_CLERK' , 'Purchasing Clerk' , 2500 , 5500, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'ST_MAN' , 'Stock Manager' , 5500 , 8500, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'ST_CLERK' , 'Stock Clerk' , 2008 , 5000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'SH_CLERK' , 'Shipping Clerk' , 2500 , 5500, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'IT_PROG' , 'Programmer' , 4000 , 10000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'MK_MAN' , 'Marketing Manager' , 9000 , 15000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'MK_REP' , 'Marketing Representative' , 4000 , 9000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'DATA_REP' , 'Human Resources Representative' , 4000 , 9000, 'SYSTEM');
INSERT INTO HR.TBL_JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY, user_add_date) VALUES ( 'PR_REP' , 'Public Relations Representative' , 4500 , 10500, 'SYSTEM');

COMMIT;

-- Employees
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Steven' , 'King' , 'SKING' , '515.123.4567' , STR_TO_DATE('17/06/2003', '%d/%m/%Y') , '' , '' , '' , 'AD_PRES' , 24000 , NULL , NULL , 9, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Neena' , 'Kochhar' , 'NKOCHHAR' , '515.123.4568' , STR_TO_DATE('21/09/2005', '%d/%m/%Y') , '' , '' , '' , 'AD_VP' , 17000 , NULL , 100 , 9, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Lex' , 'De Haan' , 'LDEHAAN' , '515.123.4569' , STR_TO_DATE('13/01/2001', '%d/%m/%Y') , '' , '' , '' , 'AD_VP' , 17000 , NULL , 100 , 9, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Alexander' , 'Hunold' , 'AHUNOLD' , '590.423.4567' , STR_TO_DATE('03/01/2006', '%d/%m/%Y') , '' , '' , '' , 'IT_PROG' , 9000 , NULL , 102 , 6, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Bruce' , 'Ernst' , 'BERNST' , '590.423.4568' , STR_TO_DATE('21/05/2007', '%d/%m/%Y') , '' , '' , '' , 'IT_PROG' , 6000 , NULL , 103 , 6, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'David' , 'Austin' , 'DAUSTIN' , '590.423.4569' , STR_TO_DATE('25/06/2005', '%d/%m/%Y') , '' , '' , '' , 'IT_PROG' , 4800 , NULL , 103 , 6, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Valli' , 'Pataballa' , 'VPATABAL' , '590.423.4560' , STR_TO_DATE('05/02/2006', '%d/%m/%Y') , '' , '' , '' , 'IT_PROG' , 4800 , NULL , 103 , 6, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Diana' , 'Lorentz' , 'DLORENTZ' , '590.423.5567' , STR_TO_DATE('07/02/2007', '%d/%m/%Y') , '' , '' , '' , 'IT_PROG' , 4200 , NULL , 103 , 6, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Nancy' , 'Greenberg' , 'NGREENBE' , '515.124.4569' , STR_TO_DATE('17/08/2002', '%d/%m/%Y') , '' , '' , '' , 'FI_MGR' , 12008 , NULL , 101 , 10, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Daniel' , 'Faviet' , 'DFAVIET' , '515.124.4169' , STR_TO_DATE('16/08/2002', '%d/%m/%Y') , '' , '' , '' , 'FI_ACCOUNT' , 9000 , NULL , 108 , 10, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'John' , 'Chen' , 'JCHEN' , '515.124.4269' , STR_TO_DATE('28/09/2005', '%d/%m/%Y') , '' , '' , '' , 'FI_ACCOUNT' , 8200 , NULL , 108 , 10, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Ismael' , 'Sciarra' , 'ISCIARRA' , '515.124.4369' , STR_TO_DATE('30/09/2005', '%d/%m/%Y') , '' , '' , '' , 'FI_ACCOUNT' , 7700 , NULL , 108 , 10, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Jose Manuel' , 'Urman' , 'JMURMAN' , '515.124.4469' , STR_TO_DATE('07/03/2006', '%d/%m/%Y') , '' , '' , '' , 'FI_ACCOUNT' , 7800 , NULL , 108 , 10, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Luis' , 'Popp' , 'LPOPP' , '515.124.4567' , STR_TO_DATE('07/12/2007', '%d/%m/%Y') , '' , '' , '' , 'FI_ACCOUNT' , 6900 , NULL , 108 , 10, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Den' , 'Raphaely' , 'DRAPHEAL' , '515.127.4561' , STR_TO_DATE('07/12/2002', '%d/%m/%Y') , '' , '' , '' , 'PU_MAN' , 11000 , NULL , 100 , 3, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Alexander' , 'Khoo' , 'AKHOO' , '515.127.4562' , STR_TO_DATE('18/05/2003', '%d/%m/%Y') , '' , '' , '' , 'PU_CLERK' , 3100 , NULL , 114 , 3, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Shelli' , 'Baida' , 'SBAIDA' , '515.127.4563' , STR_TO_DATE('24/12/2005', '%d/%m/%Y') , '' , '' , '' , 'PU_CLERK' , 2900 , NULL , 114 , 3, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Sigal' , 'Tobias' , 'STOBIAS' , '515.127.4564' , STR_TO_DATE('24/07/2005', '%d/%m/%Y') , '' , '' , '' , 'PU_CLERK' , 2800 , NULL , 114 , 3, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Guy' , 'Himuro' , 'GHIMURO' , '515.127.4565' , STR_TO_DATE('15/11/2006', '%d/%m/%Y') , '' , '' , '' , 'PU_CLERK' , 2600 , NULL , 114 , 3, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Karen' , 'Colmenares' , 'KCOLMENA' , '515.127.4566' , STR_TO_DATE('10/08/2007', '%d/%m/%Y') , '' , '' , '' , 'PU_CLERK' , 2500 , NULL , 114 , 3, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Matthew' , 'Weiss' , 'MWEISS' , '650.123.1234' , STR_TO_DATE('18/07/2004', '%d/%m/%Y') , '' , '' , '' , 'ST_MAN' , 8000 , NULL , 100 , 5, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Adam' , 'Fripp' , 'AFRIPP' , '650.123.2234' , STR_TO_DATE('10/04/2005', '%d/%m/%Y') , '' , '' , '' , 'ST_MAN' , 8200 , NULL , 100 , 5, 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Payam' , 'Kaufling' , 'PKAUFLIN' , '650.123.3234' , STR_TO_DATE('01/05/2003', '%d/%m/%Y') , '' , '' , '' , 'ST_MAN' , 7900 , NULL , 100 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Shanta' , 'Vollman' , 'SVOLLMAN' , '650.123.4234' , STR_TO_DATE('10/10/2005', '%d/%m/%Y') , '' , '' , '' , 'ST_MAN' , 6500 , NULL , 100 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Kevin' , 'Mourgos' , 'KMOURGOS' , '650.123.5234' , STR_TO_DATE('16/11/2007', '%d/%m/%Y') , '' , '' , '' , 'ST_MAN' , 5800 , NULL , 100 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Julia' , 'Nayer' , 'JNAYER' , '650.124.1214' , STR_TO_DATE('16/07/2005', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 3200 , NULL , 120 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Irene' , 'Mikkilineni' , 'IMIKKILI' , '650.124.1224' , STR_TO_DATE('28/09/2006', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2700 , NULL , 120 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'James' , 'Landry' , 'JLANDRY' , '650.124.1334' , STR_TO_DATE('14/01/2007', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2400 , NULL , 120 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Steven' , 'Markle' , 'SMARKLE' , '650.124.1434' , STR_TO_DATE('08/03/2008', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2200 , NULL , 120 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Laura' , 'Bissot' , 'LBISSOT' , '650.124.5234' , STR_TO_DATE('20/08/2005', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 3300 , NULL , 121 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Mozhe' , 'Atkinson' , 'MATKINSO' , '650.124.6234' , STR_TO_DATE('30/10/2005', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2800 , NULL , 121 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'James' , 'Marlow' , 'JAMRLOW' , '650.124.7234' , STR_TO_DATE('16/02/2005', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2500 , NULL , 121 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'TJ' , 'Olson' , 'TJOLSON' , '650.124.8234' , STR_TO_DATE('10/04/2007', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2100 , NULL , 121 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Jason' , 'Mallin' , 'JMALLIN' , '650.127.1934' , STR_TO_DATE('14/06/2004', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 3300 , NULL , 122 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Michael' , 'Rogers' , 'MROGERS' , '650.127.1834' , STR_TO_DATE('26/08/2006', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2900 , NULL , 122 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Ki' , 'Gee' , 'KGEE' , '650.127.1734' , STR_TO_DATE('12/12/2007', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2400 , NULL , 122 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Hazel' , 'Philtanker' , 'HPHILTAN' , '650.127.1634' , STR_TO_DATE('06/02/2008', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2200 , NULL , 122 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Renske' , 'Ladwig' , 'RLADWIG' , '650.121.1234' , STR_TO_DATE('14/07/2003', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 3600 , NULL , 123 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Stephen' , 'Stiles' , 'SSTILES' , '650.121.2034' , STR_TO_DATE('26/10/2005', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 3200 , NULL , 123 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'John' , 'Seo' , 'JSEO' , '650.121.2019' , STR_TO_DATE('12/02/2006', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2700 , NULL , 123 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Joshua' , 'Patel' , 'JPATEL' , '650.121.1834' , STR_TO_DATE('06/04/2006', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2500 , NULL , 123 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Trenna' , 'Rajs' , 'TRAJS' , '650.121.8009' , STR_TO_DATE('17/10/2003', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 3500 , NULL , 124 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Curtis' , 'Davies' , 'CDAVIES' , '650.121.2994' , STR_TO_DATE('29/01/2005', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 3100 , NULL , 124 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Randall' , 'Matos' , 'RMATOS' , '650.121.2874' , STR_TO_DATE('15/03/2006', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2600 , NULL , 124 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Peter' , 'Vargas' , 'PVARGAS' , '650.121.2004' , STR_TO_DATE('09/07/2006', '%d/%m/%Y') , '' , '' , '' , 'ST_CLERK' , 2500 , NULL , 124 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'John' , 'Russell' , 'JRUSSEL' , '011.44.1344.429268' , STR_TO_DATE('01/10/2004', '%d/%m/%Y') , '' , '' , '' , 'SA_MAN' , 14000 , .4 , 100 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Karen' , 'Partners' , 'KPARTNER' , '011.44.1344.467268' , STR_TO_DATE('05/01/2005', '%d/%m/%Y') , '' , '' , '' , 'SA_MAN' , 13500 , .3 , 100 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Alberto' , 'Errazuriz' , 'AERRAZUR' , '011.44.1344.429278' , STR_TO_DATE('10/03/2005', '%d/%m/%Y') , '' , '' , '' , 'SA_MAN' , 12000 , .3 , 100 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Gerald' , 'Cambrault' , 'GCAMBRAU' , '011.44.1344.619268' , STR_TO_DATE('15/10/2007', '%d/%m/%Y') , '' , '' , '' , 'SA_MAN' , 11000 , .3 , 100 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Eleni' , 'Zlotkey' , 'EZLOTKEY' , '011.44.1344.429018' , STR_TO_DATE('29/01/2008', '%d/%m/%Y') , '' , '' , '' , 'SA_MAN' , 10500 , .2 , 100 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Peter' , 'Tucker' , 'PTUCKER' , '011.44.1344.129268' , STR_TO_DATE('30/01/2005', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 10000 , .3 , 145 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'David' , 'Bernstein' , 'DBERNSTE' , '011.44.1344.345268' , STR_TO_DATE('24/03/2005', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 9500 , .25 , 145 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Peter' , 'Hall' , 'PHALL' , '011.44.1344.478968' , STR_TO_DATE('20/08/2005', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 9000 , .25 , 145 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'CHRistopher' , 'Olsen' , 'COLSEN' , '011.44.1344.498718' , STR_TO_DATE('30/03/2006', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 8000 , .2 , 145 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Nanette' , 'Cambrault' , 'NCAMBRAU' , '011.44.1344.987668' , STR_TO_DATE('09/12/2006', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 7500 , .2 , 145 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Oliver' , 'Tuvault' , 'OTUVAULT' , '011.44.1344.486508' , STR_TO_DATE('23/11/2007', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 7000 , .15 , 145 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Janette' , 'King' , 'JKING' , '011.44.1345.429268' , STR_TO_DATE('30/01/2004', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 10000 , .35 , 146 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Patrick' , 'Sully' , 'PSULLY' , '011.44.1345.929268' , STR_TO_DATE('04/03/2004', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 9500 , .35 , 146 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Allan' , 'McEwen' , 'AMCEWEN' , '011.44.1345.829268' , STR_TO_DATE('01/08/2004', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 9000 , .35 , 146 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Lindsey' , 'Smith' , 'LSMITH' , '011.44.1345.729268' , STR_TO_DATE('10/03/2005', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 8000 , .3 , 146 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Louise' , 'Doran' , 'LDORAN' , '011.44.1345.629268' , STR_TO_DATE('15/12/2005', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 7500 , .3 , 146 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Sarath' , 'Sewall' , 'SSEWALL' , '011.44.1345.529268' , STR_TO_DATE('03/11/2006', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 7000 , .25 , 146 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Clara' , 'Vishney' , 'CVISHNEY' , '011.44.1346.129268' , STR_TO_DATE('11/11/2005', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 10500 , .25 , 147 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Danielle' , 'Greene' , 'DGREENE' , '011.44.1346.229268' , STR_TO_DATE('19/03/2007', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 9500 , .15 , 147 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Mattea' , 'Marvins' , 'MMARVINS' , '011.44.1346.329268' , STR_TO_DATE('24/01/2008', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 7200 , .10 , 147 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'David' , 'Lee' , 'DLEE' , '011.44.1346.529268' , STR_TO_DATE('23/02/2008', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 6800 , .1 , 147 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Sundar' , 'Ande' , 'SANDE' , '011.44.1346.629268' , STR_TO_DATE('24/03/2008', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 6400 , .10 , 147 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Amit' , 'Banda' , 'ABANDA' , '011.44.1346.729268' , STR_TO_DATE('21/04/2008', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 6200 , .10 , 147 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Lisa' , 'Ozer' , 'LOZER' , '011.44.1343.929268' , STR_TO_DATE('11/03/2005', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 11500 , .25 , 148 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Harrison' , 'Bloom' , 'HBLOOM' , '011.44.1343.829268' , STR_TO_DATE('23/03/2006', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 10000 , .20 , 148 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Tayler' , 'Fox' , 'TFOX' , '011.44.1343.729268' , STR_TO_DATE('24/01/2006', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 9600 , .20 , 148 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'William' , 'Smith' , 'WSMITH' , '011.44.1343.629268' , STR_TO_DATE('23/02/2007', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 7400 , .15 , 148 , 8  , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Elizabeth' , 'Bates' , 'EBATES' , '011.44.1343.529268' , STR_TO_DATE('24/03/2007', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 7300 , .15 , 148 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Sundita' , 'Kumar' , 'SKUMAR' , '011.44.1343.329268' , STR_TO_DATE('21/04/2008', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 6100 , .10 , 148 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Ellen' , 'Abel' , 'EABEL' , '011.44.1644.429267' , STR_TO_DATE('11/05/2004', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 11000 , .30 , 149 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Alyssa' , 'Hutton' , 'AHUTTON' , '011.44.1644.429266' , STR_TO_DATE('19/03/2005', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 8800 , .25 , 149 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Jonathon' , 'Taylor' , 'JTAYLOR' , '011.44.1644.429265' , STR_TO_DATE('24/03/2006', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 8600 , .20 , 149 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Jack' , 'Livingston' , 'JLIVINGS' , '011.44.1644.429264' , STR_TO_DATE('23/04/2006', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 8400 , .20 , 149 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Kimberely' , 'Grant' , 'KGRANT' , '011.44.1644.429263' , STR_TO_DATE('24/05/2007', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 7000 , .15 , 149 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Charles' , 'Johnson' , 'CJOHNSON' , '011.44.1644.429262' , STR_TO_DATE('04/01/2008', '%d/%m/%Y') , '' , '' , '' , 'SA_REP' , 6200 , .10 , 149 , 8 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Winston' , 'Taylor' , 'WTAYLOR' , '650.507.9876' , STR_TO_DATE('24/01/2006', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 3200 , NULL , 120 , 5  , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Jean' , 'Fleaur' , 'JFLEAUR' , '650.507.9877' , STR_TO_DATE('23/02/2006', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 3100 , NULL , 120 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Martha' , 'Sullivan' , 'MSULLIVA' , '650.507.9878' , STR_TO_DATE('21/06/2007', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 2500 , NULL , 120 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Girard' , 'Geoni' , 'GGEONI' , '650.507.9879' , STR_TO_DATE('03/02/2008', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 2800 , NULL , 120 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Nandita' , 'Sarchand' , 'NSARCHAN' , '650.509.1876' , STR_TO_DATE('27/01/2004', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 4200 , NULL , 121 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Alexis' , 'Bull' , 'ABULL' , '650.509.2876' , STR_TO_DATE('20/02/2005', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 4100 , NULL , 121 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Julia' , 'Dellinger' , 'JDELLING' , '650.509.3876' , STR_TO_DATE('24/06/2006', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 3400 , NULL , 121 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Anthony' , 'Cabrio' , 'ACABRIO' , '650.509.4876' , STR_TO_DATE('07/02/2007', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 3000 , NULL , 121 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Kelly' , 'Chung' , 'KCHUNG' , '650.505.1876' , STR_TO_DATE('14/06/2005', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 3800 , NULL , 122 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Jennifer' , 'Dilly' , 'JDILLY' , '650.505.2876' , STR_TO_DATE('13/08/2005', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 3600 , NULL , 122 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Timothy' , 'Gates' , 'TGATES' , '650.505.3876' , STR_TO_DATE('11/07/2006', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 2900 , NULL , 122 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Randall' , 'Perkins' , 'RPERKINS' , '650.505.4876' , STR_TO_DATE('19/12/2007', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 2500 , NULL , 122 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Sarah' , 'Bell' , 'SBELL' , '650.501.1876' , STR_TO_DATE('04/02/2004', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 4000 , NULL , 123 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Britney' , 'Everett' , 'BEVERETT' , '650.501.2876' , STR_TO_DATE('03/03/2005', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 3900 , NULL , 123 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Samuel' , 'McCain' , 'SMCCAIN' , '650.501.3876' , STR_TO_DATE('01/07/2006', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 3200 , NULL , 123 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Vance' , 'Jones' , 'VJONES' , '650.501.4876' , STR_TO_DATE('17/03/2007', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 2800 , NULL , 123 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Alana' , 'Walsh' , 'AWALSH' , '650.507.9811' , STR_TO_DATE('24/04/2006', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 3100 , NULL , 124 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Kevin' , 'Feeney' , 'KFEENEY' , '650.507.9822' , STR_TO_DATE('23/05/2006', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 3000 , NULL , 124 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Donald' , 'OConnell' , 'DOCONNEL' , '650.507.9833' , STR_TO_DATE('21/06/2007', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 2600 , NULL , 124 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Douglas' , 'Grant' , 'DGRANT' , '650.507.9844' , STR_TO_DATE('13/01/2008', '%d/%m/%Y') , '' , '' , '' , 'SH_CLERK' , 2600 , NULL , 124 , 5 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Jennifer' , 'Whalen' , 'JWHALEN' , '515.123.4444' , STR_TO_DATE('17/09/2003', '%d/%m/%Y') , '' , '' , '' , 'AD_ASST' , 4400 , NULL , 101 , 1 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Michael' , 'Hartstein' , 'MHARTSTE' , '515.123.5555' , STR_TO_DATE('17/02/2004', '%d/%m/%Y') , '' , '' , '' , 'MK_MAN' , 13000 , NULL , 100 , 2 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Pat' , 'Fay' , 'PFAY' , '603.123.6666' , STR_TO_DATE('17/08/2005', '%d/%m/%Y') , '' , '' , '' , 'MK_REP' , 6000 , NULL , 201 , 2 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Susan' , 'Mavris' , 'SMAVRIS' , '515.123.7777' , STR_TO_DATE('07/06/2002', '%d/%m/%Y') , '' , '' , '' , 'DATA_REP' , 6500 , NULL , 101 , 4 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Hermann' , 'Baer' , 'HBAER' , '515.123.8888' , STR_TO_DATE('07/06/2002', '%d/%m/%Y') , '' , '' , '' , 'PR_REP' , 10000 , NULL , 101 , 7 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'Shelley' , 'Higgins' , 'SHIGGINS' , '515.123.8080' , STR_TO_DATE('07/06/2002', '%d/%m/%Y') , '' , '' , '' , 'AC_MGR' , 12008 , NULL , 101 , 11 , 'SYSTEM');
INSERT INTO HR.TBL_EMPLOYEES (first_name, last_name, email, phone_number, hire_date, identity_code, social_safety_code, business_code, job_id, salary, commission_pct, manager_id, department_id, user_add_date) VALUES ( 'William' , 'Gietz' , 'WGIETZ' , '515.123.8181' , STR_TO_DATE('07/06/2002', '%d/%m/%Y') , '' , '' , '' , 'AC_ACCOUNT' , 8300 , NULL , 205 , 11 , 'SYSTEM');

COMMIT;

-- Job history
INSERT INTO HR.TBL_JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, department_id, user_add_date) VALUES (102 , STR_TO_DATE('13/01/2001', '%d/%m/%Y') , STR_TO_DATE('24/07/2006', '%d/%m/%Y') , 'IT_PROG' , 6 , 'SYSTEM');
INSERT INTO HR.TBL_JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, department_id, user_add_date) VALUES (101 , STR_TO_DATE('21/09/1997', '%d/%m/%Y') , STR_TO_DATE('27/10/2001', '%d/%m/%Y') , 'AC_ACCOUNT' , 11 , 'SYSTEM');
INSERT INTO HR.TBL_JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, department_id, user_add_date) VALUES (101 , STR_TO_DATE('28/10/2001', '%d/%m/%Y') , STR_TO_DATE('15/03/2005', '%d/%m/%Y') , 'AC_MGR' , 11 , 'SYSTEM');
INSERT INTO HR.TBL_JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, department_id, user_add_date) VALUES (201 , STR_TO_DATE('17/02/2004', '%d/%m/%Y') , STR_TO_DATE('19/12/2007', '%d/%m/%Y') , 'MK_REP' , 2 , 'SYSTEM');
INSERT INTO HR.TBL_JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, department_id, user_add_date) VALUES (114 , STR_TO_DATE('24/03/2006', '%d/%m/%Y') , STR_TO_DATE('31/12/2007', '%d/%m/%Y') , 'ST_CLERK' , 5 , 'SYSTEM');
INSERT INTO HR.TBL_JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, department_id, user_add_date) VALUES (122 , STR_TO_DATE('01/01/2007', '%d/%m/%Y') , STR_TO_DATE('31/12/2007', '%d/%m/%Y') , 'ST_CLERK' , 5 , 'SYSTEM');
INSERT INTO HR.TBL_JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, department_id, user_add_date) VALUES (200 , STR_TO_DATE('17/09/1995', '%d/%m/%Y') , STR_TO_DATE('17/06/2001', '%d/%m/%Y') , 'AD_ASST' , 9 , 'SYSTEM');
INSERT INTO HR.TBL_JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, department_id, user_add_date) VALUES (176 , STR_TO_DATE('24/03/2006', '%d/%m/%Y') , STR_TO_DATE('31/12/2006', '%d/%m/%Y') , 'SA_REP' , 8 , 'SYSTEM');
INSERT INTO HR.TBL_JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, department_id, user_add_date) VALUES (176 , STR_TO_DATE('01/01/2007', '%d/%m/%Y') , STR_TO_DATE('31/12/2007', '%d/%m/%Y') , 'SA_MAN' , 8 , 'SYSTEM');
INSERT INTO HR.TBL_JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, department_id, user_add_date) VALUES (200 , STR_TO_DATE('01/07/2002', '%d/%m/%Y') , STR_TO_DATE('31/12/2006', '%d/%m/%Y') , 'AC_ACCOUNT' , 9 , 'SYSTEM');

COMMIT;

-- Foreign keys.
ALTER TABLE HR.TBL_USER_TOKENS ADD CONSTRAINT USR_CRED_FK FOREIGN KEY (credential_id) REFERENCES HR.TBL_USERS(credential_id);
ALTER TABLE HR.TBL_COUNTRIES ADD CONSTRAINT COUNTRY_REG_FK FOREIGN KEY (region_id) REFERENCES HR.TBL_REGIONS(region_id);
ALTER TABLE HR.TBL_LOCATIONS ADD CONSTRAINT LOC_C_ID_FK FOREIGN KEY (country_id) REFERENCES HR.TBL_COUNTRIES(country_id);
ALTER TABLE HR.TBL_DEPARTMENTS ADD CONSTRAINT DEPT_LOC_FK FOREIGN KEY (location_id) REFERENCES HR.TBL_LOCATIONS (location_id);
ALTER TABLE HR.TBL_JOB_HISTORY ADD CONSTRAINT JOB_HIS_EMP_PK FOREIGN KEY (employee_id) REFERENCES HR.TBL_EMPLOYEES (employee_id);
ALTER TABLE HR.TBL_JOB_HISTORY ADD CONSTRAINT JOB_HIS_JOB_PK FOREIGN KEY (job_id) REFERENCES HR.TBL_JOBS (job_id);
ALTER TABLE HR.TBL_JOB_HISTORY ADD CONSTRAINT JOB_HIS_DEPT_PK FOREIGN KEY (department_id) REFERENCES HR.TBL_DEPARTMENTS (department_id);
ALTER TABLE HR.TBL_DEPARTMENTS ADD CONSTRAINT DEPT_MGR_FK FOREIGN KEY (manager_id) REFERENCES HR.TBL_EMPLOYEES (employee_id) ON DELETE SET NULL ON UPDATE CASCADE;

COMMIT;

USE HR;

SELECT * FROM HR.TBL_USERS;

SELECT * FROM HR.TBL_USER_TOKENS;

SELECT * FROM HR.TBL_REGIONS;

SELECT * FROM HR.TBL_COUNTRIES;

SELECT * FROM HR.TBL_LOCATIONS;

SELECT * FROM HR.TBL_DEPARTMENTS;

SELECT * FROM HR.TBL_JOBS;

SELECT * FROM HR.TBL_EMPLOYEES;

SELECT * FROM HR.TBL_JOB_HISTORY;

SELECT e.first_name AS empleado,
       e.job_id,
       j.first_name AS jefe
  FROM HR.TBL_EMPLOYEES e
  LEFT JOIN HR.TBL_EMPLOYEES j ON e.manager_id = j.employee_id;

-- Store Procedures.
USE HR;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_add_new_user`(IN `p_user_name`           VARCHAR(15),
                                                        IN `p_user_secret`         VARCHAR(255),
                                                        IN `p_user_full_name`      VARCHAR(255),
                                                        IN `p_user_add_date`       VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO max_user_id FROM HR.TBL_USERS WHERE (user_name = p_user_name);

    IF (max_user_id = 0) THEN
        INSERT INTO HR.TBL_USERS (user_name, user_secret, user_full_name, flag_state, user_add_date)
        VALUES(p_user_name, p_user_secret, p_user_full_name, 'ACTIVE', p_user_add_date);
    ELSE
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = "A user account with a reference user name already exists";
    END IF;
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_update_existent_user`(IN `p_credential_id`    CHAR(36),
                                                                IN `p_user_secret`      VARCHAR(255),
                                                                IN `p_user_update_date` VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO max_user_id FROM HR.TBL_USERS WHERE (credential_id = p_credential_id) AND (flag_state = 'ACTIVE');

    IF (max_user_id > 0) THEN
        UPDATE HR.TBL_USERS t1
           SET t1.user_secret = p_user_secret,
               t1.updated_at = CURRENT_TIMESTAMP(),
               t1.user_update_date = p_user_update_date
         WHERE (t1.credential_id = p_credential_id)
           AND (t1.flag_state = 'ACTIVE');
    ELSE
        SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = "A user account with a reference user not found";
    END IF;
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_delete_existent_user`(IN `p_credential_id`    CHAR(36),
                                                                IN `p_user_delete_date` VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO max_user_id FROM HR.TBL_USERS WHERE (credential_id = p_credential_id) AND (flag_state = 'ACTIVE');

    IF (max_user_id > 0) THEN
        UPDATE HR.TBL_USERS t1
           SET t1.user_secret = '***************',
               t1.deleted_at = CURRENT_TIMESTAMP(),
               t1.user_delete_date = p_user_delete_date,
               t1.flag_state = 'DELETED'
         WHERE (t1.credential_id = p_credential_id)
           AND (t1.flag_state = 'ACTIVE');
    ELSE
        SIGNAL SQLSTATE '45003' SET MESSAGE_TEXT = "A user account with a reference user not found";
    END IF;
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_restore_existent_user`(IN `p_credential_id`    CHAR(36),
                                                                 IN `p_user_update_date` VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO max_user_id FROM HR.TBL_USERS WHERE (credential_id = p_credential_id) AND (flag_state != 'ACTIVE');

    IF (max_user_id > 0) THEN
        UPDATE HR.TBL_USERS t1
           SET t1.user_secret = '-',
               t1.updated_at = CURRENT_TIMESTAMP(),
               t1.user_delete_date = p_user_delete_date,
               t1.flag_state = 'LOCKED'
         WHERE (t1.credential_id = p_credential_id);
    ELSE
        SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = "A user account with a reference user not found";
    END IF;
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_existent_user`(IN `p_user_name`            VARCHAR(15))
BEGIN
    SELECT t1.credential_id AS Id,
           t1.user_name AS UserName,
           t1.user_secret AS UserSecret,
           t1.user_full_name AS UserFullName,
           t1.last_refresh_date AS LastRefreshDate,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.TBL_USERS t1
     WHERE (t1.user_name = p_user_name);
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_existent_user_by_id`(IN `p_credential_id`  VARCHAR(36))
BEGIN
    SELECT t1.credential_id AS Id,
           t1.user_name AS UserName,
           t1.user_secret AS UserSecret,
           t1.user_full_name AS UserFullName,
           t1.last_refresh_date AS LastRefreshDate,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.TBL_USERS t1
     WHERE (t1.credential_id = p_credential_id);
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_token_by_user`(IN `p_credential_id`  VARCHAR(36))
BEGIN
    SELECT t1.id_token AS Id,
           t1.credential_id AS IdCredential,
           t1.token_value AS Token,
           t1.expiration_date AS ExpirationDate,
           t1.ip_address AS IpAddress,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.TBL_USER_TOKENS t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_token`(IN `p_token_value`  VARCHAR(255))
BEGIN
    SELECT t1.id_token AS Id,
           t1.credential_id AS IdCredential,
           t1.token_value AS Token,
           t1.expiration_date AS ExpirationDate,
           t1.ip_address AS IpAddress,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.TBL_USER_TOKENS t1
     WHERE (t1.token_value = p_token_value)
       AND (t1.flag_state = 'ACTIVE');
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_refreshtoken`(IN `p_user_name`           VARCHAR(15),
                                                            IN `p_id_token`            VARCHAR(36))
BEGIN
    SELECT t1.token_value AS Token
      FROM HR.TBL_USER_TOKENS t1
      JOIN HR.TBL_USERS t2 ON (t1.credential_id = t2.credential_id)
     WHERE (t1.id_token = p_id_token)
       AND (t2.user_name = p_user_name)
       AND (t2.flag_state = 'ACTIVE');
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_is_expired_token`(IN `p_id_token`            VARCHAR(36))
BEGIN
    SELECT (CURRENT_TIMESTAMP() > t1.expiration_date) AS StatusExpiration
      FROM HR.TBL_USER_TOKEN t1
     WHERE (t1.id_token = p_id_token);
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_save_new_token`(IN `p_user_name`           VARCHAR(15),
                                                          IN `p_ip_address`          VARCHAR(100),
                                                          IN `p_new_refresh`         VARCHAR(255),
                                                          IN `p_user_date`           VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE time_expiration VARCHAR(255) DEFAULT '';
    DECLARE current_credential_id CHAR(36);
    SELECT COUNT(*) INTO max_user_id FROM HR.TBL_USERS WHERE (user_name = p_user_name);
    SELECT t1.value_parameter INTO time_expiration FROM HR.TBL_PARAMETERS t1 WHERE (t1.parameter_description = 'CFG_EXPIRATION_TOKEN_MINUTES');

    IF (max_user_id > 0 AND time_expiration > 0) THEN
        -- Actualizo la fecha de refresco del token.
        UPDATE HR.TBL_USERS t1
           SET t1.last_refresh_date = CURRENT_TIMESTAMP(),
               t1.updated_at = CURRENT_TIMESTAMP(),
               t1.user_update_date = p_user_date
         WHERE (t1.user_name = p_user_name)
           AND (t1.flag_state = 'ACTIVE');

        -- Leo el identificador de la credencial de la cuenta existente.
        SELECT t1.credential_id INTO current_credential_id
          FROM HR.TBL_USERS t1
         WHERE (t1.user_name = p_user_name)
           AND (t1.flag_state = 'ACTIVE');

        -- Guardo el nuevo token generado.
        INSERT INTO HR.TBL_USER_TOKENS (credential_id, token_value, expiration_date, ip_address, flag_state, user_add_date)
        VALUES(current_credential_id, p_new_refresh, DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL time_expiration MINUTE), p_ip_address, 'ACTIVE', p_user_date);

        -- Muestro el identificador del token generado.
        SELECT t1.id_token AS IdToken
          FROM HR.TBL_USER_TOKENS t1
         WHERE (t1.credential_id = current_credential_id)
           AND (t1.flag_state = 'ACTIVE')
         ORDER BY t1.added_at DESC LIMIT 1;
    ELSE
        SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = "A user account with a reference user name not exists";
    END IF;
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_save_refresh_token`(IN `p_id_token`            VARCHAR(36),
                                                              IN `p_user_name`           VARCHAR(15),
                                                              IN `p_new_refresh`         VARCHAR(255),
                                                              IN `p_ip_address`          VARCHAR(100),
                                                              IN `p_user_date`           VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE time_expiration VARCHAR(255) DEFAULT '';
    DECLARE current_credential_id CHAR(36);
    SELECT COUNT(*) INTO max_user_id FROM HR.TBL_USERS WHERE (user_name = p_user_name);
    SELECT t1.value_parameter INTO time_expiration FROM HR.TBL_PARAMETERS WHERE (parameter_description = 'CFG_EXPIRATION_TOKEN_MINUTES');

    IF (max_user_id > 0 AND time_expiration > 0) THEN
            -- Actualizo la fecha de refresco del token.
        UPDATE HR.TBL_USERS t1
           SET t1.last_refresh_date = CURRENT_TIMESTAMP(),
               t1.updated_at = CURRENT_TIMESTAMP(),
               t1.user_update_date = p_user_date
         WHERE (t1.user_name = p_user_name)
           AND (t1.flag_state = 'ACTIVE');

        -- Leo el identificador de la credencial de la cuenta existente.
        SELECT t1.credential_id INTO current_credential_id
          FROM HR.TBL_USERS t1
         WHERE (t1.user_name = p_user_name)
           AND (t1.flag_state = 'ACTIVE');

        -- Actualizo el token nuevo.
        UPDATE HR.TBL_USER_TOKENS t1
           SET t1.token_value = p_new_refresh,
               t1.expiration_date = DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL time_expiration MINUTE),
               t1.ip_address = p_ip_address,
               t1.flag_state = 'ACTIVE',
               t1.updated_at = CURRENT_TIMESTAMP(),
               t1.user_update_date = p_user_date
         WHERE (t1.credential_id = current_credential_id)
           AND (t1.id_token = p_id_token);

        -- Muestro el identificador del token generado.
        SELECT t1.id_token AS IdToken
          FROM HR.TBL_USER_TOKENS t1
         WHERE (t1.credential_id = current_credential_id)
           AND (t1.id_token = p_id_token)
           AND (t1.flag_state = 'ACTIVE')
         ORDER BY t1.added_at DESC LIMIT 1;
    ELSE
        SIGNAL SQLSTATE '45006' SET MESSAGE_TEXT = "A user account with a reference user name not exists";
    END IF;
END$$

DELIMITER ;

COMMIT;

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_clear_token`(IN `p_id_token`            VARCHAR(36),
                                                       IN `p_user_name`           VARCHAR(15),
                                                       IN `p_user_date`           VARCHAR(255))
BEGIN
        DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE current_credential_id CHAR(36);
    SELECT COUNT(*) INTO max_user_id FROM HR.TBL_USERS WHERE (user_name = p_user_name);

    IF (max_user_id > 0) THEN
        -- Actualizo la fecha de refresco del token.
        UPDATE HR.TBL_USERS t1
           SET t1.last_refresh_date = CURRENT_TIMESTAMP(),
               t1.updated_at = CURRENT_TIMESTAMP(),
               t1.user_update_date = p_user_date
         WHERE (t1.user_name = p_user_name)
           AND (t1.flag_state = 'ACTIVE');

        -- Leo el identificador de la credencial de la cuenta existente.
        SELECT t1.credential_id INTO current_credential_id
          FROM HR.TBL_USERS t1
         WHERE (t1.user_name = p_user_name)
           AND (t1.flag_state = 'ACTIVE');


        -- Muestro el identificador del token generado.
        SELECT CONCAT(t1.id_token, '|', t1.token_value) AS arrayValue
               FROM HR.TBL_USER_TOKENS t1
         WHERE (t1.credential_id = current_credential_id)
           AND (t1.id_token = p_id_token)
           AND (t1.flag_state = 'ACTIVE')
         ORDER BY t1.added_at DESC LIMIT 1;
    ELSE
        SIGNAL SQLSTATE '45006' SET MESSAGE_TEXT = "A user account with a reference user name not exists";
    END IF;
END$$

DELIMITER ;

COMMIT;

-- Events.
SHOW VARIABLES LIKE 'event_scheduler';
SET GLOBAL event_scheduler = ON;

CREATE EVENT IF NOT EXISTS HR.EVT_STATUS_TOKEN
ON SCHEDULE EVERY 5 MINUTE
DO
    UPDATE HR.tbl_user_tokens t1
       SET t1.flag_state = 'DELETED',
           t1.user_delete_date = 'SYSTEM',
           t1.deleted_at = CURRENT_TIMESTAMP()
     WHERE (t1.expiration_date < CURRENT_TIMESTAMP());

CREATE EVENT IF NOT EXISTS HR.EVT_DELETE_TOKEN
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
    DELETE FROM HR.tbl_users_tokens
     WHERE (expiration_date < CURRENT_TIMESTAMP());

-- Fin del script.
