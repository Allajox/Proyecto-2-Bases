DELIMITER $$

CREATE TRIGGER beforeInsertProvince
BEFORE INSERT
ON province
FOR EACH ROW
BEGIN
	SET NEW.createdBy = USER();
	SET NEW.createdAt = CURRENT_DATE();
	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                        previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'province', 'name', 'empty', NEW.`name`);
END $$

CREATE TRIGGER beforeUpdateProvince
BEFORE UPDATE 
ON province
FOR EACH ROW 
BEGIN
	SET NEW.modifiedBY = USER();
	SET NEW.modifiedAt = CURRENT_DATE();
        IF OLD.`name` <> NEW.`name` THEN
            INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                            previousValue, currentValue)
            VALUES (CURRENT_DATE(), USER(), 'province', 'name', OLD.`name`, NEW.`name`);
		END IF;
END $$

DELIMITER ;
