DELIMITER $$

CREATE TRIGGER beforeInsertDiseaseXMedicSheet
BEFORE INSERT
ON disease_x_medic_sheet
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateDiseaseXMedicSheet
BEFORE UPDATE
ON disease_x_medic_sheet
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;