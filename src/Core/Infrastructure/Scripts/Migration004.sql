 -- Store Procedures.
USE HR;

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
        UPDATE HR.TBL_USERS SET user_add_date = credential_id WHERE (user_name = p_user_name);
    ELSE
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = "A user account with a reference user name already exists";
    END IF;
END;

COMMIT;

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
END;

COMMIT;

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
END;

COMMIT;

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
END;

COMMIT;

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
END;

COMMIT;

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
END;

COMMIT;

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
END;

COMMIT;

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
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_refreshtoken`(IN `p_user_name`           VARCHAR(15),
                                                            IN `p_id_token`            VARCHAR(36))
BEGIN
    SELECT t1.token_value AS Token
      FROM HR.TBL_USER_TOKENS t1
      JOIN HR.TBL_USERS t2 ON (t1.credential_id = t2.credential_id)
     WHERE (t1.id_token = p_id_token)
       AND (t2.user_name = p_user_name)
       AND (t2.flag_state = 'ACTIVE');
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_is_expired_token`(IN `p_id_token`            VARCHAR(36))
BEGIN
    SELECT (CURRENT_TIMESTAMP() > t1.expiration_date) AS StatusExpiration
      FROM HR.TBL_USER_TOKEN t1
     WHERE (t1.id_token = p_id_token);
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_save_new_token`(IN `p_user_name`           VARCHAR(15),
                                                          IN `p_ip_address`          VARCHAR(100),
                                                          IN `p_new_refresh`         VARCHAR(255),
                                                          IN `p_user_date`           VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    DECLARE time_expiration VARCHAR(255) DEFAULT '';
    DECLARE current_credential_id CHAR(36);
    SELECT COUNT(*) INTO max_user_id FROM HR.TBL_USERS WHERE (user_name = p_user_name);
    SELECT t1.value_parameter INTO time_expiration FROM HR.TBL_PARAMETERS t1 WHERE (t1.group_name = 'CONFIGURATION') AND (t1.sub_group_name = 'JwtSettings') AND (t1.parameter_key = 'CFG_EXPIRATION_TOKEN_MINUTES');

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
END;

COMMIT;

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
    SELECT t1.value_parameter INTO time_expiration FROM HR.TBL_PARAMETERS WHERE (t1.group_name = 'CONFIGURATION') AND (t1.sub_group_name = 'JwtSettings') AND (parameter_key = 'CFG_EXPIRATION_TOKEN_MINUTES');

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
END;

COMMIT;

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
END;

COMMIT;