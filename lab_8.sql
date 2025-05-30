use master
go
if exists(select * from sys.databases where name = 'QLDeAn_2351220021')
	drop database QLDeAn_2351220021
GO
create database QLDeAn_2351220021
go
use QLDeAn_2351220021
go
CREATE TABLE PHONGBAN
(
	TENPHONG NVARCHAR(30),
	MAPHG INT NOT NULL,
	TRPHG CHAR(9),
	NG_NHANCHUC DATETIME,
	constraint PK_PB PRIMARY KEY (MAPHG)
)
CREATE TABLE NHANVIEN
(
	HONV  NVARCHAR(30),
	TENLOT  NVARCHAR(30),
	TEN  NVARCHAR(30),
	MANV CHAR(9) NOT NULL,
	NGSINH DATETIME,
	DCHI NVARCHAR(50),
	PHAI NCHAR(6),
	LUONG FLOAT,
	PHG INT,
	constraint PK_NV PRIMARY KEY(MANV)
)

CREATE TABLE DIADIEM_PHG
(
	MAPHG INT NOT NULL,
	DIADIEM NVARCHAR(30) NOT NULL,
	constraint PK_DD PRIMARY KEY (MAPHG, DIADIEM)
)

CREATE TABLE PHANCONG
(
	MADA INT NOT NULL,
	MA_NVIEN CHAR(9) NOT NULL,
	VITRI NVARCHAR(50),
	constraint PK_PC PRIMARY KEY ( MADA,MA_NVIEN)
)

CREATE TABLE THANNHAN
(
	MA_NVIEN CHAR(9) NOT NULL,
	TENTN NVARCHAR(30) NOT NULL,
	PHAI NCHAR(6),
	NGSINH DATETIME,
	QUANHE NVARCHAR(16),
	constraint PK_TN PRIMARY KEY (MA_NVIEN, TENTN)
)

CREATE TABLE DEAN
(
	TENDA NVARCHAR(30),
	MADA INT NOT NULL,
	DDIEM_DA NVARCHAR(30),
	NGAYBD DATETIME,
	NGAYKT DATETIME,
	constraint PK_DA PRIMARY KEY (MADA)
)
/*TAO KHOA NGOAI CHO CAC BANG*/
/*TRPHG - NHANVIEN(MANV)*/
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NHANVIEN_PHONGBAN 
FOREIGN KEY (PHG) REFERENCES PHONGBAN(MAPHG) 

ALTER TABLE PHONGBAN ADD CONSTRAINT FK_PHONGBAN_NHANVIEN
FOREIGN KEY (TRPHG) REFERENCES NHANVIEN(MANV) 


ALTER TABLE DIADIEM_PHG ADD CONSTRAINT FK_DIADIEM_PHG_PHONGBAN
FOREIGN KEY (MAPHG) REFERENCES PHONGBAN(MAPHG)


ALTER TABLE THANNHAN ADD CONSTRAINT FK_THANNHAN_NHANVIEN
FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)


ALTER TABLE PHANCONG ADD CONSTRAINT FK_PHANCONG_NHANVIEN
FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)

ALTER TABLE PHANCONG ADD CONSTRAINT FK_PHANCONG_DEAN
FOREIGN KEY (MADA) REFERENCES DEAN(MADA)

---NHAP DU LIEU BANG PHONG BAN
INSERT INTO PHONGBAN (TENPHONG,MAPHG,TRPHG,NG_NHANCHUC)
VALUES	(N'Phòng Triển Khai',5,NULL,'2010-05-20'),
		(N'Phòng Xây Dựng',4,NULL,'2011-01-01'),
		(N'Phòng Quản Lý',1,NULL,'2012-06-19')
		---NHAP DU LIEU BANG NHAN VIEN
