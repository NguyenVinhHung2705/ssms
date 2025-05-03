/*
	===========================
		  Code by Kazumin    
	===========================
*/

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

--1. Các lệnh truy vấn đơn
--a. Cho biết danh sách các nhân viên thuộc phòng triển khai.
select nv.HONV, nv.TENLOT, nv.TEN, nv.NGSINH, nv.DCHI, nv.PHAI, pb.TENPHONG from NHANVIEN as nv
inner join PHONGBAN as pb on pb.MAPHG = nv.PHG
where pb.TENPHONG = N'phòng triển khai'
--b. Cho biết họ tên trưởng phòng của phòng quản lý
select * from NHANVIEN as nv
inner join PHONGBAN as pb on pb.TRPHG = nv.MANV
where pb.TENPHONG = N'phòng quản lý'
--c. Cho biết họ tên những trưởng phòng tham gia đề án ở “Hà Nội”
select distinct nv.HONV, nv.TENLOT, nv.TEN from NHANVIEN as nv
inner join PHONGBAN as pb on pb.TRPHG = nv.MANV
inner join PHANCONG as pc on pc.MA_NVIEN = pb.TRPHG
inner join DEAN as da on da.MADA = pc.MADA
where da.DDIEM_DA = N'Hà Nội'
--d. Cho biết họ tên nhân viên có thân nhân.
select nv.HONV, nv.TENLOT, nv.TEN from NHANVIEN as nv
left join THANNHAN as tn on tn.MA_NVIEN = nv.MANV
where tn.TENTN is not null
--e. Cho biết họ tên nhân viên được phân công tham gia đề án.
select distinct nv.HONV, nv.TENLOT, nv.TEN from NHANVIEN as nv
left join PHANCONG as pc on pc.MA_NVIEN = nv.MANV
where pc.MADA is not null
--f. Cho biết mã nhân viên (MA_NVIEN) có người thân và tham gia đề án.
select distinct nv.MANV from NHANVIEN as nv
left join THANNHAN as tn on tn.MA_NVIEN = nv.MANV
left join PHANCONG as pc on pc.MA_NVIEN = nv.MANV
where tn.MA_NVIEN is not null and pc.MA_NVIEN is not null
--g. Danh sách các đề án (MADA) có nhân viên họ “Nguyễn” tham gia.
select distinct pc.MADA from PHANCONG as pc
inner join NHANVIEN as nv on nv.MANV = pc.MA_NVIEN
where nv.HONV = N'Nguyễn'
--h. Danh sách các đề án (TENDA) có người trưởng phòng họ “Nguyễn” chủ trì.
select distinct da.TENDA from PHANCONG as pc
inner join PHONGBAN as pb on pb.TRPHG = pc.MA_NVIEN
inner join NHANVIEN as nv on nv.MANV = pb.TRPHG
inner join DEAN as da on da.MADA = pc.MADA
where nv.HONV = N'Nguyễn' and pc.VITRI = N'Trưởng Nhóm'
--i. Cho biết tên của các nhân viên và tên các phòng ban mà họ phụ trách nếu có
select nv.TEN, pb.TENPHONG from NHANVIEN as nv
inner join PHONGBAN as pb on nv.MaNV = pb.TRPHG;
--j. Danh sách những đề án có:
--o Người tham gia có họ “Đinh”
select distinct pc.MADA from PHANCONG as pc
inner join NHANVIEN as nv on nv.MANV = pc.MA_NVIEN
where nv.HONV = N'Đinh'
--o Có người trưởng phòng chủ trì đề án họ “Đinh”
select * from DEAN as da
inner join PHANCONG as pc on pc.MADA = da.MADA 
inner join NHANVIEN as nv on nv.MANV = pc.MA_NVIEN
where pc.VITRI = N'Trưởng Dự Án' and nv.HONV = N'Đinh'
--2. Các lệnh truy vấn lồng
--k. Viết lại tất cả các câu trên thành các câu SELECT lồng.
	--a. Cho biết danh sách các nhân viên thuộc phòng triển khai.
		select distinct * from NHANVIEN
		where PHG in (select MAPHG from PHONGBAN where TENPHONG = N'Phòng triển khai')
	--b. Cho biết họ tên trưởng phòng của phòng quản lý
		select * from NHANVIEN
		where MANV in (select TRPHG from PHONGBAN where TENPHONG = N'Phòng Quản Lý')
	--c. Cho biết họ tên những trưởng phòng tham gia đề án ở “Hà Nội”
		select * from NHANVIEN
		where MANV in ( select TRPHG from PHONGBAN 
						where TRPHG in ( select MA_NVIEN from PHANCONG
										 where MADA in ( select MADA from DEAN
														 where DDIEM_DA =N'Hà Nội'
														 )
										)
						)
	--d. Cho biết họ tên nhân viên có thân nhân.
		select * from NHANVIEN
		where MANV in ( select MA_NVIEN from THANNHAN )
	--e. Cho biết họ tên nhân viên được phân công tham gia đề án.
		select * from NHANVIEN
		where MANV in (select MA_NVIEN from PHANCONG)
	--f. Cho biết mã nhân viên (MA_NVIEN) có người thân và tham gia đề án.
		select * from NHANVIEN
		where MANV in (
						select MA_NVIEN from THANNHAN
						where MA_NVIEN in (select MA_NVIEN from PHANCONG)
						)
	--g. Danh sách các đề án (MADA) có nhân viên họ “Nguyễn” tham gia.
		select distinct MADA from PHANCONG
		where MA_NVIEN in (select MANV from NHANVIEN where HONV = N'Nguyễn')
	--h. Danh sách các đề án (TENDA) có người trưởng phòng họ “Nguyễn” chủ trì.
		select * from DEAN
		where MADA in (
						select MADA from PHANCONG
						where MA_NVIEN in (
											select TRPHG from PHONGBAN
											where TRPHG in (
															select MANV from NHANVIEN
															where HONV = N'Nguyễn'
															)
											) and VITRI = N'Trưởng nhóm'
						)
	--i. Cho biết tên của các nhân viên và tên các phòng ban mà họ phụ trách nếu có
		select TEN , (select TENPHONG from PHONGBAN where TRPHG = MANV) as tenphongphutrach from NHANVIEN
	--j. Danh sách những đề án có:
		--o Người tham gia có họ “Đinh”
			select * from DEAN 
			where MADA in (
							select MADA from PHANCONG
							where MA_NVIEN in (
												select MANV from NHANVIEN
												where HONV =N'Đinh'
												)
							)
		--o Có người trưởng phòng chủ trì đề án họ “Đinh”
			select * from DEAN
			where MADA in (
							select MADA from PHANCONG
							where MA_NVIEN in (
												select MANV from NHANVIEN
												where HONV =N'Đinh'
												) and VITRI = N'Trưởng Dự Án'
							) 
