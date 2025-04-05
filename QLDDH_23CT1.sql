--1. ĐỊNH NGHĨA DỮ LIỆU, tr17
--1.1. Tạo CSDL, tr18
--1.2. Xóa CSDL, tr19
--1.3. Sử dụng CSDL, tr19
/*trước khi tạo CSD kiểm tra CSDL đã tồn tại chưa,
nếu đã tồn tại rồi thì xóa CSDL đó đi rồi mới tạo. */
use master
GO -- ép lệnh phía trước thực thi
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'QLDDH_23CT1')
BEGIN
    DROP DATABASE QLDDH_23CT1 -- xóa CSDL
END
Go
CREATE DATABASE QLDDH_23CT1 -- tạo CSDL
go
use QLDDH_23CT1 -- sử dụng CSDL
go
--2. Tạo bảng, tr20
CREATE TABLE KhachHang
(
   MaKH     char(5) not null, -- primary key,
   TenKH     nvarchar(50),
   DiaChi    nvarchar(50),
   DienThoai varchar(15),
   constraint pk_KhachHang primary key(MaKH) -- tr22  
)
GO
CREATE TABLE DonDatHang
(
	MaDat  char(5) not null,
	NgayDat date,
	MaKH char(5),
	constraint pk_DonDatHang primary key(MaDat),
	constraint fk_DonDatHang_MaKH foreign key (MaKH) references KhachHang(MaKH)
)
GO
CREATE TABLE HangHoa --tạo bảng HangHoa
(
    MaHH char(5) not null,
    TenHH nvarchar(50) not null,
    DVT nvarchar(20),
    SLCon int not null,
    DonGiaHH int,
    constraint pk_HangHoa primary key (MaHH)
)
Go
CREATE TABLE ChiTietDatHang
(
    MaDat    char(5) not null,
    MaHH     char(5) not null,
    SLDat    int,
    constraint pk_ChiTietDatHang primary key(MaDat, MaHH),
    constraint fk_ChiTietDatHang_MaDat foreign key(MaDat) references DonDatHang(MaDat),
    constraint fk_ChiTietDatHang_MaHH foreign key(MaHH) references HangHoa(MaHH)
)
Go
CREATE TABLE PhieuGiaoHang
(
   MaGiao      char(5) not null,
   NgayGiao  date,
   MaDat      char(5),
    constraint pk_PhieuGiaoHang primary key(MaGiao),
    constraint fk_PhieuGiaoHang_MaDat foreign key(MaDat) references DonDatHang(MaDat)
)
Go
CREATE TABLE ChiTietGiaoHang
(
    MaGiao      char(5) not null,
    MaHH      char(5) not null,
    SLGiao      int,
    DonGiaGiao   int,
    constraint pk_ChiTietGiaoHang primary key(MaGiao, MaHH),
    constraint fk_ChiTietGiaoHang_MaGiao foreign key(MaGiao) references PhieuGiaoHang(MaGiao),
    constraint fk_ChiTietGiaoHang_MaHH foreign key(MaHH) references HangHoa(MaHH)
)
Go
CREATE TABLE LichSuGia
(
   MaHH      char(5) not null,
   NgayHL    date not null,
   DonGia    int,
   constraint pk_LichSuGia primary key(MaHH, NgayHL),
   constraint fk_LichSuGia_MaHH foreign key(MaHH) references HangHoa(MaHH) on delete cascade
)
--SỬA BẢNG, TR25
-- sửa bảng DonDatHang
--alter table DonDatHang
--	add
--		constraint pk_DonDatHang primary key(MaDat), 
--		constraint fk_DonDatHang_MaDat foreign key (MaKH) references KhachHang(MaKH)
--Go
--b. Thêm ràng buộc duy nhất (UNIQUE) cho trường TenHH trong bảng HangHoa, thử 
--nhập dữ liệu để kiểm tra ràng buộc. 
alter table HangHoa
	add
		constraint un_HangHoa_TenHH unique(TenHH)
