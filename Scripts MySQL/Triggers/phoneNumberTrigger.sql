DELIMITER $$

CREATE TRIGGER beforeInsertPhoneNumber
BEFORE INSERT
ON phone_number
FOR EACH ROW
BEGIN
	SET NEW.createdBy = USER();
	SET NEW.createdAt = CURRENT_DATE();
	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                        previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'phone_Number', 'number', 'empty', NEW.`number`);
END $$

CREATE TRIGGER beforeUpdatePhoneNumber
BEFORE UPDATE 
ON phone_number
FOR EACH ROW 
BEGIN
	SET NEW.modifiedBY = USER();
	SET NEW.modifiedAt = CURRENT_DATE();
        IF OLD.`number` <> NEW.`number` THEN
            INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                            previousValue, currentValue)
            VALUES (CURRENT_DATE(), USER(), 'phone_Number', 'number', OLD.`number`, NEW.`number`);
		END IF;
END $$

DELIMITER ;
