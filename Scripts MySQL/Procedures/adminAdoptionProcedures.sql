DELIMITER $$

-- ===============================================================
-- INSERT
-- ===============================================================

CREATE PROCEDURE insertAdoptionForm(
    IN pNotes VARCHAR(255),
    IN pAdoptionDate DATE,
    IN pReference VARCHAR(255),
    IN pIdAdopter INT,
    IN pIdPet INT
)
BEGIN
    INSERT INTO adoption_form (
        notes,
        adoption_date,
        `reference`,
        id_adopter,
        id_pet
    )
    VALUES (
        pNotes,
        pAdoptionDate,
        pReference,
        pIdAdopter,
        pIdPet
    );
END $$

CREATE PROCEDURE insertPhoto(
    IN pIdPhoto INT,
    IN pDate DATE,
    IN pPhotoDir VARCHAR(255),
    IN pIdAdopter INT
)
BEGIN
    INSERT INTO photo (
        id_photo,
        `date`,
        photo_dir,
        id_user
    )
    VALUES (
        pIdPhoto,
        pDate,
        pPhotoDir,
        pIdAdopter
    );
END $$

CREATE PROCEDURE insertRating(
    IN pIdRating INT,
    IN pScore INT,
    IN pIdUser INT,
    IN pIdAdopter INT
)
BEGIN
    INSERT INTO rating (
        score,
        id_user,
        id_adopter
    )
    VALUES (
        pScore,
        pIdUser,
        pIdAdopter
    );
END $$

CREATE PROCEDURE insertMatch(
    IN pMatchDate DATE,
    IN pIdPetLost INT,
    IN pIdPetFound INT
)
BEGIN
    INSERT INTO `match` (
        match_date,
        id_pet_lost,
        id_pet_found
    )
    VALUES (
        pMatchDate,
        pIdPetLost,
        pIdPetFound
    );
END $$

CREATE PROCEDURE insertParameters(
    IN pIdParameter INT,
    IN pValue VARCHAR(255),
    IN pIdMatch INT,
    IN pIdValueType INT
)
BEGIN
    INSERT INTO parameters (
        `value`,
        id_match,
        id_value_type
    )
    VALUES (
        pValue,
        pIdMatch,
        pIdValueType
    );
END $$

-- ===============================================================
-- UPDATE
-- ===============================================================

CREATE PROCEDURE updateAdoptionForm(
    IN pIdAdoption INT,
    IN pNotes VARCHAR(255),
    IN pAdoptionDate DATE,
    IN pReference VARCHAR(255)
)
BEGIN
    UPDATE adoption_form
    SET notes = pNotes,
        adoption_date = pAdoptionDate,
        `reference` = pReference
    WHERE id_adoption = pIdAdoption;
END $$

CREATE PROCEDURE updatePhoto(
    IN pIdPhoto INT,
    IN pDate DATE,
    IN pPhotoDir VARCHAR(255),
    IN pIdAdopter INT
)
BEGIN
    UPDATE photo
    SET `date` = pDate,
        photo_dir = pPhotoDir
    WHERE id_photo = pIdPhoto
      AND id_user = pIdAdopter;
END $$

CREATE PROCEDURE updateRating(
    IN pIdRating INT,
    IN pScore INT,
    IN pIdUser INT,
    IN pIdAdopter INT
)
BEGIN
    UPDATE rating
    SET score = pScore
    WHERE id_rating = pIdRating
      AND id_user = pIdUser
      AND id_adopter = pIdAdopter;
END $$

CREATE PROCEDURE updateMatch(
    IN pIdMatch INT,
    IN pMatchDate DATE
)
BEGIN
    UPDATE `match`
    SET match_date = pMatchDate
    WHERE id_match = pIdMatch;
END $$

CREATE PROCEDURE updateParameters(
    IN pIdParameter INT,
    IN pValue VARCHAR(255),
    IN pIdMatch INT,
    IN pIdValueType INT
)
BEGIN
    UPDATE parameters
    SET `value` = pValue,
        id_match = pIdMatch,
        id_value_type = pIdValueType
    WHERE id_parameter = pIdParameter;
END $$

-- ===============================================================
-- GET
-- ===============================================================

CREATE PROCEDURE getAdoptionForm()
BEGIN
    SELECT af.id_adoption,
           af.notes,
           af.adoption_date,
           af.`reference`,
           af.id_adopter,
           af.id_pet
    FROM adoption_form af
    ORDER BY af.adoption_date DESC;
END $$

CREATE PROCEDURE getAdoptionFormById(
    IN pIdAdoption INT
)
BEGIN
    SELECT af.id_adoption,
           af.notes,
           af.adoption_date,
           af.`reference`,
           af.id_adopter,
           af.id_pet
    FROM adoption_form af
    WHERE af.id_adoption = pIdAdoption;
END $$

CREATE PROCEDURE getAdoptionsByPet(
    IN pIdPet INT
)
BEGIN
    SELECT af.id_adoption,
           af.notes,
           af.adoption_date,
           af.`reference`,
           af.id_adopter,
           af.id_pet
    FROM adoption_form af
    WHERE af.id_pet = pIdPet
    ORDER BY af.adoption_date DESC;
END $$

CREATE PROCEDURE getAdoptionsByAdopter(
    IN pIdAdopter INT
)
BEGIN
    SELECT af.id_adoption,
           af.notes,
           af.adoption_date,
           af.`reference`,
           af.id_adopter,
           af.id_pet
    FROM adoption_form af
    WHERE af.id_adopter = pIdAdopter
    ORDER BY af.adoption_date DESC;
END $$

CREATE PROCEDURE getPhoto()
BEGIN
    SELECT * FROM photo;
END $$

CREATE PROCEDURE getRating()
BEGIN
    SELECT * FROM rating;
END $$

CREATE PROCEDURE getMatch()
BEGIN
    SELECT * FROM `match`;
END $$

CREATE PROCEDURE getParameters()
BEGIN
    SELECT * FROM parameters;
END $$

CREATE PROCEDURE getRatingByUserAndAdopter(
    IN pIdUser INT,
    IN pIdAdopter INT
)
BEGIN
    SELECT *
    FROM rating
    WHERE id_user = pIdUser
      AND id_adopter = pIdAdopter;
END $$

-- ===============================================================
-- DELETE
-- ===============================================================

CREATE PROCEDURE deleteAdoptionForm(
    IN pIdAdoption INT
)
BEGIN
    DELETE FROM adoption_form
    WHERE id_adoption = pIdAdoption;
END $$

CREATE PROCEDURE deletePhoto(
    IN pIdPhoto INT
)
BEGIN
    DELETE FROM photo
    WHERE id_photo = pIdPhoto;
END $$

CREATE PROCEDURE deleteRating(
    IN pIdRating INT
)
BEGIN
    DELETE FROM rating
    WHERE id_rating = pIdRating;
END $$

DELIMITER ;