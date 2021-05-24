USE testingsystem3;
-- tao phong ban cho viec
	INSERT INTO Department 	(	DepartmentID	, 	DepartmentName	)
	VALUES			(	    13		,	'Waiting'	);

-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

DROP PROCEDURE IF EXISTS getAccs_byDepName;
DELIMITER $$
CREATE PROCEDURE getAccs_byDepName (IN in_dep_name VARCHAR(30))
	BEGIN
		SELECT 		a.* 
		FROM 		`account` a
		LEFT JOIN 	department d ON a.DepartmentID = d.DepartmentID
		WHERE 		d.departmentName = in_dep_name;
	END $$    
DELIMITER ;

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS getNumberOf_members ;
DELIMITER $$
CREATE PROCEDURE getNumberOf_members ()
	BEGIN
		SELECT 		g.GroupName, COUNT(ga.AccountID) AS numberOfMembers
		FROM 		groupaccount ga
		JOIN 		`group` g ON ga.GroupID = g.GroupID
		GROUP BY 	ga.GroupID;

		SELECT 		g.GroupName, COUNT(ga.AccountID) AS numberOfMembers
       	 	FROM 		groupaccount ga
        	JOIN 		`group` g ON ga.GroupID = g.GroupID
        	GROUP BY 	ga.GroupID;
	END $$    
DELIMITER ;

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS getNumberOf_ques_createdThisMonth ;
DELIMITER $$
CREATE PROCEDURE getNumberOf_ques_createdThisMonth ()
	BEGIN

		SELECT 		tq.TypeName, count(QuestionID) as NumberOf_ques_createdThisMonth
		FROM 		question q
		JOIN 		typequestion tq ON q.TypeID = tq.TypeID
		WHERE		YEAR(q.CreateDate) = YEAR(curdate()) AND MONTH(q.CreateDate) = MONTH(curdate())
		GROUP BY 	q.TypeID;

		SELECT 		tq.TypeName, count(QuestionID) as NumberOf_ques_createdThisMonth
       		FROM 		question q
       		JOIN 		typequestion tq ON q.TypeID = tq.TypeID
        	WHERE 		in_curMonth = MONTH(q.CreateDate) 
				AND 	YEAR(q.CreateDate) = YEAR(curdate()) 
				AND 	in_typeQues = q.TypeID
        	GROUP BY tq.TypeID;

	END $$    
DELIMITER ;

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất

DROP PROCEDURE IF EXISTS getID_typeQues_haveMostQues ;
DELIMITER $$
CREATE PROCEDURE getID_typeQues_haveMostQues (OUT out_typeID MEDIUMINT UNSIGNED)
	BEGIN

		WITH 	cte_countQues 	AS (	SELECT q.TypeID, COUNT(QuestionID) AS countQues
						FROM question q
						JOIN typequestion tq ON q.TypeID = tq.TypeID
						GROUP BY q.TypeID )
		SELECT 	tq.TypeID INTO out_typeID
		FROM 	typequestion tq
		JOIN 	cte_countQues cq ON tq.TypeID = cq.TypeID
		WHERE 	countQues = (SELECT MAX(countQues) FROM cte_countQues);
	END$$
DELIMITER ;

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question 
SET 	@id = 0;
CALL 	getID_typeQues_haveMostQues (@id);
SELECT 	@id;

SELECT 	typeName 
FROM 	typequestion
WHERE 	typeID = @id;
 
/* Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên 
				chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa 
				chuỗi của người dùng nhập vào*/

DROP PROCEDURE IF EXISTS findUser_orGroup;
DELIMITER $$
CREATE PROCEDURE findUser_orGroup (IN in_userString VARCHAR(50))
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
		DECLARE in_DepartmentID		MEDIUMINT UNSIGNED DEFAULT 13 ;
		
		INSERT INTO `account` 	( Fullname	, 	Username, 	Email, 		PositionID, 	DepartmentID )
        	VALUES			( in_fullName	,	in_Username,	in_email,	in_positionID,	in_departmentID);
        

		SELECT 	*
		FROM 	`Account`
		WHERE 	Username = in_Username;
	END $$    
DELIMITER ;
 
 
 
/* Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
 để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất */
 DROP PROCEDURE IF EXISTS getQues_mostLongContent;
 DELIMITER $$
 CREATE PROCEDURE getQues_mostLongContent (IN in_typeQues ENUM('essay','multiple-choice'))
	BEGIN
		WITH cte_length AS (	SELECT QuestionID, length(content) AS length_content
					FROM	question 	)
        	
		SELECT q.QuestionID, q.Content
		FROM question q
		JOIN typequestion tq ON q.TypeID = tq.TypeID
		WHERE tq.TypeName = in_typeQues AND length(q.Content) = (SELECT MAX(length_content) FROM cte_length);

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
 
 	SET @x = 0;	
 	SELECT ExamID INTO @x
	FROM exam
	WHERE (year(curdate()) -  year(CreateDate)) >= 3;
 	SELECT @x;
 	CALL delExam_byItsID (@x);
 
 ***
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

    		SET 	@x2 = 0;	
		
		SELECT	DepartmentID INTO @x2
		FROM 	Department
		WHERE 	DepartmentName = in_depName;
		
		SELECT 	@x2;
 
		DELETE FROM 	department
		WHERE 		departmentID = @X2;
		
		UPDATE		`account`
		SET 		DepartmentID = 13
		WHERE 		DepartmentID IS NULL;


 DELIMITER ;
 
-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
DROP PROCEDURE IF EXISTS getNumbers_Ques_everyMonth_ThisYear;
DELIMITER $$
<<<<<<< HEAD
CREATE PROCEDURE getNumbers_Ques_everyMonth_ThisYear()
	BEGIN
		SELECT		MONTH(CreateDate) AS 'Month', COUNT(*) AS question_created
		FROM 		question
		WHERE  		YEAR(curDate()) - YEAR(CreateDate) = 0
		GROUP BY	MONTH(CreateDate);
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
		DROP TABLE IF EXISTS list_last6Months_fromNow;
		CREATE TABLE 	list_last6Months_fromNow ( years INT, months VARCHAR(10) );
		INSERT INTO 	list_last6Months_fromNow (years,months) VALUES 	( YEAR(curDate()), MONTHNAME(curDate()));
		INSERT INTO 	list_last6Months_fromNow (years,months) VALUES	( YEAR(DATE_SUB(curDate(), INTERVAL 1 MONTH)), MONTHNAME(DATE_SUB(curDate(), INTERVAL 1 MONTH)));
		INSERT INTO 	list_last6Months_fromNow (years,months) VALUES	( YEAR(DATE_SUB(curDate(), INTERVAL 2 MONTH)), MONTHNAME(DATE_SUB(curDate(), INTERVAL 2 MONTH)));
		INSERT INTO 	list_last6Months_fromNow (years,months) VALUES	( YEAR(DATE_SUB(curDate(), INTERVAL 3 MONTH)), MONTHNAME(DATE_SUB(curDate(), INTERVAL 3 MONTH)));
		INSERT INTO 	list_last6Months_fromNow (years,months) VALUES	( YEAR(DATE_SUB(curDate(), INTERVAL 4 MONTH)), MONTHNAME(DATE_SUB(curDate(), INTERVAL 4 MONTH)));
		INSERT INTO 	list_last6Months_fromNow (years,months) VALUES	( YEAR(DATE_SUB(curDate(), INTERVAL 5 MONTH)), MONTHNAME(DATE_SUB(curDate(), INTERVAL 5 MONTH)));
		INSERT INTO 	list_last6Months_fromNow (years,months) VALUES	( YEAR(DATE_SUB(curDate(), INTERVAL 6 MONTH)), MONTHNAME(DATE_SUB(curDate(), INTERVAL 6 MONTH)));
        
        	WITH cte_countques AS	(	SELECT 		YEAR(CreateDate) AS 'Years', 
					 			MONTHNAME(CreateDate) AS 'Months', 
					 			COUNT(QuestionID) AS ques_created 
						FROM 		question
						WHERE 		CreateDate >= DATE_SUB(curDate(), INTERVAL 6 MONTH) AND CreateDate <= CurDate()
						GROUP BY 	MONTH(CreateDate), YEAR(CreateDate)
						ORDER BY 	YEAR(CreateDate),  MONTH(CreateDate)	)
                        
		SELECT 		A.years AS 'YEAR', 
				A.months AS 'MONTH', 
                    		IF(B.ques_created IS NOT NULL, B.ques_created , 'No Question is Created') AS Ques_created
        	FROM 		list_last6Months_fromNow A 
        	LEFT JOIN 	cte_countques B ON A.years = B.years AND A.months = B.months;

	END $$
DELIMITER ;





