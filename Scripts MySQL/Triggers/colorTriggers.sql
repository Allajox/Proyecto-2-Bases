DELIMITER $$

CREATE TRIGGER beforeInsertColor
BEFORE INSERT
ON color
FOR EACH ROW
BEGIN
	SET NEW.createdBy = USER();
	SET NEW.createdAt = CURRENT_DATE();
	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                        previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'Color', 'name', 'empty', NEW.`name`);
END $$

CREATE TRIGGER beforeUpdateColor
BEFORE UPDATE ON color
FOR EACH ROW 
BEGIN
	SET NEW.modifiedBY = USER();
	SET NEW.modifiedAt = CURRENT_DATE();
        IF OLD.`name` <> NEW.`name` THEN
            INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                            previousValue, currentValue)
            VALUES (CURRENT_DATE(), USER(), 'Color', 'name', OLD.`name`, NEW.`name`);
		END IF;
END $$

DELIMITER ;