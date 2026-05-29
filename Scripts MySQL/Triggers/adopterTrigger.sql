DELIMITER $$

CREATE TRIGGER beforeInsertAdopter
BEFORE INSERT
ON adopter
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateAdopter
BEFORE UPDATE
ON adopter
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;