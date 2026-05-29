DELIMITER $$

CREATE TRIGGER beforeInsertStatus
BEFORE INSERT
ON `status`
FOR EACH ROW
BEGIN
	SET NEW.createdBy = USER();
	SET NEW.createdAt = CURRENT_DATE();
	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                        previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'status', 'status_type', 'empty', NEW.status_type);
END $$

CREATE TRIGGER beforeUpdateStatus
BEFORE UPDATE 
ON `status`
FOR EACH ROW 
BEGIN
	SET NEW.modifiedBY = USER();
	SET NEW.modifiedAt = CURRENT_DATE();
        IF OLD.status_type <> NEW.status_type THEN
            INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                            previousValue, currentValue)
            VALUES (CURRENT_DATE(), USER(), 'status', 'status_type', OLD.status_type, NEW.status_type);
		END IF;
END $$

DELIMITER ;