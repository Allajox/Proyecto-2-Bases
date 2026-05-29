DELIMITER $$

CREATE TRIGGER beforeInsertIdentificationChip
BEFORE INSERT
ON identification_chip
FOR EACH ROW
BEGIN
	SET NEW.createdBy = USER();
	SET NEW.createdAt = CURRENT_DATE();
	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                        previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'identification_chip', 'chip_number', 'empty', NEW.chip_number);
END $$

CREATE TRIGGER beforeUpdateIdentificationChip
BEFORE UPDATE 
ON identification_chip
FOR EACH ROW 
BEGIN
	SET NEW.modifiedBY = USER();
	SET NEW.modifiedAt = CURRENT_DATE();
        IF OLD.chip_number <> NEW.chip_number THEN
            INSERT INTO `log`(changeDate, changeBy, tableName, fieldName,
                            previousValue, currentValue)
            VALUES (CURRENT_DATE(), USER(), 'identification_chip', 'chip_number', OLD.chip_number, NEW.chip_number);
		END IF;
END $$

DELIMITER ;
