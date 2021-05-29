USE BT_25_05_2021;

-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java
SELECT DISTINCT E.Employee_Name AS ListOf_JAVA_dev
FROM employee_skill_table		ES
LEFT JOIN employee_table		E	ON E.Employee_Number	=	ES.Employee_Number
JOIN skill_table				S 	ON ES.Skill_Number		=	S.Skill_Number
WHERE S.Skill_Name LIKE 'Java';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT D.Department_Name AS ListOf_DEP_3plusStaff
FROM employee_table		E
RIGHT JOIN department	D ON E.Department_Number = D.Department_Number
GROUP BY E.Department_Number
HAVING count(E.Employee_Number) >=3;

-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban. 
SELECT D.Department_Name,E.Employee_Name
FROM employee_table		E
RIGHT JOIN department	D	ON E.Department_Number = D.Department_Number
ORDER BY E.Department_Number;

-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills.
SELECT E.Employee_Name
FROM employee_skill_table ES
LEFT JOIN employee_table  E 	ON ES.Employee_Number = E.Employee_Number
GROUP BY ES.Employee_Number
HAVING COUNT(*) > 1 ;