INSERT INTO NHANVIEN(HONV,TENLOT,TEN,MANV,NGSINH,DCHI,PHAI,LUONG,PHG)
Values	(N'Đinh',N'Bá',N'Tiên','123456789','1970-01-09',N'TPHCM',N'Nam',30000,5),
		(N'Nguyễn',N'Thanh',N'Tùng','333445555','1975-12-08',N'TPHCM',N'Nam',40000,5),
		(N'Bùi',N'Thúy',N'Vũ','999887777','1980-07-19',N'Đà Nẵng',N'Nữ',25000,4),
		(N'Lê',N'Thị',N'Nhàn','987654321','1978-06-20',N'Huế',N'Nữ',43000,4),
		(N'Nguyễn',N'Mạnh',N'Hùng','666884444','1984-09-15',N'Quảng Nam',N'Nam',38000,5),
		(N'Trần',N'Thanh',N'Tâm','453453453','1988-07-31',N'Quảng Trị',N'Nam',25000,5),
		(N'Trần',N'Hồng',N'Quân','987987987','1990-03-29',N'Đà Nẵng',N'Nam',25000,4),
		(N'Vương',N'Ngọc',N'Quyền','888665555','1965-10-10',N'Quảng Ngãi',N'Nữ',55000,1)
Go
-----CẬP NHẬT DỮ LIỆU BẢNG PHÒNG BAN
UPDATE PHONGBAN
SET  TRPHG='333445555'
WHERE MAPHG=5
UPDATE PHONGBAN
SET  TRPHG='987987987'
WHERE MAPHG=4
UPDATE PHONGBAN
SET  TRPHG='888665555'
WHERE MAPHG=1
---NHAP DU LIEU BANG DIADIEM_PHG
INSERT INTO DIADIEM_PHG(MAPHG,DIADIEM)
VALUES	(1,N'Đà Nẵng'),
		(4,N'Đà Nẵng'),
		(5,N'Đà Nẵng'),
		(5,N'Hà Nội'),
		(5,N'Quảng Nam')
go
---NHAP DU LIEU BANG DIADIEM_PHG
INSERT INTO THANNHAN(MA_NVIEN,TENTN,PHAI,NGSINH,QUANHE)
values	('333445555',N'Quang',N'Nữ','2005-04-05',N'Con gai'),
		('333445555',N'Khang',N'Nam','2008-10-25',N'Con trai'),
		('333445555',N'Duong',N'Nữ','2078-05-03',N'Vo chong'),
		('987654321',N'Dang',N'Nam','2070-02-20',N'Vo chong'),
		('123456789',N'Duy',N'Nam','2000-01-01',N'Con trai'),
		('123456789',N'Chau',N'Nữ','2004-12-31',N'Con gai'),
		('123456789',N'Phuong',N'Nữ','2077-05-05',N'Vo chong')
Go
---NHAP DU LIEU BANG DEAN
INSERT INTO DEAN(TENDA,MADA,DDIEM_DA,NGAYBD,NGAYKT)
values	(N'Quản Lí Khách Sạn',100,N'Đà Nẵng','2012-01-01','2012-02-20'),
		(N'Quản Lí Bệnh Viện',200,N'Đà Nẵng','2013-03-15','2013-06-30'),
		(N'Quản Lí Bán Hàng',300,N'Hà Nội','2013-12-01','2014-02-01'),
		(N'Quản Lí Đào Tạo',400,N'Hà Nội','2014-03-15',null)
Go
---NHAP DU LIEU BANG PHAN CONG
INSERT INTO PHANCONG(MADA,MA_NVIEN,VITRI)
values	(100,'333445555',N'Trưởng Nhóm'),
		(100,'123456789',N'Thành Viên'),
		(100,'666884444',N'Thành Viên'),
		(200,'987987987',N'Trưởng Dự Án'),
		(200,'999887777',N'Trưởng Nhóm'),
		(200,'453453453',N'Thành Viên'),
		(200,'987654321',N'Thành Viên'),
		(300,'987987987',N'Trưởng Dự Án'),
		(300,'999887777',N'Trưởng Nhóm'),
		(300,'333445555',N'Trưởng Nhóm'),
		(300,'666884444',N'Thành Viên'),
		(300,'123456789',N'Thành Viên'),
		(400,'987987987',N'Trưởng Dự Án'),
		(400,'999887777',N'Trưởng Nhóm'),
		(400,'123456789',N'Thành Viên'),
		(400,'333445555',N'Thành Viên'),
		(400,'987654321',N'Thành Viên'),
		(400,'666884444',N'Thành Viên')
Go

