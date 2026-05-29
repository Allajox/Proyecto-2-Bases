DELIMITER $$

CREATE TRIGGER beforeInsertBlackList
BEFORE INSERT
ON black_list
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateBlackList
BEFORE UPDATE
ON black_list
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;