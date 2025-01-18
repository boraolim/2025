-- Scripts para politicas y metodos de negocio.
USE HR;

-- Agregar parametros a los usuarios.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_add_parameter_to_user`(IN `p_credential_id`          CHAR(36),
                                                                 IN `p_detail_parameters_json` TEXT,
                                                                 IN `p_user_add_date`          VARCHAR(255))
BEGIN
    DECLARE v_index INT DEFAULT 0;
    DECLARE v_length INT DEFAULT 0;
    DECLARE v_id_parameter INT;
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE max_previous_parameters INTEGER DEFAULT 0;

    IF JSON_LENGTH(p_detail_parameters_json) = 0 THEN
        SIGNAL SQLSTATE '45015' SET MESSAGE_TEXT = 'Parameters list not found or is empty.';
    END IF;

    SELECT COUNT(*) INTO max_previous_parameters FROM HR.tbl_users_parameters t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');

    IF max_previous_parameters > 0 THEN
        SIGNAL SQLSTATE '45016' SET MESSAGE_TEXT = 'Parameters for credential id already exists';
    END IF;

    SELECT COUNT(*) INTO max_user_id FROM HR.tbl_users t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');

    IF max_user_id > 0 THEN
        SET v_length = JSON_LENGTH(p_detail_parameters_json);

        WHILE v_index < v_length DO
            SET v_id_parameter = JSON_UNQUOTE(JSON_EXTRACT(p_detail_parameters_json, CONCAT('$[', v_index, '].idParameter')));

            IF v_id_parameter IS NULL THEN
                SIGNAL SQLSTATE '45017' SET MESSAGE_TEXT = 'Missing value in idParameter field from current index.';
            END IF;

            INSERT INTO HR.tbl_users_parameters (credential_id, parameter_id, user_add_date)
            VALUES (p_credential_id, v_id_parameter, p_user_add_date);

            SET v_index = v_index + 1;
        END WHILE;
    ELSE
        SIGNAL SQLSTATE '45018' SET MESSAGE_TEXT = 'Credential Id not exists.';
    END IF;
END;

COMMIT;

-- Actualizar parametros a cuentas de usuario existentes.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_update_parameter_to_user`(IN `p_credential_id`          CHAR(36),
                                                                    IN `p_detail_parameters_json` TEXT,
                                                                    IN `p_user_add_date`          VARCHAR(255))
BEGIN
    DECLARE v_index INT DEFAULT 0;
    DECLARE v_length INT DEFAULT 0;
    DECLARE v_id_parameter INT;
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE max_previous_parameters INTEGER DEFAULT 0;

    IF JSON_LENGTH(p_detail_parameters_json) = 0 THEN
        SIGNAL SQLSTATE '45019' SET MESSAGE_TEXT = 'Parameters list not found or is empty.';
    END IF;

    SELECT COUNT(*) INTO max_previous_parameters FROM HR.tbl_users_parameters t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');

    IF max_previous_parameters > 0 THEN
        -- Valido si existe la cuenta de usuario existente.
        SELECT COUNT(*) INTO max_user_id FROM HR.tbl_users t1
         WHERE (t1.credential_id = p_credential_id)
           AND (t1.flag_state = 'ACTIVE');

        IF max_user_id > 0 THEN
            -- Elimino los parametros existentes.
            DELETE FROM tbl_users_parameters
             WHERE (credential_id = p_credential_id)
               AND (flag_state = 'ACTIVE');

            -- Inserto los nuevos parametros.
            SET v_length = JSON_LENGTH(p_detail_parameters_json);

            WHILE v_index < v_length DO
                SET v_id_parameter = JSON_UNQUOTE(JSON_EXTRACT(p_detail_parameters_json, CONCAT('$[', v_index, '].idParameter')));

                IF v_id_parameter IS NULL THEN
                    SIGNAL SQLSTATE '45020' SET MESSAGE_TEXT = 'Missing value in idParameter field from current index.';
                END IF;

                INSERT INTO HR.tbl_users_parameters (credential_id, parameter_id, user_add_date)
                VALUES (p_credential_id, v_id_parameter, p_user_add_date);

                SET v_index = v_index + 1;
            END WHILE;
        ELSE
            SIGNAL SQLSTATE '45021' SET MESSAGE_TEXT = 'Credential Id not exists.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45022' SET MESSAGE_TEXT = 'Parameters for credential id not exists';
    END IF;
END;

COMMIT;

