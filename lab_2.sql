use master
GO 

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'quanlybanhang')
BEGIN
    DROP DATABASE quanlybanhang
END
Go

CREATE DATABASE quanlybanhang
go

use quanlybanhang
go

create table khachhang(
	makh char(5) not null,
	hoten nvarchar(50),
	dchi nvarchar(100),
	sodt char(15),
	ngsinh date,
	doanhso money,
	ngdk date,
	constraint pk_khachhang primary key(makh)
)
go
create table nhanvien(
	manv char(5) not null,
	hoten nvarchar(50),
	dthoai char(20),
	ngvl date, -- Ngày vào làm
	constraint pk_nhanvien primary key(manv)
)
go
create table sanpham(
	masp char(5) not null,
	tensp varchar(50),
	dvt varchar(20),
	nuocsx varchar(30),
	gia money,
	constraint pk_sanpham primary key(masp)
)
go
create table hoadon(
	sohd char(5) not null,
	nghd date,
	makh char(5),
	manv char(5),
	trigia money,
	constraint pk_hoadon primary key(sohd),
	constraint fk_hoadon_makh foreign key(makh) references khachhang(makh),
	constraint fk_hoadon_manv foreign key(manv) references nhanvien(manv)
)
go
create table cthd(
	sohd char(4) not null,
	masp char(4) not null,
	sl int,
	constraint pk_cthd primary key(sohd,masp)
)
go
set dateformat dmy
go
insert into khachhang(makh,hoten,dchi,sodt,ngsinh,doanhso,ngdk)
values
('KH01','nguyen van a','731 Tran Hung Dao, Q5, tpHCM','08823451','1960-10-22',13060000,'2006-07-22'),
('KH02','tran ngoc han','23/5 Nguyen Trai, Q5, tpHCM','08823997','1974-04-03',280000,'2006-07-30'),
('KH03','tran ngoc linh','45 Nguyen Canh Chan, Q1, tpHCM','08898182','1980-06-12',3860000,'2006-08-05'),
('KH04','tran minh long','50/34 Le Dai Hanh, Q10, tpHCM','08829933','1985-03-09',250000,'2006-10-02'),
('KH05','le nhat minh','34 Truong Dinh, Q3, tpHCM','08827463','1950-03-10',21000,'2006-10-28'),
('KH06','le hoai thuong','227 Nguyen Van Cu, Q5, tpHCM','08877632','1981-12-31',915000,'2006-11-24'),
('KH07','nguyen van tam','32/3 Tran Binh Trong, Q5, tpHCM','08897532','1971-04-06',12500,'2006-12-01'),
('KH08','phan thi thanh','45/2 An Duong Vuong, Q5, tpHCM','088848492','1971-01-10',365000,'2006-12-13'),
('KH09','le ha vinh','873 Le Hong Phong, Q5, tpHCM','08844921','1979-09-03',70000,'2007-01-14'),
('KH10','ha duy lap','34/34B Nguyen Trai, Q1, tpHCM','08821231','1983-05-02',67500,'2007-01-16')
go
insert into nhanvien(manv,hoten,dthoai,ngvl)
values
('nv01','nguyen nhu nhut','0927345678','2006-04-13'),
('nv02','le thi phi yen','0927341724','2006-04-21'),
('nv03','nguyen van b','0920743678','2006-04-27'),
('nv04','ngo thanh tuan','0927340188','2006-06-24'),
('nv05','nguyen thi thanh truc','0927112678','2006-07-20')
go
insert into sanpham(masp, tensp, dvt, nuocsx, gia)
values
('BC01', 'But chi', 'cay', 'Singapore', 3000),
('BC02', 'But chi', 'cay', 'Singapore', 5000),
('BC03', 'But chi', 'cay', 'Viet Nam', 3500),
('BC04', 'But chi', 'hop', 'Viet Nam', 30000),
('BB01', 'But bi', 'cay', 'Viet Nam', 7000),
('BB02', 'But bi', 'cay', 'Trung Quoc', 5000),
('BB03', 'But bi', 'hop', 'Thai Lan', 100000),
('TV01', 'Tap 100 giay mong', 'quyen', 'Trung Quoc', 2500),
('TV02', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', 4500),
('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', 3000),
('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', 5500),
('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', 23000),
('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', 53000),
('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', 34000),
('ST01', 'So tay 500 trang', 'quyen', 'Trung Quoc', 40000),
('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', 55000),
('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', 51000),
('ST04', 'So tay', 'quyen', 'Thai Lan', 55000),
('ST05', 'So tay mong', 'quyen', 'Thai Lan', 20000),
('ST06', 'Phan viet bang', 'hop', 'Viet Nam', 5000),
('ST07', 'Phan khong bui', 'hop', 'Viet Nam', 7000),
('ST08', 'Bong bang', 'cai', 'Viet Nam', 1000),
('ST09', 'But long', 'cay', 'Viet Nam', 5000),
('ST10', 'But long', 'cay', 'Trung Quoc', 7000)
go

insert into hoadon (sohd, nghd, makh, manv, trigia) 
values
(1001, '2006-07-23', 'KH01', 'NV01', 320000),
(1002, '2006-08-12', 'KH01', 'NV02', 840000),
(1003, '2006-08-23', 'KH02', 'NV01', 100000),
(1004, '2006-09-01', 'KH02', 'NV01', 180000),
(1005, '2006-10-20', 'KH01', 'NV02', 3800000),
(1006, '2006-10-16', 'KH01', 'NV03', 2430000),
(1007, '2006-10-28', 'KH03', 'NV03', 510000),
(1008, '2006-10-28', 'KH01', 'NV03', 440000),
(1009, '2006-10-28', 'KH03', 'NV04', 200000),
(1010, '2006-11-01', 'KH01', 'NV01', 5200000),
(1011, '2006-11-04', 'KH04', 'NV03', 250000),
(1012, '2006-11-30', 'KH05', 'NV03', 21000),
(1013, '2006-12-12', 'KH06', 'NV01', 5000),
(1014, '2006-12-31', 'KH03', 'NV02', 3150000),
(1015, '2007-01-01', 'KH06', 'NV01', 910000),
(1016, '2007-01-01', 'KH07', 'NV02', 12500),
(1017, '2007-01-02', 'KH08', 'NV03', 35000),
(1018, '2007-01-13', 'KH08', 'NV03', 330000),
(1019, '2007-01-13', 'KH01', 'NV03', 30000),
(1020, '2007-01-14', 'KH09', 'NV04', 70000),
(1021, '2007-01-16', 'KH10', 'NV03', 67500),
(1022, '2007-01-16', 'KH10', 'NV03', 7000),
(1023, '2007-01-17', 'KH10', 'NV01', 330000)
go



insert into cthd(sohd,masp,sl)
values
('1001','TV02',10),
('1001','ST01',5),
('1001','BC01',5),
('1001','BC02',10),
('1001','ST08',10),
('1002','BC04',20),
('1002','BB01',20),
('1002','BB02',20),
('1003','BB03',10),
('1004','TV01',20),
('1004','TV02',10),
('1004','TV03',10),
('1004','TV04',10),
('1005','TV05',50),
('1005','TV06',50),
('1006','TV07',20),

('1006','ST01',30),
('1006','ST02',10),
('1007','ST03',10),
('1008','ST04',8),
('1009','ST05',10),
('1010','TV07',50),
('1010','ST07',50),
('1010','ST08',100),
('1010','ST04',50),
('1010','TV03',100),
('1011','ST06',50),
('1012','ST07',3),
('1013','ST06',5),
('1014','BC02',80),
('1014','BB02',100),
('1014','BC04',60),

('1014','BB01',50),
('1015','BB02',30),
('1015','BB03',7),
('1016','TV01',5),
('1017','TV02',1),
('1017','TV03',1),
('1017','TV04',5),
('1018','ST04',6),
('1019','ST05',1),
('1019','ST06',2),
('1020','ST07',10),
('1021','ST08',5),
('1021','TV01',7),
('1021','TV02',10),
('1022','ST07',1),
('1023','ST04',16)
go
alter table sanpham
add constraint check_gia check (gia > 500)
go
alter table cthd
add constraint check_sl check(sl >= 1)
go
alter table khachhang 
add constraint check_day check(ngdk > ngsinh);
go
CREATE TRIGGER trg_Check_NGHD ON hoadon
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN khachhang k ON i.makh = k.makh
        WHERE i.nghd < k.ngdk
    )
    BEGIN
        print('Error')
        ROLLBACK TRANSACTION
    END
