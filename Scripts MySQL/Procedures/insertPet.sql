DELIMITER $$

CREATE FUNCTION insertPet(
    pPicture VARCHAR(255),
    pFirstName VARCHAR(255),
    pBirthDate DATE,
    pDateLost DATE,
    pDateFound DATE,
    pEmail VARCHAR(255),
    pCreatedBy VARCHAR(255),
    pCreatedAt DATETIME,
    pModifiedBy VARCHAR(255),
    pModifiedAt DATETIME,
    pIdStatus INT,
    pIdPetType INT,
    pIdRescuer INT
)
RETURNS INT
MODIFIES SQL DATA
BEGIN
    INSERT INTO pet (
        picture,
        first_name,
        birth_date,
        date_lost,
        date_found,
        email,
        createdBy,
        createdAt,
        modifiedBy,
        modifiedAt,
        id_status,
        id_pet_type,
        id_rescuer
    )
    VALUES (
        pPicture,
        pFirstName,
        pBirthDate,
        pDateLost,
        pDateFound,
        pEmail,
        pCreatedBy,
        pCreatedAt,
        pModifiedBy,
        pModifiedAt,
        pIdStatus,
        pIdPetType,
        pIdRescuer
    );

    RETURN LAST_INSERT_ID();
END$$

DELIMITER ;