-- Inhabilitar todos los parámetros a una cuenta de usuario existente.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_lock_all_parameter_to_user`(IN `p_credential_id`          CHAR(36),
                                                                      IN `p_user_update_date`       VARCHAR(255))
BEGIN
    DECLARE v_index INT DEFAULT 0;
    DECLARE v_length INT DEFAULT 0;
    DECLARE v_id_parameter INT;
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE max_previous_parameters INTEGER DEFAULT 0;

    SELECT COUNT(*) INTO max_previous_parameters FROM HR.tbl_users_parameters t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');

    IF max_previous_parameters > 0 THEN
        -- Valido si existe la cuenta de usuario existente.
        SELECT COUNT(*) INTO max_user_id FROM HR.tbl_users t1
         WHERE (t1.credential_id = p_credential_id)
           AND (t1.flag_state = 'ACTIVE');

        IF max_user_id > 0 THEN
            -- Bloqueo los parámetros .
            UPDATE tbl_users_parameters t1
               SET t1.updated_at = CURRENT_TIMESTAMP(),
                   t1.user_update_date = p_user_update_date,
                   t1.flag_state = 'LOCKED'
             WHERE (t1.credential_id = p_credential_id)
               AND (t1.flag_state = 'ACTIVE');
        ELSE
            SIGNAL SQLSTATE '45023' SET MESSAGE_TEXT = 'Credential Id not exists.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45024' SET MESSAGE_TEXT = 'Parameters for credential id not exists';
    END IF;
END;

COMMIT;

-- Bloquear un parámetro a una cuenta de usuario existente.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_disable_all_parameter_to_user`(IN `p_credential_id`          CHAR(36),
                                                                         IN `p_user_delete_date`      VARCHAR(255))
BEGIN
    DECLARE v_index INT DEFAULT 0;
    DECLARE v_length INT DEFAULT 0;
    DECLARE v_id_parameter INT;
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE max_previous_parameters INTEGER DEFAULT 0;

    SELECT COUNT(*) INTO max_previous_parameters FROM HR.tbl_users_parameters t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');

    IF max_previous_parameters > 0 THEN
        -- Valido si existe la cuenta de usuario existente.
        SELECT COUNT(*) INTO max_user_id FROM HR.tbl_users t1
         WHERE (t1.credential_id = p_credential_id)
           AND (t1.flag_state = 'ACTIVE');

        IF max_user_id > 0 THEN
            -- Bloqueo los parámetros .
            UPDATE tbl_users_parameters t1
               SET t1.deleted_at = CURRENT_TIMESTAMP(),
                   t1.user_delete_date = p_user_delete_date,
                   t1.flag_state = 'DELETED'
             WHERE (t1.credential_id = p_credential_id)
               AND (t1.flag_state = 'ACTIVE');
        ELSE
            SIGNAL SQLSTATE '45025' SET MESSAGE_TEXT = 'Credential Id not exists.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45026' SET MESSAGE_TEXT = 'Parameters for credential id not exists';
    END IF;
END;

COMMIT;

-- Rehabilitar todos los parámetros a una cuenta de usuario existente.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_enable_all_parameter_to_user`(IN `p_credential_id`          CHAR(36),
                                                                        IN `p_user_update_date`       VARCHAR(255))
BEGIN
    DECLARE v_index INT DEFAULT 0;
    DECLARE v_length INT DEFAULT 0;
    DECLARE v_id_parameter INT;
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE max_previous_parameters INTEGER DEFAULT 0;

    SELECT COUNT(*) INTO max_previous_parameters FROM HR.tbl_users_parameters t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'LOCKED' OR t1.flag_state = 'DELETED');

    IF max_previous_parameters > 0 THEN
        -- Valido si existe la cuenta de usuario existente.
        SELECT COUNT(*) INTO max_user_id FROM HR.tbl_users t1
         WHERE (t1.credential_id = p_credential_id)
           AND (t1.flag_state = 'ACTIVE');

        IF max_user_id > 0 THEN
            -- Reactivo los parámetros.
            UPDATE tbl_users_parameters t1
               SET t1.updated_at = CURRENT_TIMESTAMP(),
                   t1.user_update_date = p_user_update_date,
                   t1.flag_state = 'ACTIVE'
             WHERE (t1.credential_id = p_credential_id)
               AND (t1.flag_state = 'LOCKED' OR t1.flag_state = 'DELETED');
        ELSE
            SIGNAL SQLSTATE '45027' SET MESSAGE_TEXT = 'Credential Id not exists.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45028' SET MESSAGE_TEXT = 'Parameters for credential id not exists';
    END IF;
END;

COMMIT;

-- Mostrar los parámetros de una cuenta de usuario existente.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_parameter_user`(IN `p_credential_id`            CHAR(36))
BEGIN
    SELECT t1.parameter_credential_id AS Id,
           t1.credential_id AS CredentialId,
           t2.user_full_name AS UserFullName,
           t1.parameter_id AS ParameterId,
           t3.group_name AS GroupName,
           t3.sub_group_name AS SubGroupName,
           t3.parameter_key AS ParameterKey,
           t3.value_parameter AS ValueParameter,
           t3.value_type AS ValueType,
           t3.parameter_description AS ParameterDescription,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.tbl_users_parameters t1
      JOIN HR.tbl_users t2 ON (t1.credential_id = t2.credential_id)
      JOIN HR.tbl_parameters t3 ON (t1.parameter_id = t3.parameter_id)
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');
END;

