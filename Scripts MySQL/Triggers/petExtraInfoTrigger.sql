DELIMITER $$

CREATE TRIGGER beforeInsertPetExtraInfo
BEFORE INSERT ON pet_extra_info
FOR EACH ROW
BEGIN
    SET NEW.createdBy = USER();
    SET NEW.createdAt = CURRENT_DATE();
    
    INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
							previousValue, currentValue)
    VALUES (CURRENT_DATE(), USER(), 'pet_Extra_Info', 'id_current_status', 'empty', NEW.id_current_status);
END$$

CREATE TRIGGER beforeUpdatePetExtraInfo
BEFORE UPDATE ON pet_extra_info
FOR EACH ROW
BEGIN
    SET NEW.modifiedBy = USER();
    SET NEW.modifiedAt = CURRENT_DATE();
    
    IF OLD.id_current_status <> NEW.id_current_status THEN
        INSERT INTO `log` (changeDate, changeBy, tableName, fieldName, 
								previousValue, currentValue)
        VALUES (CURRENT_DATE(), USER(), 'pet_Extra_Info', 'id_current_status', OLD.id_current_status, NEW.id_current_status);
    END IF;
END$$

DELIMITER ;
