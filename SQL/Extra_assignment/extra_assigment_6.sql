DROP DATABASE IF EXISTS newProject;
CREATE DATABASE newProject;
USE newProject;

DROP TABLE IF EXISTS Project_Modules;
CREATE TABLE Project_Modules(
	ModuleID 			SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	ProjectID			SMALLINT UNSIGNED REFERENCES Project(ProjectID) ,
	EmployeeID			INT UNSIGNED DEFAULT NULL REFERENCES Employee(EmployeeID),
	ProjectModulesDate 		DATE DEFAULT NULl,
	ProjectModulesCompledOn 	DATE DEFAULT NULl,
	ProjectModulesDescription 	VARCHAR(250)
);

DROP TABLE IF EXISTS Projects;
CREATE TABLE Projects(
	ProjectID		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	ManagerID		INT UNSIGNED DEFAULT NULL REFERENCES Employee(EmployeeID),
	ProjectName		VARCHAR(50),
	ProjectStartDate 	DATE DEFAULT NULL,
	ProjectDescription	VARCHAR(50),
	ProjectDetails		VARCHAR(250),
	ProjectCompletedOn	DATE DEFAULT NULL
);

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee(
	EmployeeID 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    	EmployeeLastName	VARCHAR(50),
	EmployeeFirstName	VARCHAR(50),
    	EmployeeHireDate	DATE,
   	EmployeeStatus		VARCHAR(50),
	SupervisorID		INT UNSIGNED DEFAULT NULL REFERENCES Employee(EmployeeID),
	SocialSecurityNumber 	CHAR(12)
);

DROP TABLE IF EXISTS Work_done;
CREATE TABLE Work_done(
	WorkDoneID			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	EmployeeID			INT UNSIGNED REFERENCES Employee(EmployeeID),
	ModuleID			SMALLINT UNSIGNED REFERENCES Project_Modules(ModuleID),
	WorkDoneDate			DATE DEFAULT NULL,
	WorkDoneDescription		VARCHAR(250),
    WorkDoneStatus			VARCHAR(50)
);

/* Viết stored procedure (không có parameter) để Remove tất cả thông tin 
project đã hoàn thành sau 3 tháng kể từ ngày hiện. In số lượng record đã 
remove từ các table liên quan trong khi removing (dùng lệnh print) */

DROP PROCEDURE IF EXISTS remove_oldProject;
DELIMITER $$
CREATE PROCEDURE remove_oldProject()
	BEGIN
		-- print record da xoa ra man hinh
		SELECT WorkdoneID AS 'Works has been deleted'
		FROM  Work_done
		WHERE ModuleID IN	(	SELECT ModuleID
						FROM Project_Modules PM
						LEFT JOIN	Projects P		ON PM.ProjectID = P.ProjectID
						WHERE P.ProjectCompletedOn < DATE_SUB(curdate(), INTERVAL 3 MONTH) );
		SELECT ModuleID AS  'Modules has been deleted'
		FROM Project_Modules PM
		LEFT JOIN Projects   P	ON PM.ProjectID = P.ProjectID
		WHERE P.ProjectCompletedOn < DATE_SUB(curdate(), INTERVAL 3 MONTH);
		
		SELECT ProjectID, ProjectName AS 'Projects has been deleted'
		FROM Projects
		WHERE ProjectCompletedOn < DATE_SUB(curdate(), INTERVAL 3 MONTH);
		
		-- xoa records
		DELETE FROM Projects
		WHERE ProjectID IN ( 	SELECT ProjectID
					FROM Projects
					WHERE ProjectCompletedOn < DATE_SUB(curdate(), INTERVAL 3 MONTH) );
		
		DELETE FROM Project_Modules
		WHERE ModuleID IN ( 	SELECT ModuleID
					FROM Project_Modules 		PM
					LEFT JOIN	Projects 	P	ON PM.ProjectID = P.ProjectID
					WHERE P.ProjectCompletedOn < DATE_SUB(curdate(), INTERVAL 3 MONTH) );
		DELETE FROM Work_done
		WHERE ModuleID	IN (	SELECT ModuleID
					FROM Project_Modules 	PM
					LEFT JOIN Projects 	P	ON PM.ProjectID = P.ProjectID
					WHERE P.ProjectCompletedOn < DATE_SUB(curdate(), INTERVAL 3 MONTH) );
	END $$
DELIMITER ;
-- Viết stored procedure (có parameter) để in ra các module đang được thực hiện)
DROP PROCEDURE IF EXISTS modules_inAction;
DELIMITER $$
CREATE PROCEDURE modules_inAction()
	BEGIN
		SELECT *
        	FROM Project_Modules
		WHERE ProjectModulesDate IS NOT NULL AND ProjectModulesCompledOn != curDate();
	END $$
DELIMITER ;

/* Viết hàm (có parameter) trả về thông tin 1 nhân viên đã tham gia làm mặc 
dù không ai giao việc cho nhân viên đó (trong bảng Works) */

DROP PROCEDURE IF EXISTS remove_oldProject;
DELIMITER $$
CREATE PROCEDURE remove_oldProject(OUT out_employeeID INT UNSIGNED, OUT out_moduleID SMALLINT UNSIGNED)
	BEGIN
		DECLARE check_employeeID INT UNSIGNED;
        	DECLARE check_moduleID SMALLINT UNSIGNED;		
		
		SELECT EmployeeID INTO check_employeeID
		FROM Work_done;

		SELECT ModuleID INTO check_moduleID
		FROM Work_done;
        
		SELECT M.EmployeeID, CONCAT(E.EmployeeFirstName,' ',E.EmployeeLastName) AS Fullname
		FROM Project_Modules 		M
		LEFT JOIN Employee		E  ON M.EmployeeID = E.EmployeeID
		WHERE M.EmployeeID = check_employeeID AND EXISTS (  SELECT *
															FROM Project_Modules 
															WHERE ModuleID = check_moduleID AND EmployeeID != check_employeeID );
	END $$
DELIMITER ;