COMMIT;

-- Agregar politicas a los usuarios.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_add_policy_to_user`(IN `p_credential_id`      CHAR(36),
                                                              IN `p_detail_policy_json` TEXT,
                                                              IN `p_user_add_date`      VARCHAR(255))
BEGIN
    DECLARE v_index INT DEFAULT 0;
    DECLARE v_length INT DEFAULT 0;
    DECLARE v_id_policy INT;
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE max_previous_policies INTEGER DEFAULT 0;

    IF JSON_LENGTH(p_detail_policy_json) = 0 THEN
        SIGNAL SQLSTATE '45029' SET MESSAGE_TEXT = 'Policies list not found or is empty.';
    END IF;

    SELECT COUNT(*) INTO max_previous_policies FROM HR.tbl_users_module_policy t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');

    IF max_previous_policies > 0 THEN
        SIGNAL SQLSTATE '45030' SET MESSAGE_TEXT = 'Policies for credential id already exists';
    END IF;

    SELECT COUNT(*) INTO max_user_id FROM HR.tbl_users t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');

    IF max_user_id > 0 THEN
        SET v_length = JSON_LENGTH(p_detail_policy_json);

        WHILE v_index < v_length DO
            SET v_id_policy = JSON_UNQUOTE(JSON_EXTRACT(p_detail_policy_json, CONCAT('$[', v_index, '].idPolicy')));

            IF v_id_policy IS NULL THEN
                SIGNAL SQLSTATE '45031' SET MESSAGE_TEXT = 'Missing value in idPolicy field from current index.';
            END IF;

            INSERT INTO HR.tbl_users_module_policy (credential_id, module_policy_id, user_add_date)
            VALUES (p_credential_id, v_id_policy, p_user_add_date);

            SET v_index = v_index + 1;
        END WHILE;
    ELSE
        SIGNAL SQLSTATE '45032' SET MESSAGE_TEXT = 'Credential Id not exists.';
    END IF;
END;

COMMIT;

-- Actualizar politicas a cuentas de usuario existentes.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_update_policy_to_user`(IN `p_credential_id`          CHAR(36),
                                                                 IN `p_detail_policy_json`     TEXT,
                                                                 IN `p_user_add_date`          VARCHAR(255))
BEGIN
    DECLARE v_index INT DEFAULT 0;
    DECLARE v_length INT DEFAULT 0;
    DECLARE v_id_policy INT;
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE max_previous_policies INTEGER DEFAULT 0;

    IF JSON_LENGTH(p_detail_policy_json) = 0 THEN
        SIGNAL SQLSTATE '45019' SET MESSAGE_TEXT = 'Parameters list not found or is empty.';
    END IF;

    SELECT COUNT(*) INTO max_previous_policies FROM HR.tbl_users_module_policy t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');

    IF max_previous_policies > 0 THEN
        -- Valido si existe la cuenta de usuario existente.
        SELECT COUNT(*) INTO max_user_id FROM HR.tbl_users t1
         WHERE (t1.credential_id = p_credential_id)
           AND (t1.flag_state = 'ACTIVE');

        IF max_user_id > 0 THEN
            -- Elimino las politicas existentes.
            DELETE FROM tbl_users_module_policy
             WHERE (credential_id = p_credential_id)
               AND (flag_state = 'ACTIVE');

            -- Inserto las nuevas políticas.
            SET v_length = JSON_LENGTH(p_detail_policy_json);

            WHILE v_index < v_length DO
                SET v_id_policy = JSON_UNQUOTE(JSON_EXTRACT(p_detail_policy_json, CONCAT('$[', v_index, '].idPolicy')));

                IF v_id_policy IS NULL THEN
                    SIGNAL SQLSTATE '45020' SET MESSAGE_TEXT = 'Missing value in idPolicy field from current index.';
                END IF;

                INSERT INTO HR.tbl_users_module_policy (credential_id, module_policy_id, user_add_date)
                VALUES (p_credential_id, v_id_policy, p_user_add_date);

                SET v_index = v_index + 1;
            END WHILE;
        ELSE
            SIGNAL SQLSTATE '45021' SET MESSAGE_TEXT = 'Credential Id not exists.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45022' SET MESSAGE_TEXT = 'Policies for credential id not exists';
    END IF;
