DELIMITER $$

CREATE TRIGGER beforeInsertMedicSheet
BEFORE INSERT
ON medic_sheet
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateMedicSheet
BEFORE UPDATE
ON medic_sheet
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;
