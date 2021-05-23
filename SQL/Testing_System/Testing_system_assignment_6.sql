USE testingsystem3;

-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

DROP PROCEDURE IF EXISTS info_workers_fromdep;
DELIMITER $$
CREATE PROCEDURE getInfo_workers_byInputDep (IN in_dep_name VARCHAR(30))
	BEGIN
		SELECT a.* 
		FROM `account` a
		LEFT JOIN department d ON a.DepartmentID = d.DepartmentID
		WHERE in_dep_name = d.departmentName;
	END $$    
DELIMITER ;

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS getNumberOf_members ;
DELIMITER $$
CREATE PROCEDURE getNumberOf_members ()
	BEGIN
		SELECT g.GroupName, COUNT(ga.AccountID) AS numberOfMembers
       	 	FROM groupaccount ga
        	JOIN `group` g ON ga.GroupID = g.GroupID
        	GROUP BY ga.GroupID;
	END $$    
DELIMITER ;

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS getNumberOf_ques_createdThisMonth ;
DELIMITER $$
CREATE PROCEDURE getNumberOf_ques_createdThisMonth (IN in_typeQues MEDIUMINT UNSIGNED, IN in_curMonth TINYINT UNSIGNED)
	BEGIN
		SELECT 	tq.TypeName, count(QuestionID) as NumberOf_ques_createdThisMonth
       		FROM 	question q
       		JOIN 	typequestion tq ON q.TypeID = tq.TypeID
        	WHERE 	in_curMonth = MONTH(q.CreateDate) 
				AND 	YEAR(q.CreateDate) = YEAR(curdate()) 
				AND 	in_typeQues = q.TypeID
        GROUP BY tq.TypeID;
	END $$    
DELIMITER ;

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất

DROP PROCEDURE IF EXISTS getID_typeQues_haveMostQues ;
DELIMITER $$
CREATE PROCEDURE getID_typeQues_haveMostQues ()
	BEGIN
		WITH cte_countQues AS (	SELECT q.TypeID, tq.TypeName, COUNT(QuestionID) AS countQues
					FROM question q
					JOIN typequestion tq ON q.TypeID = tq.TypeID
					GROUP BY q.TypeID )
		SELECT tq.TypeID
       		FROM typequestion tq
        	JOIN cte_countQues cq ON tq.TypeID = cq.TypeID
        	WHERE countQues = (	SELECT MAX(countQues) 
					FROM cte_countQues 	);
	END$$
DELIMITER ;
-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question 

DROP PROCEDURE IF EXISTS getName_typeQues_haveMostQues ;
DELIMITER $$
CREATE PROCEDURE getName_typeQues_haveMostQues ()
	BEGIN
		WITH cte_countQues AS (	SELECT q.TypeID, tq.TypeName, COUNT(QuestionID) AS countQues
					FROM question q
					JOIN typequestion tq ON q.TypeID = tq.TypeID
					GROUP BY q.TypeID )
		SELECT tq.TypeName
        	FROM typequestion tq
        	JOIN cte_countQues cq ON tq.TypeID = cq.TypeID
        	WHERE countQues = (	SELECT MAX(countQues) 
					FROM cte_countQues 	);
	END$$
DELIMITER ;

/* Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên 
				chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa 
				chuỗi của người dùng nhập vào*/

DROP PROCEDURE IF EXISTS getUserName_orGroupName;
DELIMITER $$
CREATE PROCEDURE getUserName_orGroupName (IN in_userString VARCHAR(50))
	BEGIN
		SELECT	username 
        	FROM	`account` 
        	WHERE	username LIKE CONCAT ('%',in_userString,'%');
        
        	SELECT	GroupName 
        	FROM 	`group`
        	WHERE 	GroupName LIKE CONCAT ('%',in_userString,'%');
	END $$    
DELIMITER ;


/* Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
username sẽ giống email nhưng bỏ phần @..mail đi
positionID: sẽ có default là developer
departmentID: sẽ được cho vào 1 phòng chờ 
 Sau đó in ra kết quả tạo thành công */
 
 DROP PROCEDURE IF EXISTS insertNew_acc;
