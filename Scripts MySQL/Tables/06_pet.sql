-- ============================================================
-- FILE 06 - PET & PET RELATIONSHIPS
-- Tables: pet, identification_chip, pet_x_color,
--         pet_x_district, pet_type_x_crib_house
-- Depends on: catalogs (01), user subtypes (02), veterinarian (05)
-- ============================================================

-- ============================================
-- PET
-- ============================================
CREATE TABLE pet
(
    id_pet      INT,
    picture     VARCHAR(500),
    `name`      VARCHAR(50),
    birth_date  DATE,
    date_lost   DATE,
    date_found  DATE,
    email       VARCHAR(50),
    id_size     INT,
    id_status   INT,
    id_race     INT,
    id_user     INT,
    id_adopter  INT,
    id_district INT,
    createdBy   VARCHAR(20),
    createdAt   DATE,
    modifiedBy  VARCHAR(20),
    modifiedAt  DATE
) ENGINE = InnoDB;

ALTER TABLE pet
    MODIFY id_pet INT NOT NULL,
    ADD CONSTRAINT pet_idPet_nn CHECK (id_pet IS NOT NULL);

ALTER TABLE pet
    MODIFY `name` VARCHAR(50) NOT NULL,
    ADD CONSTRAINT pet_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE pet
    MODIFY id_size INT NOT NULL,
    ADD CONSTRAINT pet_idSize_nn CHECK (id_size IS NOT NULL);

ALTER TABLE pet
    MODIFY id_status INT NOT NULL,
    ADD CONSTRAINT pet_idStatus_nn CHECK (id_status IS NOT NULL);

ALTER TABLE pet
    MODIFY id_race INT NOT NULL,
    ADD CONSTRAINT pet_idRace_nn CHECK (id_race IS NOT NULL);

ALTER TABLE pet
    MODIFY id_user INT NOT NULL,
    ADD CONSTRAINT pet_idUser_nn CHECK (id_user IS NOT NULL);

ALTER TABLE pet
    MODIFY id_district INT NOT NULL,
    ADD CONSTRAINT pet_idDistrict_nn CHECK (id_district IS NOT NULL);

ALTER TABLE pet
    ADD CONSTRAINT pk_pet PRIMARY KEY AUTO_INCREMENT (id_pet);

ALTER TABLE pet
    ADD CONSTRAINT fk_pet_status
    FOREIGN KEY (id_status) REFERENCES status (id_status);

ALTER TABLE pet
    ADD CONSTRAINT fk_pet_size
    FOREIGN KEY (id_size) REFERENCES `size` (id_size);

ALTER TABLE pet
    ADD CONSTRAINT fk_pet_race
    FOREIGN KEY (id_race) REFERENCES race (id_race);

ALTER TABLE pet
    ADD CONSTRAINT fk_pet_user
    FOREIGN KEY (id_user) REFERENCES `user` (id_user);
    
ALTER TABLE pet
    ADD CONSTRAINT fk_pet_adopter
    FOREIGN KEY (id_adopter) REFERENCES `user` (id_user);
    
ALTER TABLE pet
    ADD CONSTRAINT fk_pet_district
    FOREIGN KEY (id_district) REFERENCES district (id_district);

ALTER TABLE pet
    MODIFY createdBy VARCHAR(20) NOT NULL,
    ADD CONSTRAINT pet_createdBy_nn CHECK (createdBy IS NOT NULL);

ALTER TABLE pet
    MODIFY createdAt DATE NOT NULL,
    ADD CONSTRAINT pet_createdAt_nn CHECK (createdAt IS NOT NULL);

ALTER TABLE pet COMMENT = 'Stores information about animals registered in the system';

ALTER TABLE pet
    MODIFY COLUMN id_pet INT COMMENT 'Primary key, identifier for the pet',
    MODIFY COLUMN picture VARCHAR(500) COMMENT 'File path to the pet photograph',
    MODIFY COLUMN `name` VARCHAR(50) COMMENT 'Name of the pet',
    MODIFY COLUMN birth_date DATE COMMENT 'Date when the pet was born',
    MODIFY COLUMN date_lost DATE COMMENT 'Date when the pet went missing',
    MODIFY COLUMN date_found DATE COMMENT 'Date when the pet was found or rescued',
    MODIFY COLUMN email VARCHAR(50) COMMENT 'Contact email address associated with the pet',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified',
    MODIFY COLUMN id_size INT COMMENT 'Foreign key, references the size of the pet',
    MODIFY COLUMN id_status INT COMMENT 'Foreign key, references the current status of the pet',
    MODIFY COLUMN id_race INT COMMENT 'Foreign key, references the race of the pet',
    MODIFY COLUMN id_adopter INT COMMENT 'Foreign key, references the user that owns the pet',
    MODIFY COLUMN id_district INT COMMENT 'Foreign key, references the district where the pet was found';

-- ============================================
-- IDENTIFICATION CHIP
-- ============================================
CREATE TABLE identification_chip
(
    id_chip           INT,
    chip_number       VARCHAR(30),
    registration_date DATE,
    id_pet            INT,
    createdBy         VARCHAR(20),
    createdAt         DATE,
    modifiedBy        VARCHAR(20),
    modifiedAt        DATE
) ENGINE = InnoDB;

