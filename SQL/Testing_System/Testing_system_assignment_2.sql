-- create database
DROP DATABASE IF EXISTS testing_system_assignment_2;
CREATE DATABASE testing_system_assignment_2;

USE Testing_system_assignment_2;
	
    -- Create table Department
    DROP TABLE IF EXISTS Department;
	CREATE TABLE Department (
		DepartmentID 	TINYINT UNSIGNED PRIMARY KEY NOT NULL,
		DepartmentName 	VARCHAR(50) NOT NULL
    ); 
    
    -- Create table Position
    DROP TABLE IF EXISTS `Position`;
	CREATE TABLE `Position` (
		PositionID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
		PositionName 	ENUM('Dev','Test','Scrum Master','PM') 
    );
    
    -- Create table Account
    DROP TABLE IF EXISTS `Account`;
    CREATE TABLE `Account` (
		AccountID 		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
        Email 			CHAR(40) NOT NULL UNIQUE KEY,
        Username 		CHAR(20) NOT NULL UNIQUE KEY CHECK(length(Username)>=6),
        Fullname 		VARCHAR(50) NOT NULL,
		DepartmentID 	TINYINT UNSIGNED REFERENCES Department(DepartmentID),
        PositionID 		TINYINT UNSIGNED REFERENCES `Position`(PositionID),
        CreateDate 		DATETIME DEFAULT NOW()
   ); 
   
    -- Create table Group
    DROP TABLE IF EXISTS `Group`;
	CREATE TABLE `Group` (
		GroupID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
        GroupName		VARCHAR(50) NOT NULL UNIQUE KEY,
        CreatorID		SMALLINT UNSIGNED REFERENCES `Account`(AccountID),
        CreateDate		DATETIME DEFAULT NOW()
   );
   
    -- Create table GroupAccount
    DROP TABLE IF EXISTS GroupAccount;
	CREATE TABLE GroupAccount (
		GroupID			TINYINT UNSIGNED REFERENCES `Group`(GroupID),
        AccountID		SMALLINT UNSIGNED REFERENCES `Account`(AccountID),
        JoinDate		DATETIME DEFAULT NOW(),
		PRIMARY KEY (GroupID , AccountID)
   );
   
   -- Create table TypeQuestion
    DROP TABLE IF EXISTS TypeQuestion;
	CREATE TABLE TypeQuestion (
		TypeID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
        TypeName		ENUM('Essay','Multiple-Choice')
   );
   
   -- Create table CategoryQuestion
    DROP TABLE IF EXISTS CategoryQuestion;
    CREATE TABLE CategoryQuestion (
		CategoryID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
        CategoryName	VARCHAR(50)
   );
   
   -- Create table Question
    DROP TABLE IF EXISTS Question;
	CREATE TABLE Question (
		QuestionID		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
        Content			VARCHAR(250),
		CategoryID		TINYINT UNSIGNED REFERENCES CategoryQuestion(CategoryID),
        TypeID			TINYINT UNSIGNED REFERENCES TypeQuestion(TypeID),
		CreatorID		SMALLINT UNSIGNED REFERENCES `Account`(AccountID),
        CreateDate		DATETIME DEFAULT NOW()
   );
   
   -- Create table Answer
    DROP TABLE IF EXISTS Answer;
	CREATE TABLE Answer (
		AnswerID		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
        Content			VARCHAR(250),
		QuestionID		SMALLINT UNSIGNED NOT NULL REFERENCES Question(QuestionID),
		isCorrect		ENUM('Yes','No')
   );
   
   -- Create table Exam
    DROP TABLE IF EXISTS Exam;
	CREATE TABLE Exam (
		ExamID			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
		`Code`			CHAR(10) NOT NULL UNIQUE KEY,
        Title			VARCHAR(250) NOT NULL,
        CategoryID		SMALLINT UNSIGNED,
        Duration		CHAR(20),
        CreatorID		SMALLINT UNSIGNED REFERENCES `Account`(AccountID),
        CreateDate		DATETIME DEFAULT NOW()
   );
   
   -- Create table ExamQuestion
    DROP TABLE IF EXISTS ExamQuestion;
	CREATE TABLE ExamQuestion (
		ExamID			SMALLINT UNSIGNED REFERENCES Exam(ExamID),
        QuestionID		SMALLINT UNSIGNED REFERENCES Question(QuestionID),
        PRIMARY KEY (ExamID, QuestionID)
   );