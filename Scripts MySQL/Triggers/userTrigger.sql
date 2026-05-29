DELIMITER $$

CREATE TRIGGER beforeInsertUser
BEFORE INSERT 
ON `user`
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'user', 'email', 'empty', NEW.email);
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'user', 'password', 'empty', NEW.`password`);
END$$

CREATE TRIGGER beforeUpdateUser
BEFORE UPDATE 
ON `user`
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
    
    IF OLD.email <> NEW.email THEN
        INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
								previousValue, currentValue)
        VALUES (CURRENT_DATE(), USER(), 'user', 'email', OLD.email, NEW.email);
    END IF;
    
    IF OLD.`password` <> NEW.`password` THEN
        INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
								previousValue, currentValue)
        VALUES (CURRENT_DATE(), USER(), 'user', 'password', OLD.`password`, NEW.`password`);
    END IF;
END$$

DELIMITER ;
