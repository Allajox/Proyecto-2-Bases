DELIMITER $$

CREATE TRIGGER beforeInsertEnergyLevel
BEFORE INSERT
ON energy_level
FOR EACH ROW
BEGIN
	SET NEW.createdBy = USER();
	SET NEW.createdAt = CURRENT_DATE();
	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                        previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'energy_level', 'name', 'empty', NEW.`name`);
END $$

CREATE TRIGGER beforeUpdateEnergyLevel
BEFORE UPDATE 
ON energy_level
FOR EACH ROW 
BEGIN
	SET NEW.modifiedBY = USER();
	SET NEW.modifiedAt = CURRENT_DATE();
        IF OLD.`name` <> NEW.`name` THEN
            INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                            previousValue, currentValue)
            VALUES (CURRENT_DATE(), USER(), 'energy_level', 'name', OLD.`name`, NEW.`name`);
		END IF;
END $$

DELIMITER ;
