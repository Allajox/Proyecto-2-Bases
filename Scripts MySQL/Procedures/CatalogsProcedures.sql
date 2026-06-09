DELIMITER $$

-- ==================== INSERT ====================

CREATE PROCEDURE insertCurrency(
    IN p_name VARCHAR(255),
    IN p_acronym VARCHAR(255)
)
BEGIN
    INSERT INTO currency (`name`, acronym)
    VALUES (p_name, p_acronym);

    COMMIT;
END$$


CREATE PROCEDURE insertProvince(
    IN p_name VARCHAR(255)
)
BEGIN
    INSERT INTO province (`name`)
    VALUES (p_name);

    COMMIT;
END$$


CREATE PROCEDURE insertCanton(
    IN p_name VARCHAR(255),
    IN p_id_province INT
)
BEGIN
    INSERT INTO canton (`name`, id_province)
    VALUES (p_name, p_id_province);

    COMMIT;
END$$


CREATE PROCEDURE insertDistrict(
    IN p_name VARCHAR(255),
    IN p_id_canton INT
)
BEGIN
    INSERT INTO district (`name`, id_canton)
    VALUES (p_name, p_id_canton);

    COMMIT;
END$$


CREATE PROCEDURE insertPetType(
    IN p_name VARCHAR(255)
)
BEGIN
    INSERT INTO pet_type (`name`)
    VALUES (p_name);

    COMMIT;
END$$


CREATE PROCEDURE insertRace(
    IN p_name VARCHAR(255),
    IN p_id_pet_type INT
)
BEGIN
    INSERT INTO race (`name`, id_pet_type)
    VALUES (p_name, p_id_pet_type);

    COMMIT;
END$$


CREATE PROCEDURE insertStatus(
    IN p_status_type VARCHAR(255)
)
BEGIN
    INSERT INTO status (status_type)
    VALUES (p_status_type);

    COMMIT;
END$$


CREATE PROCEDURE insertColor(
    IN p_name VARCHAR(255)
)
BEGIN
    INSERT INTO color (`name`)
    VALUES (p_name);

    COMMIT;
END$$


CREATE PROCEDURE insertValueType(
    IN p_type VARCHAR(255)
)
BEGIN
    INSERT INTO value_type (`type`)
    VALUES (p_type);

    COMMIT;
END$$


CREATE PROCEDURE insertSize(
    IN p_name VARCHAR(255)
)
BEGIN
    INSERT INTO `size` (`name`)
    VALUES (p_name);

    COMMIT;
END$$


CREATE PROCEDURE insertSizeXCribHouse(
    IN p_id_size INT,
    IN p_id_crib_house INT
)
BEGIN
    INSERT INTO size_x_crib_house (
        id_size,
        id_crib_house
    )
    VALUES (
        p_id_size,
        p_id_crib_house
    );

    COMMIT;
END$$


-- ==================== UPDATE ====================

CREATE PROCEDURE updateCurrency(
    IN p_id_currency INT,
    IN p_name VARCHAR(255),
    IN p_acronym VARCHAR(255)
)
BEGIN
    UPDATE currency
    SET `name` = p_name,
        acronym = p_acronym
    WHERE id_currency = p_id_currency;

    COMMIT;
END$$


CREATE PROCEDURE updateProvince(
    IN p_id_province INT,
    IN p_name VARCHAR(255)
)
BEGIN
    UPDATE province
    SET `name` = p_name
    WHERE id_province = p_id_province;

    COMMIT;
END$$


CREATE PROCEDURE updateCanton(
    IN p_id_canton INT,
    IN p_name VARCHAR(255),
    IN p_id_province INT
)
BEGIN
    UPDATE canton
    SET `name` = p_name,
        id_province = p_id_province
    WHERE id_canton = p_id_canton;

    COMMIT;
END$$


CREATE PROCEDURE updateDistrict(
    IN p_id_district INT,
    IN p_name VARCHAR(255),
    IN p_id_canton INT
)
BEGIN
    UPDATE district
    SET `name` = p_name,
        id_canton = p_id_canton
    WHERE id_district = p_id_district;

    COMMIT;