--l. Cho biết những nhân viên có cùng tên với người thân
	select * from NHANVIEN
	where MANV in (select MA_NVIEN from THANNHAN where MA_NVIEN = MANV and TEN = TENTN)
--m. Cho biết danh sách những nhân viên có 2 thân nhân trở lên
	select * from NHANVIEN
	where MANV in (
					select MA_NVIEN from THANNHAN
					group by MA_NVIEN
					having count(MA_NVIEN) >= 2
					)
--n. Cho biết những trưởng phòng có tối thiểu 1 thân nhân
	select * from NHANVIEN
	where MANV in (
					select TRPHG from PHONGBAN
					where TRPHG in (
									select MA_NVIEN from THANNHAN
									group by MA_NVIEN
									having count(MA_NVIEN) >= 1
									)
					)
--o. Cho biết những trưởng phòng có mức lương ít hơn (ít nhất một) nhân viên của mình
	--select *
	--from NHANVIEN
	--where MANV in (
	--	select TRPHG
	--	from PHONGBAN
	--	where TRPHG in (
	--		select NVQL.MANV
	--		from NHANVIEN NVQL
	--		where exists (
	--			select 1
	--			from NHANVIEN NV
	--			where NV.PHG = (
	--				select PHG
	--				from NHANVIEN
	--				where MANV = NVQL.MANV
	--			)
	--			and NV.LUONG > NVQL.LUONG
	--		)
	--	)
	--)code chat gpt
	select * from NHANVIEN as nv
	where nv.MANV in (select TRPHG from PHONGBAN) and nv.LUONG < (	select top 1 LUONG from NHANVIEN
						where MANV not in(select TRPHG from PHONGBAN) and PHG = nv.PHG
						order by LUONG  desc)
	--- ý tưởng : lọc nhân viên là trưởng phòng, so sánh lương của trường phòng với nhân viên có số 
	--- lương cao nhất trong phòng (vì nếu lương trưởng phòng bé hơn thì có nghĩa sẽ có ít nhất 1 nhân 
	--- viên lương cao hơn xếp, ngược lại, nếu lớn hơn thì không có ai lương cao hơn trưởng phòng cả)
--3.Các lệnh về gom nhóm
--p. Cho biết tên phòng, mức lương trung bình của phòng đó >40000.
	select pb.TENPHONG, MUCLUONGTRUNGBINH = avg(nv.LUONG) from PHONGBAN as pb
	inner join NHANVIEN as nv on pb.MAPHG = nv.PHG
	group by pb.TENPHONG
	having avg(nv.LUONG) > 40000
