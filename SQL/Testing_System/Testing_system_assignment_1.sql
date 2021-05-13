DROP DATABASE IF EXISTS Testing_system_assignment_1;
CREATE DATABASE Testing_system_assignment_1; 

USE Testing_system_assignment_1;

	CREATE TABLE Department (
		DepartmentID 	INT,
		DepartmentName 	VARCHAR(50) 
    ); 
    
	CREATE TABLE `Position` (
		PositionID 		INT,
		PositionName 	VARCHAR(50)
    );
    
    CREATE TABLE `Account` (
		AccountID 		INT,
        Email 			VARCHAR(50),
        Username 		VARCHAR(50),
        Fullname 		VARCHAR(50),
		DepartmentID 	INT,
        PositionID 		INT,
        CreateDate 		DATE
   ); 
   
   CREATE TABLE `Group` (
		GroupID			INT,
        GroupName		VARCHAR(50),
        CreatorID		INT,
        CreateDate		DATE
   );
   
   CREATE TABLE GroupAccount (
		GroupID			INT,
        AccountID		INT,
        JoinDate		DATE
   );
   
   CREATE TABLE TypeQuestion (
		TypeID 			INT,
        TypeName		VARCHAR(50)
   );
   
   CREATE TABLE Question (
		QuestionID		INT,
        Content			VARCHAR(250),
		CategoryID		INT,
        TypeID			INT,
		CreatorID		INT,
        CreateDate		DATE
   );
   
   CREATE TABLE CategoryQuestion (
		CategoryID		INT,
        CategoryName	VARCHAR(250)
   );
   
   CREATE TABLE Answer (
		AnswerID		INT,
        Content			VARCHAR(250),
		QuestionID		INT,
		isCorrect		VARCHAR(50)
   );
   
   CREATE TABLE Exam (
		ExamID			INT,
		`Code`			VARCHAR(50),
        Title			VARCHAR(250),
        CategoryID		INT,
        Duration		VARCHAR(50),
        CreatorID		INT,
        CreateDate		DATE
   );
   
   CREATE TABLE ExamQuestion (
		ExamID			INT,
        QuestionID		INT
   );
   
   
    