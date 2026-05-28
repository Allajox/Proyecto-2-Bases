-- ============================================================
-- FILE 02 - USER & USER SUBTYPES
-- Tables: user, association, adopter, rescuer, crib_house, log
-- ============================================================

-- ============================================
-- USER
-- ============================================
CREATE TABLE `user`
(
    id_user    INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the user',
    email      VARCHAR(50),
    `password` VARCHAR(20),
    createdBy  VARCHAR(20),
    createdAt  DATE,
    modifiedBy VARCHAR(20),
    modifiedAt DATE
) ENGINE = InnoDB;

ALTER TABLE `user`
    MODIFY email VARCHAR(50) NOT NULL,
    ADD CONSTRAINT user_email_nn CHECK (email IS NOT NULL);

ALTER TABLE `user`
    MODIFY `password` VARCHAR(20) NOT NULL,
    ADD CONSTRAINT user_password_nn CHECK (`password` IS NOT NULL);

ALTER TABLE `user`
    MODIFY createdBy VARCHAR(20) NOT NULL,
    ADD CONSTRAINT user_createdBy_nn CHECK (createdBy IS NOT NULL);

ALTER TABLE `user`
    MODIFY createdAt DATE NOT NULL,
    ADD CONSTRAINT user_createdAt_nn CHECK (createdAt IS NOT NULL);

ALTER TABLE `user`
    ADD CONSTRAINT uq_user_email UNIQUE (email);

ALTER TABLE `user` COMMENT = 'Stores user account information';

ALTER TABLE `user`
    MODIFY COLUMN email VARCHAR(50) COMMENT 'Email address used for login',
    MODIFY COLUMN `password` VARCHAR(20) COMMENT 'Password for user authentication',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- ASSOCIATION
-- ============================================
CREATE TABLE association
(
    id_user    INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Foreign key, references the user id',
    `name`     VARCHAR(100),
    createdBy  VARCHAR(20),
    createdAt  DATE,
    modifiedBy VARCHAR(20),
    modifiedAt DATE
) ENGINE = InnoDB;

ALTER TABLE association
    MODIFY `name` VARCHAR(100) NOT NULL,
    ADD CONSTRAINT association_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE association
    ADD CONSTRAINT fk_association_user
    FOREIGN KEY (id_user) REFERENCES `user` (id_user)
    ON DELETE CASCADE;

ALTER TABLE association COMMENT = 'Extends user table with organization-specific information';

ALTER TABLE association
    MODIFY COLUMN `name` VARCHAR(100) COMMENT 'Official name of the association',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- ADOPTER
-- ============================================
CREATE TABLE adopter
(
    id_user        INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Foreign key, references the user id',
    first_name     VARCHAR(50),
    second_name    VARCHAR(50),
    first_surname  VARCHAR(50),
    second_surname VARCHAR(50),
    createdBy      VARCHAR(20),
    createdAt      DATE,
    modifiedBy     VARCHAR(20),
    modifiedAt     DATE
) ENGINE = InnoDB;

ALTER TABLE adopter
    MODIFY first_name VARCHAR(50) NOT NULL,
    ADD CONSTRAINT adopter_firstName_nn CHECK (first_name IS NOT NULL);

ALTER TABLE adopter
    MODIFY first_surname VARCHAR(50) NOT NULL,
    ADD CONSTRAINT adopter_firstSurname_nn CHECK (first_surname IS NOT NULL);

ALTER TABLE adopter
    ADD CONSTRAINT fk_adopter_user
    FOREIGN KEY (id_user) REFERENCES `user` (id_user)
    ON DELETE CASCADE;

ALTER TABLE adopter COMMENT = 'Extends user table with person-specific information for adopters';

ALTER TABLE adopter
    MODIFY COLUMN first_name VARCHAR(50) COMMENT 'First name of the adopter',
    MODIFY COLUMN second_name VARCHAR(50) COMMENT 'Second name of the adopter',
    MODIFY COLUMN first_surname VARCHAR(50) COMMENT 'Paternal surname of the adopter',
    MODIFY COLUMN second_surname VARCHAR(50) COMMENT 'Maternal surname of the adopter',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- RESCUER
-- ============================================
CREATE TABLE rescuer
(
    id_user        INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Foreign key referencing the user id',
    first_name     VARCHAR(50),
    second_name    VARCHAR(50),
    first_surname  VARCHAR(50),
    second_surname VARCHAR(50),
    createdBy      VARCHAR(20),
    createdAt      DATE,
    modifiedBy     VARCHAR(20),
    modifiedAt     DATE
) ENGINE = InnoDB;