go
--c. Thêm ràng buộc kiểm tra (CHECK) cho trường SLCon, yêu cầu là trường này chỉ 
--nhận giá trị >=0, thử nhập dữ liệu để kiểm tra ràng buộc. 
alter table HangHoa
	add
		constraint ck_HangHoa_SLCon check (SLCon>=0)
Go
--d. Thêm ràng buộc mặc định (DEFAULT) cho cột NgayDat trong DonDatHang với giá 
--trị mặc định là ngày hiện tại, thử nhập dữ liệu để kiểm tra ràng buộc.
alter table DonDatHang
	add
		constraint df_DonDatHang_NgayDat default (getdate()) for NgayDat
Go
--NHẬP DỮ LIỆU, tr26
/* Trong SQL Server, ngày được định dạng khi nhập liệu là 
tháng/ngày/năm, 
nếu muốn ngày định dạng là ngày/tháng/năm thì phải thực thi lệnh sau 
trước 
khi thực hiện lệnh INSERT INTO*/ 
--SET DATEFORMAT dmy
INSERT INTO HangHoa (MaHH, TenHH, DVT, SLCon, DonGiaHH) 
VALUES
('BU', N'Bàn ủi Philip', N'Cái', 60, 350000),
('CD', N'Nồi cơm điện Sharp', N'Cái', 100, 700000),
('DM', N'Đầu máy Sharp', N'Cái', 75, 1200000),
('MG', N'Máy giặt SanYo', N'Cái', 10, 4700000),
('MQ', N'Máy quạt ASIA', N'Cái', 40, 400000),
('TL', N'Tủ lạnh Hitachi', N'Cái', 50, 5500000),
('TV', N'TiVi JVC 14WS', N'Cái', 33, 7800000)
Go
INSERT INTO KhachHang (MaKH, TenKH, DiaChi, DienThoai) 
VALUES
('KH001', N'Cửa hàng Phú Lộc', N'Đà Nẵng', '0511.3246135'),
('KH002', N'Cửa hàng Hoàng Gia', N'Quảng Nam', '0510.6333444'),
('KH003', N'Nguyễn Lan Anh', N'Huế', N'0988.148248'),
('KH004', N'Công ty TNHH An Phước', N'Đà Nẵng', '0511.6987789'),
('KH005', N'Huỳnh Ngọc Trung', N'Quảng Nam', '0905.888555'),
('KH006', N'Cửa hàng Trung Tín', N'Đà Nẵng', NULL)
Go
INSERT INTO LichSuGia (MaHH, NgayHL, DonGia)
VALUES
('BU', '2011-01-01', 300000),
('BU', '2012-01-01', 350000),
('CD', '2011-06-01', 650000),
('CD', '2012-01-01', 700000),
('DM', '2011-01-01', 1000000),
('DM', '2012-01-01', 1200000),
('MG', '2011-01-01', 4700000),
('MQ', '2011-01-01', 400000),
('TL', '2011-01-01', 5000000),
('TL', '2012-01-01', 5500000),
('TV', '2012-01-01', 7800000)
Go
INSERT INTO DonDatHang (MaDat, NgayDat, MaKH) 
VALUES
('DH01', '2011-02-02', 'KH001'),
('DH02', '2011-02-15', 'KH002'),
('DH03', '2012-01-23', 'KH003'),
('DH04', '2012-03-22', 'KH004'),
('DH05', '2012-04-20', 'KH005'),
('DH06', '2012-08-05', 'KH003'),
('DH07', '2012-11-25', 'KH005')
Go
INSERT INTO PhieuGiaoHang (MaGiao, NgayGiao, MaDat)
VALUES
('GH01', '2011-02-02', 'DH01'),
('GH02', '2011-02-15', 'DH02'),
('GH03', '2012-01-23', 'DH03'),
('GH04', '2012-03-22', 'DH04'),
('GH05', '2012-04-20', 'DH05'),
('GH06', '2012-08-05', 'DH06')
Go
INSERT INTO ChiTietDatHang (MaDat, MaHH, SLDat)
VALUES
('DH01', 'BU', 15),
('DH01', 'DM', 10),
('DH01', 'TL', 4),
('DH02', 'BU', 20),
('DH02', 'TL', 3),
('DH03', 'MG', 8),
('DH04', 'TL', 12),
('DH04', 'TV', 5),
('DH05', 'BU', 12),
('DH05', 'DM', 6),
('DH05', 'MG', 6),
('DH05', 'TL', 5),
('DH06', 'BU', 30),
('DH06', 'MG', 7);
GO
INSERT INTO ChiTietGiaoHang (MaGiao, MaHH, SLGiao, DonGiaGiao) VALUES
('GH01', 'BU', 15, 300000),
('GH01', 'DM', 10, 1000000),
('GH01', 'TL', 4, 5000000),
('GH02', 'BU', 10, 300000),
('GH03', 'MG', 8, 4700000),
('GH04', 'TL', 12, 350000),
('GH05', 'DM', 15, 1200000),
('GH05', 'MG', 5, 4700000),
('GH05', 'TL', 5, 5500000),
('GH06', 'BU', 20, 350000),
('GH06', 'MG', 7, 4700000);