END
GO

create trigger trg_check_ngvl on nhanvien
for insert, update
as
begin
	if exists(
		select 1
		from inserted i
		inner join hoadon as hd on i.manv=hd.manv
		where nghd < ngvl
	)
	begin
		print('error')
		rollback transaction
	end
end
go

update sanpham
set gia = gia * 1.05
where nuocsx = 'Thai Lan'

update sanpham
set gia = gia * 0.95
where nuocsx = 'Trung Quoc'

-- bai 3
-- 1 In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
select masp, tensp from sanpham
where nuocsx = 'Trung Quoc'
-- 2 In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
select masp, tensp from sanpham
where dvt = 'cay' or dvt = 'quyen'
-- 3 In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
select masp, tensp from sanpham
where masp like 'B%01'
-- 4 In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
select masp, tensp from sanpham
where nuocsx = 'Trung Quoc' and (gia between 30000 and 40000)
-- 5 In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
select masp, tensp from sanpham
where (nuocsx = 'Trung Quoc' or nuocsx = 'Thai Lan')  and (gia between 30000 and 40000)
-- 6 In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
select sohd, trigia from hoadon
where nghd = '2007-01-01' or nghd = '2007-01-02'
-- 7 In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007
select sohd, trigia from hoadon
where nghd like '2007-01-%'
-- 8 In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
select kh.makh, kh.hoten from khachhang as kh
	inner join hoadon as hd on hd.makh = kh.makh
	where hd.nghd = '2007-01-01'
