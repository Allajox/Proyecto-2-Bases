DELIMITER $$

CREATE TRIGGER beforeInsertDisease
BEFORE INSERT
ON disease
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateDisease
BEFORE UPDATE
ON disease
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;