DELIMITER $$

CREATE TRIGGER beforeInsertMatch
BEFORE INSERT
ON `match`
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateMatch
BEFORE UPDATE
ON `match`
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;