--e. Xóa bảng KHACHHANG? Nếu không xóa được thì nêu lý do? Muốn xóa được thì 
--phải làm sao? 
	-- Xóa khóa ngoại fk_DonDatHang_MaKH
	--alter table DonDatHang
	--	drop
	--		fk_DonDatHang_MaKH
	--go
	---- Xóa bảng
	--DROP TABLE KhachHang
--f. Xóa cột DiaChi trong bảng KhachHang, sau đó tạo lại cột này với ràng buộc mặc định là “Đà Nẵng”. 
--alter table KhachHang
--	drop
--		COLUMN DiaChi
--go
--alter table KhachHang
--	add
--		DiaChi nvarchar(50),
--		constraint df_KhacHang_DiaChi default(N'Đà Nẵng') for DiaChi	
--g. Xóa khóa ngoại MaDat trong PHIEUGIAOHANG tham chiếu tới MaDat trong 
--DonDatHang, sau đó tạo lại khóa ngoại này.
--alter table PhieuGiaoHang
--	drop
--		fk_PhieuGiaoHang_MaDat
--go
--alter table PhieuGiaoHang
--	add
--		constraint fk_PhieuGiaoHang_MaDat foreign key(MaDat) references DonDatHang(MaDat)
-- ---------------------------------------
--TRUY VẤN DỮ LIỆU, SELECT-- TR29
SELECT * 
FROM KhachHang
-- SELECT, 
SELECT TenKH as [Tên Khách Hàng],MaKH MaKhachHang,DT=DienThoai
FROM KhachHang
	-- biểu thức
select *, TongTien = SLCon * DonGiaHH
from HangHoa
	-- distinct, loại bỏ dòng trùng lặp
select distinct MaHH
from ChiTietDatHang
	-- top, lấy dòng
select top 3 *
from HangHoa
-- MỆNH ĐỀ WHERE, tr33
select *
from HangHoa
Where SLCon>=50
--Mặt hàng có giá từ 500000 đến 1000000
select *
from HangHoa
where --DonGiaHH>=500000 and DonGiaHH<1000000
	DonGiaHH between 500000 and 1000000
--Khách hàng có địa chỉ ở Đà Nẵng
select *
from KhachHang
where DiaChi = N'Đà Nẵng'
--Khách hàng không ở Đà Nẵng
select *
from KhachHang
where DiaChi<>N'Đà Nẵng'
--Khách hàng vừa ở Đà Nẵng, vừa ở Quảng Nam
select *
from KhachHang
where -- DiaChi=N'Đà Nẵng' or DiaChi=N'Quảng Nam'
		DiaChi in (N'Đà Nẵng',N'Quảng Nam')