--q. Cho biết lương trung bình của tất các nhân viên nữ phòng số 4
	select LUONGTB = avg(LUONG) from NHANVIEN
	where PHAI =N'Nữ' and PHG = 4
--r. Cho biết họ tên và số thân nhân của nhân viên phòng số 5 có trên 2 thân nhân
	select nv.HONV, nv.TENLOT, nv.TEN, [Số thân nhân] = count(*) from NHANVIEN as nv
	inner join THANNHAN as tn on tn.MA_NVIEN = nv.MANV
	where  PHG = 5
	group by nv.MANV, tn.MA_NVIEN, nv.HONV, nv.TENLOT, nv.TEN
	having count(*) > 2
--s. Ứng với mỗi phòng cho biết họ tên nhân viên có mức lương cao nhất
	select nv.HONV, nv.LUONG, pb.TENPHONG
	from NHANVIEN nv
	inner join (
		select PHG, max(LUONG) as MAX_LUONG
		from NHANVIEN
		group by PHG
	) as maxluongphong
	on nv.PHG = maxluongphong.PHG AND nv.LUONG = maxluongphong.MAX_LUONG
	join PHONGBAN as pb ON nv.PHG = pb.MAPHG;
--t. Cho biết họ tên nhân viên nam và số lượng các đề án mà nhân viên đó tham gia
select N.HONV, N.TENLOT, N.TEN, count(P.MADA) AS SoDeAn
from NHANVIEN N
left join PHANCONG P ON N.MANV = P.MA_NVIEN
where N.PHAI = N'Nam'
group by N.HONV, N.TENLOT, N.TEN;
--u. Cho biết nhân viên (HONV, TENLOT, TENNV) nào có lương cao nhất.
select HONV, TENLOT, TEN, LUONG
from NHANVIEN
where LUONG = (select max(LUONG) from NHANVIEN);
--v. Cho biết mã nhân viên (MA_NVIEN) nào có nhiều thân nhân nhất.
select T.MA_NVIEN, count(TENTN) as SoThanNhan
from THANNHAN T
group by T.MA_NVIEN
having count(TENTN) = (
    select max(SoTN)
    from (
        select count(*) as SoTN
        from THANNHAN
        group by MA_NVIEN
    ) as Temp
);
--w. Cho biết họ tên trưởng phòng của phòng có đông nhân viên nhất
select N.HONV, N.TENLOT, N.TEN
from NHANVIEN N
join PHONGBAN P ON N.MANV = P.TRPHG
where P.MAPHG = (
    select top 1 PHG
    from NHANVIEN
    group by PHG
    order by count(*) desc
	
)
--x. Đếm số nhân viên nữ của từng phòng, hiển thị: TenPHG, SoNVNữ, những khoa không có nhân viên nữ hiển thị SoNVNữ=0
select P.TENPHONG, count(CASE WHEN N.PHAI = N'Nữ' THEN 1 END) as SoNVNu
from PHONGBAN as P
left join NHANVIEN N on P.MAPHG = N.PHG
group by P.TENPHONG;
--4. VIEW
--a. Cho biết tên phòng, số lượng nhân viên và mức lương trung bình của từng phòng.
CREATE VIEW VW_PHONG_THONGKE AS
SELECT P.TENPHONG, COUNT(N.MANV) AS SoNV, AVG(N.LUONG) AS LuongTB
FROM PHONGBAN P
LEFT JOIN NHANVIEN N ON P.MAPHG = N.PHG
GROUP BY P.TENPHONG
select * from VW_PHONG_THONGKE
--b. Cho biết họ tên nhân viên và số lượng các đề án mà nhân viên đó tham gia
CREATE VIEW VW_NV_DEAN AS
SELECT N.HONV, N.TENLOT, N.TEN, COUNT(P.MADA) AS SoDeAn
FROM NHANVIEN N
LEFT JOIN PHANCONG P ON N.MANV = P.MA_NVIEN
GROUP BY N.HONV, N.TENLOT, N.TEN
select * from VW_NV_DEAN
--c. Thống kê số nhân viên của từng phòng, hiển thị: MaPH, TenPHG, SoNVNữ, SoNVNam, TongSoNV. 
CREATE VIEW VW_PHONG_GIOITINH AS
SELECT 
    P.MAPHG, 
    P.TENPHONG,
    COUNT(CASE WHEN N.PHAI = 'NU' THEN 1 END) AS SoNVNu,
    COUNT(CASE WHEN N.PHAI = 'NAM' THEN 1 END) AS SoNVNam,
    COUNT(N.MANV) AS TongSoNV
FROM PHONGBAN P
LEFT JOIN NHANVIEN N ON P.MAPHG = N.PHG
GROUP BY P.MAPHG, P.TENPHONG