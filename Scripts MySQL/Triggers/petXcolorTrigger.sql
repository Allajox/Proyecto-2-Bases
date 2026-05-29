DELIMITER $$

CREATE TRIGGER beforeInsertPetXColor
BEFORE INSERT
ON pet_x_color
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdatePetXColor
BEFORE UPDATE
ON pet_x_color
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;