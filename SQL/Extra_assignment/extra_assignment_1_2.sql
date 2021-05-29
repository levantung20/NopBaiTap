-- Exercise 1
DROP DATABASE IF EXISTS fresher;
CREATE DATABASE fresher;
USE fresher;

	-- Question 1
DROP TABLE IF EXISTS trainee;
CREATE TABLE trainee(
	TraineeID			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Full_name			VARCHAR(50) NOT NULL,
    Birth_Date			DATE,
    Gender				ENUM('male','female','unknown'),
    ET_IQ				TINYINT UNSIGNED CHECK ( ET_IQ <= 20 ),
    ET_English			TINYINT UNSIGNED CHECK ( ET_English <= 50),
	ET_GMath			TINYINT UNSIGNED CHECK ( ET_GMath <=20),
    Training_Class		CHAR(10),
    Evaluation_Notes	VARCHAR(50)
);

	-- Question 2
ALTER TABLE trainee
ADD VTI_account VARCHAR(50) NOT NULL;

-- Exercise 2
CREATE TABLE Exercise_2 (
	ID				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Name`			VARCHAR(50) NOT NULL,
	`Code`			CHAR(5) UNIQUE KEY NOT NULL,
	ModifiedDate	DATETIME
);

-- Exercise 3
CREATE TABLE Exercise_3 (
	ID				INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`Name`			VARCHAR(50) NOT NULL,
	BirthDate		DATE,	
    Gender			BIT DEFAULT NULL,
    IsDeletedFlag	BIT NOT NULL
);

