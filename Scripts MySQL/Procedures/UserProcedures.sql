DELIMITER $$

CREATE PROCEDURE insertUser(
    OUT pIdUser INT,
    IN pEmail VARCHAR(255),
    IN pPassword VARCHAR(255)
)
BEGIN
    SET pIdUser = NEXTVAL(s_user);

    INSERT INTO user (id_user, email, `password`)
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
        a.first_name,
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
        a.first_name,
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