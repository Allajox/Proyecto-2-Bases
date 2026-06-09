DELIMITER $$

-- ======================================== STATS ========================================

CREATE PROCEDURE getPetsByTypeAndStatus(
    IN pIdType INT,
    IN pIdStatus INT,
    IN pStartDate DATE,
    IN pEndDate DATE
)
BEGIN
    SELECT
        pt.`name`,
        s.status_type,
        COUNT(p.id_pet) AS pet_count
    FROM pet_type pt

    CROSS JOIN status s

    LEFT JOIN race r
        ON pt.id_pet_type = r.id_pet_type

    LEFT JOIN pet p
        ON r.id_race = p.id_race
       AND s.id_status = p.id_status
       AND p.createdAt BETWEEN
           COALESCE(
               pStartDate,
               STR_TO_DATE(CONCAT(YEAR(CURDATE()), '-01-01'), '%Y-%m-%d')
           )
           AND COALESCE(pEndDate, CURDATE())

    WHERE pt.id_pet_type = COALESCE(pIdType, pt.id_pet_type)
      AND s.id_status = COALESCE(pIdStatus, s.id_status)

    GROUP BY
        pt.`name`,
        s.status_type

    ORDER BY
        pt.`name`,
        s.status_type;
END$$


CREATE PROCEDURE getDonationsByAssociation(
    IN pStartDate DATE,
    IN pEndDate DATE
)
BEGIN
    SELECT
        a.`name`,
        COUNT(d.id_donation) AS donation_count
    FROM association a

    LEFT JOIN donation d
        ON a.id_user = d.id_association
       AND d.createdAt BETWEEN
           COALESCE(
               pStartDate,
               STR_TO_DATE(CONCAT(YEAR(CURDATE()), '-01-01'), '%Y-%m-%d')
           )
           AND COALESCE(pEndDate, CURDATE())

    GROUP BY a.`name`

    ORDER BY a.`name`;
END$$


CREATE PROCEDURE getDonationsByCribHouse(
    IN pStartDate DATE,
    IN pEndDate DATE
)
BEGIN
    SELECT
        cb.`name`,
        COUNT(d.id_donation) AS donation_count
    FROM crib_house cb

    LEFT JOIN donation d
        ON cb.id_user = d.id_crib_house
       AND d.createdAt BETWEEN
           COALESCE(
               pStartDate,
               STR_TO_DATE(CONCAT(YEAR(CURDATE()), '-01-01'), '%Y-%m-%d')
           )
           AND COALESCE(pEndDate, CURDATE())

    GROUP BY cb.`name`

    ORDER BY cb.`name`;
END$$


CREATE PROCEDURE getAdoptedVSUnadopted(
    IN pIdType INT,
    IN pIdRace INT
)
BEGIN

    SELECT
        s.status_type,
        pt.`name`,
        r.`name`,
        COUNT(p.id_pet) AS pet_count
    FROM pet p

    INNER JOIN race r
        ON p.id_race = r.id_race

    INNER JOIN pet_type pt
        ON r.id_pet_type = pt.id_pet_type

    INNER JOIN status s
        ON p.id_status = s.id_status

    WHERE pt.id_pet_type = COALESCE(pIdType, pt.id_pet_type)
      AND r.id_race = COALESCE(pIdRace, r.id_race)
      AND s.id_status = 4

    GROUP BY
        s.status_type,
        pt.`name`,
        r.`name`

    UNION

    SELECT
        s.status_type,
        pt.`name`,
        r.`name`,
        COUNT(p.id_pet) AS pet_count
    FROM pet p

    INNER JOIN race r
        ON p.id_race = r.id_race

    INNER JOIN pet_type pt
        ON r.id_pet_type = pt.id_pet_type

    INNER JOIN status s
        ON p.id_status = s.id_status

    WHERE pt.id_pet_type = COALESCE(pIdType, pt.id_pet_type)
      AND r.id_race = COALESCE(pIdRace, r.id_race)
      AND s.id_status = 3

    GROUP BY
        s.status_type,
        pt.`name`,
        r.`name`;

END$$


CREATE PROCEDURE getUnadoptedPetsByAgeRange()
BEGIN

    SELECT
        '0-1' AS age_range,
        COUNT(p.id_pet) AS pet_count
    FROM pet p
    INNER JOIN status s
        ON p.id_status = s.id_status
    WHERE s.id_status = 3
      AND TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE()) BETWEEN 0 AND 1

    UNION

    SELECT
        '1-5',
        COUNT(p.id_pet)
    FROM pet p
    INNER JOIN status s
        ON p.id_status = s.id_status
    WHERE s.id_status = 3
      AND TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE()) BETWEEN 1 AND 5

    UNION

    SELECT
        '5-9',
        COUNT(p.id_pet)
    FROM pet p
    INNER JOIN status s
        ON p.id_status = s.id_status
    WHERE s.id_status = 3
      AND TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE()) BETWEEN 5 AND 9

    UNION

    SELECT
        '10-12',
        COUNT(p.id_pet)
    FROM pet p
    INNER JOIN status s
        ON p.id_status = s.id_status
    WHERE s.id_status = 3
      AND TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE()) BETWEEN 10 AND 12

    UNION

    SELECT
        '>12',
        COUNT(p.id_pet)
    FROM pet p
    INNER JOIN status s
        ON p.id_status = s.id_status
    WHERE s.id_status = 3
      AND TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE()) > 12;

END$$

DELIMITER ;