DELIMITER $$

-- ========================================
-- INSERT
-- ========================================
CREATE PROCEDURE insertPet(
	OUT pId INT,
    IN pPicture VARCHAR(255),
    IN pFirstName VARCHAR(255),
    IN pBirthDate DATE,
    IN pDateLost DATE,
    IN pDateFound DATE,
    IN pEmail VARCHAR(255),
    IN pIdStatus INT,
    IN pIdRace INT,
    IN pIdSize INT,
    IN pIdUser INT,
    IN pIdAdopter INT,
    IN pIdDistrict INT
)
MODIFIES SQL DATA
BEGIN
    INSERT INTO pet (
        picture,
        `name`,
        birth_date,
        date_lost,
        date_found,
        email,
        id_status,
        id_race,
        id_size,
        id_user,
        id_adopter,
        id_district
    )
    VALUES (
        pPicture,
        pFirstName,
        pBirthDate,
        pDateLost,
        pDateFound,
        pEmail,
        pIdStatus,
        pIdRace,
        pIdSize,
        pIdUser,
        pIdAdopter,
        pIdDistrict
    );
    
    SET pId = LAST_INSERT_ID();
END$$


CREATE FUNCTION insertIdChip(
    pChipNumber VARCHAR(255),
    pRegistrationDate DATE,
    pIdPet INT
)
RETURNS INT
MODIFIES SQL DATA
BEGIN

    INSERT INTO identification_chip (
        chip_number,
        registration_date,
        id_pet
    )
    VALUES (
        pChipNumber,
        pRegistrationDate,
        pIdPet
    );

    RETURN LAST_INSERT_ID();

END$$


CREATE PROCEDURE insertPetXColor(
    IN pIdPet INT,
    IN pIdColor INT
)
BEGIN

    INSERT INTO pet_x_color (
        id_pet,
        id_color
    )
    VALUES (
        pIdPet,
        pIdColor
    );

END$$


CREATE PROCEDURE insertPetTypeXCribHouse(
    IN pIdPetType INT,
    IN pIdCribHouse INT
)
BEGIN

    INSERT INTO pet_type_x_crib_house (
        id_pet_type,
        id_crib_house
    )
    VALUES (
        pIdPetType,
        pIdCribHouse
    );

END$$


-- ========================================
-- UPDATE
-- ========================================

CREATE PROCEDURE adoptPet(
    IN pIdUser INT,
    IN pIdStatus INT,
    IN pIdPet INT
)
BEGIN

    UPDATE pet
    SET id_adopter = pIdUser,
        id_status = pIdStatus
    WHERE id_pet = pIdPet;

END$$

CREATE PROCEDURE updatePet(
    IN pIdPet INT,
    IN pPicture VARCHAR(255),
    IN pFirstName VARCHAR(255),
    IN pBirthDate DATE,
    IN pDateLost DATE,
    IN pDateFound DATE,
    IN pEmail VARCHAR(255),
    IN pIdStatus INT
)
BEGIN

    UPDATE pet
    SET picture = pPicture,
        `name` = pFirstName,
        birth_date = pBirthDate,
        date_lost = pDateLost,
        date_found = pDateFound,
        email = pEmail,
        id_status = pIdStatus
    WHERE id_pet = pIdPet;

END$$


CREATE PROCEDURE petFound(
    IN pIdPet INT
)
BEGIN

    UPDATE pet
    SET id_status = 2
    WHERE id_pet = pIdPet
      AND id_status = 1;

END$$


-- ========================================
-- DELETE
-- ========================================

CREATE PROCEDURE deletePet(
    IN pIdPet INT
)
BEGIN

    DELETE FROM pet
    WHERE id_pet = pIdPet;

END$$

DELIMITER $$

-- ========================================
-- GET
-- ========================================

CREATE PROCEDURE getPet()
BEGIN
    SELECT * FROM pet;
END$$


