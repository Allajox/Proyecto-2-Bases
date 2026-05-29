DELIMITER $$

CREATE TRIGGER beforeInsertTrainingEase
BEFORE INSERT
ON training_ease
FOR EACH ROW
BEGIN
	SET NEW.createdBy = USER();
	SET NEW.createdAt = CURRENT_DATE();
	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                        previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'training_ease', 'name', 'empty', NEW.`name`);
END $$

CREATE TRIGGER beforeUpdateTrainingEase
BEFORE UPDATE 
ON training_ease
FOR EACH ROW 
BEGIN
	SET NEW.modifiedBY = USER();
	SET NEW.modifiedAt = CURRENT_DATE();
        IF OLD.`name` <> NEW.`name` THEN
            INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                            previousValue, currentValue)
            VALUES (CURRENT_DATE(), USER(), 'training_ease', 'name', OLD.`name`, NEW.`name`);
		END IF;
END $$

DELIMITER ;
