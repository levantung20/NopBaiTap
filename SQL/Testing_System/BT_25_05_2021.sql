-- Cho table sau:
/*Department (Department_Number, Department_Name)
Employee_Table (Employee_Number, Employee_Name,
Department_Number)
Employee_Skill_Table (Employee_Number, Skill_Number, Date Registered)
Skill_Table (Skill_Number, Skill_Name)*/

-- Question 1: Tạo table với các ràng buộc và kiểu dữ liệu & Question 2: Thêm ít nhất 10 bản ghi vào table
DROP DATABASE IF EXISTS BT_25_05_2021;
CREATE DATABASE BT_25_05_2021;
USE BT_25_05_2021;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	Department_Number	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	Department_Name		VARCHAR(50) NOT NULL
);
TRUNCATE TABLE Department;
INSERT INTO Department (Department_Name)	
VALUES	('Accounting'),('Audit'),('Sales'),('Administration'),('Human Resources'),('Customer Service'),('Financial'),('Quality');

DROP TABLE IF EXISTS Employee_Table;
CREATE TABLE Employee_Table (
	Employee_Number		MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
   	Employee_Name		NVARCHAR(50) NOT NULL,
    	Department_Number	TINYINT UNSIGNED REFERENCES Department(Department_Number)
);
TRUNCATE TABLE Employee_Table;
INSERT INTO Employee_Table 	(	Employee_Name	,	Department_Number	)
VALUES				(	'Đỗ Quang Danh',		1		),
				(	'Trương Ngọc Thạch',	2			),
				(	'Trần Ðức Kiên',		3		),
                            	(	'Vũ Gia Khánh',			4		),
                            	(	'Cao Nhật Nam',			1		),
				(	'Nguyễn Tuấn Việt',		6		),
                            	(	'Hoàng Bảo Huỳnh',		1		),
                            	(	'Lý Hải Nguyên',		8		),
                            	(	'Phan Việt Dũng',		1		),
                            	(	'Dương Bình Quân',		2		),
				(	'Lý Diễm Thảo',			1		),
                           	(	'Quang Trang Anh',		6		),
                           	(	'Phan Phượng Vy',		8		),
                            	(	'Tô Hương Thu',			1		),
                            	(	'Dương Như Ngọc',		2		);

DROP TABLE IF EXISTS Employee_Skill_Table;
CREATE TABLE Employee_Skill_Table (
	Employee_Number		MEDIUMINT UNSIGNED REFERENCES Employee_Table(Employee_Number),		
   	Skill_Number		TINYINT UNSIGNED REFERENCES Skill_Table(Skill_Number),
   	Registered		DATETIME DEFAULT NOW(),
    	PRIMARY KEY (Employee_Number, Skill_Number)
);
TRUNCATE TABLE Employee_Skill_Table;
INSERT INTO Employee_Skill_Table 	(Employee_Number,Skill_Number) 
VALUES					(1,3),(1,4),(1,2),(1,1),
					(2,3),(2,4),
                                    	(3,1),(3,2),(3,3),(3,7),
                                    	(4,1),
                                    	(5,2),(5,6),(5,5),
                                    	(6,1),(6,3),
                                    	(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),
                                    	(8,4),
                                    	(9,7),(9,4),
                                    	(10,7),(10,2),
                                    	(11,4),(11,6),(11,7),
                                    	(12,5),(12,6),(12,7),(12,1),
                                    	(14,1),
                                    	(15,1);
                                    

DROP TABLE IF EXISTS Skill_Table;
CREATE TABLE Skill_Table (
	Skill_Number		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    	Skill_Name		VARCHAR(50)
);
TRUNCATE TABLE Skill_Table;
INSERT INTO Skill_Table (Skill_Name) VALUES ('MySQL'),('PHP'),('JAVA'),('JavaScript'),('Pyton'),('CSS'),('HTML');

-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java Hướng dẫn: sử dụng UNION
SELECT 		E.Employee_Name AS 'List_JAVA_dev'
FROM 		employee_table E 
LEFT JOIN 	employee_skill_table ESK  ON E.Employee_Number = ESK.Employee_Number
WHERE 		ESK.Skill_Number = 4;

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT 		D.Department_Name, COUNT(E.Employee_Number) AS list_DEP_haveMore3Staff
FROM 		employee_table E
JOIN 		department D ON E.Department_Number = D.Department_Number
GROUP BY	E.Department_Number
HAVING 		list_DEP_haveMore3Staff >= 3 ;

-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban. Hướng dẫn: sử dụng GROUP BY
SELECT 		D.Department_Name, COUNT(E.Employee_Number) AS number_ofStaff
FROM 		employee_table E
RIGHT JOIN 	department D ON E.Department_Number = D.Department_Number
GROUP BY 	D.Department_Number;

-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills. Hướng dẫn: sử dụng DISTINCT
SELECT DISTINCT ESK.Employee_Number, E.Employee_Name
FROM 		employee_skill_table ESK
LEFT JOIN 	employee_table E ON E.Employee_Number = ESK.Employee_Number;
