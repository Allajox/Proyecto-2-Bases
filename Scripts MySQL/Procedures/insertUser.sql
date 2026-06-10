DELIMITER $$

CREATE FUNCTION insertUser(
    pEmail VARCHAR(255),
    pPassword VARCHAR(255)
)
RETURNS INT
MODIFIES SQL DATA
BEGIN

    INSERT INTO `user` (
        email,
        `password`
    )
    VALUES (
        pEmail,
        pPassword
    );

    RETURN LAST_INSERT_ID();

END$$

DELIMITER ;