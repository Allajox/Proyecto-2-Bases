DELIMITER $$

CREATE TRIGGER beforeInsertPet
BEFORE INSERT ON pet
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'pet', 'id_status', 'empty', NEW.id_status);
END$$

CREATE TRIGGER beforeUpdatePet
BEFORE UPDATE ON pet
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
    
    IF OLD.id_status <> NEW.id_status THEN
        INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
								previousValue, currentValue)
        VALUES (CURRENT_DATE(), USER(), 'pet', 'id_status', OLD.id_status, NEW.id_status);
    END IF;
END$$

DELIMITER ;
