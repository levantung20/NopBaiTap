-- Bai Thi thu tren lop
DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

DROP TABLE IF EXISTS Khoa;
CREATE TABLE Khoa (
	makhoa 		CHAR(5) PRIMARY KEY NOT NULL,
	tenkhoa 	CHAR(30) UNIQUE KEY NOT NULL,
    dienthoai 	CHAR(10) 
);
INSERT INTO Khoa (makhoa,tenkhoa,dienthoai)
VALUES			('KH001','Cong nghe thong tin','0903111111'),
				('KH002','Cong nghe thuc pham','0903111112'),
                ('KH003','Cong nghe che tao','0903111113');

DROP TABLE IF EXISTS GiangVien;
CREATE TABLE GiangVien(
	magv 	CHAR(5) NOT NULL PRIMARY KEY,
	hotengv CHAR(30) NOT NULL,
	luong 	INT UNSIGNED,
    makhoa 	CHAR(5) NOT NULL REFERENCES Khoa(makhoa)
);
INSERT INTO GiangVien(magv,hotengv,luong,makhoa)
VALUES				('GV001','Pham Van A','1000000','KH001'),
					('GV002','Pham Van B','1000000','KH002'),
                    ('GV003','Pham Van C','1000000','KH002');

DROP TABLE IF EXISTS SinhVien;
CREATE TABLE SinhVien (
	masv 	CHAR(5) NOT NULL PRIMARY KEY,
	hotensv CHAR(30) NOT NULL,
    makhoa 	CHAR(10) NOT NULL REFERENCES Khoa(makhoa),
    namsinh DATE,
    quequan CHAR(30) NOT NULL
);
INSERT INTO sinhvien(masv,hotensv,makhoa,namsinh,quequan)
VALUES				('SV001','Tran Van A','KH001','1996-06-11','Hai Phong'),
					('SV002','Tran Van B','KH001','1989-06-11','Hai Phong'),
                    ('SV003','Tran Van C','KH002','1998-06-11','Hai Phong'),
                    ('SV004','Tran Van D','KH002','1998-06-11','Hai Phong'),
                    ('SV005','Tran Van E','KH002','1995-06-11','Hai Phong'),
                    ('SV006','Tran Van F','KH003','1992-06-11','Hai Phong');

DROP TABLE IF EXISTS DeTai;
CREATE TABLE DeTai(
	madt 		CHAR(10) NOT NULL PRIMARY KEY,
	tendt 		CHAR(30) NOT NULL,
	kinhphi 	INT UNSIGNED,
	NoiThucTap CHAR(30)
);
INSERT INTO DeTai(madt,tendt,kinhphi,NoiThucTap)
VALUES			('DT001','CONG NGHE SINH HOC',1000000,'Ha Noi'),
				('DT002','CONG NGHE XU LI CHAT THAI',1000000,'Ha Noi'),
                ('DT003','CONG NGHE TAI CHE',1000000,'Ha Noi'),
                ('DT004','CONG NGHE SAN XUAT',1000000,'Ha Noi'),
                ('DT005','CONG NGHE VI TINH',1000000,'Ha Noi');
 
DROP TABLE IF EXISTS HuongDan;
CREATE TABLE HuongDan(
	masv 	CHAR(5) REFERENCES SinhVien(masv) ON DELETE CASCADE,
	madt 	CHAR(5) REFERENCES DeTai(madt),
	magv 	CHAR(5) REFERENCES GiangVien(magv),
	ketqua 	ENUM('Dat','Khong Dat'),
    PRIMARY KEY (masv,madt,magv)
);
INSERT INTO HuongDan(masv,madt,magv,ketqua)
VALUES				('SV001','DT003','GV003','Dat'),
					('SV002','DT003','GV001','Dat'),
                    ('SV003','DT003','GV002','Dat'),
                    ('SV004','DT001','GV003','Dat'),
                    ('SV005','DT002','GV003','Khong dat');
-- ----------------------------------------------------------------------------
-- 2. Viết lệnh để
	-- a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
			SELECT 	*
            FROM 	sinhvien
            WHERE 	masv NOT IN (	SELECT DISTINCT masv
									FROM huongdan );
	-- b) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’
			SELECT 	*
            FROM 	sinhvien
            WHERE 	masv IN ( 	SELECT HD.masv
								FROM huongdan 		HD
								LEFT JOIN detai		DT ON HD.madt = DT.madt
								WHERE DT.tendt LIKE 'CONG NGHE SINH HOC'
								GROUP BY HD.madt
                            );
-- 3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm: mã số, họ tên và tên đề tài
-- (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")
			
DROP VIEW IF EXISTS SinhVienInfo;
CREATE VIEW SinhVienInfo AS
SELECT IF (	HD.madt IS NULL,'Chưa có',DT.tendt) AS 'De tai',SV.masv AS 'Ma sv',SV.hotensv AS 'Ho ten'
FROM 		Huongdan 		HD
RIGHT JOIN 	sinhvien 		SV ON HD.masv = SV.masv
LEFT JOIN 	detai			DT ON DT.madt = HD.madt;

-- 4. Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900 thì hiện ra thông báo "năm sinh phải > 1900"
DROP TRIGGER IF EXISTS insert_sv_check;
DELIMITER $$
CREATE TRIGGER insert_sv_check
BEFORE INSERT ON sinhvien
FOR EACH ROW
	BEGIN
		DECLARE check_year TINYINT UNSIGNED;
        SELECT YEAR(NEW.namsinh) INTO check_year
        FROM sinhvien; 
    
		IF check_year <= 1900 THEN
        SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'Ban qua gia de di hoc';
        END IF;
	END $$
DELIMITER ;
-- TEST
INSERT INTO sinhvien(masv,hotensv,makhoa,namsinh,quequan)
VALUES				('SV007','Tran Van R','KH001','1990-06-11','Hai Phong');


-- Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì sẽ xóa tất cả thông
-- tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi

DROP TRIGGER IF EXISTS delete_sv;
DELIMITER $$
CREATE TRIGGER delete_sv
AFTER DELETE ON sinhvien
FOR EACH ROW
BEGIN
	DELETE FROM huongdan
    WHERE masv = OLD.masv;
END $$
DELIMITER ;

-- TEST
DELETE FROM sinhvien
WHERE masv = 'SV001';


