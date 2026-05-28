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
    id_currency 	INT,
    `name`   VARCHAR(20),
    acronym     	VARCHAR(5),
    createdBy  		VARCHAR(20),
    createdAt  		DATE,
    modifiedBy 		VARCHAR(20),
    modifiedAt 		DATE
) ENGINE = InnoDB;

ALTER TABLE currency 
    MODIFY id_currency INT NOT NULL,
    ADD CONSTRAINT currency_idCurrency_nn CHECK (id_currency IS NOT NULL);

ALTER TABLE currency 
    MODIFY `name` VARCHAR(20) NOT NULL,
    ADD CONSTRAINT currency_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE currency 
    MODIFY acronym VARCHAR(5) NOT NULL,
    ADD CONSTRAINT currency_acronym_nn CHECK (acronym IS NOT NULL);

ALTER TABLE currency
    ADD CONSTRAINT pk_currency PRIMARY KEY AUTO_INCREMENT(id_currency);
    
ALTER TABLE currency COMMENT = 'Stores currency types for donations';

ALTER TABLE currency 
    MODIFY COLUMN id_currency INT COMMENT 'Primary key, identifier for the currency',
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
    id_province   INT,
    `name` VARCHAR(50),
    createdBy     VARCHAR(20),
    createdAt     DATE,
    modifiedBy    VARCHAR(20),
    modifiedAt    DATE
) ENGINE = InnoDB;

ALTER TABLE province 
    MODIFY id_province INT NOT NULL,
    ADD CONSTRAINT province_idProvince_nn CHECK (id_province IS NOT NULL);

ALTER TABLE province 
    MODIFY `name` VARCHAR(50) NOT NULL,
    ADD CONSTRAINT province_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE province
    ADD CONSTRAINT pk_province  PRIMARY KEY AUTO_INCREMENT (id_province);

ALTER TABLE province COMMENT = 'Stores provinces. Each country contains multiple provinces';

ALTER TABLE province 
    MODIFY COLUMN id_province INT COMMENT 'Primary key, identifier for the province',
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
    id_canton   INT,
    `name` VARCHAR(50),
    id_province INT,
    createdBy   VARCHAR(20),
    createdAt   DATE,
    modifiedBy  VARCHAR(20),
    modifiedAt  DATE
) ENGINE = InnoDB;

ALTER TABLE canton 
    MODIFY id_canton INT NOT NULL,
    ADD CONSTRAINT canton_idCanton_nn CHECK (id_canton IS NOT NULL);
    
ALTER TABLE canton 
    MODIFY `name` VARCHAR(50) NOT NULL,
    ADD CONSTRAINT canton_name_nn CHECK (`name` IS NOT NULL);
    
ALTER TABLE canton 
    MODIFY id_province INT NOT NULL,
    ADD CONSTRAINT canton_idProvince_nn CHECK (id_province IS NOT NULL);

ALTER TABLE canton
    ADD CONSTRAINT pk_canton  PRIMARY KEY AUTO_INCREMENT (id_canton);

ALTER TABLE canton
    ADD CONSTRAINT fk_canton_province
    FOREIGN KEY (id_province) REFERENCES province (id_province)
    ON DELETE CASCADE;

ALTER TABLE canton COMMENT = 'Stores the canton. Each province contains multiple cantons';

ALTER TABLE canton 
    MODIFY COLUMN id_canton INT COMMENT 'Primary key, identifier for the canton',
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
    id_district   INT,
    `name`		  VARCHAR(50),
    id_canton     INT,
    createdBy     VARCHAR(20),
    createdAt     DATE,
    modifiedBy    VARCHAR(20),
    modifiedAt    DATE
) ENGINE = InnoDB;

ALTER TABLE district
    MODIFY id_district INT NOT NULL,
    ADD CONSTRAINT district_idDistrict_nn CHECK (id_district IS NOT NULL);

ALTER TABLE district
    MODIFY `name` VARCHAR(50) NOT NULL,
    ADD CONSTRAINT district_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE district
    MODIFY id_canton INT NOT NULL,
    ADD CONSTRAINT district_idCanton_nn CHECK (id_canton IS NOT NULL);

ALTER TABLE district
    ADD CONSTRAINT pk_district  PRIMARY KEY AUTO_INCREMENT (id_district);

ALTER TABLE district
    ADD CONSTRAINT fk_district_canton
    FOREIGN KEY (id_canton) REFERENCES canton (id_canton)
    ON DELETE CASCADE;

ALTER TABLE district COMMENT = 'Stores districts. Each canton has multiple districts';

ALTER TABLE district 
    MODIFY COLUMN id_district INT COMMENT 'Primary key, identifier for the district',
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
    id_pet_type   INT,
    `name` 		  VARCHAR(50),
    createdBy     VARCHAR(20),
    createdAt     DATE,
    modifiedBy    VARCHAR(20),
    modifiedAt    DATE
) ENGINE = InnoDB;

ALTER TABLE pet_type 
    MODIFY id_pet_type INT NOT NULL,
    ADD CONSTRAINT petType_idPetType_nn CHECK (id_pet_type IS NOT NULL);

ALTER TABLE pet_type 
    MODIFY `name` VARCHAR(50) NOT NULL,
    ADD CONSTRAINT petType_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE pet_type
    ADD CONSTRAINT pk_pet_type  PRIMARY KEY AUTO_INCREMENT (id_pet_type);

