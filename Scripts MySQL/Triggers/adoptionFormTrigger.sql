DELIMITER $$

CREATE TRIGGER beforeInsertAdoptionForm
BEFORE INSERT
ON adoption_form
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateAdoptionForm
BEFORE UPDATE
ON adoption_form
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;