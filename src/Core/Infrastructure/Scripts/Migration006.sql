USE HR;

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