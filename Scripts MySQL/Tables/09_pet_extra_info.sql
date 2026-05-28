-- ============================================================
-- FILE 09 - PET EXTRA INFO & RELATED
-- Tables: current_status, energy_level, training_ease,
--         pet_extra_info, bounty
-- Depends on: pet (06), currency (01)
-- ============================================================

-- ============================================
-- CURRENT STATUS
-- ============================================
CREATE TABLE current_status
(
    id_current_status INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the current health status',
    status_type       VARCHAR(30),
    createdBy         VARCHAR(20),
    createdAt         DATE,
    modifiedBy        VARCHAR(20),
    modifiedAt        DATE
) ENGINE = InnoDB;

ALTER TABLE current_status COMMENT = 'Stores information about health statuses for pets';

ALTER TABLE current_status
    MODIFY COLUMN status_type VARCHAR(30) COMMENT 'The name of the status',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- ENERGY LEVEL
-- ============================================
CREATE TABLE energy_level
(
    id_energy_level INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the energy level',
    `name`          VARCHAR(50),
    createdBy       VARCHAR(20),
    createdAt       DATE,
    modifiedBy      VARCHAR(20),
    modifiedAt      DATE
) ENGINE = InnoDB;

ALTER TABLE energy_level COMMENT = 'Stores information the energy levels of pets';

ALTER TABLE energy_level
    MODIFY COLUMN `name` VARCHAR(50) COMMENT 'The name of the energy level',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- TRAINING EASE
-- ============================================
CREATE TABLE training_ease
(
    id_training_ease INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the training ease',
    `name`           VARCHAR(50),
    createdBy        VARCHAR(20),
    createdAt        DATE,
    modifiedBy       VARCHAR(20),
    modifiedAt       DATE
) ENGINE = InnoDB;

ALTER TABLE training_ease COMMENT = 'Stores information about how easy it is to train a pet';

ALTER TABLE training_ease
    MODIFY COLUMN `name` VARCHAR(50) COMMENT 'The name of the training ease',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- PET EXTRA INFO
-- ============================================
CREATE TABLE pet_extra_info
(
    id_pet_extra_info INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the pet extra info',
    before_picture    VARCHAR(200),
    after_picture     VARCHAR(200),
    id_pet            INT,
    id_current_status INT,
    id_energy_level   INT,
    id_training_ease  INT,
    createdBy         VARCHAR(20),
    createdAt         DATE,
    modifiedBy        VARCHAR(20),
    modifiedAt        DATE
) ENGINE = InnoDB;

ALTER TABLE pet_extra_info
    ADD CONSTRAINT fk_pei_pet
    FOREIGN KEY (id_pet) REFERENCES pet (id_pet)
    ON DELETE CASCADE;
    
ALTER TABLE pet_extra_info
    ADD CONSTRAINT fk_pei_currentStatus
    FOREIGN KEY (id_current_status) REFERENCES current_status (id_current_status);
    
ALTER TABLE pet_extra_info
    ADD CONSTRAINT fk_pei_energyLevel
    FOREIGN KEY (id_energy_level) REFERENCES energy_level (id_energy_level);
    
ALTER TABLE pet_extra_info
    ADD CONSTRAINT fk_pei_trainingEase
    FOREIGN KEY (id_training_ease) REFERENCES training_ease (id_training_ease);

ALTER TABLE pet_extra_info COMMENT = 'Stores all the extra information of the pet';

ALTER TABLE pet_extra_info
    MODIFY COLUMN before_picture VARCHAR(200) COMMENT 'Path to the picture before the pet was rescued',
    MODIFY COLUMN after_picture VARCHAR(200) COMMENT 'Path to the picture after the pet was rescued',
    MODIFY COLUMN id_pet INT COMMENT 'Foreign key, references the associated pet',
    MODIFY COLUMN id_current_status INT COMMENT 'Foreign key, references the health status of the pet',
    MODIFY COLUMN id_energy_level INT COMMENT 'Foreign key, references the energy level of the pet',
    MODIFY COLUMN id_training_ease INT COMMENT 'Foreign key, references the training ease of the pet',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- BOUNTY
-- ============================================
CREATE TABLE bounty
(
    id_bounty         INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the bounty',
    amount            DECIMAL(12,2),
    id_pet_extra_info INT,
    id_currency       INT,
    createdBy         VARCHAR(20),
    createdAt         DATE,
    modifiedBy        VARCHAR(20),
    modifiedAt        DATE
) ENGINE = InnoDB;

ALTER TABLE bounty
    ADD CONSTRAINT fk_bounty_pet_extra_info
    FOREIGN KEY (id_pet_extra_info) REFERENCES pet_extra_info (id_pet_extra_info)
    ON DELETE CASCADE;

ALTER TABLE bounty
    ADD CONSTRAINT fk_bounty_currency
    FOREIGN KEY (id_currency) REFERENCES currency (id_currency)
    ON DELETE CASCADE;
    
ALTER TABLE bounty COMMENT = 'Stores information about a bounty put on a lost pet';

ALTER TABLE bounty
    MODIFY COLUMN amount DECIMAL(12,2) COMMENT 'The amount of the bounty',
    MODIFY COLUMN id_pet_extra_info INT COMMENT 'Foreign key, references the associated pet_extra_info',
    MODIFY COLUMN id_currency INT COMMENT 'Foreign key, references the currency of the bounty',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';