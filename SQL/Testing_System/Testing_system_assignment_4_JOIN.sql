USE testingsystem3;

-- Exercise 1: Join

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT A.accountid AS ID, A.fullname AS Fullname, D.departmentname AS Department
FROM `account` A
LEFT JOIN department D ON A.DepartmentID = D.DepartmentID
ORDER BY accountid;


-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
WITH date_1 AS (SELECT accountid, createdate FROM `account` WHERE createdate >= '2010-12-20')
SELECT a.AccountID, a.Email, a.Username, a.FullName, a.DepartmentID, a.PositionID, b.CreateDate
FROM `account` a
INNER JOIN date_1 b ON a.AccountID = b.AccountID;


-- Question 3: Viết lệnh để lấy ra tất cả các developer 
SELECT a.AccountID AS ID, a.FullName, b.PositionName AS 'Position'
FROM `account` a
RIGHT JOIN `position` b ON a.PositionID = b.PositionID
WHERE a.PositionID = 1;


-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
WITH department_1 AS (	SELECT DepartmentID, COUNT(AccountID) AS countacc
			FROM `account`
			GROUP BY DepartmentID
			ORDER BY DepartmentID	)
SELECT  d.DepartmentName, d1.countacc AS so_luong
FROM department d
JOIN department_1 d1 ON d.DepartmentID = d1.DepartmentID
WHERE d1.countacc >=25;


-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
WITH question_1 AS (	SELECT QuestionID, COUNT(ExamID) AS numberOfUses
			FROM examquestion
			GROUP BY QuestionID	)
SELECT q.*, q1.numberOfUses
FROM question q
LEFT JOIN question_1 q1 ON q.QuestionID= q1.QuestionID
WHERE q1.numberOfUses = ( SELECT MAX(numberOfUses) FROM question_1 )  ;


-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
WITH category_1 AS (	SELECT CategoryID, COUNT(QuestionID) AS countques
			FROM question
			GROUP BY CategoryID	)
SELECT cq.CategoryName, c1.countques AS so_lan_SD
FROM categoryquestion cq
JOIN category_1 c1 ON cq.CategoryID = c1.CategoryID;


-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
WITH question_1 AS (	SELECT QuestionID, COUNT(ExamID) AS countexam
			FROM examquestion
			GROUP BY QuestionID	)
SELECT q.QuestionID, q.Content, q1.countexam AS so_lan_SD
FROM question q
LEFT JOIN question_1 q1 ON q.QuestionID = q1.QuestionID;

-- Q7 cach 2:
SELECT q.QuestionID, q.Content, COUNT(eq.QuestionID)
FROM question q
LEFT JOIN examquestion eq ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID;


-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
WITH answer_1 AS (	SELECT QuestionID, COUNT(AnswerID) AS countans
			FROM answer
			GROUP BY QuestionID	)
SELECT q.QuestionID, q.Content, ans.countans AS so_cau_tra_loi
FROM question q
LEFT JOIN answer_1 ans ON q.QuestionID =ans.QuestionID
WHERE ans.countans = (SELECT MAX(countans) FROM answer_1) ; 


-- Question 9: Thống kê số lượng account trong mỗi group
WITH group_1 AS ( 	SELECT GroupID, COUNT(AccountID) AS countacc
			FROM groupaccount
			GROUP BY GroupID 	)
SELECT g.GroupName, g1.countacc AS so_luong_acc
FROM `group` g
JOIN group_1 g1 ON g.GroupID = g1.GroupID;


-- Question 10: Tìm chức vụ có ít người nhất
WITH position_1 AS (	SELECT PositionID, COUNT(AccountID) AS countpos
			FROM `account`
			GROUP BY PositionID	)
SELECT p.PositionName, p1.countpos AS so_luong
FROM `position` p
JOIN position_1 p1 ON p.PositionID = p1.PositionID
WHERE p1.countpos = ( SELECT MIN(countpos) FROM position_1 ) ;


-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT d.DepartmentID, d.DepartmentName, p.PositionName, count(p.positionid) as SL
FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
INNER JOIN `position` p ON a.PositionID = p.PositionID
GROUP BY a.DepartmentID , a.PositionID; -- SAI




/* Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của  
question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …*/
SELECT q.QuestionID, q.Content, cq.CategoryName, tq.TypeName, acc.FullName AS Creator, ans.Content AS Answer
FROM question q
LEFT JOIN categoryquestion cq ON q.CategoryID= cq.CategoryID
LEFT JOIN typequestion tq ON q.TypeID = tq.TypeID
LEFT JOIN `account` acc ON q.CreatorID = acc.AccountID
LEFT JOIN answer ans ON q.QuestionID = ans.QuestionID;


-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
WITH type_1 AS ( 	SELECT TypeID, COUNT(QuestionID) AS countques
			FROM question
			GROUP BY TypeID		)
SELECT tq.TypeName AS dang_cau_hoi, t1.countques AS so_luong
FROM typequestion tq
JOIN type_1 t1 ON tq.TypeID = t1.TypeID;


-- Question 14:Lấy ra group không có account nào
WITH group_1 AS (	SELECT GroupID, COUNT(AccountID) AS countacc
			FROM groupaccount 
			GROUP BY GroupID	)
SELECT g.GroupName, g1.countacc AS so_tv
FROM `group` g
JOIN group_1 g1 ON g.GroupID = g1.GroupID
WHERE g1.countacc IS NULL;

-- Question 15:Lấy ra account không tham gia Group nào
SELECT a.*, ga.GroupID
FROM `account` a
LEFT JOIN `groupaccount` ga on a.AccountID = ga.AccountID
WHERE ga.GroupID IS NULL;


-- Question 16: Lấy ra question không có answer nào
WITH answer_1 AS (	SELECT QuestionID, COUNT(AnswerID) AS countans
			FROM answer
			GROUP BY QuestionID	)
SELECT q.QuestionID, q.Content, ans.countans AS so_cau_tl
FROM question q
LEFT JOIN answer_1 ans ON q.QuestionID =ans.QuestionID
WHERE ans.countans IS NULL ; 