END$$


CREATE PROCEDURE updatePetType(
    IN p_id_pet_type INT,
    IN p_name VARCHAR(255)
)
BEGIN
    UPDATE pet_type
    SET `name` = p_name
    WHERE id_pet_type = p_id_pet_type;

    COMMIT;
END$$


CREATE PROCEDURE updateRace(
    IN p_id_race INT,
    IN p_name VARCHAR(255),
    IN p_id_pet_type INT
)
BEGIN
    UPDATE race
    SET `name` = p_name,
        id_pet_type = p_id_pet_type
    WHERE id_race = p_id_race;

    COMMIT;
END$$


CREATE PROCEDURE updateStatus(
    IN p_id_status INT,
    IN p_status_type VARCHAR(255)
)
BEGIN
    UPDATE status
    SET status_type = p_status_type
    WHERE id_status = p_id_status;

    COMMIT;
END$$


CREATE PROCEDURE updateColor(
    IN p_id_color INT,
    IN p_name VARCHAR(255)
)
BEGIN
    UPDATE color
    SET `name` = p_name
    WHERE id_color = p_id_color;

    COMMIT;
END$$


CREATE PROCEDURE updateValueType(
    IN p_id_value_type INT,
    IN p_type VARCHAR(255)
)
BEGIN
    UPDATE value_type
    SET `type` = p_type
    WHERE id_value_type = p_id_value_type;

    COMMIT;
END$$


CREATE PROCEDURE updateSize(
    IN p_id_size INT,
    IN p_name VARCHAR(255)
)
BEGIN
    UPDATE `size`
    SET `name` = p_name
    WHERE id_size = p_id_size;

    COMMIT;
END$$


CREATE PROCEDURE updateSizeXCribHouse(
    IN p_id_size INT,
    IN p_old_crib_house INT,
    IN p_new_crib_house INT
)
BEGIN
    UPDATE size_x_crib_house
    SET id_crib_house = p_new_crib_house
    WHERE id_size = p_id_size
      AND id_crib_house = p_old_crib_house;

    COMMIT;
END$$

DELIMITER ;
DELIMITER $$

-- ==================== DELETE ====================

CREATE PROCEDURE deleteCurrency(
    IN p_id_currency INT
)
BEGIN
    DELETE FROM currency
    WHERE id_currency = p_id_currency;

    COMMIT;
END$$


CREATE PROCEDURE deleteProvince(
    IN p_id_province INT
)
BEGIN
    DELETE FROM province
    WHERE id_province = p_id_province;

    COMMIT;
END$$


CREATE PROCEDURE deleteCanton(
    IN p_id_canton INT
)
BEGIN
    DELETE FROM canton
    WHERE id_canton = p_id_canton;

    COMMIT;
END$$


CREATE PROCEDURE deleteDistrict(
    IN p_id_district INT
)
BEGIN
    DELETE FROM district
    WHERE id_district = p_id_district;

    COMMIT;
END$$


CREATE PROCEDURE deletePetType(
    IN p_id_pet_type INT
)
BEGIN
    DELETE FROM pet_type
    WHERE id_pet_type = p_id_pet_type;

    COMMIT;
END$$


CREATE PROCEDURE deleteRace(
    IN p_id_race INT
)
BEGIN
    DELETE FROM race
    WHERE id_race = p_id_race;

    COMMIT;
END$$


CREATE PROCEDURE deleteStatus(
    IN p_id_status INT
)
BEGIN
    DELETE FROM status
    WHERE id_status = p_id_status;

    COMMIT;
END$$


CREATE PROCEDURE deleteColor(
    IN p_id_color INT
)
BEGIN
    DELETE FROM color
    WHERE id_color = p_id_color;

    COMMIT;
END$$


CREATE PROCEDURE deleteValueType(
    IN p_id_value_type INT
)
BEGIN
    DELETE FROM value_type
    WHERE id_value_type = p_id_value_type;

    COMMIT;
