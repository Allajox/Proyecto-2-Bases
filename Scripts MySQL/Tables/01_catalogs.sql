-- ============================================================
-- FILE 01 - CATALOGS
-- Tables: currency, province, canton, district,
--         pet_type, race, status, color, value_type, size, size_x_crib_house
-- ============================================================

-- ============================================
-- CURRENCY
-- ============================================
CREATE TABLE currency
(
    id_currency 	INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the currency',
    `name`   VARCHAR(20),
    acronym     	VARCHAR(5),
    createdBy  		VARCHAR(20),
    createdAt  		DATE,
    modifiedBy 		VARCHAR(20),
    modifiedAt 		DATE
) ENGINE = InnoDB;

ALTER TABLE currency 
    MODIFY `name` VARCHAR(20) NOT NULL,
    ADD CONSTRAINT currency_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE currency 
    MODIFY acronym VARCHAR(5) NOT NULL,
    ADD CONSTRAINT currency_acronym_nn CHECK (acronym IS NOT NULL);
    
ALTER TABLE currency COMMENT = 'Stores currency types for donations';

ALTER TABLE currency
    MODIFY COLUMN `name` VARCHAR(20) COMMENT 'Full name of the currency',
    MODIFY COLUMN acronym VARCHAR(5) COMMENT 'Standard 3 letter acronym for the currency (USD, EUR, CRC)',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- PROVINCE
-- ============================================
CREATE TABLE province
(
    id_province   INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the province',
    `name` VARCHAR(50),
    createdBy     VARCHAR(20),
    createdAt     DATE,
    modifiedBy    VARCHAR(20),
    modifiedAt    DATE
) ENGINE = InnoDB;

ALTER TABLE province 
    MODIFY `name` VARCHAR(50) NOT NULL,
    ADD CONSTRAINT province_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE province COMMENT = 'Stores provinces. Each country contains multiple provinces';

ALTER TABLE province
    MODIFY COLUMN `name` VARCHAR(50) COMMENT 'Official name of the province',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- CANTON
-- ============================================
CREATE TABLE canton
(
    id_canton   INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the canton',
    `name` VARCHAR(50),
    id_province INT,
    createdBy   VARCHAR(20),
    createdAt   DATE,
    modifiedBy  VARCHAR(20),
    modifiedAt  DATE
) ENGINE = InnoDB;
    
ALTER TABLE canton 
    MODIFY `name` VARCHAR(50) NOT NULL,
    ADD CONSTRAINT canton_name_nn CHECK (`name` IS NOT NULL);
    
ALTER TABLE canton 
    MODIFY id_province INT NOT NULL,
    ADD CONSTRAINT canton_idProvince_nn CHECK (id_province IS NOT NULL);

ALTER TABLE canton
    ADD CONSTRAINT fk_canton_province
    FOREIGN KEY (id_province) REFERENCES province (id_province)
    ON DELETE CASCADE;

ALTER TABLE canton COMMENT = 'Stores the canton. Each province contains multiple cantons';

ALTER TABLE canton
    MODIFY COLUMN `name` VARCHAR(50) COMMENT 'Official name of the canton',
    MODIFY COLUMN id_province INT COMMENT 'Foreign key, references the province that contains this canton',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- DISTRICT
-- ============================================
CREATE TABLE district
(
    id_district   INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the district',
    `name`		  VARCHAR(50),
    id_canton     INT,
    createdBy     VARCHAR(20),
    createdAt     DATE,
    modifiedBy    VARCHAR(20),
    modifiedAt    DATE
) ENGINE = InnoDB;

ALTER TABLE district
    MODIFY `name` VARCHAR(50) NOT NULL,
    ADD CONSTRAINT district_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE district
    MODIFY id_canton INT NOT NULL,
    ADD CONSTRAINT district_idCanton_nn CHECK (id_canton IS NOT NULL);

ALTER TABLE district
    ADD CONSTRAINT fk_district_canton
    FOREIGN KEY (id_canton) REFERENCES canton (id_canton)
    ON DELETE CASCADE;

ALTER TABLE district COMMENT = 'Stores districts. Each canton has multiple districts';

ALTER TABLE district
    MODIFY COLUMN `name` VARCHAR(50) COMMENT 'Official name of the district',
    MODIFY COLUMN id_canton INT COMMENT 'Foreign key, references the canton that contains this district',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- PET TYPE
-- ============================================
CREATE TABLE pet_type
(
    id_pet_type   INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the pet type',
    `name` 		  VARCHAR(50),
    createdBy     VARCHAR(20),
    createdAt     DATE,
    modifiedBy    VARCHAR(20),
    modifiedAt    DATE
) ENGINE = InnoDB;

ALTER TABLE pet_type 
    MODIFY `name` VARCHAR(50) NOT NULL,
    ADD CONSTRAINT petType_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE pet_type COMMENT = 'Stores species of pets';

ALTER TABLE pet_type
    MODIFY COLUMN `name` VARCHAR(50) COMMENT 'Name of the pet category',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- RACE
