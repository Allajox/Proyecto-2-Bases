DELIMITER $$

CREATE TRIGGER beforeInsertTreatment
BEFORE INSERT
ON treatment
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateTreatment
BEFORE UPDATE
ON treatment
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;