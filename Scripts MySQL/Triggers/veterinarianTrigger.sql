DELIMITER $$

CREATE TRIGGER beforeInsertVeterinarian
BEFORE INSERT
ON veterinarian
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateVeterinarian
BEFORE UPDATE
ON veterinarian
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;