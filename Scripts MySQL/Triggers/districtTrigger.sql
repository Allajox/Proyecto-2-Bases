DELIMITER $$

CREATE TRIGGER beforeInsertDistrict
BEFORE INSERT ON district
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'district', 'name', 'empty', NEW.`name`);
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'district', 'id_canton', 'empty', NEW.id_canton);
END$$

CREATE TRIGGER beforeUpdateDistrict
BEFORE UPDATE ON district
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
    
    IF OLD.`name` <> NEW.`name` THEN
        INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
								previousValue, currentValue)
        VALUES (CURRENT_DATE(), USER(), 'district', 'name', OLD.`name`, NEW.`name`);
    END IF;
    
    IF OLD.id_canton <> NEW.id_canton THEN
        INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
								previousValue, currentValue)
        VALUES (CURRENT_DATE(), USER(), 'district', 'id_canton', OLD.id_canton, NEW.id_canton);
    END IF;
END$$

DELIMITER ;
