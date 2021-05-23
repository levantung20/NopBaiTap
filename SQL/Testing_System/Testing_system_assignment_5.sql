USE testingsystem3;

-- Modify data for output question 5
UPDATE `account`
SET Fullname = 'Nguyễn Bla'
WHERE AccountID = 119;

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE VIEW saleWorkers AS 
SELECT *
FROM `account` 
WHERE DepartmentID = (SELECT DepartmentID 
		      FROM department 
                      WHERE DepartmentName LIKE '%Sale%' );

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE VIEW joinMostGroups AS 
WITH cte_countGroup AS (SELECT AccountID , count(GroupID) AS countGroup
			FROM groupaccount
			GROUP BY AccountID)

SELECT  a.*, cte.countGroup AS so_nhom_tgia
FROM `account` a
JOIN cte_countGroup cte ON a.AccountID = cte.AccountID 
WHERE a.AccountID IN (SELECT AccountID 	
		      FROM cte_countGroup 
		      WHERE countGroup = (SELECT MAX(countGroup) FROM cte_countGroup)
			 );

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ  được coi là quá dài) và xóa nó đi
CREATE VIEW overLongContent AS
DELETE FROM question
WHERE QuestionID IN (	SELECT QuestionID
			FROM question
			WHERE length(content) > 300	);


-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE VIEW Top5BiggestDep AS
SELECT d.DepartmentName, count(AccountID) AS Workers
FROM `account` a
LEFT JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
ORDER BY Workers DESC
LIMIT 0,5;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE VIEW listQuesByNguyen AS
SELECT q.QuestionID, q.Content, a.FullName AS Creator
FROM question q
JOIN `account` a ON q.CreatorID = a.AccountID
WHERE a.AccountID IN (	SELECT AccountID 
			FROM `account`
			WHERE FullName Like 'Nguyễn%' );
