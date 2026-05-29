DELIMITER $$

CREATE TRIGGER beforeInsertRescuer
BEFORE INSERT
ON rescuer
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateRescuer
BEFORE UPDATE
ON rescuer
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;