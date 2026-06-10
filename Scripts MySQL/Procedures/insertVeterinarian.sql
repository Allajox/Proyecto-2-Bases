DELIMITER $$

CREATE PROCEDURE insertVeterinarian(
    IN pIdVeterinarian INT,
    IN pFirstName VARCHAR(255),
    IN pSecondName VARCHAR(255),
    IN pFirstSurname VARCHAR(255),
    IN pSecondSurname VARCHAR(255),
    IN pClinicName VARCHAR(255)
)
BEGIN

    INSERT INTO veterinarian (
        id_veterinarian,
        first_name,
        second_name,
        first_surname,
        second_surname,
        clinic_name
    )
    VALUES (
        pIdVeterinarian,
        pFirstName,
        pSecondName,
        pFirstSurname,
        pSecondSurname,
        pClinicName
    );

END$$

DELIMITER ;