DELIMITER $$

-- ===================================== INSERT =====================================

CREATE PROCEDURE insertBlackList(
    IN pIdUser INT
)
BEGIN
    INSERT INTO black_list (id_user)
    VALUES (pIdUser);

    COMMIT;
END$$


CREATE PROCEDURE insertUserXBlackList(
    IN pReason VARCHAR(255),
    IN pIdUser INT,
    IN pIdReport INT
)
BEGIN
    INSERT INTO user_x_black_list (reason, id_user, id_report)
    VALUES (pReason, pIdUser, pIdReport);

    COMMIT;
END$$


-- ===================================== UPDATE =====================================

CREATE PROCEDURE updateUserXBlackList(
    IN pReason VARCHAR(255),
    IN pIdUser INT,
    IN pIdReport INT
)
BEGIN
    UPDATE user_x_black_list
    SET reason = COALESCE(pReason, reason)
    WHERE id_user = pIdUser
      AND id_report = pIdReport;

    COMMIT;
END$$


-- ====================================== GET =======================================

CREATE PROCEDURE getBlackList()
BEGIN
    SELECT *
    FROM black_list;
END$$


CREATE FUNCTION getBlackListId(
    pIdUser INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_id INT DEFAULT -1;

    SELECT id_report
    INTO v_id
    FROM black_list
    WHERE id_user = pIdUser
    LIMIT 1;

    RETURN IFNULL(v_id, -1);
END$$


CREATE PROCEDURE getUserXBlackList()
BEGIN
    SELECT *
    FROM user_x_black_list;
END$$


CREATE PROCEDURE getUsersFromBlackList(
    IN pIdUser INT
)
BEGIN
    SELECT
        u.id_user,
        u.email,
        COALESCE(a.first_name, r.first_name) AS name,
        uxbl.reason
    FROM black_list bl
    INNER JOIN 'user' u
        ON uxbl.id_user = u.id_user
    INNER JOIN user_x_black_list uxbl
        ON bl.id_report = uxbl.id_report
    LEFT JOIN adopter a
        ON u.id_user = a.id_user
    LEFT JOIN rescuer r
        ON u.id_user = r.id_user
    WHERE bl.id_user = pIdUser;
END$$


-- ===================================== DELETE =====================================

CREATE PROCEDURE deleteUserFromBlackList(
    IN pIdReport INT,
    IN pIdUser INT
)
BEGIN
    DELETE FROM user_x_black_list
    WHERE id_report = pIdReport
      AND id_user = pIdUser;

    COMMIT;
END$$

DELIMITER ;