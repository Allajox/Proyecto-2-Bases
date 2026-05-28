-- ============================================================
-- FILE 08 - ADOPTION, PHOTO, RATING & MATCH
-- Tables: adoption_form, photo, rating, match
-- Depends on: user (02), pet (06), value_type (01)
-- ============================================================

-- ============================================
-- ADOPTION FORM
-- ============================================
CREATE TABLE adoption_form
(
    id_adoption   INT,
    notes         VARCHAR(500),
    adoption_date DATE,
    `reference`   VARCHAR(200),
    id_adopter    INT,
    id_pet        INT,
    createdBy     VARCHAR(20),
    createdAt     DATE,
    modifiedBy    VARCHAR(20),
    modifiedAt    DATE
) ENGINE = InnoDB;

ALTER TABLE adoption_form
    MODIFY id_adoption INT NOT NULL,
    ADD CONSTRAINT adoptionForm_idAdoption_nn CHECK (id_adoption IS NOT NULL);

ALTER TABLE adoption_form
    MODIFY adoption_date DATE NOT NULL,
    ADD CONSTRAINT adoptionForm_adoptionDate_nn CHECK (adoption_date IS NOT NULL);

ALTER TABLE adoption_form
    MODIFY id_adopter INT NOT NULL,
    ADD CONSTRAINT adoptionForm_idAdopter_nn CHECK (id_adopter IS NOT NULL);

ALTER TABLE adoption_form
    MODIFY id_pet INT NOT NULL,
    ADD CONSTRAINT adoptionForm_idPet_nn CHECK (id_pet IS NOT NULL);

ALTER TABLE adoption_form
    ADD CONSTRAINT pk_adoption_form PRIMARY KEY AUTO_INCREMENT (id_adoption);

ALTER TABLE adoption_form
    ADD CONSTRAINT fk_af_adopter
    FOREIGN KEY (id_adopter) REFERENCES `user` (id_user)
    ON DELETE CASCADE;

ALTER TABLE adoption_form
    ADD CONSTRAINT fk_af_pet
    FOREIGN KEY (id_pet) REFERENCES pet (id_pet)
    ON DELETE CASCADE;

ALTER TABLE adoption_form COMMENT = 'Stores information about adoption forms for adopting pets';

ALTER TABLE adoption_form
    MODIFY COLUMN id_adoption INT COMMENT 'Primary key, identifier for the adoption form',
    MODIFY COLUMN notes VARCHAR(500) COMMENT 'Notes from the adoption',
    MODIFY COLUMN adoption_date DATE COMMENT 'The date the adoption was made',
    MODIFY COLUMN `reference` VARCHAR(200) COMMENT 'The reference',
    MODIFY COLUMN id_adopter INT COMMENT 'Foreign key, references the adopter who filled the form',
    MODIFY COLUMN id_pet INT COMMENT 'Foreign key, references the adopted pet',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- PHOTO
-- ============================================
CREATE TABLE photo
(
    id_photo  INT,
    `date`    DATE,
    photo_dir VARCHAR(200),
    id_user   INT,
    createdBy VARCHAR(20),
    createdAt DATE,
    modifiedBy VARCHAR(20),
    modifiedAt DATE
) ENGINE = InnoDB;

ALTER TABLE photo
    MODIFY id_photo INT NOT NULL,
    ADD CONSTRAINT photo_idPhoto_nn CHECK (id_photo IS NOT NULL);

ALTER TABLE photo
    MODIFY `date` DATE NOT NULL,
    ADD CONSTRAINT photo_date_nn CHECK (`date` IS NOT NULL);

ALTER TABLE photo
    MODIFY photo_dir VARCHAR(200) NOT NULL,
    ADD CONSTRAINT photo_photoDir_nn CHECK (photo_dir IS NOT NULL);

ALTER TABLE photo
    MODIFY id_user INT NOT NULL,
    ADD CONSTRAINT photo_idUser_nn CHECK (id_user IS NOT NULL);

ALTER TABLE photo
    ADD CONSTRAINT pk_photo PRIMARY KEY AUTO_INCREMENT (id_photo);

ALTER TABLE photo
    ADD CONSTRAINT fk_photo_user
    FOREIGN KEY (id_user) REFERENCES `user` (id_user)
    ON DELETE CASCADE;

ALTER TABLE photo COMMENT = 'Stores information about photos uploaded by the adopter showing the current state of the pet';