--Khách hàng loại 'Cửa hàng'
select *
from KhachHang
where TenKH like N'Cửa hàng%'
--Sản phẩm hãng Sharp
select *
from HangHoa
where TenHH like N'%Sharp%'
--Khách hàng không có số điện thoại
select *
from KhachHang
where DienThoai is NULL
--Khách hàng có số điện thoại
select *
from KhachHang
where DienThoai is not NULL
--Khách hàng số điện thoại, có dấu '.' ở đúng vị trí thứ 5
select * 
from KhachHang
where DienThoai like '____.%'
------
-- NỐI BẢNG, tr36
	-- Cách 1: tích đề các
select *
from ChiTietGiaoHang, PhieuGiaoHang
where ChiTietGiaoHang.MaGiao = PhieuGiaoHang.MaGiao
	and MaDat ='DH01'
	-- Cách 2: phép join
select *
from ChiTietGiaoHang
	inner join PhieuGiaoHang on ChiTietGiaoHang.MaGiao = PhieuGiaoHang.MaGiao
where MaDat ='DH01'

--a. Cho biết chi tiết giao hàng của đơn đặt hàng DH01, hiển thị: tên hàng hóa, số lượng giao và đơn giá giao.
select hh.TenHH,ctgh.SLGiao,ctgh.DonGiaGiao
from ChiTietGiaoHang as ctgh
	inner join PhieuGiaoHang as pgh on pgh.MaGiao = ctgh.MaGiao
	inner join HangHoa as hh on hh.MaHH=ctgh.MaHH
-- LEFT JOIN
	-- thông tin tên khách hàng và các đơn hàng họ mua, nếu KH ko mua thì đơn hàng hiện NULL
select *
from KhachHang as kh
	left join DonDatHang as ddh on kh.MaKH=ddh.MaKH
--b. Cho biết thông tin những đơn đặt hàng không được giao, hiển thị: mã đặt, ngày đặt, tên khách hàng.
select kh.TenKH, ddh.MaDat,ddh.NgayDat
from DonDatHang as ddh
	left join PhieuGiaoHang as pgh on ddh.MaDat=pgh.MaDat
	inner join KhachHang as kh on kh.MaKH=ddh.MaKH
where MaGiao is NULL
	--right join
select kh.TenKH, ddh.MaDat,ddh.NgayDat
from PhieuGiaoHang as pgh
	right join DonDatHang as ddh on ddh.MaDat=pgh.MaDat
	inner join KhachHang as kh on kh.MaKH=ddh.MaKH
where MaGiao is NULL
	--CÁC PHÉP TOÁN TẬP HỢP, UNION, INTERSECT, EXCEPT, tr41
select *
from
		(select MaDat from DonDatHang
			intersect  --uninon --except
		select MaDat from PhieuGiaoHang) as a
		inner join DonDatHang as ddh on a.MaDat=ddh.MaDat
		inner join KhachHang as kh on kh.MaKH=ddh.MaKH
-- Lấy ra các MaHH chưa có ai mua bao giờ
select *
from HangHoa as hh
	left join ChiTietDatHang as ctdh on ctdh.MaHH=hh.MaHH
where ctdh.MaDat is null 
	---- order by, tr36
select *
from HangHoa
order by DonGiaHH desc
	-- group by - GOM NHÓM - THỐNG KÊ, tr42
-- 1. THỐNG KÊ TRÊN TOÀN VÙNG DỮ LIỆU, tr43
select max(DonGiaHH)
from HangHoa
-- tổng số lượng HH còn
select sum(SLCon)
from HangHoa

select count(TenHH)
from HangHoa
-- đếm bao nhiêu đơn hàng đã giao
select count(*)  --dấu * đếm tất cả các dòng
from DonDatHang as ddh
	inner join PhieuGiaoHang as pgh on pgh.MaDat=ddh.MaDat
-- đếm bao nhiêu đơn hàng chưa giao
select count(*)
from DonDatHang as ddh
	left join PhieuGiaoHang as pgh on pgh.MaDat=ddh.MaDat
