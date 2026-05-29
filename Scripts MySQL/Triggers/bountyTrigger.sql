DELIMITER $$

CREATE TRIGGER beforeInsertBounty
BEFORE INSERT
ON bounty
FOR EACH ROW
BEGIN
	SET NEW.createdBY = USER();
	SET NEW.createdAt = CURRENT_DATE();
        
	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName, previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'Bounty', 'amount', 'empty', NEW.amount);

	INSERT INTO `log`(changeDate, changeBy, tableName, fieldName, previousValue, currentValue)
	VALUES (CURRENT_DATE(), USER(), 'Bounty', 'id_currency', 'empty', NEW.id_currency);
END $$

CREATE TRIGGER beforeUpdateBounty
BEFORE UPDATE
ON bounty
FOR EACH ROW
BEGIN
	SET NEW.modifiedBy = USER();
	SET NEW.modifiedAt = CURRENT_DATE();
	IF OLD.amount <> NEW.amount THEN
		INSERT INTO `log`(changeDate, changeBy, tableName, fieldName, previousValue, currentValue)
		VALUES (CURRENT_DATE(), USER(), 'Bounty', 'amount', OLD.amount, NEW.amount);
	END IF;

	IF OLD.id_currency <> NEW.id_currency THEN
		INSERT INTO `log`(changeDate, changeBy, tableName, fieldName, previousValue, currentValue)
		VALUES (CURRENT_DATE(), USER(), 'Bounty', 'id_currency', OLD.id_currency, NEW.id_currency);
	END IF;
END $$;

DELIMITER ;