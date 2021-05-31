DROP DATABASE IF EXISTS GiaoHangNhanhDaNang;
CREATE DATABASE GiaoHangNhanhDaNang;
USE GiaoHangNhanhDaNang;

DROP TABLE IF EXISTS LoaiMatHang;
CREATE TABLE LoaiMatHang(
	MaLoaiMatHang	CHAR(5) NOT NULL PRIMARY KEY CHECK (MaLoaiMatHang LIKE 'MH%'),
	TenLoaiMatHang	VARCHAR(50) NOT NULL UNIQUE KEY
);
INSERT INTO LoaiMatHang	(MaLoaiMatHang,TenLoaiMatHang)
VALUES					('MH001','Quan Ao'),('MH002','My Pham'),('MH003','Do gia dung'),('MH004','Do Dem Tu');
						
DROP TABLE IF EXISTS KhuVuc;
CREATE TABLE KhuVuc(
	MaKhuVuc	CHAR(5) NOT NULL PRIMARY KEY CHECK (MaKhuVuc LIKE 'KV%'),
	TenKhuVuc	VARCHAR(50) NOT NULL
);
INSERT INTO KhuVuc	(MaKhuVuc,TenKhuVuc)
VALUES				('KV001','Son Tra'),('KV002','Lien Chieu'),('KV003','Ngu Hanh Son'),('KV004','Hai Chau'),('KV005','Thanh Khe');

DROP TABLE IF EXISTS KhoangThoiGian;
CREATE TABLE KhoangThoiGian(
	MaKhoangThoiGianGiaoHang	CHAR(5) NOT NULL PRIMARY KEY CHECK (MaKhoangThoiGianGiaoHang LIKE 'TG%'),
	MoTa						VARCHAR(50)
);
INSERT INTO KhoangThoiGian	(MaKhoangThoiGianGiaoHang,MoTa)
VALUES						('TG001','7h-9h AM'),('TG002','9h-11h AM'),('TG003','1h-3h PM'),('TG004','3h-5h PM'),('TG005','7h-9h30 PM');

DROP TABLE IF EXISTS DichVu;
CREATE TABLE DichVu(
	MaDichVu	CHAR(5) NOT NULL PRIMARY KEY CHECK (MaDichVu LIKE 'DV%'),
	TenDichVu	VARCHAR(50)
);
INSERT INTO DichVu(MaDichVu,TenDichVu)
VALUES		('DV001','Giao hang nguoi nhan tra tien phi'),('DV002','Giao hang nguoi nhan gui tien phi'),('DV003','Giao hang cong ich (khong tinh phi)');

DROP TABLE IF EXISTS ThanhVienGiaoHang;
CREATE TABLE ThanhVienGiaoHang(
	MaThanhVienGiaoHang		CHAR(5) NOT NULL PRIMARY KEY CHECK (MaThanhVienGiaoHang LIKE 'TV%'),
    TenThanhVienGiaoHang	VARCHAR(50) NOT NULL,
    NgaySinh				DATE,
    GioiTinh				ENUM('Nam','Nu'),
	SoDTThanhVien			CHAR(10),
	DiaChiThanhVien			VARCHAR(50)
);
INSERT INTO ThanhVienGiaoHang	(MaThanhVienGiaoHang,TenThanhVienGiaoHang,NgaySinh,GioiTinh,SoDTThanhVien,DiaChiThanhVien)
VALUES							('TV001','Nguyen Van A','1995-11-20','Nam','0905111111','23 Ong Ich Khiem'),
								('TV002','Nguyen Van B','1992-12-26','Nu','0905111112','234 Ton Duc Thang'),
                                ('TV003','Nguyen Van C','1990-11-30','Nu','0905111113','45 Hoang Dieu'),
								('TV004','Nguyen Van D','1995-8-7','Nam','0905111114','23/33 Ngu Hanh Son'),
                                ('TV005','Nguyen Van E','1991-4-2','Nam','0905111115','56 Dinh Thi Dieu');
