DELIMITER $$

CREATE TRIGGER beforeInsertValueType
BEFORE INSERT
ON value_type
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateValueType
BEFORE UPDATE
ON value_type
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;