ALTER TABLE identification_chip
    MODIFY id_chip INT NOT NULL,
    ADD CONSTRAINT identificationChip_idChip_nn CHECK (id_chip IS NOT NULL);

ALTER TABLE identification_chip
    MODIFY chip_number VARCHAR(30) NOT NULL,
    ADD CONSTRAINT identifChip_chipNumber_nn CHECK (chip_number IS NOT NULL);

ALTER TABLE identification_chip
    MODIFY registration_date DATE NOT NULL,
    ADD CONSTRAINT identChip_registrationDate_nn CHECK (registration_date IS NOT NULL);

ALTER TABLE identification_chip
    MODIFY id_pet INT NOT NULL,
    ADD CONSTRAINT identificationChip_idPet_nn CHECK (id_pet IS NOT NULL);

ALTER TABLE identification_chip
    ADD CONSTRAINT pk_identification_chip PRIMARY KEY AUTO_INCREMENT (id_chip);

ALTER TABLE identification_chip
    ADD CONSTRAINT uq_chip_number UNIQUE (chip_number);

ALTER TABLE identification_chip
    ADD CONSTRAINT fk_chip_pet
    FOREIGN KEY (id_pet) REFERENCES pet (id_pet)
    ON DELETE CASCADE;
    
ALTER TABLE identification_chip COMMENT = 'Stores the pets identification chip information';

ALTER TABLE identification_chip
    MODIFY COLUMN id_chip INT COMMENT 'Primary key, identifier for the identification chip',
    MODIFY COLUMN chip_number VARCHAR(30) COMMENT 'Identification chip of the pet. Unique',
    MODIFY COLUMN registration_date DATE COMMENT 'Date when the chip was registered',
    MODIFY COLUMN id_pet INT COMMENT 'Foreign key, references the associated pet',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- PET X COLOR
-- ============================================
CREATE TABLE pet_x_color
(
    id_pet     INT,
    id_color   INT,
    createdBy  VARCHAR(20),
    createdAt  DATE,
    modifiedBy VARCHAR(20),
    modifiedAt DATE
) ENGINE = InnoDB;

ALTER TABLE pet_x_color
    MODIFY id_pet INT NOT NULL,
    ADD CONSTRAINT petXColor_idPet_nn CHECK (id_pet IS NOT NULL);

ALTER TABLE pet_x_color
    MODIFY id_color INT NOT NULL,
    ADD CONSTRAINT petXColor_idColor_nn CHECK (id_color IS NOT NULL);

ALTER TABLE pet_x_color
    ADD CONSTRAINT pk_pet_x_color PRIMARY KEY (id_pet, id_color);

ALTER TABLE pet_x_color
    ADD CONSTRAINT fk_pxc_pet
    FOREIGN KEY (id_pet) REFERENCES pet (id_pet)
    ON DELETE CASCADE;

ALTER TABLE pet_x_color
    ADD CONSTRAINT fk_pxc_color
    FOREIGN KEY (id_color) REFERENCES color (id_color)
    ON DELETE CASCADE;

ALTER TABLE pet_x_color COMMENT = 'Intermediate table, stores the pets colors';

ALTER TABLE pet_x_color
    MODIFY COLUMN id_pet INT COMMENT 'Composite primary key. Foreign key references the pet id',
    MODIFY COLUMN id_color INT COMMENT 'Composite primary key. Foreign key references the color id',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- PET TYPE X CRIB HOUSE
-- ============================================
CREATE TABLE pet_type_x_crib_house
(
    id_pet_type   INT,
    id_crib_house INT,
    createdBy     VARCHAR(20),
    createdAt     DATE,
    modifiedBy    VARCHAR(20),
    modifiedAt    DATE
) ENGINE = InnoDB;

ALTER TABLE pet_type_x_crib_house
    MODIFY id_pet_type INT NOT NULL,
    ADD CONSTRAINT petTypeXCribHouse_idPetType_nn CHECK (id_pet_type IS NOT NULL);

ALTER TABLE pet_type_x_crib_house
    MODIFY id_crib_house INT NOT NULL,
    ADD CONSTRAINT petTypeXCrib_idCribHouse_nn CHECK (id_crib_house IS NOT NULL);

ALTER TABLE pet_type_x_crib_house
    ADD CONSTRAINT pk_pet_type_x_crib_house PRIMARY KEY (id_pet_type, id_crib_house);

ALTER TABLE pet_type_x_crib_house
    ADD CONSTRAINT fk_ptxch_pet_type
    FOREIGN KEY (id_pet_type) REFERENCES pet_type (id_pet_type)
    ON DELETE CASCADE;

ALTER TABLE pet_type_x_crib_house
    ADD CONSTRAINT fk_ptxch_crib_house
    FOREIGN KEY (id_crib_house) REFERENCES crib_house (id_user)
    ON DELETE CASCADE;

ALTER TABLE pet_type_x_crib_house COMMENT = 'Intermediate table, stores pet types accepted by a crib house';

ALTER TABLE pet_type_x_crib_house
    MODIFY COLUMN id_pet_type INT COMMENT 'Composite primary key. Foreign key references the pet type id',
    MODIFY COLUMN id_crib_house INT COMMENT 'Composite primary key. Foreign key references the crib house id',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';