DROP TABLE IF EXISTS DangKyGiaoHang;
CREATE TABLE DangKyGiaoHang(
	MaThanhVienGiaoHang			CHAR(5) NOT NULL REFERENCES ThanhVienGiaoHang(MaThanhVienGiaoHang),	
    MaKhoangThoiGianDKGiaoHang	CHAR(5) REFERENCES KhoangThoiGian(MaKhoangThoiGianGiaoHang),
    PRIMARY KEY (MaThanhVienGiaoHang,MaKhoangThoiGianDKGiaoHang)
);
INSERT INTO DangKyGiaoHang	(MaThanhVienGiaoHang,MaKhoangThoiGianDKGiaoHang)
VALUES						('TV001','TG004'),('TV002','TG005'),('TV003','TG001'),('TV003','TG002'),('TV003','TG003');

DROP TABLE IF EXISTS KhachHang;
CREATE TABLE KhachHang(
	MaKhachHang		CHAR(5) NOT NULL PRIMARY KEY CHECK (MaKhachHang LIKE 'KH%'),
	MaKhuVuc		CHAR(5) NOT NULL REFERENCES KhuVuc(MaKhuVuc),
    TenKhachHang	VARCHAR(50) NOT NULL,
    TenCuaHang		VARCHAR(50) NOT NULL,
    SoDTKhachHang	CHAR(10) NOT NULL,
    DiaChiEmail		VARCHAR(50), 
    DiaChiNhanHang	VARCHAR(50) NOT NULL
);
INSERT INTO KhachHang	(MaKhachHang,MaKhuVuc,TenKhachHang,TenCuaHang,SoDTKhachHang,DiaChiEmail,DiaChiNhanHang)
VALUES					('KH001','KV001','Le Thi A','Cua Hang 1','0905111111','alethi@gmail.com','80 Pham Phu Thai'),
						('KH002','KV001','Nguyen Van B','Cua Hang 2','0905111112','bnguyenvan@gmail.com','100 Phan Tu'),
                        ('KH003','KV002','Le Thi B','Cua Hang 3','0905111113','blethi@gmail.com','23 An Thuong 18'),
                        ('KH004','KV002','Nguyen Van C','Cua Hang 4','0905111114','cnguyenvan@gmail.com','67 Ngo The Thai'),
                        ('KH005','KV001','Le Thi D','Cua Hang 5','0905111115','dlethi@gmail.com','100 Chau Thi Vinh Te');
                        
DROP TABLE IF EXISTS DonHang_GiaoHang;
CREATE TABLE DonHang_GiaoHang(
	MaDonHang				CHAR(5) NOT NULL PRIMARY KEY CHECK (MaDonHang LIKE 'DH%'),
    MaKhachHang				CHAR(5) NOT NULL REFERENCES KhachHang(MaKhachHang),
    MaThanhVienGiaoHang		CHAR(5) NOT NULL REFERENCES ThanhVienGiaoHang(MaThanhVienGiaoHang),
    MaDichVu				CHAR(5) NOT NULL REFERENCES DichVu(MaDichVu),
    MaKhuVucGiaoHang		CHAR(5) NOT NULL REFERENCES KhuVuc(MaKhuVuc),
    TenNguoiNhan			VARCHAR(50),
    DiaChiGiaoHang			VARCHAR(50),
    SoDTNguoiNhan			CHAR(10),
    MaKhoangThoiGiaoHang	CHAR(5) NOT NULL REFERENCES KhoangThoiGian(MaKhoangThoiGianGiaoHang),
    NgayGiaoHang			DATE,
    PhuongThucThanhToan		ENUM('chuyen khoan','tien mat'),
    TrangThaiPheDuyet		ENUM('Da phe duyet','Chua phe duyet'),
    TrangThaiGaoHang		ENUM('Da giao hang','Chua giao Hang') DEFAULT NULL
);
INSERT INTO DonHang_GiaoHang	(MaDonHang,MaKhachHang,MaThanhVienGiaoHang,MaDichVu,MaKhuVucGiaoHang,TenNguoiNhan,DiaChiGiaoHang,SoDTNguoiNhan,MaKhoangThoiGiaoHang,NgayGiaoHang,PhuongThucThanhToan,TrangThaiPheDuyet,TrangThaiGaoHang)
VALUES							('DH001','KH001','TV001','DV001','KV001','Pham Van A','30 Hoang Van Thu','0905111111','TG004','2016-10-10','tien mat','Da phe duyet','Da giao hang'),
								('DH002','KH001','TV002','DV001','KV005','Pham Van B','15 Le Dinh LY','0905111112','TG005','2016-12-23','tien mat','Da phe duyet','Da giao hang'),
                                ('DH003','KH002','TV003','DV001','KV005','Pham Van C','23 Le Dinh Duong','0905111113','TG001','2015-4-8','tien mat','Da phe duyet','Da giao hang'),
                                ('DH004','KH003','TV001','DV003','KV002','Pham Van D','45 Pham Thu Thai','0905111114','TG002','2017-10-11','chuyen khoan','Da phe duyet','Da giao hang'),
                                ('DH005','KH003','TV005','DV003','KV003','Pham Van E','78 Hoang Dieu','0905111115','TG003','2014-4-4','chuyen khoan','Chua phe duyet',NULL);