END$$


CREATE PROCEDURE deleteSize(
    IN p_id_size INT
)
BEGIN
    DELETE FROM `size`
    WHERE id_size = p_id_size;

    COMMIT;
END$$


CREATE PROCEDURE deleteSizeXCribHouse(
    IN p_id_size INT,
    IN p_id_crib_house INT
)
BEGIN
    DELETE FROM size_x_crib_house
    WHERE id_size = p_id_size
      AND id_crib_house = p_id_crib_house;

    COMMIT;
END$$


-- ==================== GET ====================

CREATE PROCEDURE getCurrency()
BEGIN
    SELECT *
    FROM currency;
END$$


CREATE PROCEDURE getCurrencyById(
    IN pIdCurrency INT
)
BEGIN
    SELECT c.`name`
    FROM currency c
    WHERE c.id_currency = pIdCurrency;
END$$


CREATE PROCEDURE getProvince()
BEGIN
    SELECT *
    FROM province;
END$$


CREATE PROCEDURE getProvinceById(
    IN pIdProvince INT
)
BEGIN
    SELECT p.`name`
    FROM province p
    WHERE p.id_province = pIdProvince;
END$$


CREATE PROCEDURE getCanton()
BEGIN
    SELECT *
    FROM canton;
END$$


CREATE PROCEDURE getCantonById(
    IN pIdCanton INT
)
BEGIN
    SELECT c.`name`
    FROM canton c
    WHERE c.id_canton = pIdCanton;
END$$


CREATE PROCEDURE getDistrict()
BEGIN
    SELECT *
    FROM district;
END$$


CREATE PROCEDURE getDistrictById(
    IN pIdDistrict INT
)
BEGIN
    SELECT d.`name`
    FROM district d
    WHERE d.id_district = pIdDistrict;
END$$


CREATE PROCEDURE getPetType()
BEGIN
    SELECT *
    FROM pet_type;
END$$


CREATE PROCEDURE getPetTypeById(
    IN pIdPetType INT
)
BEGIN
    SELECT pt.`name`
    FROM pet_type pt
    WHERE pt.id_pet_type = pIdPetType;
END$$


CREATE PROCEDURE getRace()
BEGIN
    SELECT *
    FROM race;
END$$


CREATE PROCEDURE getRaceById(
    IN pIdRace INT
)
BEGIN
    SELECT r.`name`
    FROM race r
    WHERE r.id_race = pIdRace;
END$$


CREATE PROCEDURE getRaceByPetType(
    IN p_id_pet_type INT
)
BEGIN
    SELECT
        id_race,
        `name`,
        id_pet_type
    FROM race
    WHERE id_pet_type = p_id_pet_type
    ORDER BY `name`;
END$$


CREATE PROCEDURE getStatus()
BEGIN
    SELECT *
    FROM status;
END$$


CREATE PROCEDURE getStatusById(
    IN pIdStatus INT
)
BEGIN
    SELECT s.status_type
    FROM status s
    WHERE s.id_status = pIdStatus;
END$$


CREATE PROCEDURE getColor()
BEGIN
    SELECT *
    FROM color;
END$$


CREATE PROCEDURE getColorById(
    IN pIdColor INT
)
BEGIN
    SELECT c.`name`
    FROM color c
    WHERE c.id_color = pIdColor;
END$$


CREATE PROCEDURE getValueType()
BEGIN
    SELECT *
    FROM value_type;
END$$


CREATE PROCEDURE getValueTypeById(
    IN pIdValueType INT
)
BEGIN
    SELECT vt.`type`
    FROM value_type vt
    WHERE vt.id_value_type = pIdValueType;
END$$


CREATE PROCEDURE getSize()
BEGIN
    SELECT *
    FROM `size`;
END$$


CREATE PROCEDURE getSizeById(
    IN pIdSize INT
)
BEGIN
    SELECT s.`name`
    FROM `size` s
    WHERE s.id_size = pIdSize;
END$$

DELIMITER ;