DELIMITER $$
CREATE PROCEDURE insertNew_acc (IN in_fullName VARCHAR(50), IN in_email VARCHAR(50))
	BEGIN
		DECLARE in_Username 		VARCHAR(50) DEFAULT SUBSTRING_INDEX(in_email,'@',1);
        	DECLARE in_PositionID 		MEDIUMINT UNSIGNED DEFAULT 1 ;
        	DECLARE in_DepartmentID		MEDIUMINT UNSIGNED DEFAULT 10 ;
        
		INSERT INTO `account` 	( Fullname	, 	Username, 	Email, 		PositionID, 	DepartmentID )
        	VALUES			( in_fullName	,	in_Username,	in_email,	in_positionID,	in_departmentID);
        
       	 	SELECT *
        	FROM `Account`
        	WHERE Username = in_Username;
	END $$    
DELIMITER ;
 
 
 
/* Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
 để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất */
 DROP PROCEDURE IF EXISTS getQues_mostLongContent;
 DELIMITER $$
 CREATE PROCEDURE getQues_mostLongContent (IN in_typeQues ENUM('essay','multiple-choice'))
	BEGIN
		WITH cte_length AS ( 	SELECT 	QuestionID, length(content) AS length_content
					FROM	question 					)
        SELECT q.QuestionID, q.Content
        FROM question q
        JOIN typequestion tq ON q.TypeID = tq.TypeID
	WHERE tq.TypeName = in_typeQues AND length(q.Content) = (SELECT MAX(length_content)
								 FROM cte_length		);
    END $$
DELIMITER ;


-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS delExam_byItsID;
DELIMITER $$
CREATE PROCEDURE delExam_byItsID (IN in_examID MEDIUMINT UNSIGNED)
	BEGIN
		DELETE 
        	FROM exam
        	WHERE ExamID = in_examID;
    END $$

/* Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử 
 dụng store ở câu 9 để xóa)
 Sau đó in số lượng record đã remove từ các table liên quan trong khi 
 removing */
 
 SET @x = (	SELECT ExamID
		FROM exam
		WHERE year(curdate()) -  year(CreateDate) >= 3 );
 
 CALL delExam_byItsID (@X);
 
/* Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng 
 nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được 
 chuyển về phòng ban default là phòng ban chờ việc */
 -- create 'phòng ban chờ việc'
	INSERT INTO Department 	(	DepartmentID	, 	DepartmentName	)
	VALUES			(	    13		, 	'Waiting'	);
 
 DROP PROCEDURE IF EXISTS delDep_byItsName;
 DELIMITER $$
 CREATE PROCEDURE delDep_byItsName (IN in_depName VARCHAR(50))
 	BEGIN
	
    		SET @X = (	SELECT	DepartmentID
				FROM 	Department
				WHERE 	DepartmentName = in_depName	);
   
   	 	DELETE FROM department
    		WHERE departmentID = @X;
    
		UPDATE	`account`
		SET DepartmentID = 13
		WHERE DepartmentID = @X;
 	END $$
 DELIMITER ;
 
-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
DROP PROCEDURE IF EXISTS getNumbers_Ques_everyMonth;
DELIMITER $$
CREATE PROCEDURE getNumbers_Ques_everyMonth()
	BEGIN
		SELECT MONTH(CreateDate) AS 'Month', COUNT(QuestionID) AS question_created_this_month
		FROM question
		WHERE  YEAR(curDate()) - YEAR(CreateDate) = 0
	    GROUP BY MONTH(CreateDate);
	END $$
DELIMITER ;
	
 

/* Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 
 tháng gần đây nhất
 (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong 
tháng") */
DROP PROCEDURE IF EXISTS getNumber_ofQues_last6Months;
DELIMITER $$
CREATE PROCEDURE getNumber_ofQues_last6Months()
	BEGIN
		WITH cte_countQues AS (	SELECT YEAR(CreateDate) AS 'YEAR', MONTH(CreateDate) AS 'MONTH', COUNT(QuestionID) AS quescreated
					FROM question
					WHERE DATE_SUB(curDate(), INTERVAL 6 MONTH) <= CreateDate AND CreateDate <= CurDate()
					GROUP BY MONTH(CreateDate)
					ORDER BY YEAR(CreateDate))
		SELECT SUM(quescreated) AS quesCreatedLast6Month
		FROM cte_countQues;
	END $$
DELIMITER ;
