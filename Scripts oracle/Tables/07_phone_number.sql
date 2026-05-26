-- ============================================================
-- FILE 07 - PHONE NUMBER (UNIFIED)
-- Table: phone_number
-- Depends on: user (02), pet (06), veterinarian (05)
-- Note: Only one FK per row will be populated depending
--       on the entity the number belongs to.
-- ============================================================

-- ============================================
-- PHONE NUMBER
-- ============================================
CREATE TABLE phone_number
(
    id_phone        INT,
    `number`        VARCHAR(20),
    id_user         INT,
    id_pet          INT,
    id_veterinarian INT,
    createdBy       VARCHAR(20),
    createdAt       DATE,
    modifiedBy      VARCHAR(20),
    modifiedAt      DATE
) ENGINE = InnoDB;

ALTER TABLE phone_number
    MODIFY id_phone INT NOT NULL,
    ADD CONSTRAINT phoneNumber_idPhone_nn CHECK (id_phone IS NOT NULL);
    
ALTER TABLE phone_number
    MODIFY `number` VARCHAR(20) NOT NULL,
    ADD CONSTRAINT phoneNumber_number_nn CHECK (`number` IS NOT NULL);

ALTER TABLE phone_number
    ADD CONSTRAINT pk_phone_number PRIMARY KEY (id_phone);

ALTER TABLE phone_number
    ADD CONSTRAINT fk_phone_user
    FOREIGN KEY (id_user) REFERENCES `user` (id_user)
    ON DELETE CASCADE;

ALTER TABLE phone_number
    ADD CONSTRAINT fk_phone_pet
    FOREIGN KEY (id_pet) REFERENCES pet (id_pet)
    ON DELETE CASCADE;

ALTER TABLE phone_number
    ADD CONSTRAINT fk_phone_veterinarian
    FOREIGN KEY (id_veterinarian) REFERENCES veterinarian (id_veterinarian)
    ON DELETE CASCADE;

ALTER TABLE phone_number
    ADD CONSTRAINT chk_phone_single_owner
    CHECK (
        (CASE WHEN id_user         IS NOT NULL THEN 1 ELSE 0 END +
         CASE WHEN id_pet          IS NOT NULL THEN 1 ELSE 0 END +
         CASE WHEN id_veterinarian IS NOT NULL THEN 1 ELSE 0 END) = 1
    );

ALTER TABLE phone_number COMMENT = 'Stores information about phone numbers registered in the system';

ALTER TABLE phone_number
    MODIFY COLUMN id_phone INT COMMENT 'Primary key, identifier for the phone number',
    MODIFY COLUMN `number` VARCHAR(20) COMMENT 'The phone number',
    MODIFY COLUMN id_user INT COMMENT 'Foreign key, references the user associated with the number. Can be null',
    MODIFY COLUMN id_pet INT COMMENT 'Foreign key, references the pet associated with the number. Can be null',
    MODIFY COLUMN id_veterinarian INT COMMENT 'Foreign key, references the veterinarian associated with the number. Can be null',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';