--CURSOR 
--a. Công ty quyết định tăng lương cho nhân viên như sau: 
--+ 20% nếu tham gia ít nhất 2 dự án với chức vụ trưởng dự án
declare cur_at_least_2_duan cursor
	forward_only 
for
select nv.MANV,nv.LUONG from NHANVIEN as nv
inner join PHANCONG as pc on pc.MA_NVIEN = nv.MANV
inner join DEAN as da on da.MADA = pc.MADA
where pc.vitri = N'Trưởng Dự Án'
group by nv.MANV, nv.LUONG
having count(da.MADA) >= 2
open cur_at_least_2_duan
declare @manv char(9)
fetch next from cur_at_least_2_duan into @manv
while(@@FETCH_STATUS = 0)
	begin
		update NHANVIEN
		set LUONG = LUONG * 1.2
		where MANV = @manv
	end
close cur_at_least_2_duan
-- + 15% nếu là trưởng phòng hoặc người quản lý trực tiếp 
declare cur_isTruongPhong cursor
	forward_only
for
	select nv.MANV from NHANVIEN as nv
	inner join PHONGBAN as pb on pb.TRPHG = nv.MANV
open cur_isTruongPhong
fetch next from cur_isTruongPhong into @manv
while(@@FETCH_STATUS = 0)
	begin
		update NHANVIEN
		set LUONG = LUONG * 1.15
		where MANV = @manv
		fetch next from cur_isTruongPhong into @manv
	end
close cur_isTruongPhong


--+ 10% nếu là nhân viên phòng số 5 có tham gia dự án bắt đầu và kết thúc trong năm
--2014 .
declare cur_beginEnd2014 cursor
	forward_only
for
	select nv.MANV from NHANVIEN as nv
	inner join PHANCONG as pc on pc.MA_NVIEN = nv.MANV
	inner join DEAN as da on da.MADA = pc.MADA
	where nv.PHG = 5 and year(da.NGAYBD) = 2014 and year(da.NGAYKT) = 2014
open cur_beginEnd2014
fetch next from cur_beginEnd2014 into @manv
while(@@FETCH_STATUS = 0)
	begin
		update NHANVIEN
		set LUONG = LUONG * 1.1
		where MANV = @manv
		fetch next from cur_beginEnd2014 into @manv
	end
close cur_beginEnd2014
--Dùng con trỏ duyệt qua từng dòng trong bảng NHANVIEN để thực hiện tăng lương
--như trên. 
--b. Ứng với mỗi đề án, thêm mới 3 cột: số lượng trưởng dự án, số lượng trưởng nhóm,
alter table DEAN
add SLTruongDuAn int default 0,
	SLTruongNhom int default 0,
	SLThanhVien int default 0

declare cur_dean cursor
for
	select MADA from DEAN

declare @mada int
open cur_dean
fetch next from cur_dean into @mada
while @@FETCH_STATUS = 0
begin
	-- Đếm số Trưởng Dự Án
	declare @slTruongDuAn int
	select @slTruongDuAn = count(*) 
	from PHANCONG 
	where MADA = @mada and VITRI = N'Trưởng Dự Án'

	-- Đếm số Trưởng Nhóm
	declare @slTruongNhom int
	select @slTruongNhom = count(*) 
	from PHANCONG 
	where MADA = @mada and VITRI = N'Trưởng Nhóm'

	-- Đếm số Thành Viên
	declare @slThanhVien int
	select @slThanhVien = count(*) 
	from PHANCONG 
	where MADA = @mada and VITRI = N'Thành Viên'

	-- Cập nhật vào bảng DEAN
	update DEAN
	set SLTruongDuAn = @slTruongDuAn,
		SLTruongNhom = @slTruongNhom,
		SLThanhVien = @slThanhVien
	where MADA = @mada

	fetch next from cur_dean into @mada
end
close cur_dean
deallocate cur_dean
--số lượng thành viên. 
--Dùng con trỏ duyệt qua từng dòng trong bảng DEAN cập nhật dữ liệu
--cho 3 cột này.


