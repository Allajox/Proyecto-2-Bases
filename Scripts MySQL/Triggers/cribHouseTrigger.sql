DELIMITER $$

CREATE TRIGGER beforeInsertCribHouse
BEFORE INSERT
ON crib_house
FOR EACH ROW
BEGIN
	SET NEW.createdBy = USER();
	SET NEW.createdAt = CURRENT_DATE();
	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                        previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'crib_house', 'requires_donations', 'empty', NEW.requires_donations);
END $$

CREATE TRIGGER beforeUpdateCribHouse
BEFORE UPDATE 
ON crib_house
FOR EACH ROW 
BEGIN
	SET NEW.modifiedBY = USER();
	SET NEW.modifiedAt = CURRENT_DATE();
        IF OLD.requires_donations <> NEW.requires_donations THEN
            INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                            previousValue, currentValue)
            VALUES (CURRENT_DATE(), USER(), 'crib_house', 'requires_donations', OLD.requires_donations, NEW.requires_donations);
		END IF;
END $$

DELIMITER ;
