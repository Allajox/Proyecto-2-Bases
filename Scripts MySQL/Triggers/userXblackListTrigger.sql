DELIMITER $$

CREATE TRIGGER beforeInsertUserXBlackList
BEFORE INSERT
ON user_x_black_list
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
END$$

CREATE TRIGGER beforeUpdateUserXBlackList
BEFORE UPDATE
ON user_x_black_list
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
END$$

DELIMITER ;