--1. TRANSACTION
--a. Xóa một nhân viên bất kỳ và xóa thông tin trưởng phòng của nhân viên này (không xóa phòng ban, chỉ xóa dữ liệu trưởng phòng và 
--ngày nhận chức). Nếu bất kỳ hành động nào xảy ra lỗi thì hủy bỏ tất cả các hành động.
-- 1a. Xóa nhân viên và nếu là trưởng phòng thì xóa luôn thông tin trưởng phòng
BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @MaNV INT = 1001; -- Nhập mã nhân viên cần xóa

    -- Xóa thông tin trưởng phòng nếu có
    UPDATE PHONGBAN
    SET TRPHG = NULL, NG_NHANCHUC = NULL
    WHERE TRPHG = @MaNV;

    -- Xóa nhân viên
    DELETE FROM NHANVIEN
    WHERE MANV = @MaNV;

    COMMIT TRANSACTION;
    PRINT 'Xóa nhân viên và thông tin trưởng phòng thành công.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Lỗi: ' + ERROR_MESSAGE();
END CATCH;
--b. Xóa một phòng ban, xóa những địa điểm liên quan
--đến phòng ban, xóa thông tin phòng ban của nhân viên viên thuộc phòng ban này (không xóa nhân viên, chỉ xóa dữ liệu phòng trong nhân viên). Nếu bất kỳ hành động nào xảy ra lỗi thì hủy bỏ tất cả các hành động.
BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @MaPHG INT = 10; -- Nhập mã phòng ban cần xóa

    -- Cập nhật thông tin phòng ban trong nhân viên thành NULL
    UPDATE NHANVIEN
    SET PHG = NULL
    WHERE PHG = @MaPHG;

    -- Xóa địa điểm thuộc phòng ban này
    DELETE FROM DIADIEM_PHG
    WHERE MAPHG = @MaPHG;

    -- Xóa phòng ban
    DELETE FROM PHONGBAN
    WHERE MAPHG = @MaPHG;

    COMMIT TRANSACTION;
    PRINT 'Xóa phòng ban và thông tin liên quan thành công.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Lỗi: ' + ERROR_MESSAGE();
END CATCH;
--2. FUNCTION
--Viết hàm xác định một nhân viên có tham gia dự án nào đó với chức vụ là “Trưởng dự án” hay không
-- 2. Function: Kiểm tra nhân viên có là trưởng dự án hay không
CREATE FUNCTION dbo.KiemTraTruongDuAn
(
    @MaNV INT,
    @MaDA INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @KetQua BIT;

    IF EXISTS (
        SELECT 1 FROM PHANCONG
        WHERE MANV = @MaNV AND MADA = @MaDA AND VAITRO = N'Trưởng dự án'
    )
        SET @KetQua = 1;
    ELSE
        SET @KetQua = 0;

    RETURN @KetQua;
END;
--3. TRIGGER
--Tạo trigger cho ràng buộc: Với mỗi dự án, số lượng “trưởng dự án” phải ít hơn số lượng “trưởng nhóm” và số lượng “trưởng nhóm” phải ít hơn số lượng “thành viên”.
-- 3. Trigger: Trưởng dự án < Trưởng nhóm < Thành viên
CREATE TRIGGER trg_KiemTraVaiTro
ON PHANCONG
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaDA INT;

    SELECT TOP 1 @MaDA = MADA FROM inserted;

    DECLARE @SoTruongDuAn INT, @SoTruongNhom INT, @SoThanhVien INT;

    SELECT 
        @SoTruongDuAn = COUNT(*) 
    FROM PHANCONG 
    WHERE MADA = @MaDA AND VAITRO = N'Trưởng dự án';

    SELECT 
        @SoTruongNhom = COUNT(*) 
    FROM PHANCONG 
    WHERE MADA = @MaDA AND VAITRO = N'Trưởng nhóm';

    SELECT 
        @SoThanhVien = COUNT(*) 
    FROM PHANCONG 
    WHERE MADA = @MaDA AND VAITRO = N'Thành viên';

    IF @SoTruongDuAn >= @SoTruongNhom OR @SoTruongNhom >= @SoThanhVien
    BEGIN
        RAISERROR(N'Ràng buộc vai trò không hợp lệ: Trưởng dự án < Trưởng nhóm < Thành viên.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

