USE testingsystem3;

-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước
DROP TRIGGER IF EXISTS question1;
DELIMITER $$
CREATE TRIGGER question1
BEFORE INSERT ON `Group` 
FOR EACH ROW
    BEGIN
    -- logic
	IF 	
		NEW.CreateDate < DATE_SUB(curDate(), INTERVAL 1 YEAR) 
		THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'YOUR GROUP IS OUT OF DATE';
		END IF;
    	END $$
DELIMITER ;

/* Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào 
 department "Sale" nữa, khi thêm thì hiện ra thông báo "Department "Sale" cannot add more user"*/
DROP TRIGGER IF EXISTS question2;
DELIMITER $$
CREATE TRIGGER question2
BEFORE INSERT ON `account` 
FOR EACH ROW 
	BEGIN
	-- logic
		DECLARE var_depID TINYINT UNSIGNED;
		SELECT departmentID INTO var_depID FROM department WHERE DepartmentName = 'Sale';
		IF NEW.DepartmentID = var_depID 
		THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = 'Department "Sale" cannot add more user';
		END IF;
	END $$
 DELIMITER ;

-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS question3;
DELIMITER $$
CREATE TRIGGER question3 
BEFORE INSERT ON groupaccount
FOR EACH ROW
	BEGIN
		DECLARE  check_nb TINYINT UNSIGNED;
		SELECT 	 COUNT(AccountID) INTO check_nb
		FROM 	 groupaccount
		WHERE 	 GroupID = NEW.GroupID
		GROUP BY GroupID;

		IF check_nb >= 5 THEN
			SIGNAL SQLSTATE '12345'
		    	SET MESSAGE_TEXT = 'The chosen Group is full. Please join another Group :D';
		END IF;
        
	END $$
DELIMITER ;

-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DROP TRIGGER IF EXISTS question4;
DELIMITER $$
CREATE TRIGGER question4 
BEFORE INSERT ON examquestion
FOR EACH ROW
	BEGIN
		DECLARE  check_nb_2 TINYINT UNSIGNED;
        	SELECT 	 COUNT(QuestionID) INTO check_nb_2
        	FROM 	 examquestion 
		GROUP BY NEW.ExamID;
        
		IF check_nb_2 >= 10 THEN
			SIGNAL SQLSTATE '12345'
            		SET MESSAGE_TEXT = 'Stop adding question. 10 is enough!';
		END IF;
	END $$
DELIMITER ;

/* Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là 
 admin@gmail.com (đây là tài khoản admin, không cho phép user xóa), 
 còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông 
 tin liên quan tới user đó */
DROP TRIGGER IF EXISTS question5;
DELIMITER $$
CREATE TRIGGER question5
BEFORE DELETE ON `account`
FOR EACH ROW
	BEGIN
		DECLARE check_mail VARCHAR(50);
		SELECT 	email INTO check_mail
		FROM 	`account`
		WHERE 	accountID = OLD.accountID;
        
        	IF check_mail = 'admin@gmail.com' THEN
			SIGNAL SQLSTATE '12345'
            		SET MESSAGE_TEXT = 'This is account of Admin. Stop doing stupid thing!';
		END IF;

	END $$
DELIMITER ;

/* Question 6: Không sử dụng cấu hình default cho field DepartmentID của table 
 Account, hãy tạo trigger cho phép người dùng khi tạo account không điền 
 vào departmentID thì sẽ được phân vào phòng ban "waiting Department" */
DROP TRIGGER IF EXISTS question6;
DELIMITER $$
CREATE TRIGGER question6 
BEFORE INSERT ON `account`
FOR EACH ROW
	BEGIN
        	IF 	NEW.DepartmentID IS NULL 
		THEN
			SET NEW.DepartmentID = 13;
		END IF;
	END $$
DELIMITER ;

/* Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi 
 question, trong đó có tối đa 2 đáp án đúng. */