ALTER TABLE rescuer
    MODIFY first_name VARCHAR(50) NOT NULL,
    ADD CONSTRAINT rescuer_firstName_nn CHECK (first_name IS NOT NULL);

ALTER TABLE rescuer
    MODIFY first_surname VARCHAR(50) NOT NULL,
    ADD CONSTRAINT rescuer_firstSurname_nn CHECK (first_surname IS NOT NULL);

ALTER TABLE rescuer
    ADD CONSTRAINT fk_rescuer_user
    FOREIGN KEY (id_user) REFERENCES `user` (id_user)
    ON DELETE CASCADE;

ALTER TABLE rescuer COMMENT = 'Extends user table with person-specific information for rescuers';

ALTER TABLE rescuer
    MODIFY COLUMN first_name VARCHAR(50) COMMENT 'First name of the rescuer',
    MODIFY COLUMN second_name VARCHAR(50) COMMENT 'Second name of the rescuer',
    MODIFY COLUMN first_surname VARCHAR(50) COMMENT 'Paternal surname of the rescuer',
    MODIFY COLUMN second_surname VARCHAR(50) COMMENT 'Maternal surname of the rescuer',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- CRIB HOUSE
-- ============================================
CREATE TABLE crib_house
(
    id_user            INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Foreign key, references the user id',
    `name`             VARCHAR(100),
    requires_donations TINYINT DEFAULT 0,
    createdBy          VARCHAR(20),
    createdAt          DATE,
    modifiedBy         VARCHAR(20),
    modifiedAt         DATE
) ENGINE = InnoDB;

ALTER TABLE crib_house
    MODIFY `name` VARCHAR(100) NOT NULL,
    ADD CONSTRAINT cribHouse_name_nn CHECK (`name` IS NOT NULL);

ALTER TABLE crib_house
    MODIFY requires_donations TINYINT NOT NULL,
    ADD CONSTRAINT cribHouse_requiresDonations_nn CHECK (requires_donations IS NOT NULL);

ALTER TABLE crib_house
    ADD CONSTRAINT fk_crib_house_user
    FOREIGN KEY (id_user) REFERENCES `user` (id_user)
    ON DELETE CASCADE;

ALTER TABLE crib_house
    ADD CONSTRAINT chk_requires_donations
    CHECK (requires_donations IN (0, 1));

ALTER TABLE crib_house COMMENT = 'Extends user table with crib house specific information';

ALTER TABLE crib_house
    MODIFY COLUMN `name` VARCHAR(100) COMMENT 'Name of the crib house',
    MODIFY COLUMN requires_donations TINYINT COMMENT 'Flag indicating if the crib house accepts donations',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- LOG
-- ============================================
CREATE TABLE log
(
    id_log        INT PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary key, identifier for the log entry',
    changeDate    DATE,
    changeBy      VARCHAR(20),
    tableName     VARCHAR(20),
    fieldName     VARCHAR(20),
    previousValue VARCHAR(20),
    currentValue  VARCHAR(20)
) ENGINE = InnoDB;

ALTER TABLE log
    MODIFY changeDate DATE NOT NULL,
    ADD CONSTRAINT log_changeDate_nn CHECK (changeDate IS NOT NULL);

ALTER TABLE log
    MODIFY changeBy VARCHAR(20) NOT NULL,
    ADD CONSTRAINT log_changeBy_nn CHECK (changeBy IS NOT NULL);

ALTER TABLE log
    MODIFY tableName VARCHAR(20) NOT NULL,
    ADD CONSTRAINT log_tableName_nn CHECK (tableName IS NOT NULL);

ALTER TABLE log
    MODIFY fieldName VARCHAR(20) NOT NULL,
    ADD CONSTRAINT log_fieldName_nn CHECK (fieldName IS NOT NULL);

ALTER TABLE log COMMENT = 'Stores data changes across tables';

ALTER TABLE log
    MODIFY COLUMN changeDate DATE COMMENT 'The date when the change occurred',
    MODIFY COLUMN changeBy VARCHAR(20) COMMENT 'The user who made the change',
    MODIFY COLUMN tableName VARCHAR(20) COMMENT 'Name of the table where the change happened',
    MODIFY COLUMN fieldName VARCHAR(20) COMMENT 'Name of the column that was modified',
    MODIFY COLUMN previousValue VARCHAR(20) COMMENT 'Value before the change was applied',
    MODIFY COLUMN currentValue VARCHAR(20) COMMENT 'Value after the change was applied';