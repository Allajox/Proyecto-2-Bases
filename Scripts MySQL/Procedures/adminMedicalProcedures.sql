DELIMITER $$

-- ========================================
-- INSERT
-- ========================================

CREATE FUNCTION insertDisease(
    pName VARCHAR(255)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_id INT;

    INSERT INTO disease (name)
    VALUES (pName);

    COMMIT;

    SET v_id = LAST_INSERT_ID();

    RETURN v_id;
END;

CREATE PROCEDURE insertMedicSheet(
    IN pAbandonmentDescription VARCHAR(500),
    IN pIdVeterinarian INT,
    IN pIdPetExtraInfo INT
)
BEGIN
    INSERT INTO medic_sheet (
        abandonment_description,
        id_veterinarian,
        id_pet_extra_info
    )
    VALUES (
        pAbandonmentDescription,
        pIdVeterinarian,
        pIdPetExtraInfo
    );

    COMMIT;
END;

CREATE FUNCTION insertTreatment(
    pName VARCHAR(255),
    pDose VARCHAR(255)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_id INT;

    INSERT INTO treatment (
        name,
        dose
    )
    VALUES (
        pName,
        pDose
    );

    COMMIT;

    SET v_id = LAST_INSERT_ID();

    RETURN v_id;
END;

CREATE FUNCTION insertMedicSheetF(
    pAbandonmentDesc VARCHAR(500),
    pIdVeterinarian INT,
    pIdPetExtraInfo INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_id INT;

    INSERT INTO medic_sheet (
        abandonment_description,
        id_veterinarian,
        id_pet_extra_info
    )
    VALUES (
        pAbandonmentDesc,
        NULLIF(pIdVeterinarian, 0),
        pIdPetExtraInfo
    );

    COMMIT;

    SET v_id = LAST_INSERT_ID();

    RETURN v_id;
END;

CREATE FUNCTION insertVeterinarian(
    p_first_name VARCHAR(100),
    p_second_name VARCHAR(100),
    p_first_surname VARCHAR(100),
    p_second_surname VARCHAR(100),
    p_clinic_name VARCHAR(255)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_id INT;

    INSERT INTO veterinarian (
        first_name,
        second_name,
        first_surname,
        second_surname,
        clinic_name
    )
    VALUES (
        p_first_name,
        p_second_name,
        p_first_surname,
        p_second_surname,
        p_clinic_name
    );

    COMMIT;

    SET v_id = LAST_INSERT_ID();

    RETURN v_id;
END;

CREATE PROCEDURE insertDiseaseXMedicSheet(
    IN pIdDisease INT,
    IN pIdMedicSheet INT
)
BEGIN
    INSERT INTO disease_x_medic_sheet (
        id_disease,
        id_medic_sheet
    )
    VALUES (
        pIdDisease,
        pIdMedicSheet
    );

    COMMIT;
END;

CREATE PROCEDURE insertTreatmentXDisease(
    IN pIdTreatment INT,
    IN pIdDisease INT
)
BEGIN
    INSERT INTO treatment_x_disease (
        id_treatment,
        id_disease
    )
    VALUES (
        pIdTreatment,
        pIdDisease
    );

    COMMIT;
END;


-- ========================================
-- UPDATE
-- ========================================

CREATE PROCEDURE updateTreatment(
    IN pIdTreatment INT,
    IN pName VARCHAR(255),
    IN pDose VARCHAR(255)
)
BEGIN
    UPDATE treatment
    SET
        name = pName,
        dose = pDose
    WHERE id_treatment = pIdTreatment;

    COMMIT;
END;

CREATE PROCEDURE updateDisease(
    IN pIdDisease INT,
    IN pName VARCHAR(255)
)
BEGIN
    UPDATE disease
    SET name = pName
    WHERE id_disease = pIdDisease;

    COMMIT;
END;

CREATE PROCEDURE updateMedicSheet(
    IN pIdMedicSheet INT,
    IN pAbandonmentDescription VARCHAR(500),
    IN pIdVeterinarian INT,
    IN pIdPetExtraInfo INT
)
BEGIN
    UPDATE medic_sheet
    SET abandonment_description = pAbandonmentDescription
    WHERE id_medic_sheet = pIdMedicSheet
      AND id_veterinarian = pIdVeterinarian
      AND id_pet_extra_info = pIdPetExtraInfo;

    COMMIT;
END;

-- ========================================
-- GET
-- ========================================

CREATE PROCEDURE getMedicSheetByPetId(
    IN p_idPet INT
)
BEGIN
    SELECT *
    FROM medic_sheet a
    INNER JOIN pet_extra_info b
        ON a.id_pet_extra_info = b.id_pet_extra_info
    INNER JOIN pet c
        ON c.id_pet = b.id_pet
    WHERE c.id_pet = p_idPet;
END;

CREATE PROCEDURE getDiseasesAndTreatments(
    IN p_idPet INT
)
BEGIN
    SELECT
        e.name,
        g.name,
        g.dose
    FROM medic_sheet a
    INNER JOIN pet_extra_info b
        ON a.id_pet_extra_info = b.id_pet_extra_info
    INNER JOIN pet c
        ON c.id_pet = b.id_pet
    INNER JOIN disease_x_medic_sheet d
        ON a.id_medic_sheet = d.id_medic_sheet
    INNER JOIN disease e
        ON d.id_disease = e.id_disease
    INNER JOIN treatment_x_disease f
        ON f.id_disease = e.id_disease
    INNER JOIN treatment g
        ON f.id_treatment = g.id_treatment
    WHERE c.id_pet = p_idPet;
END;

CREATE PROCEDURE getTreatment()
BEGIN
    SELECT *
    FROM treatment;
END;

CREATE PROCEDURE getTreatmentById(
    IN pIdTreatment INT
)
BEGIN
    SELECT t.name
    FROM treatment t
    WHERE t.id_treatment = pIdTreatment;
END;

CREATE PROCEDURE getDisease()
BEGIN
    SELECT *
    FROM disease;
END;

CREATE PROCEDURE getDiseaseById(
    IN pIdDisease INT
)
BEGIN
    SELECT d.name
    FROM disease d
    WHERE d.id_disease = pIdDisease;
END;

CREATE PROCEDURE getMedicSheet()
BEGIN
    SELECT *
    FROM medic_sheet;
END;

CREATE PROCEDURE getMedicSheetById(
    IN pIdMedicSheet INT
)
BEGIN
    SELECT *
    FROM medic_sheet
    WHERE id_medic_sheet = pIdMedicSheet;
END;

CREATE PROCEDURE getDiseaseXMedicSheet()
BEGIN
    SELECT *
    FROM disease_x_medic_sheet;
END;

CREATE PROCEDURE getTreatmentXDisease()
BEGIN
    SELECT *
    FROM treatment_x_disease;
END;

CREATE PROCEDURE getDiseasesFromMedicSheet(
    IN pIdMedicSheet INT
)
BEGIN
    SELECT d.name
    FROM disease d
    INNER JOIN disease_x_medic_sheet dxms
        ON d.id_disease = dxms.id_disease
    WHERE dxms.id_medic_sheet = pIdMedicSheet;
END;

CREATE PROCEDURE getTreatmentsForDisease(
    IN pIdDisease INT
)
BEGIN
    SELECT t.name
    FROM treatment t
    INNER JOIN treatment_x_disease txd
        ON t.id_treatment = txd.id_treatment
    WHERE txd.id_disease = pIdDisease;
END;

DELIMITER ;