-- ============================================
CREATE TABLE race
(
    id_race     INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the breed',
    `name`   VARCHAR(50),
    id_pet_type INT,
    createdBy   VARCHAR(20),
    createdAt   DATE,
    modifiedBy  VARCHAR(20),
    modifiedAt  DATE
) ENGINE = InnoDB;
    
ALTER TABLE race 
    MODIFY `name` VARCHAR(50) NOT NULL,
    ADD CONSTRAINT race_name_nn CHECK (`name` IS NOT NULL);
    
ALTER TABLE race 
    MODIFY id_pet_type INT NOT NULL,
    ADD CONSTRAINT race_idPetType_nn CHECK (id_pet_type IS NOT NULL);

ALTER TABLE race
    ADD CONSTRAINT fk_race_pet_type
    FOREIGN KEY (id_pet_type) REFERENCES pet_type (id_pet_type)
    ON DELETE CASCADE;

ALTER TABLE race COMMENT = 'Specific breed within a pet type';

ALTER TABLE race 
    MODIFY COLUMN `name` VARCHAR(50) COMMENT 'Name of the breed',
    MODIFY COLUMN id_pet_type INT COMMENT 'Foreign key, references the pet type this breed belongs to',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- STATUS
-- ============================================
CREATE TABLE `status`
(
    id_status   INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the status',
    status_type VARCHAR(30),
    createdBy   VARCHAR(20),
    createdAt   DATE,
    modifiedBy  VARCHAR(20),
    modifiedAt  DATE
) ENGINE = InnoDB;
    
ALTER TABLE `status` 
    MODIFY status_type VARCHAR(30) NOT NULL,
    ADD CONSTRAINT status_statusType_nn CHECK (status_type IS NOT NULL);

ALTER TABLE `status` COMMENT = 'Stores statuses for pets';

ALTER TABLE `status` 
    MODIFY COLUMN status_type VARCHAR(30) COMMENT 'Name of the status (Adopted, Not adopted, Lost, Found)',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- COLOR
-- ============================================
CREATE TABLE color
(
    id_color   INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the color',
    `name` VARCHAR(30),
    createdBy  VARCHAR(20),
    createdAt  DATE,
    modifiedBy VARCHAR(20),
    modifiedAt DATE
) ENGINE = InnoDB;

ALTER TABLE color 
    MODIFY `name` VARCHAR(30) NOT NULL,
    ADD CONSTRAINT color_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE color COMMENT = 'Stores colors for pets';

ALTER TABLE color 
    MODIFY COLUMN `name` VARCHAR(30) COMMENT 'Name of the color',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- VALUE TYPE
-- ============================================
CREATE TABLE value_type
(
    id_value_type   INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the value type',
    `type`			VARCHAR(30),
    createdBy       VARCHAR(20),
    createdAt       DATE,
    modifiedBy      VARCHAR(20),
    modifiedAt      DATE
) ENGINE = InnoDB;

ALTER TABLE value_type 
    MODIFY `type` VARCHAR(30) NOT NULL,
    ADD CONSTRAINT valueType_type_nn CHECK (`type` IS NOT NULL);

ALTER TABLE value_type COMMENT = 'Stores types of values for parameters';

ALTER TABLE value_type 
    MODIFY COLUMN `type` VARCHAR(30) COMMENT 'Name of the value type',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- PET_SIZE
-- ============================================
CREATE TABLE `size`
(
    id_size     INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for pet size',
    `name`   	VARCHAR(20),
    createdBy   VARCHAR(20),
    createdAt   DATE,
    modifiedBy  VARCHAR(20),
    modifiedAt  DATE
) ENGINE = InnoDB;

ALTER TABLE `size`
    MODIFY `name` INT NOT NULL,
    ADD CONSTRAINT size_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE `size` COMMENT = 'Stores pet sizes';

ALTER TABLE `size` 
    MODIFY COLUMN `name` VARCHAR(20) COMMENT 'Name of the size',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- SIZE_X_CRIB_HOUSE
-- ============================================
CREATE TABLE size_x_crib_house
(
    id_size       INT,
    id_crib_house INT,
    createdBy     VARCHAR(20),
    createdAt     DATE,
    modifiedBy    VARCHAR(20),
    modifiedAt    DATE
) ENGINE = InnoDB;

ALTER TABLE size_x_crib_house
    ADD CONSTRAINT pk_size_x_crib_house  PRIMARY KEY (id_size, id_crib_house);

ALTER TABLE size_x_crib_house
    ADD CONSTRAINT fk_sxch_size
    FOREIGN KEY (id_size) REFERENCES `size`(id_size)
    ON DELETE CASCADE;

ALTER TABLE size_x_crib_house
    ADD CONSTRAINT fk_sxch_crib_house
    FOREIGN KEY (id_crib_house) REFERENCES crib_house (id_user)
    ON DELETE CASCADE;

ALTER TABLE size_x_crib_house COMMENT = 'Intermediate table, stores sizes accepted by a crib house';

ALTER TABLE size_x_crib_house 
    MODIFY COLUMN id_size INT COMMENT 'Composite primary key. Foreign key references the size id',
    MODIFY COLUMN id_crib_house INT COMMENT 'Composite primary key. Foreign key references the crib house id',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';