DROP TRIGGER IF EXISTS set_answer_ofExam;
DELIMITER $$
CREATE TRIGGER set_answer_ofExam 
BEFORE INSERT ON examquestion
FOR EACH ROW
	BEGIN
		-- create variable
		DECLARE var_answers TINYINT UNSIGNED;
		DECLARE var_Correctanswers TINYINT UNSIGNED;

		SELECT 	  COUNT(A.AnswerID) INTO var_answers
		FROM 	  examquestion	EQ
		LEFT JOIN answer 	A 	ON A.QuestionID = EQ.QuestionID
		WHERE 	  ExamID = NEW.ExamID
		GROUP BY  EQ.ExamID, EQ.QuestionID;

		SELECT 	  COUNT(A.isCorrect) INTO var_Correctanswers
		FROM 	  examquestion EQ
		LEFT JOIN answer  	A     	ON A.QuestionID = EQ.QuestionID
		WHERE 	  ExamID = NEW.ExamID AND A.isCorrect = 1 
		GROUP BY  EQ.ExamID, EQ.QuestionID;
		-- logic
		IF var_answers > 4 
		THEN 
			SIGNAL SQLSTATE '12345'
		   	 SET MESSAGE_TEXT = 'Every question have only four answers in maximum';
		END IF;
		-- logic 2
		IF var_Correctanswers > 2 
		THEN 
			SIGNAL SQLSTATE '12345'
		   	SET MESSAGE_TEXT = 'Every question have only two correct answers in maximum';
		END IF;
	END $$
DELIMITER ;



/* Question 8: Viết trigger sửa lại dữ liệu cho đúng: 
 Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định 
 Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database */
 DROP TRIGGER IF EXISTS question8 ;
 DELIMITER $$
 CREATE TRIGGER question8
 AFTER INSERT ON `account`
 FOR EACH ROW
	BEGIN
		IF  NEW.gender = 'nam' THEN
		SET NEW.gender = 'M';
		END IF;

		IF  NEW.gender = 'nu' THEN
		SET NEW.gender = 'F';
		END IF;

		IF  NEW.gender = 'chưa xác định' OR NEW.gender IS NULL THEN
		SET NEW.gender = 'U';
		END IF;
    END $$
DELIMITER ;
 
-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS question9 ;
DELIMITER $$
CREATE TRIGGER question9
BEFORE DELETE ON `question`
FOR EACH ROW
	BEGIN
		IF
		YEAR(NEW.CreateDate) 	= YEAR(curdate()) 	AND
            	MONTH(NEW.CreateDate) 	= MONTH(curdate()) 	AND
           	DAY(curdate()) - DAY(NEW.CreateDate) <= 2
		THEN
			SIGNAL SQLSTATE '12345'
            		SET MESSAGE_TEXT = 'You can only delete questions after creating 2 days';
		END IF;
    END $$
DELIMITER ;
/* Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các 
 question khi question đó chưa nằm trong exam nào */
 DROP TRIGGER IF EXISTS question10 ;
 DELIMITER $$
 CREATE TRIGGER question10
 BEFORE UPDATE ON `question`
 FOR EACH ROW 
	BEGIN
		DECLARE countExam TINYINT UNSIGNED;
        
        	SELECT    COUNT(ExamID) INTO countExam
		FROM      `question`	Q
		LEFT JOIN examquestion	EQ ON Q.QuestionID = EQ.QuestionID
		WHERE 	  QuestionID = OLD.QuestionID
        	GROUP BY  Q.QuestionID;
        
       		IF countExam > 0 
		THEN
			SIGNAL SQLSTATE '12345'
            		SET MESSAGE_TEXT = 'You can only update question that is not in any question';
		END IF;
	END $$
 DELIMITER ;
 
/* Question 12: Lấy ra thông tin exam trong đó:
Duration <= 30 thì sẽ đổi thành giá trị "Short time"
30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
Duration > 60 thì sẽ đổi thành giá trị "Long time" */
SELECT ExamID, Duration,
	CASE 
		WHEN Duration <= 30 THEN 'Short time'
		WHEN Duration > 60 THEN 'Long time'
		ELSE 'Medium Time'
	END AS Duration_Text
FROM Exam;

/* Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên 
 là the_number_user_amount và mang giá trị được quy định như sau:
 Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher */
SELECT G.GroupName, count(GA.AccountID) AS so_tv,
	CASE
	    	WHEN count(GA.AccountID) <= 5 THEN 'few'
		WHEN count(GA.AccountID) > 20 THEN 'higher'
	    	ELSE 'normal'
	END AS the_number_user_amount
FROM groupaccount	GA
JOIN `group`		G 	ON 	GA.GroupID = G.GroupID
GROUP BY GA.GroupID;

/* Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào không có user thì 
sẽ thay đổi giá trị 0 thành "Không có User" */
SELECT IF(COUNT(*) = 0, 'Không có User', COUNT(*)) AS so_nv, D.DepartmentName
FROM `account`		A
JOIN department		D ON A.DepartmentID = D.DepartmentID
GROUP BY A.DepartmentID;