DROP TABLE IF EXISTS Chitiet_DonHang;
CREATE TABLE Chitiet_DonHang(
	MaDonHangGiaoHang	CHAR(5) NOT NULL REFERENCES DonHang_GiaoHang(MaDonHang),
    TenSanPhamDuocGiao	VARCHAR(50),
    SoLuong				SMALLINT UNSIGNED NOT NULL,	
    TrongLuong			DECIMAL(2,2),
    MaLoaiMatHang		VARCHAR(50) DEFAULT 'thong thuong',
	TienThuHo			MEDIUMINT UNSIGNED DEFAULT 0
);
INSERT INTO Chitiet_DonHang	(MaDonHangGiaoHang,TenSanPhamDuocGiao,SoLuong,TrongLuong,MaLoaiMatHang,TienThuHo)
VALUES						('DH001','Ao len',2,0.5,'thong thuong',200000),
							('DH001','Quan Au',1,0.25,'thong thuong',350000),
                            ('DH002','Ao thun',1,0.25,'thong thuong',1000000),
                            ('DH002','Ao khoac',3,0.25,'thong thuong',2000000),
                            ('DH003','Sua duong the',2,0.25,'thong thuong',780000),
                            ('DH003','Kem tay da chet',3,0.25,'thong thuong',150000),
                            ('DH003','Kem duong ban dem',4,0.5,'thong thuong',900000);
                            
-- Cập nhật
-- Câu 1: Xóa những khách hàng có tên là “Le Thi A”.
DELETE FROM KhachHang
WHERE TenKhachHang LIKE 'Le Thi A';
-- Câu 2: Cập nhật những khách hàng đang thường trú ở khu vực “Son Tra” thành khu vực “Ngu Hanh Son”.
UPDATE KhachHang
SET MaKhuVuc = (	SELECT MaKhuVuc
					FROM KhuVuc
					WHERE TenKhuVuc LIKE 'Ngu Hanh Son')
WHERE MaKhachHang IN (	SELECT KH.MaKhachHang
						FROM KhachHang		KH
						LEFT JOIN KhuVuc	KV ON KH.MaKhuVuc = KV.MaKhuVuc
						WHERE KV.TenKhuVuc LIKE 'Son Tra');

-- Câu 3: Liệt kê những thành viên (shipper) có họ tên bắt đầu là ký tự ‘Tr’ và có độ dài ít nhất là 25 ký tự (kể cả ký tự trắng).
SELECT *
FROM ThanhVienGiaoHang
WHERE TenThanhVienGiaoHang LIKE 'Tr%' AND lENGTH(TenThanhVienGiaoHang) >= 25;
-- Câu 4: Liệt kê những đơn hàng có NgayGiaoHang nằm trong năm 2017 và có khu vực giao hàng là “Hai Chau”.
SELECT 	*
FROM 	donhang_giaohang
WHERE 	YEAR(NgayGiaoHang) = 2017 
		AND MaKhuVucGiaoHang = ( SELECT MaKhuVuc FROM khuvuc WHERE TenKhuVuc LIKE 'Hai Chau');

