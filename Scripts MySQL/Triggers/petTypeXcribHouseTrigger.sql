DELIMITER $$

CREATE TRIGGER beforeInsertPetTypeXCribHouse
BEFORE INSERT
ON pet_type_x_crib_house
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdatePetTypeXCribHouse
BEFORE UPDATE
ON pet_type_x_crib_house
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;