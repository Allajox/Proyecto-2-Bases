DELIMITER $$

CREATE PROCEDURE insertUser(
    OUT pIdUser INT,
    IN pEmail VARCHAR(255),
    IN pPassword VARCHAR(255)
)
BEGIN
    SET pIdUser = NEXTVAL(s_user);

    INSERT INTO user (id_user, email, password)
    VALUES (pIdUser, pEmail, pPassword);
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

DELIMITER ;