ALTER TABLE photo
    MODIFY COLUMN id_photo INT COMMENT 'Primary key, identifier for the photo',
    MODIFY COLUMN `date` DATE COMMENT 'The date the photo was uploaded',
    MODIFY COLUMN photo_dir VARCHAR(200) COMMENT 'File path to the photo',
    MODIFY COLUMN id_user INT COMMENT 'Foreign key, references the user who uploaded the photo',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- RATING
-- ============================================
CREATE TABLE rating
(
    id_rating  INT,
    score      DECIMAL(3,1),
    id_user    INT,
    id_adopter INT,
    createdBy  VARCHAR(20),
    createdAt  DATE,
    modifiedBy VARCHAR(20),
    modifiedAt DATE
) ENGINE = InnoDB;

ALTER TABLE rating
    MODIFY id_rating INT NOT NULL,
    ADD CONSTRAINT rating_idRating_nn CHECK (id_rating IS NOT NULL);

ALTER TABLE rating
    MODIFY score DECIMAL(3,1) NOT NULL,
    ADD CONSTRAINT rating_score_nn CHECK (score IS NOT NULL);

ALTER TABLE rating
    MODIFY id_user INT NOT NULL,
    ADD CONSTRAINT rating_idUser_nn CHECK (id_user IS NOT NULL);

ALTER TABLE rating
    MODIFY id_adopter INT NOT NULL,
    ADD CONSTRAINT rating_idAdopter_nn CHECK (id_adopter IS NOT NULL);

ALTER TABLE rating
    ADD CONSTRAINT pk_rating PRIMARY KEY AUTO_INCREMENT (id_rating);

ALTER TABLE rating
    ADD CONSTRAINT fk_rating_user
    FOREIGN KEY (id_user) REFERENCES `user` (id_user)
    ON DELETE CASCADE;

ALTER TABLE rating
    ADD CONSTRAINT fk_rating_adopter
    FOREIGN KEY (id_adopter) REFERENCES `user` (id_user)
    ON DELETE CASCADE;

ALTER TABLE rating COMMENT = 'Stores information about ratings assigned to adopters';

ALTER TABLE rating
    MODIFY COLUMN id_rating INT COMMENT 'Primary key, identifier for the rating',
    MODIFY COLUMN score DECIMAL(3,1) COMMENT 'The score assigned to the adopter',
    MODIFY COLUMN id_user INT COMMENT 'Foreign key, references the user who does the rating',
    MODIFY COLUMN id_adopter INT COMMENT 'Foreign key, references the adopter who receives the rating',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- MATCH
-- ============================================
CREATE TABLE `match`
(
    id_match      INT,
    match_date    DATE,
    id_pet_lost   INT,
    id_pet_found  INT,
    createdBy     VARCHAR(20),
    createdAt     DATE,
    modifiedBy    VARCHAR(20),
    modifiedAt    DATE
) ENGINE = InnoDB;

ALTER TABLE `match`
    MODIFY id_match INT NOT NULL,
    ADD CONSTRAINT match_idMatch_nn CHECK (id_match IS NOT NULL);

ALTER TABLE `match`
    MODIFY match_date DATE NOT NULL,
    ADD CONSTRAINT match_matchDate_nn CHECK (match_date IS NOT NULL);

ALTER TABLE `match`
    MODIFY id_pet_lost INT NOT NULL,
    ADD CONSTRAINT match_idPetLost_nn CHECK (id_pet_lost IS NOT NULL);

ALTER TABLE `match`
    MODIFY id_pet_found INT NOT NULL,
    ADD CONSTRAINT match_idPetFound_nn CHECK (id_pet_found IS NOT NULL);

ALTER TABLE `match`
    ADD CONSTRAINT pk_match PRIMARY KEY AUTO_INCREMENT (id_match);
    
ALTER TABLE `match`
    ADD CONSTRAINT fk_match_pet_lost
    FOREIGN KEY (id_pet_lost) REFERENCES pet (id_pet);

ALTER TABLE `match`
    ADD CONSTRAINT fk_match_pet_found
    FOREIGN KEY (id_pet_found) REFERENCES pet (id_pet);

ALTER TABLE `match` COMMENT = 'Stores information about matches between lost and found pets';

ALTER TABLE `match`
    MODIFY COLUMN id_match INT COMMENT 'Primary key, identifier for the match',
    MODIFY COLUMN match_date DATE COMMENT 'The date the match was made',
    MODIFY COLUMN id_pet_lost INT COMMENT 'Foreign key, references the lost pet',
    MODIFY COLUMN id_pet_found INT COMMENT 'Foreign key, references the found pet',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';