DELIMITER $$

CREATE TRIGGER beforeInsertRace
BEFORE INSERT ON race
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'race', 'name', 'empty', NEW.`name`);
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'race', 'id_pet_type', 'empty', NEW.id_pet_type);
END$$

CREATE TRIGGER beforeUpdateRace
BEFORE UPDATE ON race
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
    
    IF OLD.`name` <> NEW.`name` THEN
        INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
								previousValue, currentValue)
        VALUES (CURRENT_DATE(), USER(), 'race', 'name', OLD.`name`, NEW.`name`);
    END IF;
    
    IF OLD.id_pet_type <> NEW.id_pet_type THEN
        INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
								previousValue, currentValue)
        VALUES (CURRENT_DATE(), USER(), 'race', 'id_pet_type', OLD.id_pet_type, NEW.id_pet_type);
    END IF;
END$$

DELIMITER ;