ALTER TABLE pet_type COMMENT = 'Stores species of pets';

ALTER TABLE pet_type 
    MODIFY COLUMN id_pet_type INT COMMENT 'Primary key, identifier for the pet type',
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
    id_race     INT,
    `name`   VARCHAR(50),
    id_pet_type INT,
    createdBy   VARCHAR(20),
    createdAt   DATE,
    modifiedBy  VARCHAR(20),
    modifiedAt  DATE
) ENGINE = InnoDB;

ALTER TABLE race 
    MODIFY id_race INT NOT NULL,
    ADD CONSTRAINT race_idRace_nn CHECK (id_race IS NOT NULL);
    
ALTER TABLE race 
    MODIFY `name` VARCHAR(50) NOT NULL,
    ADD CONSTRAINT race_name_nn CHECK (`name` IS NOT NULL);
    
ALTER TABLE race 
    MODIFY id_pet_type INT NOT NULL,
    ADD CONSTRAINT race_idPetType_nn CHECK (id_pet_type IS NOT NULL);

ALTER TABLE race
    ADD CONSTRAINT pk_race  PRIMARY KEY AUTO_INCREMENT (id_race);

ALTER TABLE race
    ADD CONSTRAINT fk_race_pet_type
    FOREIGN KEY (id_pet_type) REFERENCES pet_type (id_pet_type)
    ON DELETE CASCADE;

ALTER TABLE race COMMENT = 'Specific breed within a pet type';

ALTER TABLE race 
    MODIFY COLUMN id_race INT COMMENT 'Primary key, identifier for the breed',
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
    id_status   INT,
    status_type VARCHAR(30),
    createdBy   VARCHAR(20),
    createdAt   DATE,
    modifiedBy  VARCHAR(20),
    modifiedAt  DATE
) ENGINE = InnoDB;

ALTER TABLE `status` 
    MODIFY id_status INT NOT NULL,
    ADD CONSTRAINT status_idStatus_nn CHECK (id_status IS NOT NULL);
    
ALTER TABLE `status` 
    MODIFY status_type VARCHAR(30) NOT NULL,
    ADD CONSTRAINT status_statusType_nn CHECK (status_type IS NOT NULL);

ALTER TABLE `status`
    ADD CONSTRAINT pk_status  PRIMARY KEY AUTO_INCREMENT (id_status);

ALTER TABLE `status` COMMENT = 'Stores statuses for pets';

ALTER TABLE `status` 
    MODIFY COLUMN id_status INT COMMENT 'Primary key, identifier for the status',
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
    id_color   INT,
    `name` VARCHAR(30),
    createdBy  VARCHAR(20),
    createdAt  DATE,
    modifiedBy VARCHAR(20),
    modifiedAt DATE
) ENGINE = InnoDB;

ALTER TABLE color 
    MODIFY id_color INT NOT NULL,
    ADD CONSTRAINT color_idColor_nn CHECK (id_color IS NOT NULL);

ALTER TABLE color 
    MODIFY `name` VARCHAR(30) NOT NULL,
    ADD CONSTRAINT color_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE color
    ADD CONSTRAINT pk_color  PRIMARY KEY AUTO_INCREMENT (id_color);

ALTER TABLE color COMMENT = 'Stores colors for pets';

ALTER TABLE color 
    MODIFY COLUMN id_color INT COMMENT 'Primary key, identifier for the color',
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
    id_value_type   INT,
    `type`			VARCHAR(30),
    createdBy       VARCHAR(20),
    createdAt       DATE,
    modifiedBy      VARCHAR(20),
    modifiedAt      DATE
) ENGINE = InnoDB;

ALTER TABLE value_type 
    MODIFY id_value_type INT NOT NULL,
    ADD CONSTRAINT valueType_idValueType_nn CHECK (id_value_type IS NOT NULL);

ALTER TABLE value_type 
    MODIFY `type` VARCHAR(30) NOT NULL,
    ADD CONSTRAINT valueType_type_nn CHECK (`type` IS NOT NULL);

ALTER TABLE value_type
    ADD CONSTRAINT pk_value_type  PRIMARY KEY AUTO_INCREMENT (id_value_type);

ALTER TABLE value_type COMMENT = 'Stores types of values for parameters';

ALTER TABLE value_type 
    MODIFY COLUMN id_value_type INT COMMENT 'Primary key, identifier for the value type',
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
    id_size     INT,
    `name`   	VARCHAR(20),
    createdBy   VARCHAR(20),
    createdAt   DATE,
    modifiedBy  VARCHAR(20),
    modifiedAt  DATE
) ENGINE = InnoDB;

ALTER TABLE `size`
    MODIFY id_size INT NOT NULL,
    ADD CONSTRAINT size_idSize_nn CHECK (id_size IS NOT NULL);
ALTER TABLE `size`
    MODIFY `name` INT NOT NULL,
    ADD CONSTRAINT size_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE `size`
    ADD CONSTRAINT pk_size  PRIMARY KEY AUTO_INCREMENT (id_size);

ALTER TABLE `size` COMMENT = 'Stores pet sizes';

ALTER TABLE `size` 
    MODIFY COLUMN id_size INT COMMENT 'Primary key, identifier for pet size',
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