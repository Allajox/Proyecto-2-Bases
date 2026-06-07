DELIMITER $$

-- ======================================== INSERT ========================================

CREATE FUNCTION insertPetExtraInfo(
    pBeforePicture VARCHAR(255),
    pAfterPicture VARCHAR(255),
    pIdPet INT,
    pIdCurrentStatus INT,
    pIdEnergyLevel INT,
    pIdTrainingEase INT
)
RETURNS INT
DETERMINISTIC
MODIFIES SQL DATA
BEGIN
    INSERT INTO pet_extra_info (
        before_picture,
        after_picture,
        id_pet,
        id_current_status,
        id_energy_level,
        id_training_ease
    )
    VALUES (
        pBeforePicture,
        pAfterPicture,
        pIdPet,
        pIdCurrentStatus,
        pIdEnergyLevel,
        pIdTrainingEase
    );

    RETURN LAST_INSERT_ID();
END$$


CREATE PROCEDURE insertCurrentStatus(
    IN pStatusType VARCHAR(255)
)
BEGIN
    INSERT INTO current_status (status_type)
    VALUES (pStatusType);

    COMMIT;
END$$


CREATE PROCEDURE insertEnergyLevel(
    IN pName VARCHAR(255)
)
BEGIN
    INSERT INTO energy_level (`name`)
    VALUES (pName);

    COMMIT;
END$$


CREATE PROCEDURE insertTrainingEase(
    IN pName VARCHAR(255)
)
BEGIN
    INSERT INTO training_ease (`name`)
    VALUES (pName);

    COMMIT;
END$$


CREATE PROCEDURE insertBounty(
    IN pAmount DECIMAL(18,2),
    IN pIdPetExtraInfo INT,
    IN pIdCurrency INT
)
BEGIN
    INSERT INTO bounty (
        amount,
        id_pet_extra_info,
        id_currency
    )
    VALUES (
        pAmount,
        pIdPetExtraInfo,
        pIdCurrency
    );

    COMMIT;
END$$


-- ======================================== UPDATE ========================================

CREATE PROCEDURE updatePetExtraInfo(
    IN pIdPetExtraInfo INT,
    IN pBeforePicture VARCHAR(255),
    IN pAfterPicture VARCHAR(255),
    IN pIdCurrentStatus INT,
    IN pIdEnergyLevel INT,
    IN pIdTrainingEase INT
)
BEGIN
    UPDATE pet_extra_info
    SET before_picture = pBeforePicture,
        after_picture = pAfterPicture,
        id_current_status = pIdCurrentStatus,
        id_energy_level = pIdEnergyLevel,
        id_training_ease = pIdTrainingEase
    WHERE id_pet_extra_info = pIdPetExtraInfo;

    COMMIT;
END$$


CREATE PROCEDURE updateCurrentStatus(
    IN pIdCurrentStatus INT,
    IN pStatusType VARCHAR(255)
)
BEGIN
    UPDATE current_status
    SET status_type = pStatusType
    WHERE id_current_status = pIdCurrentStatus;

    COMMIT;
END$$


CREATE PROCEDURE updateEnergyLevel(
    IN pIdEnergyLevel INT,
    IN pName VARCHAR(255)
)
BEGIN
    UPDATE energy_level
    SET `name` = pName
    WHERE id_energy_level = pIdEnergyLevel;

    COMMIT;
END$$


CREATE PROCEDURE updateTrainingEase(
    IN pIdTrainingEase INT,
    IN pName VARCHAR(255)
)
BEGIN
    UPDATE training_ease
    SET `name` = pName
    WHERE id_training_ease = pIdTrainingEase;

    COMMIT;
END$$


CREATE PROCEDURE updateBounty(
    IN pIdBounty INT,
    IN pAmount DECIMAL(18,2),
    IN pIdCurrency INT
)
BEGIN
    UPDATE bounty
    SET amount = pAmount,
        id_currency = pIdCurrency
    WHERE id_bounty = pIdBounty;

    COMMIT;
END$$


-- ======================================== GET ========================================

CREATE PROCEDURE getPetExtraInfo()
BEGIN
    SELECT *
    FROM pet_extra_info;
END$$


CREATE PROCEDURE getPetExtraInfoById(
    IN pIdPet INT
)
BEGIN
    SELECT *
    FROM pet_extra_info
    WHERE id_pet = pIdPet;
END$$


CREATE PROCEDURE getCurrentStatus()
BEGIN
    SELECT *
    FROM current_status;
END$$


CREATE PROCEDURE getCurrentStatusById(
    IN pIdCurrentStatus INT
)
BEGIN
    SELECT cs.status_type
    FROM current_status cs
    WHERE cs.id_current_status = pIdCurrentStatus;
END$$


CREATE PROCEDURE getEnergyLevel()
BEGIN
    SELECT *
    FROM energy_level;
END$$


CREATE PROCEDURE getEnergyLevelById(
    IN pIdEnergyLevel INT
)
BEGIN
    SELECT el.`name`
    FROM energy_level el
    WHERE el.id_energy_level = pIdEnergyLevel;
END$$


CREATE PROCEDURE getTrainingEase()
BEGIN
    SELECT *
    FROM training_ease;
END$$


CREATE PROCEDURE getTrainingEaseById(
    IN pIdTrainingEase INT
)
BEGIN
    SELECT te.`name`
    FROM training_ease te
    WHERE te.id_training_ease = pIdTrainingEase;
END$$


CREATE PROCEDURE getBounty()
BEGIN
    SELECT *
    FROM bounty;
END$$


CREATE PROCEDURE getBountyById(
    IN pIdBounty INT
)
BEGIN
    SELECT b.amount
    FROM bounty b
    WHERE b.id_bounty = pIdBounty;
END$$


CREATE FUNCTION getBountyByPet(
    pIdPet INT
)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_number INT;

    SELECT b.id_bounty
    INTO v_number
    FROM bounty b
    INNER JOIN pet_extra_info pex
        ON pex.id_pet_extra_info = b.id_pet_extra_info
    INNER JOIN pet p
        ON p.id_pet = pex.id_pet
    WHERE p.id_pet = pIdPet
    LIMIT 1;

    RETURN v_number;
END$$


-- ======================================== DELETE ========================================

CREATE PROCEDURE deleteBounty(
    IN pIdBounty INT
)
BEGIN
    DELETE FROM bounty
    WHERE id_bounty = pIdBounty;

    COMMIT;
END$$


CREATE PROCEDURE deleteTrainingEase(
    IN pIdTrainingEase INT
)
BEGIN
    DELETE FROM training_ease
    WHERE id_training_ease = pIdTrainingEase;

    COMMIT;
END$$


CREATE PROCEDURE deleteEnergyLevel(
    IN pIdEnergyLevel INT
)
BEGIN
    DELETE FROM energy_level
    WHERE id_energy_level = pIdEnergyLevel;

    COMMIT;
END$$


CREATE PROCEDURE deleteCurrentStatus(
    IN pIdCurrStatus INT
)
BEGIN
    DELETE FROM current_status
    WHERE id_current_status = pIdCurrStatus;

    COMMIT;
END$$

DELIMITER ;