where MaGiao is null
-- 2. THỐNG KÊ THEO VÙNG DỮ LIỆU
	--mỗi mã KH có bao nhiêu đơn
SELECT MaKH, SLDon=count(*) 
FROM DonDatHang
group by MaKH
	-- MaDat, Số loại HH, Tổng Số lượng Đặt
select MaDat,count(MaHH) as [Số loại Hàng hóa],sum(SLDat)
from ChiTietDatHang
group by MaDat
--c. Cho biết hàng hóa nào có đơn giá hiện hành cao nhất, 
-- hiển thị: tên hàng hóa, đơn giá hiện hành.
select *
from HangHoa
where DonGiaHH = (select max(DonGiaHH)
				from HangHoa)

				--select top 1 DonGiaHH
				--from HangHoa
				--order by DonGiaHH desc
--d. Cho biết số lần đặt hàng của từng khách hàng, những khách hàng không đặt hàng thì 
--phải hiển thị số lần đặt hàng bằng 0. Hiển thị: Mã khách hàng, tên khách hàng, số lần đặt
select kh.MaKH,TenKH, SLDon=count(MaDat)
from KhachHang AS kh
	left join DonDatHang as ddh on  kh.MaKH=ddh.MaKH
group by kh.MaKH, TenKH
--e. Cho biết tổng tiền của từng phiếu giao hàng trong năm 2012, hiển thị: mã giao, ngày 
--giao, tổng tiền, với tổng tiền= SUM(SLGiao*DonGiaGiao)
select pgh.MaGiao, pgh.NgayGiao, [Tổng Tiền]=sum(ctgh.SLGiao*ctgh.DonGiaGiao)
from PhieuGiaoHang as pgh
	inner join ChiTietGiaoHang as ctgh on pgh.MaGiao= ctgh.MaGiao
where year(pgh.NgayGiao)=2012
group by pgh.MaGiao,  pgh.NgayGiao
--f. Cho biết khách hàng nào có 2 lần đặt hàng trở lên, hiển thị: mã khách hàng, tên khách 
--hàng, số lần đặt. 
select kh.MaKH, kh.TenKH, SLDat=count(ddh.MaDat)
from DonDatHang as ddh
	inner join KhachHang as kh on ddh.MaKH=kh.MaKH
group by kh.MaKH,kh.TenKH
having count(ddh.MaDat)>=2
--g. Cho biết mặt hàng nào đã được giao với tổng số lượng giao nhiều nhất, hiển thị: mã 
--hàng, tên hàng hóa, tổng số lượng đã giao. 
select hh.MaHH,  hh.TenHH, TongSLGiao=sum(ctgh.SLGiao)
from ChiTietGiaoHang as ctgh
	inner join HangHoa as hh on hh.MaHH = ctgh.MaHH
group by hh.MaHH, hh.TenHH
having sum(ctgh.SLGiao) >=all(select TongSLGiao=sum(SLGiao)  --all, any,  tr48
							from ChiTietGiaoHang
							group by MaHH)
							---- cách 2
							--(select top 1 sum(SLGiao)
							--from ChiTietGiaoHang
							--group by MaHH
							--order by sum(SLGiao) desc)
							-------cách 3
							--select max(TongSLGiao)
							--from
							--		(select MaHH, TongSLGiao=sum(SLGiao)
							--		from ChiTietGiaoHang
--							--		group by MaHH) as tam
----h. Tăng số lượng còn của mặt hàng có mã bắt đầu bằng ký tự “M” lên 10. 
----xem sách trang 27.
---- Lệnh cập nhật DL update
--update HangHoa
--set SLCon = SLCon + 10
--where MaHH like 'M%'

