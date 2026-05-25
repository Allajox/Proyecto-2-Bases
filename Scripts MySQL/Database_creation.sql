CREATE USER 'ADM'@'localhost'
    IDENTIFIED BY 'ADM';

CREATE DATABASE Pr2;

-- Set Pr2 as default schema
USE Pr2;

-- Grant privileges
GRANT CREATE, DROP, ALTER, INDEX, SELECT, INSERT, UPDATE, DELETE 
    ON Pr2.* TO 'ADM'@'localhost';

-- Adittional privileges for stored procedures
-- Permisos adicionales para procedimientos almacenados
GRANT EXECUTE, CREATE ROUTINE, ALTER ROUTINE 
    ON Pr2.* TO 'ADM'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;