/* Câu 5: Liệt kê MaDonHangGiaoHang, MaThanhVienGiaoHang, TenThanhVienGiaoHang, NgayGiaoHang, PhuongThucThanhToan của tất cả những đơn hàng có trạng thái là 
“Da giao hang”. Kết quả hiển thị được sắp xếp tăng dần theo NgayGiaoHang và giảm dần theo PhuongThucThanhToan */
SELECT A.MaDonHang, A.MaThanhVienGiaoHang, B.TenThanhVienGiaoHang, A.NgayGiaoHang, A.PhuongThucThanhToan
FROM donhang_giaohang		A 
LEFT JOIN thanhviengiaohang	B	ON	A.MaThanhVienGiaoHang = B.MaThanhVienGiaoHang
WHERE TrangThaiGaoHang = 'Da giao hang'
ORDER BY NgayGiaoHang ASC, PhuongThucThanhToan DESC;

-- Câu 6: Liệt kê những thành viên có giới tính là “Nam” và chưa từng được giao hàng lần nào.
SELECT *
FROM thanhviengiaohang
WHERE GioiTinh = 'Nam' AND MaThanhVienGiaoHang NOT IN ( SELECT DISTINCT MaThanhVienGiaoHang FROM donhang_giaohang);
/* Câu 7: Liệt kê họ tên của những khách hàng đang có trong hệ thống. Nếu họ tên trùng nhau thì chỉ hiển thị 1 lần. 
Học viên cần thực hiện yêu cầu này bằng 2 cách khác nhau (mỗi cách được tính 0.5 điểm) */
SELECT DISTINCT TenKhachHang FROM khachhang;
SELECT TenKhachHang
FROM khachhang
UNION
SELECT TenKhachHang
FROM khachhang;
-- Câu 8: Liệt kê MaKhachHang, TenKhachHang, DiaChiNhanHang, MaDonHangGiaoHang,PhuongThucThanhToan, TrangThaiGiaoHang của tất cả các khách hàng đang có trong hệ thống
SELECT A.MaKhachHang, A.TenKhachHang, A.DiaChiNhanHang, B.MaDonHang, B.PhuongThucThanhToan, B.TrangThaiGaoHang
FROM khachhang				A
LEFT JOIN donhang_giaohang	B	ON A.MaKhachHang = B.MaKhachHang
GROUP BY A.MaKhachHang;
-- Câu 9: Liệt kê những thành viên giao hàng có giới tính là “Nu” và từng giao hàng cho 10 khách hàng khác nhau ở khu vực giao hàng là “Hai Chau”

SELECT *
FROM thanhviengiaohang
WHERE 	GioiTinh = 'Nu'
		AND MaThanhVienGiaoHang IN ( 	SELECT MaThanhVienGiaoHang
										FROM donhang_giaohang
										WHERE MaKhuVucGiaoHang = ( SELECT MaKhuVuc FROM khuvuc WHERE TenKhuVuc = 'Hai Chau' )
										GROUP BY MaThanhVienGiaoHang
										HAVING	COUNT(DISTINCT(MaKhachHang)) >= 10);

-- Câu 10: Liệt kê những khách hàng đã từng yêu cầu giao hàng tại khu vực “Lien Chieu” và chưa từng được một thành viên giao hàng nào có giới tính là “Nam” nhận giao hàng
SELECT *
FROM khachhang
WHERE MaKhachHang IN ( SELECT MaKhachHang
						FROM donhang_giaohang
						WHERE 	MaKhuVucGiaoHang = ( 	SELECT MaKhuVuc 
														FROM khuvuc 
														WHERE TenKhuVuc = 'Lien Chieu' )
								AND MaThanhVienGiaoHang NOT IN ( 	SELECT MaThanhVienGiaoHang 
																	FROM thanhviengiaohang 
                                                                    WHERE GioiTinh = 'Nam')
                                                                    );

