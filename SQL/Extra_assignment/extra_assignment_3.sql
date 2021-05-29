USE fresher;

-- Exercise 1

-- Question 1: Thêm ít nhất 10 bản ghi vào table
INSERT INTO trainee (Full_name,VTI_account,Birth_Date,Gender,ET_IQ,ET_GMath,ET_English,Training_Class,Evaluation_Notes)
VALUES				('Harry Lamb','harrylamb','1990-06-22','male',9,12,11,'VTI001','DHBK'),
					('James Baker','jamesbaker','1993-03-25','male',13,2,31,'VTI001','DHKTQD'),
                    ('Roy Stotts','roystotts','1998-03-30','male',19,7,4,'VTI001','DHBK'),
                    ('Bobby Hua','bobbyhua','1993-09-23','male',1,13,27,'VTI001','DHBK'),
                    ('Melanie Sumner','melaniesum','1994-11-25','female',1,8,26,'VTI002','DHVN'),
                    ('Herbert Calderon','herbertcalderon','1997-04-02','male',7,5,8,'VTI002','DHBK'),
                    ('Janet Litten','janetlitten','1993-24-07','female',15,8,47,'VTI002','DHTM'),
                    ('Jackie Barrentine','jackiebarren','1994-05-05','female',6,10,33,'VTI003','DHTM'),
                    ('Richard Campbell','richardcamp','1997-04-20','male',19,9,34,'VTI003','DHVH'),
                    ('Patricia Latorre','patriciala','1987-12-10','female',20,6,17,'VTI003','DHVH');

/* Question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau: 
tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table) */

SELECT Full_name,(year(curdate())-year(Birth_Date)) AS Age,VTI_account,Birth_Date,Gender,ET_IQ,ET_GMath,ET_English,Training_Class,Evaluation_Notes
FROM trainee
WHERE length(Full_name)=(SELECT MAX(length(Full_name)) FROM trainee);

/* Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là 
những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau:
 ET_IQ + ET_Gmath>=20
 ET_IQ>=8
 ET_Gmath>=8
 ET_English>=18 */

SELECT * 
FROM trainee AS List_of_ET
WHERE ET_IQ + ET_Gmath>=20 AND ET_IQ>=8 AND ET_Gmath>=8 AND ET_English>=18 ;


-- Question 5: xóa thực tập sinh có TraineeID = 3
DELETE FROM trainee
WHERE TraineeID = 3;
/* Question 6: Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". Hãy cập nhật 
thông tin vào database */
UPDATE trainee
SET Training_class = 'VTI002'
WHERE TraineeID = 5;