--select * from HangHoa
----i. Copy dữ liệu bảng HangHoa sang một bảng HangHoa_copy, sau đó xóa những mặt hàng chưa được đặt 
----trong bảng HangHoa. Chèn lại vào bảng HangHoa những dòng bị xóa từ bảng HangHoa_copy. 
--	-- copy dữ liệu cả bảng. SELECT...INTO, tr49
--	select *
--	into HangHoa_copy
--	from HangHoa
--	-- xóa dữ liệu, delete, tr27
--	delete HangHoa
--	from HangHoa as hh
--		left join ChiTietDatHang as ctdh on ctdh.MaHH=hh.MaHH
--	where ctdh.MaDat is NULL
--	-- Chèn lại vào bảng HangHoa những dòng bị xóa từ bảng HangHoa_copy.
--	insert into HangHoa
--	select *
--	from HangHoa_copy
--	where MaHH not in (select MaHH from ChiTietDatHang)
--	----------------------------------------------------------------
--		-- cách khác, toán tử exists
--		select *
--		from HangHoa_copy as hh
--		where not exists  (select * 
--							from ChiTietDatHang as ctdh
--							where hh.MaHH=ctdh.MaHH)
--		-- toán tử in
--		select *
--		from HangHoa_copy
--		where MaHH not in (select MaHH from ChiTietDatHang)

--	--delete HangHoa
--	--where MaHH not in (select MaHH from ChiTietDatHang)
--	select * from HangHoa_copy	 
----j. Cập nhật số điện thoại cho khách hàng có mã KH006.
--update KhachHang
--set DienThoai = '113'
--where MaKH='KH006'
----k. Thêm cột ThanhTien cho bảng ChiTietGiaoHang, sau đó cập nhật giá trị cho cột này 
----với ThanhTien = SLGiao*DonGiaGiao 
--		--
--		alter table ChiTietGiaoHang
--			add
--				ThanhTien int
--		go
--		update ChiTietGiaoHang
--		set ThanhTien=SLGiao * DonGiaGiao
--		--
--		select * from ChiTietGiaoHang
--------------------------------------
-- VIEW, KHUNG NHÌN, tr66
--------------------------------------
-- định nghĩa view, tr67
alter view vw_SanPham(cot1,cot2,cot3,cot4,cot5)
WITH ENCRYPTION -- mã hóa nội dung
as
	select * from HangHoa
-- sử dụng view
select * from vw_SanPham

insert into vw_SanPham
values ('LT',N'laptop',N'Cái',43,20000000)
--a. Tạo view thống kê doanh số giao hàng của từng mặt hàng trong 6 tháng đầu năm 2011 
create view vw_DS6thangNam2011
as
	select hh.TenHH, DoanhSo= sum (ctgh.SLGiao)
	from HangHoa as hh
		inner join ChiTietGiaoHang as ctgh on ctgh.MaHH=hh.MaHH
		inner join PhieuGiaoHang as pgh on pgh.MaGiao=ctgh.MaGiao
	where month(pgh.NgayGiao) <=6 and year(pgh.NgayGiao)=2011
	group by hh.TenHH

select * from vw_DS6thangNam2011
--b. Tạo view hiển thị thông tin hàng hóa có tổng số lượng đặt hàng cao nhất, hiển thị: tên 
--hàng, tổng số lượng đặt (yêu cầu sử dụng toán tử >=ALL) 
create view vw_SLDatCaoNhat
as
	select hh.TenHH, SLDat=sum(ctdh.SLDat)
	from HangHoa as hh
		inner join ChiTietDatHang as ctdh on ctdh.MaHH=hh.MaHH
	group by hh.TenHH
	having sum(ctdh.SLDat) >= all( select sum(SLDat)
									from ChiTietDatHang
									group by MaHH)

select * from vw_SLDatCaoNhat

--c. Tạo view hiển thị danh sách khách hàng ở Đà Nẵng có sử dụng WITH CHECK OPTION,
--sau đó chèn 2 khách hàng vào view này, một khách hàng có địa chỉ Đà Nẵng và 
--một khách hàng có địa chỉ ở Quảng Nam, có nhận xét gì trong 2 trường hợp này? 
create view vw_KHDN
as
	select * from KhachHang where DiaChi = N'Đà Nẵng'