-- 9 In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
select hd.sohd, hd.trigia from hoadon as hd
	inner join nhanvien as nv on nv.manv = hd.manv
where nv.hoten = 'nguyen van b' and hd.nghd = '2006-10-28'
-- 10 In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
select sp.masp, sp.tensp from sanpham as sp
inner join cthd on sp.masp = cthd.masp
inner join hoadon as hd on hd.sohd = cthd.sohd
inner join khachhang as kh on kh.makh = hd.makh
where kh.hoten = 'nguyen van a' and hd.nghd like '2006-10-%'
-- 11 Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
select hd.sohd from hoadon as hd
inner join cthd on cthd.sohd = hd.sohd
inner join sanpham as sp on sp.masp = cthd.masp
where sp.masp = 'BB01' or sp.masp = 'BB02'
-- 12 Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
select hd.sohd from hoadon as hd
inner join cthd on cthd.sohd = hd.sohd
inner join sanpham as sp on sp.masp = cthd.masp
where (sp.masp = 'BB01' or sp.masp = 'BB02') and (cthd.sl between 10 and 20)
-- 13 Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
select c1.sohd from cthd as c1
inner join cthd c2 on c1.sohd = c2.sohd
where (c1.masp = 'BB01' and c1.sl between 10 and 20)
and (c2.masp = 'BB02' and c2.sl between 10 and 20)
-- 14 In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
select distinct sp.masp, sp.tensp from sanpham as sp
inner join cthd on sp.masp = cthd.masp
inner join hoadon as hd on hd.sohd = cthd.sohd
where sp.nuocsx = 'Trung Quoc' or hd.nghd = '2007-01-01'
--15  In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
select sp.masp, sp.tensp from sanpham sp
where sp.masp not in(select distinct masp from cthd)
-- 16 In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
select sp.masp, sp.tensp from sanpham sp
where sp.masp 
not in(
	select masp from cthd
	inner join hoadon as hd on hd.sohd = cthd.sohd
	where hd.nghd >= '2006-01-01' and hd.nghd <= '2006-12-31'
) 
-- 17 In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
select sp.masp, sp.tensp from sanpham sp
where sp.masp 
not in(
	select masp from cthd
	inner join hoadon as hd on hd.sohd = cthd.sohd
	where hd.nghd >= '2006-01-01' and hd.nghd <= '2006-12-31'
) and sp.nuocsx = 'Trung Quoc'