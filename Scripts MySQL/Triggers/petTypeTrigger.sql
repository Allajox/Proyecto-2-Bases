DELIMITER $$

CREATE TRIGGER beforeInsertPetType
BEFORE INSERT ON pet_type
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'pet_type', 'id_pet_type', 'empty', NEW.id_pet_type);
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'pet_type', 'name', 'empty', NEW.`name`);
END$$

CREATE TRIGGER beforeUpdatePetType
BEFORE UPDATE ON pet_type
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
    
    IF OLD.`name` <> NEW.`name` THEN
        INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
								previousValue, currentValue)
        VALUES (CURRENT_DATE(), USER(), 'pet_type', 'name', OLD.`name`, NEW.`name`);
    END IF;
END$$

DELIMITER ;
