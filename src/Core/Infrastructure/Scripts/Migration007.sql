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
                                                                         IN `p_user_deleted_date`      VARCHAR(255))
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
                   t1.user_deleted_date = p_user_deleted_date,
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
    SELECT t1.parameter_credential_id,
           t1.credential_id,
           t2.user_full_name,
           t1.parameter_id,
           t3.group_name,
           t3.sub_group_name,
           t3.parameter_key,
           t3.value_parameter,
           t3.value_type,
           t3.parameter_description
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
                                                                 IN `p_detail_policy_json` TEXT,
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
    SELECT t1.policy_credential_id,
           t1.credential_id,
           t2.user_full_name,
           t1.module_policy_id,
           t3.module_id,
           t4.module_name,
           t4.module_description,
           t4.module_path,
           t4.module_version_api,
           t3.policy_id,
           t5.policy_name,
           t5.policy_description,
           t3.is_system_policy
      FROM HR.tbl_users_module_policy t1
      JOIN HR.tbl_users t2 ON (t1.credential_id = t2.credential_id)
      JOIN HR.tbl_module_policy t3 ON (t1.module_policy_id = t3.module_policy_id)
      JOIN HR.tbl_modules t4 ON (t3.module_id = t4.module_id)
      JOIN HR.tbl_policies t5 ON (t3.policy_id = t5.policy_id)
     WHERE (t1.credential_id = p_credential_id)
       AND (t1.flag_state = 'ACTIVE');
END;

COMMIT;

-- Fin del script.