-- create database fresher
DROP DATABASE IF EXISTS fresher;
CREATE DATABASE fresher;
USE fresher;

-- create table trainee
DROP TABLE IF EXISTS Trainee;
CREATE TABLE Trainee (
	TraineeID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Full_Name			VARCHAR(50) NOT NULL,
    Birth_Date			DATE,
    Gender				ENUM('Male','Female','Unknow'),
    ET_IQ				TINYINT UNSIGNED CHECK ( ET_IQ >= 0 AND ET_IQ <=20),
    ET_Gmath			TINYINT UNSIGNED CHECK ( ET_Gmath >= 0 AND ET_Gmath <=20),
    ET_English			TINYINT UNSIGNED CHECK ( ET_English >= 0 AND ET_English <=50),
    Training_Class		CHAR(10) CHECK ( Training_Class LIKE 'VTI%'),
    Evaluation_Notes	CHAR(10)
);

-- insert data for table trainee
INSERT INTO Trainee (	Full_Name,					Birth_Date,		Gender,		ET_IQ,	ET_Gmath,	ET_English,	Training_Class,	Evaluation_Notes)
VALUES				('Pham Nhat Vuong',			'2000-08-05',		'Male',		20,		20,			50,			'VTI001',		'DHBB'),
					('Tran Dinh Long',			'1961-02-22',		'Male',		19,		20,			32,			'VTI002',		'DHBB'),
					('Bui Dinh Nhon',			'1958-07-07',		'Male',		3,		8,			39,			'VTI001',		'DHBB'),
					('Nguyen Van Duc',			'1990-06-02',		'Male',		6,		19,			9,			'VTI004',		'DHBB'),
					('Nguyen Dang Quang',		'1995-03-29',		'Male',		13,		18,			15,			'VTI004',		'DHBB'),
					('Nguyen Thi Phuong Thao',	'1997-06-28',		'Female',	17,		4,			3,			'VTI001',		'DHBB'),
					('Pham Thu Huong',			'2001-04-15',		'Female',	13,		3,			13,			'VTI001',		'DHBB'),
					('Nguyen Van Dat',			'2004-02-14',		'Male',		15,		4,			29,			'VTI003',		'DHBB'),
					('Nguyen Duc Thuy',			'1995-09-21',		'Male',		5,		1,			32,			'VTI003',		'DHBB'),
					('Vu Thi Hien',				'1985-01-12',		'Female',	18,		14,			1,			'VTI001',		'DHBB');
                    
/* Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào,
và sắp xếp theo ngày sinh. Điểm ET_IQ >=12, ET_Gmath>=12, ET_English>=20*/
SELECT * 
FROM Trainee 
WHERE ET_IQ >= 12 AND ET_Gmath >= 12 AND ET_English >=20;

/*Question 5: Viết lệnh để lấy ra thông tin thực tập sinh có tên bắt đầu bằng chữ N và kết thúc
bằng chữ C*/
SELECT *
FROM Trainee
WHERE Full_Name LIKE 'N%c';

/*Question 6: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có ký thự thứ 2 là chữ G*/
SELECT *
FROM Trainee
WHERE Full_Name LIKE '_g%';

/*Question 7: Viết lệnh để lấy ra thông tin thực tập sinh mà tên có 10 ký tự và ký tự cuối cùng 
là C*/
SELECT *
FROM Trainee
WHERE length(Full_Name)=10 AND Full_name LIKE '%c';

/*Question 8:  Viết lệnh để lấy ra Fullname của các thực tập sinh trong lớp, lọc bỏ các tên trùng 
nhau.*/
SELECT DISTINCT Full_Name
FROM Trainee; 

/*Question 9: Viết lệnh để lấy ra Fullname của các thực tập sinh trong lớp, sắp xếp các tên này 
theo thứ tự từ A-Z.*/
SELECT Full_Name
FROM Trainee
ORDER BY Full_Name;

/*Question 10:  Viết lệnh để lấy ra thông tin thực tập sinh có tên dài nhất*/
SELECT *
FROM Trainee
WHERE length(Full_Name) = (SELECT MAX(length(Full_Name)) FROM Trainee);
							
/*Question 11: Viết lệnh để lấy ra ID, Fullname và Ngày sinh thực tập sinh có tên dài nhất*/
SELECT TraineeID, Full_Name, Birth_date 
FROM Trainee
WHERE  length(Full_Name) = (SELECT MAX(length(Full_Name)) FROM Trainee);

