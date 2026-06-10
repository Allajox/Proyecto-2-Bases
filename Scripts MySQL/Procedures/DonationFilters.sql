DELIMITER $$

CREATE PROCEDURE getDonationFilters(
    IN pAmount DECIMAL(18,2),
    IN pIdAssociation INT,
    IN pIdCurrency INT,
    IN pIdUser INT,
    IN pCreatedAt DATETIME,
    IN pStartDate DATETIME,
    IN pEndDate DATETIME
)
BEGIN
    SELECT
        d.amount,
        d.id_association,
        d.id_currency,
        u.id_user,
        d.createdAt
    FROM donation d

    INNER JOIN association a
        ON d.id_association = a.id_user

    INNER JOIN donation_x_user dxu
        ON d.id_donation = dxu.id_donation

    INNER JOIN user u
        ON dxu.id_user = u.id_user

    WHERE d.amount = IFNULL(pAmount, d.amount)
      AND d.id_currency = IFNULL(pIdCurrency, d.id_currency)
      AND d.id_association = IFNULL(pIdAssociation, d.id_association)
      AND u.id_user = IFNULL(pIdUser, u.id_user)
      AND d.createdAt BETWEEN IFNULL(pStartDate, d.createdAt)
                          AND IFNULL(pEndDate, d.createdAt)

    ORDER BY d.createdAt;
END$$

DELIMITER ;