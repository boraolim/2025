USE HR;

-- Root acount.
INSERT INTO HR.TBL_USERS (user_name, user_secret, user_full_name, flag_state, user_add_date)
VALUES('root', '0C0000004B48CB9DAC37A7BB07168409100000002B0A7BD77365BFC66544DDBB86393E3D4B5CBC4E7CD0AB782E78DB0F4620F039746230CAC1575FB46B8ABBA7C7D335FCF083FC8412B31D02', 'ADMINISTRADOR DEL SISTEMA', 'ACTIVE', 'root');
UPDATE HR.TBL_USERS SET user_add_date = credential_id WHERE (user_name = 'root');

COMMIT;

-- Parameters.
INSERT INTO HR.TBL_PARAMETERS (group_name, sub_group_name, parameter_key, value_parameter, value_type, parameter_description, user_add_date)
VALUES ('CONFIGURATION', 'JwtSettings', 'CFG_EXPIRATION_TOKEN_MINUTES', '15', 'STRING', 'Tiempo de expiración de token', 'SYSTEM'),
       ('CONFIGURATION', 'JwtSettings', 'CFG_CLIENT_SECRETKEY', '0C00000062EEA38A1AF046F2EB5AAF2810000000E2F74A2C4A9BEAEF5DF958368C08E7DFEAF42D4EB339220C18E220E7056CEC1B9405748EAFC6203B50FA0496CF96F4EF74F24B03F47A72EE', 'STRING', 'Clave secreta para la autenticación JWT', 'SYSTEM'),
       ('CONFIGURATION', 'JwtSettings', 'CFG_ISSUER', '0C0000003402B928DDE339E9377213A4100000002005D9694BB5AC343795851D50F8507938D02816BAB28851B1DF509BCFC39C1C289D2434CF679F1CAF4C8298C3E10582B86FC8BAEF41CDC0', 'STRING', 'Clave del emisor JWT', 'SYSTEM'),
       ('CONFIGURATION', 'JwtSettings', 'CFG_AUDIENCE', '0C000000F61ADD9CC77D5FC35F5C8458100000001AAF25630267D301F9761371A2AC19C1A050476DBD854F3E5E53E900D43DB964455B29B7E8678A388213A1EBEB074351711ED912916EBE0D', 'STRING', 'Clave del publicante JWT', 'SYSTEM'),
       ('CONFIGURATION', 'PaginationSettings', 'CFG_MINIMUM_ROWS_PER_PAGE', '10', 'INT', 'Número de registros mínimo por página', 'SYSTEM'),
       ('CONFIGURATION', 'PaginationSettings', 'CFG_MAXIMUM_ROWS_PER_PAGE', '50', 'INT', 'Número de registros máximo por página', 'SYSTEM'),
       ('CONFIGURATION', 'PaginationSettings', 'CFG_MAXIMUM_PAGE_PER_LIST', '10', 'INT', 'Número de páginas máximo para el desplegado de registros', 'SYSTEM');

COMMIT;

-- Users-Parameters
INSERT INTO HR.tbl_users_parameters (credential_id, parameter_id, user_add_date)
SELECT t2.credential_id, t1.parameter_id, 'SYSTEM'
  FROM HR.tbl_users t2
 CROSS JOIN HR.tbl_parameters t1
 WHERE (t2.user_name = 'root');

COMMIT;

-- Modules
INSERT INTO HR.tbl_modules (module_name, module_description, module_path, module_version_api, user_add_date)
 VALUE ('ConfigurationByGroup', 'Configuración de parámetros por grupo', 'api/v1/Configuration/ConfigurationByGroup', 'v1', 'SYSTEM'),
       ('ConfigurationBySubGroup', 'Configuración de parámetros por subgrupo', 'api/v1/Configuration/ConfigurationBySubGroup', 'v1', 'SYSTEM'),
       ('ConfigurationByKeyName', 'Configuración de parámetros por clave', 'api/v1/Configuration/ConfigurationByKeyName', 'v1', 'SYSTEM'),
       ('SaveConfigurationByKeyValue', 'Alta de valor nuevo a una clave nueva', 'api/v1/Configuration/SaveConfigurationByKeyValue', 'v1', 'SYSTEM'),
       ('UpdateConfigurationByKeyValue', 'Actualización de un valor existente de una clave activa', 'api/v1/Configuration/UpdateConfigurationByKeyValue', 'v1', 'SYSTEM'),
       ('EnableGroup', 'Activar o apagar grupo de configuraciones existente', 'api/v1/Configuration/EnableGroup', 'v1', 'SYSTEM'),
       ('EnableSubGroup', 'Activar o apagar subgrupo de configuraciones existente', 'api/v1/Configuration/EnableSubGroup', 'v1', 'SYSTEM'),
       ('EnableKeyName', 'Activar o apagar clave de configuración existente', 'api/v1/Configuration/EnableKeyName', 'v1', 'SYSTEM');
COMMIT;

-- Policies
INSERT INTO HR.tbl_policies (policy_name, policy_description, user_add_date)
 VALUE ('CanGetConfigurationGroup', 'Puede mostrar la configuración de un grupo existente', 'SYSTEM'),
       ('CanGetConfigurationSubGroup', 'Puede mostrar la configuración de un subgrupo existente', 'SYSTEM'),
       ('CanGetConfigurationKeyName', 'Puede mostrar la configuración de una clave existente', 'SYSTEM'),
       ('CanSaveANewConfiguration', 'Puede guardar una nueva configuración en un grupo y subgrupo', 'SYSTEM'),
       ('CanUpdateAnExistentConfiguration', 'Puede actualizar una configuración existente de un grupo y subgrupo', 'SYSTEM'),
       ('CanEnableOrDisableGroup', 'Puede activar o apagar un grupo de configuraciones', 'SYSTEM'),
       ('CanEnableOrDisableSubGroup', 'Puede activar o apagar un grupo y subgrupo de configuraciones', 'SYSTEM'),
       ('CanEnableOrDisableKeyName', 'Puede activar o apagar una configuracion existente', 'SYSTEM');

COMMIT;

-- Module-Policy
INSERT INTO HR.tbl_module_policy (module_id, policy_id, is_system_policy, user_add_date)
VALUES (1, 1, 1, 'SYSTEM'),
       (2, 2, 1, 'SYSTEM'),
       (3, 3, 1, 'SYSTEM'),
       (4, 4, 1, 'SYSTEM'),
       (5, 5, 1, 'SYSTEM'),
       (6, 6, 1, 'SYSTEM'),
       (7, 7, 1, 'SYSTEM'),
       (8, 8, 1, 'SYSTEM');

COMMIT;

-- Users-Module-Policy
INSERT INTO HR.tbl_users_module_policy (credential_id, module_policy_id, user_add_date)
SELECT t2.credential_id, t1.module_policy_id, 'SYSTEM'
  FROM HR.tbl_users t2
CROSS JOIN HR.tbl_module_policy t1
WHERE (t2.user_name = 'root') AND (t1.is_system_policy = 1);

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