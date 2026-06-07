DELIMITER $$

-- ======================================== INSERT ========================================

CREATE PROCEDURE insertPhoneNumber(
    IN pNumber BIGINT,
    IN pIdUser INT,
    IN pIdPet INT,
    IN pIdVeterinarian INT
)
BEGIN
    INSERT INTO phone_number (
        `number`,
        id_user,
        id_pet,
        id_veterinarian
    )
    VALUES (
        pNumber,
        pIdUser,
        pIdPet,
        pIdVeterinarian
    );

    COMMIT;
END$$


-- ======================================== GET ========================================

CREATE PROCEDURE getPhoneNumber()
BEGIN
    SELECT *
    FROM phone_number;
END$$


CREATE PROCEDURE getPhoneNumberById(
    IN pIdPhone INT
)
BEGIN
    SELECT p.`number`
    FROM phone_number p
    WHERE p.id_phone = pIdPhone;
END$$


CREATE PROCEDURE getUserPhones(
    IN pIdUser INT
)
BEGIN
    SELECT p.`number`
    FROM phone_number p
    WHERE p.id_user = pIdUser;
END$$


CREATE PROCEDURE getPetPhones(
    IN pIdPet INT
)
BEGIN
    SELECT p.`number`
    FROM phone_number p
    WHERE p.id_pet = pIdPet;
END$$


CREATE PROCEDURE getVeterinarianPhones(
    IN pIdVeterinarian INT
)
BEGIN
    SELECT p.`number`
    FROM phone_number p
    WHERE p.id_veterinarian = pIdVeterinarian;
END$$


-- ======================================== DELETE ========================================

CREATE PROCEDURE deletePhoneNumber(
    IN pIdPhone INT
)
BEGIN
    DELETE FROM phone_number
    WHERE id_phone = pIdPhone;

    COMMIT;
END$$

DELIMITER ;