-- Store procedures for configuration table.
USE HR;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_all_configuration`()
BEGIN
    SELECT t1.parameter_id AS Id,
           t1.group_name AS GroupName,
           t1.sub_group_name AS SubGroupName,
           t1.parameter_key AS KeyName,
           t1.value_parameter AS KeyValue,
           t1.value_type AS ValueType,
           t1.parameter_description AS KeyDescription,
           t1.flag_state AS FlagState,           
           t1.added_at AS CreateDate,
           t1.user_add_date AS CreateUser,
           t1.updated_at AS UpdateDate,
           t1.user_update_date AS UpdateUser,
           t1.deleted_at AS DeleteDate,
           t1.user_delete_date AS DeleteUser
      FROM HR.tbl_parameters t1
     WHERE (t1.flag_state = 'ACTIVE');
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_configuration`(IN `p_group_name`       VARCHAR  (255),
                                                             IN `p_sub_group_name`   VARCHAR  (255),
                                                             IN `p_key_name`         VARCHAR  (100))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO max_user_id FROM HR.tbl_parameters t1 
     WHERE (t1.group_name = p_group_name)
       AND (t1.sub_group_name = p_sub_group_name)
       AND (t1.parameter_key = p_key_name)
       AND (t1.flag_state = 'ACTIVE');
    
    IF (max_user_id > 0) THEN
        SELECT t1.parameter_id AS Id,
               t1.group_name AS GroupName,
               t1.sub_group_name AS SubGroupName,
               t1.parameter_key AS KeyName,
               t1.value_parameter AS KeyValue,
               t1.value_type AS ValueType,
               t1.parameter_description AS KeyDescription,
               t1.flag_state AS FlagState,           
               t1.added_at AS CreateDate,
               t1.user_add_date AS CreateUser,
               t1.updated_at AS UpdateDate,
               t1.user_update_date AS UpdateUser,
               t1.deleted_at AS DeleteDate,
               t1.user_delete_date AS DeleteUser
          FROM HR.tbl_parameters t1
         WHERE (t1.flag_state = 'ACTIVE')
           AND (t1.group_name = p_group_name)
           AND (t1.sub_group_name = p_sub_group_name)
           AND (t1.parameter_key = p_key_name);
    ELSE
        SIGNAL SQLSTATE '45007' SET MESSAGE_TEXT = "A configuration with a reference value name not exists";
    END IF;
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_configuration_by_group`(IN `p_group_name`       VARCHAR  (255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO max_user_id FROM HR.tbl_parameters t1 
     WHERE (t1.group_name = p_group_name)
       AND (t1.flag_state = 'ACTIVE');
    
    IF (max_user_id > 0) THEN
        SELECT t1.parameter_id AS Id,
               t1.group_name AS GroupName,
               t1.sub_group_name AS SubGroupName,
               t1.parameter_key AS KeyName,
               t1.value_parameter AS KeyValue,
               t1.value_type AS ValueType,
               t1.parameter_description AS KeyDescription,
               t1.flag_state AS FlagState,           
               t1.added_at AS CreateDate,
               t1.user_add_date AS CreateUser,
               t1.updated_at AS UpdateDate,
               t1.user_update_date AS UpdateUser,
               t1.deleted_at AS DeleteDate,
               t1.user_delete_date AS DeleteUser
          FROM HR.tbl_parameters t1
         WHERE (t1.flag_state = 'ACTIVE')
           AND (t1.group_name = p_group_name);
    ELSE
        SIGNAL SQLSTATE '45008' SET MESSAGE_TEXT = "A configuration with a reference group name not exists";
    END IF;
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_get_configuration_by_subgroup`(IN `p_group_name`       VARCHAR  (255),
                                                                         IN `p_sub_group_name`   VARCHAR  (255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO max_user_id FROM HR.tbl_parameters t1 
      WHERE (t1.group_name = p_group_name)
        AND (t1.sub_group_name = p_sub_group_name)
        AND (t1.flag_state = 'ACTIVE');
    
    IF (max_user_id > 0) THEN
        SELECT t1.parameter_id AS Id,
               t1.group_name AS GroupName,
               t1.sub_group_name AS SubGroupName,
               t1.parameter_key AS KeyName,
               t1.value_parameter AS KeyValue,
               t1.value_type AS ValueType,
               t1.parameter_description AS KeyDescription,
               t1.flag_state AS FlagState,           
               t1.added_at AS CreateDate,
               t1.user_add_date AS CreateUser,
               t1.updated_at AS UpdateDate,
               t1.user_update_date AS UpdateUser,
               t1.deleted_at AS DeleteDate,
               t1.user_delete_date AS DeleteUser
          FROM HR.tbl_parameters t1
         WHERE (t1.flag_state = 'ACTIVE')
           AND (t1.group_name = p_group_name)
           AND (t1.sub_group_name = p_sub_group_name);
    ELSE
        SIGNAL SQLSTATE '45009' SET MESSAGE_TEXT = "A configuration with a reference subgroup name not exists";
    END IF;
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_save_configuration`(IN `p_group_name`       VARCHAR  (255),
                                                              IN `p_sub_group_name`   VARCHAR  (255),
                                                              IN `p_key_name`         VARCHAR  (100),
                                                              IN `p_key_value`        TEXT,
                                                              IN `p_type_value`       VARCHAR  (20),
                                                              IN `p_description`      VARCHAR  (100),
                                                              IN `p_user_add_date`    VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO max_user_id FROM HR.tbl_parameters t1 
     WHERE (t1.group_name = p_group_name)
       AND (t1.sub_group_name = p_sub_group_name)
       AND (t1.parameter_key = p_key_name)
       AND (t1.flag_state = 'ACTIVE');

    IF (max_user_id = 0) THEN
        INSERT INTO HR.tbl_parameters (group_name, sub_group_name, parameter_key, value_parameter, value_type, parameter_description, flag_state, user_add_date)
        VALUES (p_group_name, p_sub_group_name, p_key_name, p_key_value, p_type_value, p_description, 'ACTIVE', p_user_add_date);
    ELSE
        SIGNAL SQLSTATE '45010' SET MESSAGE_TEXT = "A configuration value already exists";
    END IF;
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_save_enable_configuration`(IN `p_group_name`       VARCHAR  (255),
                                                                     IN `p_sub_group_name`   VARCHAR  (255),
                                                                     IN `p_key_name`         VARCHAR  (100),
                                                                     IN `p_shutdown_value`   BIT,
                                                                     IN `p_user_update_date` VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO max_user_id FROM HR.tbl_parameters t1 
     WHERE (t1.group_name = p_group_name)
       AND (t1.sub_group_name = p_sub_group_name)
       AND (t1.parameter_key = p_key_name)
       AND (t1.flag_state = IF(p_shutdown_value = 0, 'LOCKED', 'ACTIVE'));

    IF (max_user_id > 0) THEN
        UPDATE HR.tbl_parameters t1
           SET t1.flag_state = IF(p_shutdown_value = 0, 'ACTIVE', 'LOCKED'),
               t1.updated_at = CURRENT_TIMESTAMP(),
               t1.user_update_date = p_user_update_date
         WHERE (t1.group_name = p_group_name)
           AND (t1.sub_group_name = p_sub_group_name)
           AND (t1.parameter_key = p_key_name)
           AND (t1.flag_state = IF(p_shutdown_value = 0, 'LOCKED', 'ACTIVE'));
    ELSE
        SIGNAL SQLSTATE '45011' SET MESSAGE_TEXT = "The setting value's power off or power on operation was not applied.";
    END IF;
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_save_enable_group`(IN `p_group_name`       VARCHAR  (255),
                                                             IN `p_shutdown_value`   BIT,
                                                             IN `p_user_update_date` VARCHAR(255))
BEGIN
   DECLARE max_user_id INTEGER DEFAULT 0;
   SELECT COUNT(*) INTO max_user_id FROM HR.tbl_parameters t1 
    WHERE (t1.group_name = p_group_name)
      AND (t1.flag_state = IF(p_shutdown_value = 0, 'LOCKED', 'ACTIVE'));

    IF (max_user_id > 0) THEN
        UPDATE HR.tbl_parameters t1
           SET t1.flag_state = IF(p_shutdown_value = 0, 'ACTIVE', 'LOCKED'),
               t1.updated_at = CURRENT_TIMESTAMP(),
               t1.user_update_date = p_user_update_date
         WHERE (t1.group_name = p_group_name)
           AND (t1.flag_state = IF(p_shutdown_value = 0, 'LOCKED', 'ACTIVE'));
    ELSE
        SIGNAL SQLSTATE '45012' SET MESSAGE_TEXT = "The setting value's power off or power on operation was not applied.";
    END IF;
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_save_enable_subgroup`(IN `p_group_name`       VARCHAR  (255),
                                                                IN `p_sub_group_name`   VARCHAR  (255),
                                                                IN `p_shutdown_value`   BIT,
                                                                IN `p_user_update_date` VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO max_user_id FROM HR.tbl_parameters t1 
     WHERE (t1.group_name = p_group_name)
       AND (t1.sub_group_name = p_sub_group_name)
       AND (t1.flag_state = IF(p_shutdown_value = 0, 'LOCKED', 'ACTIVE'));

    IF (max_user_id > 0) THEN
        UPDATE HR.tbl_parameters t1
           SET t1.flag_state = IF(p_shutdown_value = 0, 'ACTIVE', 'LOCKED'),
               t1.updated_at = CURRENT_TIMESTAMP(),
               t1.user_update_date = p_user_update_date
         WHERE (t1.group_name = p_group_name)
           AND (t1.sub_group_name = p_sub_group_name)
           AND (t1.flag_state = IF(p_shutdown_value = 0, 'LOCKED', 'ACTIVE'));
    ELSE
        SIGNAL SQLSTATE '45013' SET MESSAGE_TEXT = "The setting value's power off or power on operation was not applied.";
    END IF;
END;

COMMIT;

CREATE PROCEDURE IF NOT EXISTS `HR`.`proc_update_configuration`(IN `p_group_name`       VARCHAR  (255),
                                                                IN `p_sub_group_name`   VARCHAR  (255),
                                                                IN `p_key_name`         VARCHAR  (100),
                                                                IN `p_key_value`        TEXT,
                                                                IN `p_type_value`       VARCHAR  (20),
                                                                IN `p_description`      VARCHAR  (100),
                                                                IN `p_user_update_date` VARCHAR(255))
BEGIN
    DECLARE max_user_id INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO max_user_id FROM HR.tbl_parameters t1 
     WHERE (t1.group_name = p_group_name)
       AND (t1.sub_group_name = p_sub_group_name)
       AND (t1.parameter_key = p_key_name)
       AND (t1.flag_state = 'ACTIVE');

    IF (max_user_id > 0) THEN
        UPDATE HR.tbl_parameters t1
           SET t1.value_parameter = p_key_value,
               t1.parameter_description = p_description,
               t1.updated_at = CURRENT_TIMESTAMP(),
               t1.user_update_date = p_user_update_date
         WHERE (t1.group_name = p_group_name)
           AND (t1.sub_group_name = p_sub_group_name)
           AND (t1.flag_state = 'ACTIVE');
    ELSE
        SIGNAL SQLSTATE '45014' SET MESSAGE_TEXT = "The setting value's power off or power on operation was not applied.";
    END IF;
END;

COMMIT;