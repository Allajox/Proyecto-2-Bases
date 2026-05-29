DELIMITER $$

CREATE TRIGGER beforeInsertTreatmentXDisease
BEFORE INSERT
ON treatment_x_disease
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateTreatmentXDisease
BEFORE UPDATE
ON treatment_x_disease
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;