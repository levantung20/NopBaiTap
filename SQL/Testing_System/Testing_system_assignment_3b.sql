USE testingsystem3;
	-- Bai lam cau 2
	SELECT * 
    FROM Department
    ORDER BY DepartmentID ASC;
	
    -- Bai lam cau 3
	SELECT DepartmentID AS ID_phong_Sale 
    FROM Department 
	WHERE DepartmentName LIKE '%Sale%';
	
    -- Bai lam cau 4
    SELECT *
    FROM `Account`
    WHERE length(FullName) = (
				SELECT MAX(length(FullName))
                FROM `Account`);

    -- Bai lam cau 5
	SELECT *
    FROM `Account`
    WHERE length(FullName) = (
							SELECT MAX(length(FullName))
							FROM `Account`
                            WHERE DepartmentID = 3) AND DepartmentID = 3;
	
    -- Bai lam cau 6
    SELECT GroupName 
    FROM `Group`
    WHERE CreateDate <= '2019-12-20';
    
    -- Bai lam cau 7
    SELECT QuestionID AS cau_hoi, COUNT(AnswerID) AS so_cau_tra_loi
    From Answer
    GROUP BY QuestionID
    HAVING so_cau_tra_loi >= 4;
	
    -- Bai lam cau 8
    SELECT `Code` 
    FROM Exam
    WHERE Duration >=60 AND CreateDate >= '2019-12-20';
    
    -- Bai lam cau 9
    SELECT *
    FROM `Group`
	ORDER BY CreateDate DESC
    LIMIT 0,5;
			
    -- Bai lam cau 10
    SELECT COUNT(AccountID) AS So_nhan_vien_phong_ban_2
    FROM `Account`
    WHERE DepartmentID=2;
    
    -- Bai lam cau 11
    SELECT Fullname 
    FROM `Account`
    WHERE Fullname LIKE 'D%o';
    
    -- Bai lam cau 12
    DELETE FROM Exam
    WHERE CreateDate <= '2019-12-20';
    
    -- Bai lam cau 13
    DELETE FROM Question
    WHERE content LIKE 'Cau hoi%';
    
    -- Bai lam cau 14
    UPDATE `Account`
    SET Fullname='Nguyen Ba Loc', Email='loc.nguyenba@vti.com.vn'
    WHERE AccountID = 5;
    
    -- Bai lam cau 15
    UPDATE GroupAccount
    SET GroupID = 4
    WHERE AccountID = 5;