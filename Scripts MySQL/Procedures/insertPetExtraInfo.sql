DELIMITER $$

CREATE FUNCTION insertPetExtraInfo(
    pSize VARCHAR(255),
    pBeforePicture VARCHAR(255),
    pAfterPicture VARCHAR(255),
    pIdPet INT,
    pIdCurrentStatus INT,
    pIdEnergyLevel INT,
    pIdTrainingEase INT
)
RETURNS INT
MODIFIES SQL DATA
BEGIN
    INSERT INTO pet_extra_info (
        'size',
        before_picture,
        after_picture,
        id_pet,
        id_current_status,
        id_energy_level,
        id_training_ease
    )
    VALUES (
        pSize,
        pBeforePicture,
        pAfterPicture,
        pIdPet,
        pIdCurrentStatus,
        pIdEnergyLevel,
        pIdTrainingEase
    );

    RETURN LAST_INSERT_ID();
END$$

DELIMITER ;