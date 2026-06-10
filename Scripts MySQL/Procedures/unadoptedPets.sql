DELIMITER $$

CREATE PROCEDURE unadoptedPets()
BEGIN

    SELECT
        p.createdAt,
        s.id_status
    FROM pet p

    INNER JOIN status s
        ON p.id_status = s.id_status

    -- unadopted pets registered in the last 2 months
    WHERE p.createdAt BETWEEN DATE_SUB(NOW(), INTERVAL 60 DAY)
                          AND NOW()
      AND s.id_status = 1

    ORDER BY p.createdAt;

END$$

DELIMITER ;