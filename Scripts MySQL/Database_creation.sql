CREATE USER 'ADM'@'localhost'
    IDENTIFIED BY 'ADM';

CREATE DATABASE Pr2;

-- Set Pr2 as default schema
USE Pr2;

-- Grant privileges
GRANT ALL PRIVILEGES ON Pr2.* TO 'ADM'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;