DELIMITER $$

CREATE TRIGGER beforeInsertCurrency
BEFORE INSERT
ON currency
FOR EACH ROW
BEGIN
	SET NEW.createdBy = USER();
	SET NEW.createdAt = CURRENT_DATE();
	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                        previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'currency', 'name', 'empty', NEW.`name`);
END $$

CREATE TRIGGER beforeUpdateCurrency
BEFORE UPDATE 
ON currency
FOR EACH ROW 
BEGIN
	SET NEW.modifiedBY = USER();
	SET NEW.modifiedAt = CURRENT_DATE();
        IF OLD.`name` <> NEW.`name` THEN
            INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                            previousValue, currentValue)
            VALUES (CURRENT_DATE(), USER(), 'currency', 'name', OLD.`name`, NEW.`name`);
		END IF;
END $$

DELIMITER ;
