DELIMITER $$

CREATE PROCEDURE insertUser(
    IN pEmail VARCHAR(255),
    IN pPassword VARCHAR(255)
)
BEGIN

    INSERT INTO user (email, password)
    VALUES ( pEmail, pPassword);
END$$


CREATE PROCEDURE insertAssociation(
    IN pIdUser INT,
    IN pName VARCHAR(255)
)
BEGIN
    INSERT INTO association (id_user, name)
    VALUES (pIdUser, pName);
END$$


CREATE PROCEDURE insertAdopter(
    IN pIdUser INT,
    IN pFirstName VARCHAR(255),
    IN pSecondName VARCHAR(255),
    IN pFirstSurname VARCHAR(255),
    IN pSecondSurname VARCHAR(255)
)
BEGIN
    INSERT INTO adopter (
        id_user,
        first_name,
        second_name,
        first_surname,
        second_surname
    )
    VALUES (
        pIdUser,
        pFirstName,
        pSecondName,
        pFirstSurname,
        pSecondSurname
    );
END$$


CREATE PROCEDURE insertRescuer(
    IN pIdUser INT,
    IN pFirstName VARCHAR(255),
    IN pSecondName VARCHAR(255),
    IN pFirstSurname VARCHAR(255),
    IN pSecondSurname VARCHAR(255)
)
BEGIN
    INSERT INTO rescuer (
        id_user,
        first_name,
        second_name,
        first_surname,
        second_surname
    )
    VALUES (
        pIdUser,
        pFirstName,
        pSecondName,
        pFirstSurname,
        pSecondSurname
    );
END$$


CREATE PROCEDURE insertCribHouse(
    IN pIdUser INT,
    IN pName VARCHAR(255),
    IN pRequiresDonations INT
)
BEGIN
    INSERT INTO crib_house (
        id_user,
        name,
        requires_donations
    )
    VALUES (
        pIdUser,
        pName,
        pRequiresDonations
    );
END$$


CREATE PROCEDURE insertLog(
    IN pIdLog INT,
    IN pChangeDate DATE,
    IN pChangeBy VARCHAR(255),
    IN pTableName VARCHAR(255),
    IN pFieldName VARCHAR(255),
    IN pPreviousValue VARCHAR(255),
    IN pCurrentValue VARCHAR(255)
)
BEGIN
    INSERT INTO log (
        id_log,
        changeDate,
        changeBy,
        tableName,
        fieldName,
        previousValue,
        currentValue
    )
    VALUES (
        NEXTVAL(s_log),
        pChangeDate,
        pChangeBy,
        pTableName,
        pFieldName,
        pPreviousValue,
        pCurrentValue
    );
END$$


CREATE PROCEDURE updateUser(
    IN pIdUser INT,
    IN pEmail VARCHAR(255),
    IN pPassword VARCHAR(255)
)
BEGIN
    UPDATE user
    SET email = pEmail,
        password = pPassword
    WHERE id_user = pIdUser;
END$$


CREATE PROCEDURE updateAssociation(
    IN pIdUser INT,
    IN pName VARCHAR(255)
)
BEGIN
    UPDATE association
    SET name = pName
    WHERE id_user = pIdUser;
END$$


CREATE PROCEDURE updateAdopter(
    IN pIdUser INT,
    IN pFirstName VARCHAR(255),
    IN pSecondName VARCHAR(255),
    IN pFirstSurname VARCHAR(255),
    IN pSecondSurname VARCHAR(255)
)
BEGIN
    UPDATE adopter
    SET first_name = pFirstName,
        second_name = pSecondName,
        first_surname = pFirstSurname,
        second_surname = pSecondSurname
    WHERE id_user = pIdUser;
END$$


CREATE PROCEDURE updateRescuer(
    IN pIdUser INT,
    IN pFirstName VARCHAR(255),
    IN pSecondName VARCHAR(255),
    IN pFirstSurname VARCHAR(255),
    IN pSecondSurname VARCHAR(255)
)
BEGIN
    UPDATE rescuer
    SET first_name = pFirstName,
        second_name = pSecondName,
        first_surname = pFirstSurname,
        second_surname = pSecondSurname
    WHERE id_user = pIdUser;
