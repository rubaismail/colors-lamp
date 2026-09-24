-- Schema only: no deployed users, passwords, or color data.
-- Import into a new, empty database selected by your MySQL client.
CREATE TABLE Users (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL DEFAULT '',
    LastName VARCHAR(50) NOT NULL DEFAULT '',
    Login VARCHAR(50) NOT NULL DEFAULT '',
    Password VARCHAR(50) NOT NULL DEFAULT ''
);
CREATE TABLE Colors (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL DEFAULT '',
    UserID INT NOT NULL DEFAULT 0
);
