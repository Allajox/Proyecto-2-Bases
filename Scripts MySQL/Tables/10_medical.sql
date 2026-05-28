-- ============================================================
-- FILE 10 - MEDICAL
-- Tables: medic_sheet, disease, disease_x_medic_sheet,
--         treatment, treatment_x_disease
-- Depends on: veterinarian (05), pet_extra_info (09)
-- ============================================================

-- ============================================
-- DISEASE
-- ============================================
CREATE TABLE disease
(
    id_disease INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the disease',
    `name`     VARCHAR(100),
    createdBy  VARCHAR(20),
    createdAt  DATE,
    modifiedBy VARCHAR(20),
    modifiedAt DATE
) ENGINE = InnoDB;

ALTER TABLE disease COMMENT = 'Stores information about diseases that affect pets';

ALTER TABLE disease
    MODIFY COLUMN `name` VARCHAR(100) COMMENT 'The name of the disease',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- TREATMENT
-- ============================================
CREATE TABLE treatment
(
    id_treatment INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the treatment',
    `name`       VARCHAR(100),
    dose         VARCHAR(100),
    createdBy    VARCHAR(20),
    createdAt    DATE,
    modifiedBy   VARCHAR(20),
    modifiedAt   DATE
) ENGINE = InnoDB;

ALTER TABLE treatment COMMENT = 'Stores information about treatments for diseases';

ALTER TABLE treatment
    MODIFY COLUMN `name` VARCHAR(100) COMMENT 'The name of the treatment',
    MODIFY COLUMN dose VARCHAR(100) COMMENT 'The dose the pet must take',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- MEDIC SHEET
-- ============================================
CREATE TABLE medic_sheet
(
    id_medic_sheet          INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the training ease',
    abandonment_description VARCHAR(500),
    id_veterinarian         INT,
    id_pet_extra_info       INT,
    createdBy               VARCHAR(20),
    createdAt               DATE,
    modifiedBy              VARCHAR(20),
    modifiedAt              DATE
) ENGINE = InnoDB;

ALTER TABLE medic_sheet
    ADD CONSTRAINT fk_ms_veterinarian
    FOREIGN KEY (id_veterinarian) REFERENCES veterinarian (id_veterinarian);

ALTER TABLE medic_sheet
    ADD CONSTRAINT fk_ms_pet_extra_info
    FOREIGN KEY (id_pet_extra_info) REFERENCES pet_extra_info (id_pet_extra_info)
    ON DELETE CASCADE;

ALTER TABLE medic_sheet COMMENT = 'Stores information about the health related matters of a pet';

ALTER TABLE medic_sheet
    MODIFY COLUMN abandonment_description VARCHAR(500) COMMENT 'Describes the state in which the pet was found',
    MODIFY COLUMN id_veterinarian INT COMMENT 'Foreign key, references the veterinarian who treats the pet',
    MODIFY COLUMN id_pet_extra_info INT COMMENT 'Foreign key, references the pet extra info',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- DISEASE X MEDIC SHEET
-- ============================================
CREATE TABLE disease_x_medic_sheet
(
    id_disease     INT,
    id_medic_sheet INT,
    createdBy      VARCHAR(20),
    createdAt      DATE,
    modifiedBy     VARCHAR(20),
    modifiedAt     DATE
) ENGINE = InnoDB;

ALTER TABLE disease_x_medic_sheet
    ADD CONSTRAINT pk_disease_x_medic_sheet PRIMARY KEY (id_disease, id_medic_sheet);

ALTER TABLE disease_x_medic_sheet
    ADD CONSTRAINT fk_dxms_disease
    FOREIGN KEY (id_disease) REFERENCES disease (id_disease)
    ON DELETE CASCADE;

ALTER TABLE disease_x_medic_sheet
    ADD CONSTRAINT fk_dxms_medic_sheet
    FOREIGN KEY (id_medic_sheet) REFERENCES medic_sheet (id_medic_sheet)
    ON DELETE CASCADE;

ALTER TABLE disease_x_medic_sheet COMMENT = 'Intermediate table, stores all the diseases that a pet has';

ALTER TABLE disease_x_medic_sheet
    MODIFY COLUMN id_disease INT COMMENT 'Composite primary key. Foreign key references the disease id',
    MODIFY COLUMN id_medic_sheet INT COMMENT 'Composite primary key. Foreign key references the medic sheet id',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- TREATMENT X DISEASE
-- ============================================
CREATE TABLE treatment_x_disease
(
    id_treatment INT,
    id_disease   INT,
    createdBy    VARCHAR(20),
    createdAt    DATE,
    modifiedBy   VARCHAR(20),
    modifiedAt   DATE
) ENGINE = InnoDB;

ALTER TABLE treatment_x_disease
    ADD CONSTRAINT pk_treatment_x_disease PRIMARY KEY (id_treatment, id_disease);

ALTER TABLE treatment_x_disease
    ADD CONSTRAINT fk_txd_treatment
    FOREIGN KEY (id_treatment) REFERENCES treatment (id_treatment)
    ON DELETE CASCADE;

ALTER TABLE treatment_x_disease
    ADD CONSTRAINT fk_txd_disease
    FOREIGN KEY (id_disease) REFERENCES disease (id_disease)
    ON DELETE CASCADE;

ALTER TABLE treatment_x_disease COMMENT = 'Intermediate table, stores all treatments of a disease';

ALTER TABLE treatment_x_disease
    MODIFY COLUMN id_treatment INT COMMENT 'Composite primary key. Foreign key references the treatment id',
    MODIFY COLUMN id_disease INT COMMENT 'Composite primary key. Foreign key references the disease id',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';