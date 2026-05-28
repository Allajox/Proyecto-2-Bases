-- ============================================================
-- FILE 05 - VETERINARIAN
-- Tables: veterinarian
-- No dependencies on other custom tables
-- ============================================================

-- ============================================
-- VETERINARIAN
-- ============================================
CREATE TABLE veterinarian
(
    id_veterinarian INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the veterinarian',
    first_name      VARCHAR(50),
    second_name     VARCHAR(50),
    first_surname   VARCHAR(50),
    second_surname  VARCHAR(50),
    clinic_name     VARCHAR(100),
    createdBy       VARCHAR(20),
    createdAt       DATE,
    modifiedBy      VARCHAR(20),
    modifiedAt      DATE
) ENGINE = InnoDB;

ALTER TABLE veterinarian
    MODIFY first_name VARCHAR(50) NOT NULL,
    ADD CONSTRAINT veterinarian_firstName_nn CHECK (first_name IS NOT NULL);

ALTER TABLE veterinarian
    MODIFY first_surname VARCHAR(50) NOT NULL,
    ADD CONSTRAINT veterinarian_firstSurname_nn CHECK (first_surname IS NOT NULL);

ALTER TABLE veterinarian
    MODIFY clinic_name VARCHAR(100) NOT NULL,
    ADD CONSTRAINT veterinarian_clinicName_nn CHECK (clinic_name IS NOT NULL);

ALTER TABLE veterinarian COMMENT = 'Stores veterinarian information';

ALTER TABLE veterinarian
    MODIFY COLUMN first_name VARCHAR(50) COMMENT 'First name of the veterinarian',
    MODIFY COLUMN second_name VARCHAR(50) COMMENT 'Second name of the veterinarian',
    MODIFY COLUMN first_surname VARCHAR(50) COMMENT 'Paternal surname of the veterinarian',
    MODIFY COLUMN second_surname VARCHAR(50) COMMENT 'Maternal surname of the veterinarian',
    MODIFY COLUMN clinic_name VARCHAR(100) COMMENT 'Name of the clinic',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';