CREATE PROCEDURE getPetById(
    IN p_idPet INT
)
BEGIN
    SELECT *
    FROM pet
    WHERE id_pet = p_idPet;
END$$


CREATE PROCEDURE getPetByStatus(
    IN p_idStatus INT
)
BEGIN
    SELECT *
    FROM pet
    WHERE id_status = p_idStatus;
END$$


CREATE PROCEDURE getPetByRescuer(
    IN pIdUser INT
)
BEGIN
    SELECT *
    FROM pet
    WHERE id_user = pIdUser;
END$$


CREATE PROCEDURE getIdChip()
BEGIN
    SELECT *
    FROM identification_chip;
END$$


CREATE PROCEDURE getPetXColor()
BEGIN
    SELECT *
    FROM pet_x_color;
END$$


CREATE PROCEDURE getPetTypeXCribHouse()
BEGIN
    SELECT *
    FROM pet_type_x_crib_house;
END$$


CREATE PROCEDURE getPetColors(
    IN pIdPet INT
)
BEGIN

    SELECT c.`name`
    FROM color c

    INNER JOIN pet_x_color pxc
        ON c.id_color = pxc.id_color

    WHERE pxc.id_pet = pIdPet;

END$$


CREATE PROCEDURE getCribHousePetTypes(
    IN pIdCribHouse INT
)
BEGIN

    SELECT pt.`name`
    FROM pet_type pt

    INNER JOIN pet_type_x_crib_house ptxch
        ON pt.id_pet_type = ptxch.id_pet_type

    WHERE ptxch.id_crib_house = pIdCribHouse;

END$$

CREATE PROCEDURE getCardInfo(
    IN p_id_pet INT
)
BEGIN

    SELECT
        a.picture,
        b.status_type,
        a.`name`,
        c.id_pet_extra_info,
        d.`name`,
        e.email,
        f.`name`,
        g.`name`,
        h.`name`
    FROM pet a

    LEFT JOIN status b
        ON b.id_status = a.id_status

    LEFT JOIN pet_extra_info c
        ON c.id_pet = a.id_pet

    LEFT JOIN energy_level d
        ON c.id_energy_level = d.id_energy_level

    LEFT JOIN `user` e
        ON a.id_user = e.id_user

    LEFT JOIN `size` f
        ON a.id_size = f.id_size

    LEFT JOIN training_ease g
        ON g.id_training_ease = c.id_training_ease

    LEFT JOIN race h
        ON a.id_race = h.id_race

    WHERE a.id_pet = p_id_pet;

END$$

CREATE PROCEDURE getPopUpInfo(
    IN p_id_pet INT
)
BEGIN

    SELECT
        a.picture,
        b.status_type,
        h.`name`,
        a.`name`,
        a.birth_date,
        e.email,
        a.date_lost,
        a.date_found,
        f.`name`,
        d.`name`,
        g.`name`,
        i.`name`,
        j.amount,
        k.acronym,
        l.abandonment_description

    FROM pet a

    LEFT JOIN status b
        ON b.id_status = a.id_status

    LEFT JOIN pet_extra_info c
        ON c.id_pet = a.id_pet

    LEFT JOIN energy_level d
        ON c.id_energy_level = d.id_energy_level

    LEFT JOIN `user` e
        ON a.id_user = e.id_user

    LEFT JOIN `size` f
        ON a.id_size = f.id_size

    LEFT JOIN training_ease g
        ON g.id_training_ease = c.id_training_ease

    LEFT JOIN race h
        ON a.id_race = h.id_race

    LEFT JOIN crib_house i
        ON a.id_adopter = i.id_user

    LEFT JOIN bounty j
        ON c.id_pet_extra_info = j.id_pet_extra_info

    LEFT JOIN currency k
        ON j.id_currency = k.id_currency

    LEFT JOIN medic_sheet l
        ON c.id_pet_extra_info = l.id_pet_extra_info

    WHERE a.id_pet = p_id_pet;

END$$

DELIMITER ;