END$$


CREATE PROCEDURE updateCribHouse(
    IN pIdUser INT,
    IN pName VARCHAR(255),
    IN pRequiresDonations INT
)
BEGIN
    UPDATE crib_house
    SET name = pName,
        requires_donations = pRequiresDonations
    WHERE id_user = pIdUser;
END$$

-- ========================================
-- DELETE
-- ========================================

CREATE PROCEDURE deleteUser(
    IN pIdUser INT
)
BEGIN
    DELETE FROM user
    WHERE id_user = pIdUser;
END$$


CREATE PROCEDURE deleteAssociation(
    IN pIdUser INT
)
BEGIN
    DELETE FROM association
    WHERE id_user = pIdUser;
END$$


CREATE PROCEDURE deleteAdopter(
    IN pIdUser INT
)
BEGIN
    DELETE FROM adopter
    WHERE id_user = pIdUser;
END$$


CREATE PROCEDURE deleteRescuer(
    IN pIdUser INT
)
BEGIN
    DELETE FROM rescuer
    WHERE id_user = pIdUser;
END$$


CREATE PROCEDURE deleteCribHouse(
    IN pIdUser INT
)
BEGIN
    DELETE FROM crib_house
    WHERE id_user = pIdUser;
END$$

DELIMITER $$

-- ========================================
-- GET
-- ========================================

CREATE PROCEDURE getUser()
BEGIN
    SELECT * FROM user;
END$$


CREATE PROCEDURE getUserById(
    IN pIdUser INT
)
BEGIN
    SELECT u.email
    FROM user u
    WHERE u.id_user = pIdUser;
END$$


CREATE FUNCTION login(
    p_email VARCHAR(255),
    p_password VARCHAR(255)
)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_id INT;

    SELECT id_user
    INTO v_id
    FROM user
    WHERE email = p_email
      AND password = p_password;

    RETURN v_id;
END$$


CREATE PROCEDURE getAssociation()
BEGIN
    SELECT * FROM association;
END$$


CREATE PROCEDURE getAssociationById(
    IN pIdAssociation INT
)
BEGIN
    SELECT a.name
    FROM association a
    WHERE a.id_user = pIdAssociation;
END$$


CREATE PROCEDURE getAdopter()
BEGIN
    SELECT
        a.id_user,
        b.email,
        a.first_name,
        a.first_surname
    FROM adopter a
    INNER JOIN user b
        ON a.id_user = b.id_user;
END$$


CREATE PROCEDURE getAdopterById(
    IN pIdAdopter INT
)
BEGIN
    SELECT
        a.first_name,
        a.second_name,
        a.first_surname,
        a.second_surname
    FROM adopter a
    WHERE a.id_user = pIdAdopter;
END$$


CREATE PROCEDURE getRescuer()
BEGIN
    SELECT * FROM rescuer;
END$$


CREATE PROCEDURE getRescuerById(
    IN pIdRescuer INT
)
BEGIN
    SELECT
        r.first_name,
        r.second_name,
        r.first_surname,
        r.second_surname
    FROM rescuer r
    WHERE r.id_user = pIdRescuer;
END$$


CREATE PROCEDURE getCribHouse()
BEGIN
    SELECT * FROM crib_house;
END$$


CREATE PROCEDURE getCribHouseById(
    IN pIdCribHouse INT
)
BEGIN
    SELECT ch.name
    FROM crib_house ch
    WHERE ch.id_user = pIdCribHouse;
END$$


CREATE PROCEDURE getDonnableCrib()
BEGIN
    SELECT
        ch.id_user,
        ch.name
    FROM crib_house ch
    WHERE ch.requires_donations = 1;
END$$
CREATE PROCEDURE loginByEmail(IN pEmail VARCHAR(255))
BEGIN
    SELECT
        email,
        password
    FROM user
    WHERE email = pEmail;
END$$

DELIMITER ;