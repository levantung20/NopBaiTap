DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

DROP TABLE IF EXISTS Khoa;
CREATE TABLE Khoa (
	makhoa CHAR(10) PRIMARY KEY NOT NULL,
	tenkhoa CHAR(30) UNIQUE KEY NOT NULL,
    dienthoai CHAR(10) 
);

DROP TABLE IF EXISTS GiangVien;
CREATE TABLE GiangVien(
	magv INT UNSIGNED NOT NULL PRIMARY KEY,
	hotengv CHAR(30) NOT NULL,
	luong DECIMAL(5,2),
    makhoa CHAR(10) NOT NULL REFERENCES Khoa(makhoa)
);

DROP TABLE IF EXISTS SinhVien;
CREATE TABLE SinhVien (
	masv INT UNSIGNED NOT NULL PRIMARY KEY,
	hotensv CHAR(30) NOT NULL,
    makhoa CHAR(10) NOT NULL REFERENCES Khoa(makhoa),
    namsinh INT UNSIGNED NOT NULL,
    quequan CHAR(30) NOT NULL
);

DROP TABLE IF EXISTS DeTai;
CREATE TABLE DeTai (
	madt CHAR(10) NOT NULL PRIMARY KEY,
	tendt CHAR(30) NOT NULL,
	kinhphi INT UNSIGNED,
	NoiThucTap CHAR(30)
);
 
DROP TABLE IF EXISTS HuongDan;
CREATE TABLE HuongDan  (
	masv INT UNSIGNED REFERENCES SinhVien(masv) ON DELETE CASCADE,
	madt CHAR(10) REFERENCES DeTai(madt),
	magv INT UNSIGNED REFERENCES GiangVien(magv),
	ketqua DECIMAL(5,2),
    PRIMARY KEY (masv,madt,magv)
  
);

-- Đưa ra thông tin gồm mã số, họ tênvà tên khoa của tất cả các giảng viên
SELECT 	GV.magv AS 'mã số' , GV.hotengv AS 'họ tên', KH.tenkhoa AS 'tên khoa'
FROM 	GiangVien	GV 
JOIN 	Khoa		KH ON GV.makhoa = KH.makhoa;
-- Đưa ra thông tin gồm mã số, họ tên và tên khoa của các giảng viên của khoa ‘DIA LY va QLTN’
SELECT 	GV.magv AS 'mã số' , GV.hotengv AS 'họ tên', KH.tenkhoa AS 'tên khoa'
FROM 	GiangVien	GV 
JOIN 	Khoa		KH ON GV.makhoa = KH.makhoa
WHERE	KH.tenkhoa LIKE '%DIA LY%' OR KH.tenkhoa LIKE '%QLTN%'
ORDER BY KH.tenkhoa;
-- Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’
SELECT SV.*
FROM sinhvien	SV
JOIN khoa 		KH	ON SV.makhoa = KH.makhoa
WHERE KH.tenkhoa LIKE '%CONG NGHE SINH HOC%';

-- Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’
SELECT SV.masv AS 'mã số', SV.hotensv AS 'họ tên', YEAR(curdate())-namsinh AS 'tuổi'
FROM sinhvien	SV
JOIN khoa 		KH	ON SV.makhoa = KH.makhoa
WHERE KH.tenkhoa LIKE '%TOAN%';

-- Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’
SELECT KH.tenkhoa AS 'ten khoa', COUNT(*) AS 'So gv'
FROM GiangVien	GV
JOIN Khoa		KH	ON	GV.makhoa = KH.makhoa
WHERE KH.tenkhoa LIKE '%CONG NGHE SINH HOC%';

-- Cho biết thông tin về sinh viên không tham gia thực tập
SELECT *
FROM SinhVien
WHERE masv NOT IN ( SELECT masv FROM huongdan );

-- Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
SELECT KH.makhoa AS 'ma khoa', KH.tenkhoa AS 'ten khoa', COUNT(*) AS 'So luong gv' 
FROM GiangVien			GV
JOIN Khoa 				KH	ON KH.makhoa = GV.makhoa
GROUP BY GV.makhoa;

-- Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
SELECT KH.dienthoai
FROM sinhvien 		SV
LEFT JOIN KHOA		KH ON SV.makhoa = KH.makhoa
WHERE SV.hotensv LIKE 'Le van son';

-- Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
SELECT DT.madt, DT.tendt
FROM Huongdan	HD
JOIN GiangVien  GV ON HD.magv = GV.magv
JOIN DeTai 		DT ON HD.madt = DT.madt
WHERE GV.hotengv LIKE 'Tran son';

-- Cho biết tên đề tài không có sinh viên nào thực tập
SELECT * FROM Detai WHERE madt IN (	SELECT madt
									FROM HuongDan
									GROUP BY madt
									HAVING COUNT(masv) = 0 );

-- Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.
SELECT GV.magv, GV.hotengv, GV.luong, KH.tenkhoa
FROM GiangVien 	GV
JOIN Khoa		KH ON GV.makhoa = KH.makhoa
WHERE magv IN ( SELECT magv
				FROM Huongdan
				GROUP BY magv
				HAVING COUNT(masv) >=3);

-- Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
SELECT *
FROM Detai
WHERE kinhphi = ( SELECT MAX(kinhphi) FROM Detai );

-- Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
SELECT madt, tendt
FROM Detai
WHERE madt IN ( SELECT madt
				FROM huongdan
                GROUP BY madt
                HAVING COUNT(masv) > 2);

-- Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
SELECT SV.masv, SV.hotensv, HD.ketqua
FROM SinhVien	SV
JOIN Huongdan	HD ON HD.masv = SV.masv
JOIN Khoa		KH ON SV.makhoa = KH.makhoa
WHERE KH.makhoa LIKE 'DIALY và QLTN';

-- Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
SELECT KH.tenkhoa, COUNT(SV.masv) AS 'Tong so sv'
FROM SinhVien 	SV
RIGHT JOIN Khoa	KH ON SV.makhoa = KH.makhoa 
GROUP BY SV.makhoa;

-- Cho biết thông tin về các sinh viên thực tập tại quê nhà
SELECT SV.*
FROM huongdan	HD
JOIN detai		DT ON DT.madt = HD.madt
JOIN sinhvien	SV ON SV.masv = HD.masv
WHERE SV.quequan LIKE CONCAT('%',DT.noithuctap,'%');

-- Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
SELECT *
FROM SinhVien
WHERE masv IN ( SELECT masv
				FROM Huongdan
				WHERE ketqua IS NULL );

-- Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
SELECT masv, hotensv
FROM SinhVien
WHERE masv IN ( SELECT masv
				FROM Huongdan
                WHERE ketqua = 0);

-- Bai Thi thu tren lop
-- 2. Viết lệnh để
	-- a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
			SELECT *
            FROM sinhvien
            WHERE masv NOT IN (	SELECT DISTINCT masv
								FROM huongdan );
	-- b) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’
			SELECT *
            FROM sinhvien
            WHERE masv IN ( SELECT HD.masv
							FROM huongdan 	HD
                            JOIN detai		DT ON HD.madt = DT.madt
                            WHERE DT.tendt LIKE '%CONG NGHE SINH HOC%'
                            GROUP BY HD.madt
                            );
-- 3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm: mã số, họ tên và tên đề tài
-- (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")
			
DROP VIEW IF EXISTS SinhVienInfo;
CREATE VIEW SinhVienInfo AS
SELECT IF (	HD.madt IS NULL,'Chưa có',DT.tendt) AS 'De tai',HD.masv AS 'Ma sv',SV.hotensv AS 'Ho ten'
FROM Huongdan 	HD
LEFT JOIN sinhvien 	SV ON HD.masv = SV.masv
LEFT JOIN detai		DT ON DT.madt = HD.madt;

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

-- Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì sẽ xóa tất cả thông
-- tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi
/* 
DROP TABLE IF EXISTS HuongDan;
CREATE TABLE HuongDan  (
	masv INT UNSIGNED REFERENCES SinhVien(masv) ON DELETE CASCADE,
	madt CHAR(10) REFERENCES DeTai(madt),
	magv INT UNSIGNED REFERENCES GiangVien(magv),
	ketqua DECIMAL(5,2),
    PRIMARY KEY (masv,madt,magv)
*/