WITH CHECK OPTION
--
select * from vw_KHDN
--
insert into vw_KHDN
values('KH007',N'An',N'Đà Nẵng','113') 

insert into vw_KHDN
values('KH008',N'Nguyên',N'Quảng Nam','113') 
--d. (*)Tạo view thống kê số lượng đơn đặt hàng theo năm, hiển thị: năm, số đơn đặt hàng 
--đã giao, số đơn đặt hàng chưa giao. 
create view vw_SoDonTheoNam
as
	select Nam=year(ddh.NgayDat), SoDonGiao=count(pgh.MaGiao),SoDonChuaGiao= -- count(ddh.MaDat)-count(pgh.MaGiao)
																			sum(iif(pgh.MaGiao is NULL,1,0))
	from DonDatHang as ddh
		left join PhieuGiaoHang as pgh on pgh.MaDat=ddh.MaDat
	group by year(ddh.NgayDat)

select * from vw_SoDonTheoNam
--e. (*)Tạo view tính tổng số lượng mặt hàng “máy giặt” đã được đặt và được giao trong 
--năm 2012, hiển thị: mã mặt hàng, tên mặt hàng, tổng SL đặt, tổng SL giao.
create view vw_DatGiao2012
as
		select hh.MaHH, hh.TenHH,TongSLDat=DatHang.SLDat,TongSLGiao= iif( GiaoHang.SLGiao is NULL,0,GiaoHang.SLGiao)
		from
					(select ctdh.MaHH,SLDat=sum(ctdh.SLDat)
					from ChiTietDatHang as ctdh
						inner join DonDatHang as ddh on ddh.MaDat=ctdh.MaDat
					where year(ddh.NgayDat)=2012
					group by ctdh.MaHH) as DatHang
						left join
					(select ctgh.MaHH,SLGiao=sum(ctgh.SLGiao)
					from PhieuGiaoHang as pgh 
						inner join ChiTietGiaoHang as ctgh on ctgh.MaGiao=pgh.MaGiao
					where year(pgh.NgayGiao)=2012
					group by ctgh.MaHH) as GiaoHang
						on DatHang.MaHH=GiaoHang.MaHH
					inner join HangHoa as hh
						on hh.MaHH=DatHang.MaHH
		where hh.TenHH like N'Máy giặt%' 
--f. (*)Loại khách hàng được phân theo thông tin sau: 
--− Tổng tiền giao>= 50 triệu thì Loại khách hàng = “Khách hàng VIP” 
--− Tổng tiền giao>= 20 triệu thì Loại khách hàng = “Khách hàng thân thiết” 
--− Ngược lại thì Loại khách hàng = “Khách hàng thành viên” 
--Tạo view hiển thị danh sách khách hàng cùng loại khách hàng tương ứng, hiển thị: Mã 
--khách hàng, tên khách hàng, địa chỉ, loại khách hàng.
create view vw_LoaiKH
as
		select kh.MaKH,kh.TenKH,kh.DiaChi,LoaiKH= --iif(sum(ctgh.SLGiao*ctgh.DonGiaGiao)>50000000,N'Khách hàng VIP',
												  --iif(sum(ctgh.SLGiao*ctgh.DonGiaGiao)>20000000,N'Khách hàng thân thiết',N'Khách hàng thành viên'))
												CASE
													WHEN sum(ctgh.SLGiao*ctgh.DonGiaGiao)>50000000 then N'Khách hàng VIP'
													WHEN sum(ctgh.SLGiao*ctgh.DonGiaGiao)>20000000 then N'Khách hàng thân thiết'
													ELSE N'Khách hàng thành viên'
												END
		from KhachHang as kh 
			inner join DonDatHang as ddh on ddh.MaKH=kh.MaKH
			inner join PhieuGiaoHang as pgh on pgh.MaDat=ddh.MaDat
			inner join ChiTietGiaoHang as ctgh on ctgh.MaGiao=pgh.MaGiao
		group by kh.MaKH,kh.TenKH,kh.DiaChi

select * from vw_LoaiKH