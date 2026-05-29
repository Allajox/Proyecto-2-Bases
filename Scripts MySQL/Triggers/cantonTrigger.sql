DELIMITER $$

CREATE TRIGGER beforeInsertCanton
BEFORE INSERT ON canton
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'canton', 'name', 'empty', NEW.`name`);
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'canton', 'id_province', 'empty', NEW.id_province);
END$$

CREATE TRIGGER beforeUpdateCanton
BEFORE UPDATE ON canton
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
    
    IF OLD.`name` <> NEW.`name` THEN
        INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
								previousValue, currentValue)
        VALUES (CURRENT_DATE(), USER(), 'canton', 'name', OLD.`name`, NEW.`name`);
    END IF;
    
    IF OLD.id_province <> NEW.id_province THEN
        INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
								previousValue, currentValue)
        VALUES (CURRENT_DATE(), USER(), 'canton', 'id_province', OLD.id_province, NEW.id_province);
    END IF;
END$$

DELIMITER ;
