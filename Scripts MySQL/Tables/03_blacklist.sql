-- ============================================================
-- FILE 03 - BLACKLIST
-- Tables: black_list, user_x_black_list
-- Depends on: user (02)
-- ============================================================

-- ============================================
-- BLACK LIST
-- ============================================
CREATE TABLE black_list
(
    id_report  INT,
    id_user    INT,
    createdBy  VARCHAR(20),
    createdAt  DATE,
    modifiedBy VARCHAR(20),
    modifiedAt DATE
) ENGINE = InnoDB;

ALTER TABLE black_list
    MODIFY id_report INT NOT NULL,
    ADD CONSTRAINT blackList_idReport_nn CHECK (id_report IS NOT NULL);

ALTER TABLE black_list
    MODIFY id_user INT NOT NULL,
    ADD CONSTRAINT blackList_idUser_nn CHECK (id_user IS NOT NULL);

ALTER TABLE black_list
    ADD CONSTRAINT pk_black_list PRIMARY KEY AUTO_INCREMENT (id_report);

ALTER TABLE black_list
    ADD CONSTRAINT fk_black_list_user
    FOREIGN KEY (id_user) REFERENCES `user` (id_user)
    ON DELETE CASCADE;

ALTER TABLE black_list COMMENT = 'Stores the black list information';

ALTER TABLE black_list
    MODIFY COLUMN id_report INT COMMENT 'Primary key, identifier for the black list id',
    MODIFY COLUMN id_user INT COMMENT 'Foreign key, references the user who owns the black list',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';

-- ============================================
-- USER X BLACK LIST
-- ============================================
CREATE TABLE user_x_black_list
(
    reason     VARCHAR(200),
    id_user    INT,
    id_report  INT,
    createdBy  VARCHAR(20),
    createdAt  DATE,
    modifiedBy VARCHAR(20),
    modifiedAt DATE
) ENGINE = InnoDB;

ALTER TABLE user_x_black_list
    MODIFY reason VARCHAR(200) NOT NULL,
    ADD CONSTRAINT userXBlackList_reason_nn CHECK (reason IS NOT NULL);

ALTER TABLE user_x_black_list
    MODIFY id_user INT NOT NULL,
    ADD CONSTRAINT userXBlackList_idUser_nn CHECK (id_user IS NOT NULL);

ALTER TABLE user_x_black_list
    MODIFY id_report INT NOT NULL,
    ADD CONSTRAINT userXBlackList_idReport_nn CHECK (id_report IS NOT NULL);

ALTER TABLE user_x_black_list
    ADD CONSTRAINT pk_user_x_black_list PRIMARY KEY (id_user, id_report);

ALTER TABLE user_x_black_list
    ADD CONSTRAINT fk_uxbl_user
    FOREIGN KEY (id_user) REFERENCES `user` (id_user)
    ON DELETE CASCADE;

ALTER TABLE user_x_black_list
    ADD CONSTRAINT fk_uxbl_report
    FOREIGN KEY (id_report) REFERENCES black_list (id_report)
    ON DELETE CASCADE;

ALTER TABLE user_x_black_list COMMENT = 'Intermediate table, stores the blocked users from a black list';

ALTER TABLE user_x_black_list
    MODIFY COLUMN reason VARCHAR(200) COMMENT 'Reason why the user was blocked',
    MODIFY COLUMN id_report INT COMMENT 'Composite Primary key. Foreign key references the id of the black list',
    MODIFY COLUMN id_user INT COMMENT 'Composite Foreign key. Foreign key references the id of the blocked user',
    MODIFY COLUMN createdBy VARCHAR(20) COMMENT 'The user who created the table',
    MODIFY COLUMN createdAt DATE COMMENT 'The date the table was created',
    MODIFY COLUMN modifiedBy VARCHAR(20) COMMENT 'The user who modified the table',
    MODIFY COLUMN modifiedAt DATE COMMENT 'The date the table was modified';