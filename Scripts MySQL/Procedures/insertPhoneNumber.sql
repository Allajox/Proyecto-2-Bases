DELIMITER $$

CREATE PROCEDURE insertPhoneNumber(
    IN pNumber BIGINT,
    IN pIdUser INT,
    IN pIdPet INT,
    IN pIdVeterinarian INT
)
BEGIN
    INSERT INTO phone_number (
        number,
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
END$$

DELIMITER ;