DELIMITER $$

-- ===================================== REPORTES =====================================

CREATE PROCEDURE getDonations(
    IN pStartDate DATE,
    IN pEndDate DATE,
    IN pIdDonor INT,
    IN pIdAssociation INT
)
BEGIN
    SELECT
        d.amount,
        c.`name`,
        u.email,
        d.createdAt,
        a.`name`,
        COUNT(1) OVER () AS total_registers,
        SUM(d.amount) AS total_amount
    FROM donation d

    INNER JOIN association a
        ON d.id_association = a.id_user

    INNER JOIN `user` u
        ON d.id_donnor = u.id_user

    INNER JOIN currency c
        ON d.id_currency = c.id_currency

    WHERE d.createdAt BETWEEN
          COALESCE(
              pStartDate,
              STR_TO_DATE(CONCAT(YEAR(CURDATE()), '-01-01'), '%Y-%m-%d')
          )
          AND COALESCE(pEndDate, CURDATE())

      AND d.id_donnor = COALESCE(pIdDonor, d.id_donnor)
      AND d.id_association = COALESCE(pIdAssociation, d.id_association)

    GROUP BY
        d.amount,
        c.`name`,
        u.email,
        d.createdAt,
        a.`name`

    ORDER BY d.amount DESC;
END$$


CREATE PROCEDURE getBlackListReport()
BEGIN
    SELECT
        ad.id_user,
        ua.email,
        ad.first_name,
        COALESCE(ad.second_name, 'None') AS second_name,
        ad.first_surname,
        ad.second_surname,
        COALESCE(r.score, 0) AS score,
        uxb.reason,
        COUNT(1) OVER () AS total_registers

    FROM user_x_black_list uxb

    INNER JOIN black_list bl
        ON bl.id_report = uxb.id_report

    INNER JOIN `user` u
        ON bl.id_user = u.id_user

    INNER JOIN adopter ad
        ON uxb.id_user = ad.id_user

    INNER JOIN `user` ua
        ON ad.id_user = ua.id_user

    LEFT JOIN rating r
        ON ad.id_user = r.id_adopter;
END$$


CREATE PROCEDURE getMatches(
    IN pIdLostPet INT,
    IN pIdFoundPet INT
)
BEGIN
    SELECT
        (
            (
                CASE
                    WHEN p1.id_size = p2.id_size THEN 1
                    ELSE 0
                END +

                CASE
                    WHEN p1.id_race = p2.id_race THEN 1
                    ELSE 0
                END +

                CASE
                    WHEN p1.id_district = p2.id_district THEN 1
                    ELSE 0
                END
            ) / 3.0
        ) * 100 AS percentage_match,

        COUNT(1) OVER () AS total_registers

    FROM pet p1
    CROSS JOIN pet p2

    WHERE p1.id_pet = pIdLostPet
      AND p2.id_pet = pIdFoundPet;
END$$


CREATE PROCEDURE getPetNecessaryTreatments(
    IN pMin INT,
    IN pMax INT
)
BEGIN
    SELECT
        p.id_pet,
        p.first_name,
        pt.`name`,
        cs.status_type,
        COALESCE(COUNT(txd.id_disease), 0) AS disease_count,
        COALESCE(COUNT(txd.id_treatment), 0) AS treatment_count,
        COUNT(*) OVER () AS total_registers

    FROM pet p

    INNER JOIN race r
        ON p.id_race = r.id_race

    INNER JOIN pet_type pt
        ON r.id_pet_type = pt.id_pet_type

    INNER JOIN pet_extra_info pei
        ON p.id_pet = pei.id_pet

    INNER JOIN current_status cs
        ON pei.id_current_status = cs.id_current_status

    INNER JOIN medic_sheet ms
        ON pei.id_pet_extra_info = ms.id_pet_extra_info

    INNER JOIN disease_x_medic_sheet dxms
        ON ms.id_medic_sheet = dxms.id_medic_sheet

    INNER JOIN disease d
        ON dxms.id_disease = d.id_disease

    INNER JOIN treatment_x_disease txd
        ON d.id_disease = txd.id_disease

    GROUP BY
        p.id_pet,
        p.first_name,
        pt.`name`,
        cs.status_type

    HAVING COALESCE(COUNT(txd.id_treatment), 0)
           BETWEEN pMin AND pMax

    ORDER BY treatment_count;
END$$


CREATE PROCEDURE getCompatibleCribHouses(
    IN pIdPetType INT
)
BEGIN
    SELECT
        cb.id_user,
        cb.`name`,
        u.email,
        cb.requires_donations,
        pt.`name`,
        s.`name`,
        COUNT(1) OVER () AS total_registers

    FROM crib_house cb

    INNER JOIN pet_type_x_crib_house ptxcb
        ON cb.id_user = ptxcb.id_crib_house

    INNER JOIN pet_type pt
        ON ptxcb.id_pet_type = pt.id_pet_type

    INNER JOIN `user` u
        ON cb.id_user = u.id_user

    INNER JOIN size_x_crib_house sxcb
        ON cb.id_user = sxcb.id_crib_house

    INNER JOIN `size` s
        ON sxcb.id_size = s.id_size

    WHERE pt.id_pet_type = COALESCE(
        pIdPetType,
        pt.id_pet_type
    )

    GROUP BY
        cb.id_user,
        cb.`name`,
        u.email,
        cb.requires_donations,
        pt.`name`,
        s.`name`

    ORDER BY cb.id_user;
END$$

DELIMITER ;