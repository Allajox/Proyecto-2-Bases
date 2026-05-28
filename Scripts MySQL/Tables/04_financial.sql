-- ============================================================
-- FILE 04 - FINANCIAL
-- Tables: donation
-- Depends on: currency (01), user (02)
-- ============================================================


-- ============================================
-- DONATION
-- ============================================
CREATE TABLE donation
(
    id_donation    INT,
    amount         DECIMAL(12, 2),
    id_association INT,
    id_crib_house  INT,
    id_currency    INT,
    id_donnor      INT,
    createdBy      VARCHAR(20),
    createdAt      DATE,
    modifiedBy     VARCHAR(20),
    modifiedAt     DATE
) ENGINE = InnoDB;

ALTER TABLE donation
    MODIFY id_donation INT NOT NULL,
    ADD CONSTRAINT donation_idDonation_nn CHECK (id_donation IS NOT NULL);

ALTER TABLE donation
    MODIFY amount DECIMAL(12, 2) NOT NULL,
    ADD CONSTRAINT donation_amount_nn CHECK (amount IS NOT NULL);

ALTER TABLE donation 
    ADD CONSTRAINT chk_donation_receiver CHECK (
        (id_association IS NOT NULL AND id_crib_house IS NULL) OR
        (id_association IS NULL AND id_crib_house IS NOT NULL)
    );

ALTER TABLE donation
    MODIFY id_currency INT NOT NULL,
    ADD CONSTRAINT donation_idCurrency_nn CHECK (id_currency IS NOT NULL);

ALTER TABLE donation
    ADD CONSTRAINT pk_donation PRIMARY KEY AUTO_INCREMENT (id_donation);

ALTER TABLE donation
    ADD CONSTRAINT fk_donation_association
    FOREIGN KEY (id_association) REFERENCES association (id_user);
    
ALTER TABLE donation
    ADD CONSTRAINT fk_donation_crib_house
    FOREIGN KEY (id_crib_house) REFERENCES crib_house (id_user);

ALTER TABLE donation
    ADD CONSTRAINT fk_donation_currency
    FOREIGN KEY (id_currency) REFERENCES currency (id_currency);
    
ALTER TABLE donation
    ADD CONSTRAINT fk_donation_donnor
    FOREIGN KEY (id_donnor) REFERENCES `user` (id_user);

ALTER TABLE donation COMMENT = 'Stores the donation information';

ALTER TABLE donation
    MODIFY COLUMN id_donation INT COMMENT 'Primary key, identifier for the donation id',
    MODIFY COLUMN amount DECIMAL(12, 2) COMMENT 'Amount of the donation',
    MODIFY COLUMN id_association INT COMMENT 'Foreign key, references the receiver association',
    MODIFY COLUMN id_crib_house INT COMMENT 'Foreign key, references the receiver crib house',
    MODIFY COLUMN id_currency INT COMMENT 'Foreign key, references the currency',
    MODIFY COLUMN id_donnor INT COMMENT 'Foreign key, references the donnor',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';