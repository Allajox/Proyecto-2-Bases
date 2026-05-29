DELIMITER $$

CREATE TRIGGER beforeInsertAssociation
BEFORE INSERT
ON association
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateAssociation
BEFORE UPDATE
ON association
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;