DELIMITER $$

-- ===================================== INSERT =====================================

CREATE PROCEDURE insertDonation(
    IN pAmount DECIMAL(18,2),
    IN pIdAssociation INT,
    IN pIdCurrency INT,
    IN pIdCribHouse INT,
    IN pIdDonnor INT
)
BEGIN
    INSERT INTO donation (
        amount,
        id_association,
        id_currency,
        id_crib_house,
        id_donnor
    )
    VALUES (
        pAmount,
        pIdAssociation,
        pIdCurrency,
        pIdCribHouse,
        pIdDonnor
    );

    COMMIT;
END$$


-- ====================================== GET =======================================

CREATE PROCEDURE getDonation()
BEGIN
    SELECT *
    FROM donation;
END$$


CREATE PROCEDURE getDonationById(
    IN pIdDonation INT
)
BEGIN
    SELECT d.amount
    FROM donation d
    WHERE d.id_donation = pIdDonation;
END$$


CREATE PROCEDURE getRecipients()
BEGIN
    SELECT
        a.id_user AS ID,
        a.`name` AS NOMBRE,
        'Asociación' AS TIPO
    FROM association a

    UNION ALL

    SELECT
        ch.id_user AS ID,
        ch.`name` AS NOMBRE,
        'Casa Cuna' AS TIPO
    FROM crib_house ch
    WHERE ch.requires_donations = 1

    ORDER BY TIPO, NOMBRE;
END$$


CREATE FUNCTION getLastDonationId()
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN LAST_INSERT_ID();
END$$


CREATE PROCEDURE getDonationByUser(
    IN pIdUser INT
)
BEGIN
    SELECT *
    FROM donation d
    WHERE d.id_donnor = pIdUser;
END$$

DELIMITER ;