/*Question 12:  Viết lệnh để lấy ra Tên, và điểm IQ, Gmath, English thực tập sinh có tên dài 
nhất */
SELECT Full_Name, ET_IQ, ET_Gmath, ET_English
FROM Trainee
WHERE  length(Full_Name) = (SELECT MAX(length(Full_Name)) FROM Trainee);

/*Question 13: Lấy ra 5 thực tập sinh có tuổi nhỏ nhất*/
SELECT *
FROM Trainee
ORDER BY Birth_Date DESC
LIMIT 5;

/*Question 14: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là
những người thỏa mãn số điểm như sau:
• ET_IQ + ET_Gmath>=20
• ET_IQ>=8
• ET_Gmath>=8
• ET_English>=18 */
SELECT *
FROM Trainee
WHERE  (ET_IQ + ET_Gmath)>=20 AND ET_IQ>=8 AND ET_Gmath>=8 AND  ET_English>=18;

/*Question 15: Xóa thực tập sinh có TraineeID = 5*/
DELETE FROM Trainee
WHERE TraineeID = 5;

/*Question 16: Xóa thực tập sinh có tổng điểm ET_IQ, ET_Gmath <=15*/

DELETE FROM Trainee
WHERE (ET_IQ + ET_Gmath) <= 15;


/*Question 17: Xóa thực tập sinh quá 30 tuổi*/
DELETE FROM Trainee
WHERE (SELECT YEAR(Birth_Date) FROM Trainee) + 30 <= YEAR(curdate());


/*Question 18: Thực tập sinh có TraineeID = 3 được chuyển sang lớp " VTI003". Hãy cập nhật
thông tin vào database*/
UPDATE Trainee
SET Training_Class = 'VTI003'
WHERE TraineeID = 3;

/*Question 19: Do có sự nhầm lẫn khi nhập liệu nên thông tin của học sinh số 10 đang bị sai, 
hãy cập nhật lại tên thành “LeVanA”, điểm ET_IQ =10, điểm ET_Gmath =15, điểm 
ET_English = 30 */
UPDATE Trainee
SET Full_Name = 'LeVanA', ET_IQ = 10, ET_Math = 15, ET_English = 30
WHERE TraineeID	= 10;

/*Question 20: Đếm xem trong lớp VTI001 có bao nhiêu thực tập sinh.*/
SELECT COUNT(Training_Class) AS So_hoc_sinh_VTI001
FROM Trainee
WHERE Training_Class = 'VTI001';


/*Question 22: Đếm tổng số thực tập sinh trong lớp VTI001 và VTI003 có bao nhiêu thực tập 
sinh.*/
SELECT COUNT(TraineeID) AS Tong_thuc_tap_sinh_lop_001_va_003
FROM Trainee
WHERE Training_Class = 'VTI001' OR Training_Class = 'VTI003';

/*Question 23: Lấy ra số lượng các thực tập sinh theo giới tính: Male, Female, Unknown.*/
SELECT Gender, COUNT(*) AS so_luong_thuc_tap_sinh
FROM Trainee
GROUP BY Gender;

/*Question 24: Lấy ra lớp có lớn hơn 5 thực tập viên*/
SELECT Training_Class AS Lop_co_nhieu_hon_5_tts
FROM Trainee
GROUP BY Training_Class
HAVING COUNT(TraineeID) >=5;

/*Question 26: Lấy ra trường có ít hơn 4 thực tập viên tham gia khóa học*/
SELECT Evaluation_Notes AS Ten_truong
FROM Trainee
GROUP BY Evaluation_Notes
HAVING COUNT(*) <=4;

/*Question 27: */
-- Lấy ra danh sách thông tin ID, Fullname, lớp thực tập viên có lớp 'VTI001'
SELECT TraineeID, Full_Name
FROM Trainee
WHERE Training_Class = 'VTI001'
-- Lấy ra danh sách thông tin ID, Fullname, lớp thực tập viên có lớp 'VTI002'
-- Sử dụng UNION để nối 2 kết quả ở bước 1 và 2
UNION
SELECT TraineeID, Full_Name
FROM Trainee
WHERE Training_Class = 'VTI002'
ORDER BY TraineeID;




