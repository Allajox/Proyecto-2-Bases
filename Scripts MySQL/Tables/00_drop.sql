-- ============================================================
-- DROP ALL TABLES - ASOCIACIÓN QUIERO UN PELUDO
-- Execute this script to remove all tables from the schema
-- Order: most dependent tables first
-- ============================================================

-- MEDICAL (most dependent)
DROP TABLE treatment_x_disease;
DROP TABLE disease_x_medic_sheet;
DROP TABLE medic_sheet;

-- PET EXTRA INFO AND RELATED}
DROP TABLE bounty;
DROP TABLE pet_extra_info;
DROP TABLE training_ease;
DROP TABLE energy_level;
DROP TABLE current_status;

-- MATCH
DROP TABLE `match`;
DROP TABLE value_type;

-- ADOPTION / SOCIAL
DROP TABLE rating;
DROP TABLE photo;
DROP TABLE adoption_form;

-- PHONE NUMBER (depends on user, pet, veterinarian)
DROP TABLE phone_number;

-- PET RELATIONSHIPS
DROP TABLE pet_x_color;
DROP TABLE pet_type_x_crib_house;
DROP TABLE identification_chip;

-- PET
DROP TABLE pet;

-- VETERINARIAN
DROP TABLE veterinarian;

-- CATALOGS (pet)
DROP TABLE color;
DROP TABLE status;
DROP TABLE race;
DROP TABLE pet_type;

-- FINANCIAL
DROP TABLE donation;

-- USER BLACKLIST
DROP TABLE user_x_black_list;
DROP TABLE black_list;

-- USER SUBTYPES AND LOG
DROP TABLE log;

DROP TABLE size_x_crib_house;
DROP TABLE `size`;
DROP TABLE crib_house;
DROP TABLE rescuer;
DROP TABLE adopter;
DROP TABLE association;

-- DISEASE AND TREATMENT (no dependencies after cross tables are dropped)
DROP TABLE treatment;
DROP TABLE disease;

-- LOCATION
DROP TABLE district;
DROP TABLE canton;
DROP TABLE province;

-- FINANCIAL CATALOG
DROP TABLE currency;

-- BASE USER
DROP TABLE `user`;
