DELIMITER $$

CREATE TRIGGER beforeInsertRating
BEFORE INSERT
ON rating
FOR EACH ROW
BEGIN
	SET NEW.createdBy = USER();
	SET NEW.createdAt = CURRENT_DATE();
	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                        previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'rating', 'name', 'empty', NEW.score);
END $$

CREATE TRIGGER beforeUpdateRating
BEFORE UPDATE 
ON rating
FOR EACH ROW 
BEGIN
	SET NEW.modifiedBY = USER();
	SET NEW.modifiedAt = CURRENT_DATE();
        IF OLD.score <> NEW.score THEN
            INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                            previousValue, currentValue)
            VALUES (CURRENT_DATE(), USER(), 'rating', 'name', OLD.score, NEW.score);
		END IF;
END $$

DELIMITER ;