END;

COMMIT;

-- Inhabilitar todos las politicas a una cuenta de usuario existente.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_lock_all_policies_to_user`(IN `p_credential_id`          CHAR(36),
                                                                     IN `p_user_update_date`       VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE max_previous_policies INTEGER DEFAULT 0;

    SELECT COUNT(*) INTO max_previous_policies FROM HR.tbl_users_module_policy t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');

    IF max_previous_policies > 0 THEN
        -- Valido si existe la cuenta de usuario existente.
        SELECT COUNT(*) INTO max_user_id FROM HR.tbl_users t1
         WHERE (t1.credential_id = p_credential_id)
           AND (t1.flag_state = 'ACTIVE');

        IF max_user_id > 0 THEN
            -- Bloqueo los politicas.
            UPDATE tbl_users_module_policy t1
               SET t1.updated_at = CURRENT_TIMESTAMP(),
                   t1.user_update_date = p_user_update_date,
                   t1.flag_state = 'LOCKED'
             WHERE (t1.credential_id = p_credential_id)
               AND (t1.flag_state = 'ACTIVE');
        ELSE
            SIGNAL SQLSTATE '45023' SET MESSAGE_TEXT = 'Credential Id not exists.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45024' SET MESSAGE_TEXT = 'Policies for credential id not exists';
    END IF;
END;

COMMIT;

-- Bloquear todos las politicas a una cuenta de usuario existente.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_disable_all_policies_to_user`(IN `p_credential_id`          CHAR(36),
                                                                        IN `p_user_update_date`       VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE max_previous_policies INTEGER DEFAULT 0;

    SELECT COUNT(*) INTO max_previous_policies FROM HR.tbl_users_module_policy t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');

    IF max_previous_policies > 0 THEN
        -- Valido si existe la cuenta de usuario existente.
        SELECT COUNT(*) INTO max_user_id FROM HR.tbl_users t1
         WHERE (t1.credential_id = p_credential_id)
           AND (t1.flag_state = 'ACTIVE');

        IF max_user_id > 0 THEN
            -- Bloqueo los politicas.
            UPDATE tbl_users_module_policy t1
               SET t1.updated_at = CURRENT_TIMESTAMP(),
                   t1.user_update_date = p_user_update_date,
                   t1.flag_state = 'DELETED'
             WHERE (t1.credential_id = p_credential_id)
               AND (t1.flag_state = 'ACTIVE');
        ELSE
            SIGNAL SQLSTATE '45025' SET MESSAGE_TEXT = 'Credential Id not exists.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45026' SET MESSAGE_TEXT = 'Policies for credential id not exists';
    END IF;
END;

COMMIT;

-- Rehabilitar todos las politicas a una cuenta de usuario existente.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_enable_all_policy_to_user`(IN `p_credential_id`          CHAR(36),
                                                                     IN `p_user_update_date`       VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE max_previous_policies INTEGER DEFAULT 0;

    SELECT COUNT(*) INTO max_previous_policies FROM HR.tbl_users_module_policy t1
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'LOCKED' OR t1.flag_state = 'DELETED');

    IF max_previous_policies > 0 THEN
        -- Valido si existe la cuenta de usuario existente.
        SELECT COUNT(*) INTO max_user_id FROM HR.tbl_users t1
         WHERE (t1.credential_id = p_credential_id)
           AND (t1.flag_state = 'ACTIVE');

        IF max_user_id > 0 THEN
            -- Reactivo las politicas.
            UPDATE tbl_users_module_policy t1
               SET t1.updated_at = CURRENT_TIMESTAMP(),
                   t1.user_update_date = p_user_update_date,
                   t1.flag_state = 'ACTIVE'
             WHERE (t1.credential_id = p_credential_id)
               AND (t1.flag_state = 'LOCKED' OR t1.flag_state = 'DELETED');
        ELSE
            SIGNAL SQLSTATE '45027' SET MESSAGE_TEXT = 'Credential Id not exists.';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45028' SET MESSAGE_TEXT = 'Policies for credential id already exists';
    END IF;
END;

COMMIT;

-- Mostrar los parámetros de una cuenta de usuario existente.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_policy_user`(IN `p_credential_id`            CHAR(36))
BEGIN
    SELECT t1.policy_credential_id AS Id,
           t1.credential_id AS CredentialId,
           t2.user_full_name AS UserFullName,
           t1.module_policy_id As ModulePolicyId,
           t3.module_id AS ModuleId,
           t4.module_name AS ModuleName,
           t4.module_description AS ModuleDescription,
           t4.module_path AS ModulePath,
           t4.module_version_api AS ModuleVersionApi,
           t3.policy_id AS PolicyId,
           t5.policy_name As PolicyName,
           t5.policy_description As PolicyDescription,
           t3.is_system_policy As IsSystemPolicy,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.tbl_users_module_policy t1
      JOIN HR.tbl_users t2 ON (t1.credential_id = t2.credential_id)
      JOIN HR.tbl_module_policy t3 ON (t1.module_policy_id = t3.module_policy_id)
      JOIN HR.tbl_modules t4 ON (t3.module_id = t4.module_id)
      JOIN HR.tbl_policies t5 ON (t3.policy_id = t5.policy_id)
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');
END;

COMMIT;

-- Procedimiento para mostrar todos los módulos activos.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_all_modules`()
BEGIN
    SELECT t1.module_id AS Id,
           t1.module_name AS ModuleName,
           t1.module_description AS ModuleDescription,
           t1.module_path AS ModulePath,
           t1.module_version_api AS ModuleVersionApi,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.TBL_MODULES t1
     WHERE (t1.flag_state = 'ACTIVE');
END;

COMMIT;

-- Procedimiento para mostrar un modulo existente.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_existent_module`(IN `p_module_name`            VARCHAR(255))
BEGIN
    SELECT t1.module_id AS Id,
           t1.module_name AS ModuleName,
           t1.module_description AS ModuleDescription,
           t1.module_path AS ModulePath,
           t1.module_version_api AS ModuleVersionApi,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.TBL_MODULES t1
     WHERE (t1.module_name = p_module_name)
       AND (t1.flag_state = 'ACTIVE');
END;

COMMIT;

-- Procedimiento para insertar un módulo
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_add_new_module`(IN `p_module_name`        VARCHAR(255),
                                                          IN `p_module_description` VARCHAR(255),
                                                          IN `p_module_path`        VARCHAR(512),
                                                          IN `p_module_version_api` VARCHAR(30),
                                                          IN `p_user_add_date`      VARCHAR(255))
BEGIN
    DECLARE exist_module BOOLEAN;

    SELECT EXISTS( SELECT 1 FROM HR.TBL_MODULES t1
                    WHERE (t1.module_name = p_module_name)
                      AND (t1.flag_state = 'ACTIVE') ) INTO exist_module;
    -- Validación: Verificar que el nombre del módulo no exista
    IF exist_module THEN
        SIGNAL SQLSTATE '45029' SET MESSAGE_TEXT = 'El nombre del módulo ya existe.';
    ELSE
        INSERT INTO HR.TBL_MODULES (module_name, module_description, module_path, module_version_api, user_add_date)
        VALUES (p_module_name, p_module_description, p_module_path, p_module_version_api, p_user_add_date);
    END IF;
END;

-- Procedimiento para actualizar un módulo
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_update_existent_module`(IN `p_module_id`          INT,
                                                                  IN `p_module_name`        VARCHAR(255),
                                                                  IN `p_module_description` VARCHAR(255),
                                                                  IN `p_module_path`        VARCHAR(512),
                                                                  IN `p_module_version_api` VARCHAR(30),
                                                                  IN `p_user_update_date`   VARCHAR(255))
BEGIN
    DECLARE exist_module BOOLEAN;

    SELECT EXISTS( SELECT 1 FROM HR.TBL_MODULES t1
                    WHERE (t1.module_name = p_module_name)
                      AND (t1.flag_state = 'ACTIVE') ) INTO exist_module;

    -- Validación: Verificar que el módulo exista
    IF NOT exist_module THEN
        SIGNAL SQLSTATE '45030' SET MESSAGE_TEXT = 'El módulo no existe.';
    ELSE
        UPDATE HR.TBL_MODULES t1
           SET t1.module_name = p_module_name,
               t1.module_description = p_module_description,
               t1.module_path = p_module_path,
               t1.module_version_api = p_module_version_api,
               t1.user_update_date = p_user_update_date,
               t1.updated_at = CURRENT_TIMESTAMP
         WHERE (t1.module_id = p_module_id)
           AND (t1.flag_state = 'ACTIVE');
    END IF;
END;

COMMIT;

-- Procedimiento para eliminar un módulo (baja lógica)
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_delete_existent_module`(IN `p_module_id`        INT,
                                                                  IN `p_user_delete_date` VARCHAR(255))
BEGIN
    DECLARE exist_module BOOLEAN;

    SELECT EXISTS( SELECT 1 FROM HR.TBL_MODULES t1
                    WHERE (t1.module_name = p_module_name)
                      AND (t1.flag_state = 'ACTIVE') ) INTO exist_module;

    -- Validación: Verificar que el módulo exista
    IF NOT exist_module THEN
        SIGNAL SQLSTATE '45031' SET MESSAGE_TEXT = 'El módulo no existe.';
    ELSE
        UPDATE HR.TBL_MODULES t1
           SET t1.flag_state = 'DELETED',
               t1.user_delete_date = p_user_delete_date,
               t1.deleted_at = CURRENT_TIMESTAMP
         WHERE (t1.module_id = p_module_id)
           AND (t1.flag_state = 'ACTIVE');
    END IF;
END;

COMMIT;

-- Procedimiento para mostrar todas las politicas activas.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_all_policies`()
BEGIN
    SELECT t1.policy_id AS Id,
           t1.policy_name AS PolicyName,
           t1.policy_description AS PolicyDescription,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.TBL_POLICIES t1
     WHERE (t1.flag_state = 'ACTIVE');
END;

COMMIT;

-- Procedimiento para mostrar una politica existente.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_existent_policy`(IN `p_policy_name`            VARCHAR(255))
BEGIN
    SELECT t1.policy_id AS Id,
           t1.policy_name AS PolicyName,
           t1.policy_description AS PolicyDescription,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.TBL_POLICIES t1
     WHERE (t1.policy_name = p_policy_name)
       AND (t1.flag_state = 'ACTIVE');
END;

-- Procedimiento para insertar una política
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_add_new_policy`(IN `p_policy_name`        VARCHAR(255),
                                                          IN `p_policy_description` VARCHAR(255),
                                                          IN `p_user_add_date`      VARCHAR(255))
BEGIN
    DECLARE exist_policy BOOLEAN;

    SELECT EXISTS( SELECT 1 FROM HR.TBL_POLICIES t1
                    WHERE (t1.policy_name = p_policy_name)
                      AND (t1.flag_state = 'ACTIVE') ) INTO exist_policy;

    -- Validación: Verificar que el nombre de la política no exista
    IF exist_policy THEN
        SIGNAL SQLSTATE '45032' SET MESSAGE_TEXT = 'El nombre de la política ya existe.';
    ELSE
        INSERT INTO HR.TBL_POLICIES (policy_name, policy_description, user_add_date)
        VALUES (p_policy_name, p_policy_description, p_user_add_date);
    END IF;
END;

COMMIT;

-- Procedimiento para actualizar una política
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_update_existent_policy`(IN `p_policy_id`          INT,
                                                                  IN `p_policy_name`        VARCHAR(255),
                                                                  IN `p_policy_description` VARCHAR(255),
                                                                  IN `p_user_update_date`   VARCHAR(255))
BEGIN
    DECLARE exist_policy BOOLEAN;

    SELECT EXISTS( SELECT 1 FROM HR.TBL_POLICIES t1
                    WHERE (t1.policy_name = p_policy_name)
                      AND (t1.flag_state = 'ACTIVE') ) INTO exist_policy;

    -- Validación: Verificar que la política exista
    IF NOT exist_policy THEN
        SIGNAL SQLSTATE '45033' SET MESSAGE_TEXT = 'La política no existe.';
    ELSE
        UPDATE HR.TBL_POLICIES t1
           SET t1.policy_name = p_policy_name,
               t1.policy_description = p_policy_description,
               t1.user_update_date = p_user_update_date,
               t1.updated_at = CURRENT_TIMESTAMP
         WHERE (t1.policy_id = p_policy_id)
           AND (t1.flag_state = 'ACTIVE');
    END IF;
END;

COMMIT;

-- Procedimiento para eliminar una política (baja lógica)
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_delete_existent_policy`(IN `p_policy_id`        INT,
                                                                  IN `p_user_delete_date` VARCHAR(255))
BEGIN
    DECLARE exist_policy BOOLEAN;

    SELECT EXISTS( SELECT 1 FROM HR.TBL_POLICIES t1
                    WHERE (t1.policy_name = p_policy_name)
                      AND (t1.flag_state = 'ACTIVE') ) INTO exist_policy;

    -- Validación: Verificar que la política exista
    IF NOT exist_policy THEN
        SIGNAL SQLSTATE '45034' SET MESSAGE_TEXT = 'La política no existe.';
    ELSE
        UPDATE HR.TBL_POLICIES t1
           SET t1.flag_state = 'DELETED',
               t1.user_delete_date = p_user_delete_date,
               t1.deleted_at = CURRENT_TIMESTAMP
         WHERE (t1.policy_id = p_policy_id)
           AND (t1.flag_state = 'ACTIVE');
    END IF;
END;

COMMIT;

-- Procedimiento para insertar una relación módulo-política
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_add_new_module_policy`(IN `p_module_id`        INT,
                                                                 IN `p_policy_id`        INT,
                                                                 IN `p_is_system_policy` BIT,
                                                                 IN `p_user_add_date`    VARCHAR(255))
BEGIN
    -- Validación: Verificar que el módulo y la política existan
    IF NOT EXISTS (SELECT 1 FROM HR.TBL_MODULES WHERE module_id = p_module_id AND flag_state = 'ACTIVE') THEN
        SIGNAL SQLSTATE '45035' SET MESSAGE_TEXT = 'El módulo no existe o no está activo.';
    ELSEIF NOT EXISTS (SELECT 1 FROM HR.TBL_POLICIES WHERE policy_id = p_policy_id AND flag_state = 'ACTIVE') THEN
        SIGNAL SQLSTATE '45036' SET MESSAGE_TEXT = 'La política no existe o no está activa.';
    ELSE
        INSERT INTO HR.TBL_MODULE_POLICY (module_id, policy_id, is_system_policy, user_add_date)
        VALUES (p_module_id, p_policy_id, p_is_system_policy, p_user_add_date);
    END IF;
END;

COMMIT;

-- Procedimiento para eliminar una relación módulo-política (baja lógica)
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_delete_module_policy`(IN `p_module_policy_id` INT,
                                                                IN `p_user_delete_date` VARCHAR(255))
BEGIN
    -- Validación: Verificar que la relación exista
    IF NOT EXISTS (SELECT 1 FROM HR.TBL_MODULE_POLICY WHERE module_policy_id = p_module_policy_id AND flag_state != 'DELETED') THEN
        SIGNAL SQLSTATE '45037' SET MESSAGE_TEXT = 'La relación módulo-política no existe.';
    ELSE
        UPDATE HR.TBL_MODULE_POLICY t1
           SET t1.flag_state = 'DELETED',
               t1.user_delete_date = p_user_delete_date,
               t1.deleted_at = CURRENT_TIMESTAMP
         WHERE (t1.module_policy_id = p_module_policy_id)
           AND (t1.flag_state = 'ACTIVE');
    END IF;
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_all_module_policies`()
BEGIN
    SELECT t1.module_policy_id AS Id,
           t1.module_id AS ModuleId,
           t2.module_name AS ModuleName,
           t2.module_description AS ModuleDescription,
           t2.module_path AS ModulePath,
           t2.module_version_api AS ModuleVersionApi,
           t1.policy_id AS PolicyId,
           t3.policy_name AS PolicyName,
           t3.policy_description AS PolicyDescription,
           t1.is_system_policy AS IsSystemPolicy,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.tbl_module_policy t1
      JOIN HR.tbl_modules t2 ON (t1.module_id = t2.module_id)
      JOIN HR.tbl_policies t3 ON (t1.policy_id = t3.policy_id)
     WHERE (t1.flag_state = 'ACTIVE');
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_module_policies`(IN `p_module_policy_id` INT)
BEGIN
    SELECT t1.module_policy_id AS Id,
           t1.module_id AS ModuleId,
           t2.module_name AS ModuleName,
           t2.module_description AS ModuleDescription,
           t2.module_path AS ModulePath,
           t2.module_version_api AS ModuleVersionApi,
           t1.policy_id AS PolicyId,
           t3.policy_name AS PolicyName,
           t3.policy_description AS PolicyDescription,
           t1.is_system_policy AS IsSystemPolicy,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.tbl_module_policy t1
      JOIN HR.tbl_modules t2 ON (t1.module_id = t2.module_id)
      JOIN HR.tbl_policies t3 ON (t1.policy_id = t3.policy_id)
     WHERE (t1.module_policy_id = p_module_policy_id)
       AND (t1.flag_state = 'ACTIVE');
END;

COMMIT;

-- Agregar nueva politica a usuario.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_add_user_module_policy`(IN `p_credential_id`    CHAR(36),
                                                                  IN `p_module_policy_id` INT,
                                                                  IN `p_user_add_date`    VARCHAR(255))
BEGIN
    DECLARE exist_user_policy BOOLEAN;

    SELECT EXISTS( SELECT 1 FROM HR.TBL_USERS_MODULE_POLICY t1
                    WHERE (t1.credential_id = p_credential_id)
                      AND (t1.module_policy_id = p_module_policy_id)
                      AND (t1.flag_state = 'ACTIVE') ) INTO exist_user_policy;

    IF exist_user_policy THEN
        SIGNAL SQLSTATE '45038' SET MESSAGE_TEXT = 'Ya existe una politica asignada al usuario existente.';
    ELSE
        INSERT INTO HR.TBL_USERS_MODULE_POLICY (credential_id, module_policy_id, user_add_date)
        VALUES (p_credential_id, p_module_policy_id, p_user_add_date);
    END IF;
END;

COMMIT;

-- Elimina una politica de usuario existente.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_delete_user_module_policy`(IN `p_credential_id`    CHAR(36),
                                                                     IN `p_module_policy_id` INT,
                                                                     IN `p_user_delete_date` VARCHAR(255))
BEGIN
    DECLARE exist_user_policy BOOLEAN;

    SELECT EXISTS( SELECT 1 FROM HR.TBL_USERS_MODULE_POLICY t1
                    WHERE (t1.credential_id = p_credential_id)
                      AND (t1.module_policy_id = p_module_policy_id)
                      AND (t1.flag_state = 'ACTIVE') ) INTO exist_user_policy;

    IF NOT exist_user_policy THEN
        SIGNAL SQLSTATE '45039' SET MESSAGE_TEXT = 'La política asignada al usuario existente no existe.';
    ELSE
        UPDATE HR.TBL_USERS_MODULE_POLICY t1
           SET t1.flag_state = 'DELETED',
               t1.deleted_at = CURRENT_TIMESTAMP,
               t1.user_delete_date = p_user_delete_date
         WHERE (t1.credential_id = p_credential_id)
           AND (t1.module_policy_id = p_module_policy_id)
           AND (t1.flag_state = 'ACTIVE');
    END IF;
END;

COMMIT;

-- Mostrar todas las politicas asignadas a todos los usuarios activos.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_all_user_module_policies`()
BEGIN
    SELECT t1.policy_credential_id AS Id,
           t1.credential_id AS CredentialId,
           t5.user_full_name AS FullName,
           t1.module_policy_id AS ModulePolicyId,
           t2.module_id AS ModuleId,
           t3.module_name AS ModuleName,
           t2.policy_id AS PolicyId,
           t4.policy_name AS PolicyName,
           t2.is_system_policy AS IsSystemPolicy,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.tbl_users_module_policy t1
      JOIN HR.tbl_module_policy t2 ON (t1.module_policy_id = t2.module_policy_id)
      JOIN HR.tbl_modules t3 ON (t2.module_id = t3.module_id)
      JOIN HR.tbl_policies t4 ON (t2.policy_id = t4.policy_id)
      JOIN HR.tbl_users t5 ON (t1.credential_id = t5.credential_id)
     WHERE (t1.flag_state = 'ACTIVE');
END;

COMMIT;

-- Mostrar todas las políticas asignadas a un usuario activo.
CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_user_module_policies`(IN `p_credential_id`    CHAR(36))
BEGIN
    SELECT t1.policy_credential_id AS Id,
           t1.credential_id AS CredentialId,
           t5.user_full_name AS FullName,
           t1.module_policy_id AS ModulePolicyId,
           t2.module_id AS ModuleId,
           t3.module_name AS ModuleName,
           t2.policy_id AS PolicyId,
           t4.policy_name AS PolicyName,
           t2.is_system_policy AS IsSystemPolicy,
           t1.flag_state AS FlagState,
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.tbl_users_module_policy t1
      JOIN HR.tbl_module_policy t2 ON (t1.module_policy_id = t2.module_policy_id)
      JOIN HR.tbl_modules t3 ON (t2.module_id = t3.module_id)
      JOIN HR.tbl_policies t4 ON (t2.policy_id = t4.policy_id)
      JOIN HR.tbl_users t5 ON (t1.credential_id = t5.credential_id)
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');
END;

COMMIT;

-- Fin del script.