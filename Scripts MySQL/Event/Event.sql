DELIMITER $$

CREATE EVENT MATCH_FOUND_LOST_EVENT
ON SCHEDULE EVERY 2 MINUTE
DO
BEGIN
    INSERT INTO `match`
    (
        match_date,
        id_pet_lost,
        id_pet_found
    )
    SELECT
        CURRENT_DATE(),
        p.id_pet,
        q.id_pet
    FROM pet p
    INNER JOIN pet q
        ON p.id_race = q.id_race
    LEFT JOIN `match` m1
        ON m1.id_pet_lost = p.id_pet
       AND m1.id_pet_found = q.id_pet
    LEFT JOIN `match` m2
        ON m2.id_pet_lost = q.id_pet
       AND m2.id_pet_found = p.id_pet
    WHERE p.id_pet != q.id_pet
      AND p.date_lost IS NOT NULL
      AND q.date_found IS NOT NULL
      AND q.date_found > p.date_lost
      AND m1.id_match IS NULL
      AND m2.id_match IS NULL;
END$$

DELIMITER ;