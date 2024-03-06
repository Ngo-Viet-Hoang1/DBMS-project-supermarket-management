CREATE DATABASE QLSIEUTHI

USE QLSIEUTHI

GO
CREATE TABLE SIEUTHI(
	ID_ST CHAR(7) CONSTRAINT PK_SieuThi PRIMARY KEY,
	Ten NVARCHAR(255),
	DiaChi NVARCHAR(255),
	ThoiGianMoCua TIME,
	ThoiGianDongCua TIME
)
GO
CREATE TABLE NGANHHANG(
	ID_NH CHAR(7) CONSTRAINT PK_NganhHang PRIMARY KEY,
	Ten NVARCHAR(255)
)
GO
CREATE TABLE ST_CO_NH(
	ID_ST CHAR(7),
	ID_NH CHAR(7),
	CONSTRAINT PK_SieuThi_Co_NganhHang PRIMARY KEY (ID_ST, ID_NH),
	CONSTRAINT FK_SieuThi_Co FOREIGN KEY (ID_ST) REFERENCES SIEUTHI(ID_ST),
	CONSTRAINT FK_Co_NganhHang FOREIGN KEY (ID_NH) REFERENCES NGANHHANG(ID_NH)
)
GO
CREATE TABLE BOPHANLAMVIEC(
	ID_BP CHAR(7) CONSTRAINT PK_BoPhamLamViec PRIMARY KEY,
	Ten NVARCHAR(40)
)
GO
CREATE TABLE BPLV_THUOC_ST(
	ID_BP CHAR(7),
	ID_ST CHAR(7),
	CONSTRAINT PK_BPLV_Thuoc_ST PRIMARY KEY (ID_BP, ID_ST),
	CONSTRAINT FK_BPLV_Thuoc FOREIGN KEY (ID_BP) REFERENCES BOPHANLAMVIEC(ID_BP),
	CONSTRAINT FK_Thuoc_SieuThi FOREIGN KEY (ID_ST) REFERENCES SIEUTHI(ID_ST)
)
GO
CREATE TABLE NHANVIEN(
	ID_NV CHAR(7) CONSTRAINT PK_NhanVien PRIMARY KEY,
	Ho NVARCHAR(30),
	Ten NVARCHAR(10),
	Phai BIT,
	SDT CHAR(10),
	LuongCB INT,
	NgayBDlam DATE,
	SinhNhat DATE,
	DiaChi NVARCHAR(255),
	ChucVu NVARCHAR(10),
	BHYT CHAR(10),
	ID_QL CHAR(7),
	ID_BP CHAR(7),
	CONSTRAINT FK_QuanLi_NhanVien FOREIGN KEY (ID_QL) REFERENCES NHANVIEN(ID_NV),
	CONSTRAINT FK_NhanVien_BPLV FOREIGN KEY (ID_BP) REFERENCES BOPHANLAMVIEC(ID_BP)
)
GO
CREATE TABLE CONCAI(
	ID_NV CHAR(7),
	HoTen NVARCHAR(40),
	SinhNhat DATE,
	Phai BIT,
	CONSTRAINT PK_ConCai PRIMARY KEY (ID_NV, HoTen),
	CONSTRAINT FK_ConCai_NhanVien FOREIGN KEY (ID_NV) REFERENCES NHANVIEN(ID_NV)
)
GO
CREATE TABLE CTDT(
	ID_CTDT CHAR(7) CONSTRAINT PK_CTDT PRIMARY KEY,
	ThoiGian NVARCHAR(30),
)
GO
CREATE TABLE THAMGIA(
	ID_NV CHAR(7),
	ID_CTDT CHAR(7),
	CONSTRAINT PK_ThamGia PRIMARY KEY (ID_NV, ID_CTDT),
	CONSTRAINT FK_NhanVien_ThamGia FOREIGN KEY (ID_NV) REFERENCES NHANVIEN(ID_NV),
	CONSTRAINT FK_CTDT_ThamGia FOREIGN KEY (ID_CTDT) REFERENCES CTDT(ID_CTDT)
)
GO
CREATE TABLE CALAM(
	Ten CHAR(2) CONSTRAINT PK_CaLam PRIMARY KEY,
	ThoiGian TIME
)
GO
CREATE TABLE DONGCHAMCONG(
	ID_DCC CHAR(7) CONSTRAINT PK_DongChamCong PRIMARY KEY,
	Ngay DATE,
	TimeBD TIME,
	TimeKT TIME,
	TenCa CHAR(2),
	ID_NV CHAR(7),
	CONSTRAINT FK_NhanVien_DongChamCong FOREIGN KEY (ID_NV) REFERENCES NHANVIEN(ID_NV),
	CONSTRAINT FK_DongChamCong_TenCa FOREIGN KEY (TenCa) REFERENCES CALAM(Ten)
)
GO
CREATE TABLE SANPHAM(
	ID_SP CHAR(7) CONSTRAINT PK_SanPham PRIMARY KEY,
	Ten NVARCHAR(255),
	DonViTinh NVARCHAR(40),
	Gia INT,
	GiamGia INT,
	HSD DATE,
	ID_NH CHAR(7),
	CONSTRAINT FK_SanPham_NganhHang FOREIGN KEY (ID_NH) REFERENCES NGANHHANG(ID_NH)
)
GO
CREATE TABLE VOUCHER(
	ID_VC CHAR(7) CONSTRAINT PK_Voucher PRIMARY KEY,
	GiaTri INT
)
GO
CREATE TABLE KHACHHANG(
	ID_KH CHAR(7) CONSTRAINT PK_KhachHang PRIMARY KEY,
	Ho NVARCHAR(30),
	Ten NVARCHAR(10),
	Phai BIT,
	SDT CHAR(10),
	Email NVARCHAR(40),
	DiaChi NVARCHAR(255),
	DiemTL INT
)
GO
CREATE TABLE MUA(
	ID_KH CHAR(7),
	ID_SP CHAR(7),
	CONSTRAINT PK_Mua PRIMARY KEY (ID_KH, ID_SP),
	CONSTRAINT FK_KhachHang_Mua FOREIGN KEY (ID_KH) REFERENCES KHACHHANG(ID_KH),
	CONSTRAINT FK_Mua_SanPham FOREIGN KEY (ID_SP) REFERENCES SANPHAM(ID_SP)
)
GO
CREATE TABLE DOI(
	ID_KH CHAR(7),
	ID_VC CHAR(7),
	SoLuong INT,
	NgayDoi DATE,
	CONSTRAINT PK_Doi PRIMARY KEY (ID_KH, ID_VC),
	CONSTRAINT FK_KhachHang_Doi FOREIGN KEY (ID_KH) REFERENCES KHACHHANG(ID_KH),
	CONSTRAINT FK_Doi_Voucher FOREIGN KEY (ID_VC) REFERENCES VOUCHER(ID_VC)
)
GO 
CREATE TABLE HOADON(
	ID_HD CHAR(7) CONSTRAINT PK_HoaDon PRIMARY KEY,
	PTTT NVARCHAR(40),
	ThoiGianIn DATETIME,
	TienNhan INT,
	ID_VC CHAR(7),
	ID_NV CHAR(7),
	ID_ST CHAR(7),
	ID_KH CHAR(7),
	CONSTRAINT FK_HoaDon_Voucher FOREIGN KEY (ID_VC) REFERENCES VOUCHER(ID_VC),
	CONSTRAINT FK_HoaDon_NhanVien FOREIGN KEY (ID_NV) REFERENCES NHANVIEN(ID_NV),
	CONSTRAINT FK_HoaDon_SieuThi FOREIGN KEY (ID_ST) REFERENCES SIEUTHI(ID_ST),
	CONSTRAINT FK_HoaDon_KhachHang FOREIGN KEY (ID_KH) REFERENCES KHACHHANG(ID_KH)
)
GO
CREATE TABLE SP_TRONG_HD(
	ID_HD CHAR(7),
	ID_SP CHAR(7),
	SoLuong INT,
	CONSTRAINT PK_Trong PRIMARY KEY (ID_HD, ID_SP),
	CONSTRAINT FK_Trong_HoaDon FOREIGN KEY (ID_HD) REFERENCES HOADON(ID_HD),
	CONSTRAINT FK_SanPham_Trong FOREIGN KEY (ID_SP) REFERENCES SANPHAM(ID_SP)
)
GO
CREATE TABLE KHOTONG(
	ID_KT CHAR(7) CONSTRAINT PK_KhoTong PRIMARY KEY,
	Ten NVARCHAR(255),
	DiaChi	NVARCHAR(255),
	SucChua INT
)
GO
CREATE TABLE PHIEUNHAPXUAT(
	ID_P CHAR(7) CONSTRAINT PK_PhieuNhapXuat PRIMARY KEY,
	ThoiGian DATETIME,
	ID_NV CHAR(7) CONSTRAINT FK_NhanVien_PhieuNhapXuat FOREIGN KEY (ID_NV) REFERENCES NHANVIEN(ID_NV)
)
GO
CREATE TABLE THONGTIN(
	ID_P CHAR(7),
	ID_SP CHAR(7),
	SoLuong INT,
	TinhTrang NVARCHAR(255),
	CONSTRAINT PK_ThongTin PRIMARY KEY (ID_P, ID_SP),
	CONSTRAINT FK_ThongTin_Phieu FOREIGN KEY (ID_P) REFERENCES PHIEUNHAPXUAT(ID_P),
	CONSTRAINT FK_ThongTin_SanPham FOREIGN KEY (ID_SP) REFERENCES SANPHAM(ID_SP)
)
GO
CREATE TABLE NHACUNGCAP(
	ID_NCC CHAR(7) CONSTRAINT PK_NhaCungCap PRIMARY KEY,
	Ten NVARCHAR(255),
	SDT CHAR(10),
	DiaChi NVARCHAR(255),
	Email NVARCHAR(40)
)
GO
CREATE TABLE YEUCAU_KHO_NCC(
	ID_KT CHAR(7),
	ID_NCC CHAR(7),
	ID_P CHAR(7),
	CONSTRAINT PK_YeuCau_Kho_NCC PRIMARY KEY (ID_KT, ID_NCC, ID_P),
	CONSTRAINT FK_YeuCau_Kho FOREIGN KEY (ID_KT) REFERENCES KHOTONG(ID_KT),
	CONSTRAINT FK_YeuCau_NCC FOREIGN KEY (ID_NCC) REFERENCES NHACUNGCAP(ID_NCC),
	CONSTRAINT FK_YeuCau_Phieu FOREIGN KEY (ID_P) REFERENCES PHIEUNHAPXUAT(ID_P)
)
GO
CREATE TABLE YEUCAU_KHO_ST(
	ID_KT CHAR(7),
	ID_ST CHAR(7),
	ID_P CHAR(7),
	CONSTRAINT PK_YeuCau_Kho_ST PRIMARY KEY (ID_KT, ID_ST, ID_P),
	CONSTRAINT FK_YeuCau_KhoTong FOREIGN KEY (ID_KT) REFERENCES KHOTONG(ID_KT),
	CONSTRAINT FK_YeuCau_ST FOREIGN KEY (ID_ST) REFERENCES SIEUTHI(ID_ST),
	CONSTRAINT FK_YeuCau_PhieuNhapXuat FOREIGN KEY (ID_P) REFERENCES PHIEUNHAPXUAT(ID_P)
)

INSERT INTO SIEUTHI(ID_ST, Ten, ThoiGianMoCua, ThoiGianDongCua, DiaChi)
VALUES
('ST00001',N'Supermarket1', '06:00:00', '22:00:00', N'Hai Bà Trưng'),
('ST00002',N'Supermarket2', '06:00:00', '22:00:00', N'TP Nam Đinh'),
('ST00003',N'Supermarket3', '07:00:00', '22:30:00', N'TP Phủ Lý'),
('ST00004',N'Supermarket4', '06:30:00', '22:00:00', N'TP Hải Phòng'),
('ST00005',N'Supermarket5', '07:00:00', '22:30:00', N'TP Huế'),
('ST00006',N'Supermarket6', '07:00:00', '22:30:00', N'TP Đà Lạt'),
('ST00007',N'Supermarket7', '06:00:00', '22:00:00', N'TP Hồ Chí Minh'),
('ST00008',N'Supermarket8', '06:30:00', '22:00:00', N'TP Đà Nẵng'),
('ST00009',N'Supermarket9', '06:00:00', '22:00:00', N'TP Phan Thiết'),
('ST00010',N'Supermarket10','07:00:00', '22:30:00', N'TP Buôn Mê Thuật');


INSERT INTO NGANHHANG (ID_NH, Ten)
VALUES
('NH00001', N'Thịt hải sản tươi'),
('NH00002', N'Thực phẩm đông lạnh'),
('NH00003', N'Thực phẩm chế biến'),
('NH00004', N'Hóa phẩm tẩy rửa'),
('NH00005', N'Đồ dùng gia đình'),
('NH00006', N'Rau củ trái cây'),
('NH00007', N'Thực phẩm khô');


INSERT INTO ST_CO_NH (ID_ST, ID_NH)
VALUES
('ST00001', 'NH00006'),
('ST00001', 'NH00004'),
('ST00003', 'NH00004'),
('ST00003', 'NH00005'),
('ST00007', 'NH00001'),
('ST00007', 'NH00006'),
('ST00007', 'NH00002'),
('ST00008', 'NH00003'),
('ST00009', 'NH00004'),
('ST00010', 'NH00002'),
('ST00002', 'NH00002'),
('ST00002', 'NH00005'),
('ST00002', 'NH00004'),
('ST00004', 'NH00004'),
('ST00004', 'NH00006'),
('ST00004', 'NH00001'),
('ST00005', 'NH00001'),
('ST00005', 'NH00003'),
('ST00005', 'NH00004'),
('ST00005', 'NH00005'),
('ST00006', 'NH00001'),
('ST00006', 'NH00002'),
('ST00006', 'NH00003'),
('ST00006', 'NH00004'),
('ST00006', 'NH00005'),
('ST00006', 'NH00006'),
('ST00008', 'NH00004'),
('ST00008', 'NH00005'),
('ST00008', 'NH00007'),
('ST00009', 'NH00007'),
('ST00009', 'NH00001'),
('ST00009', 'NH00002'),
('ST00009', 'NH00006');


INSERT INTO BOPHANLAMVIEC(ID_BP, Ten)
VALUES
    ('BP00001', N'Thu Ngân'),
    
    ('BP00002', N'Bảo Vệ'),
    
    ('BP00003', N'Quầy Kệ'),
   
    ('BP00004', N'Kho');


INSERT INTO BPLV_THUOC_ST(ID_BP, ID_ST)
VALUES
    ('BP00001', 'ST00001'),
    ('BP00002', 'ST00001'),
    ('BP00003', 'ST00001'),
    ('BP00004', 'ST00001'),
    ('BP00001', 'ST00002'),
    ('BP00002', 'ST00002'),
    ('BP00003', 'ST00002'),
    ('BP00004', 'ST00002'),
    ('BP00001', 'ST00003'),
    ('BP00002', 'ST00003'),
    ('BP00003', 'ST00003'),
    ('BP00004', 'ST00003'),
    ('BP00001', 'ST00004'),
    ('BP00002', 'ST00004'),
    ('BP00003', 'ST00004'),
    ('BP00004', 'ST00004'),
    ('BP00001', 'ST00005'),
    ('BP00002', 'ST00005'),
    ('BP00003', 'ST00005'),
    ('BP00004', 'ST00005'),
    ('BP00001', 'ST00006'),
    ('BP00002', 'ST00006'),
    ('BP00003', 'ST00006'),
    ('BP00004', 'ST00006'),
    ('BP00001', 'ST00007'),
    ('BP00002', 'ST00007'),
    ('BP00003', 'ST00007'),
    ('BP00004', 'ST00007'),
    ('BP00001', 'ST00008'),
    ('BP00002', 'ST00008'),
    ('BP00003', 'ST00008'),
    ('BP00004', 'ST00008'),
    ('BP00001', 'ST00009'),
    ('BP00002', 'ST00009'),
    ('BP00003', 'ST00009'),
    ('BP00004', 'ST00009'),
    ('BP00001', 'ST00010'),
    ('BP00002', 'ST00010'),
    ('BP00003', 'ST00010'),
    ('BP00004', 'ST00010');


INSERT INTO NHANVIEN(ID_NV, Ho, Ten, Phai, SDT, LuongCB, NgayBDlam, SinhNhat, DiaChi, ChucVu, BHYT, ID_QL, ID_BP)
VALUES
('NV00001', N'Phan Văn',      N'Tú',           1, '0836145868', 5000000, '2021-11-17', '2004-09-30', N'Nam Định',     N'QL', '1234567890', 'NV00001', 'BP00001'),
('NV00002', N'Ngô Việt',      N'Hoàng',        1, '0964235452', 4000000, '2022-04-12', '2004-03-17', N'Hà Nam',       N'NV', '1000000001', 'NV00001', 'BP00001'),
('NV00003', N'Vương Hữu',     N'Lộc',          0, '0256123566', 6000000, '2023-04-03', '2001-05-04', N'Nam Định',     N'NV', '1000000002', 'NV00004', 'BP00001'),
('NV00004', N'Lê Quang',      N'Trường',       1, '0256235215', 3000000, '2020-07-15', '1990-02-02', N'Nghệ An',      N'QL', '1000000003', 'NV00004', 'BP00002'),
('NV00005', N'Trần Minh',     N'Hiệu',         1, '0285462425', 3000000, '2020-04-02', '2000-08-05', N'Thanh Hóa',    N'NV', '1000000004', 'NV00004', 'BP00002'),
('NV00006', N'Phạm Hồng',     N'Kỳ',           0, '0489753215', 4000000, '2022-07-06', '2004-08-05', N'Hà Nội',       N'NV', '1000000005', 'NV00001', 'BP00001'),
('NV00007', N'Phạm Thị',      N'Hoài',         0, '0657894261', 4000000, '2022-11-12', '2004-12-12', N'Hà Nam',       N'NV', '1000000006', 'NV00001', 'BP00001'),
('NV00008', N'Ngô Thanh',     N'Hải',          0, '0256846832', 6000000, '2020-09-03', '2002-06-04', N'Ninh Bình',    N'QL', '1000000007', 'NV00008', 'BP00003'),
('NV00009', N'Nguyễn Công',   N'Thành',        1, '0268953245', 4000000, '2021-03-22', '2003-02-04', N'Hải Dương',    N'NV', '1000000008', 'NV00008', 'BP00003'),
('NV00010', N'Lê Thanh',      N'Nghị',         1, '0564628156', 5000000, '2022-07-06', '2002-06-04', N'Bắc Ninh',     N'QL', '1000000009', 'NV00010', 'BP00004'),
('NV00011', N'Trần Đại',      N'Nghĩa',        1, '0567951628', 4000000, '2023-10-19', '2001-12-15', N'Phú Thọ',      N'NV', '1000000011', 'NV00010', 'BP00004'),
('NV00012', N'Nguyễn Ngọc',   N'Hân',          0, '0549422542', 5000000, '2020-09-06', '2003-12-12', N'Quảng Ninh',   N'QL', '1000000012', 'NV00012', 'BP00001'),
('NV00013', N'Lê Trọng',      N'Đại',          1, '0462326234', 5000000, '2023-09-30', '2004-05-23', N'Thái Bình',    N'NV', '1000000013', 'NV00012', 'BP00001'),
('NV00014', N'Đoàn Như',      N'Tùng',         1, '0978122122', 6000000, '2020-03-31', '1990-12-23', N'Hà Nội',       N'QL', '1000000014', 'NV00014', 'BP00002'),
('NV00015', N'Nguyễn Văn',    N'Hưng',         1, '0546124562', 4000000, '2021-08-21', '2000-01-22', N'Hà Nội',       N'NV', '1000000015', 'NV00014', 'BP00002'),
('NV00016', N'Nguyễn Thanh',  N'Ngọc',         1, '0596764562', 6000000, '2021-08-22', '2000-01-23', N'Nam Định',     N'QL', '1000000016', 'NV00016', 'BP00003'),
('NV00017', N'Lê Hà',         N'Giang',        0, '0464214545', 5000000, '2021-08-23', '2000-01-24', N'Ninh Bình',    N'NV', '1000000017', 'NV00016', 'BP00003'),
('NV00018', N'Trần Tiến',     N'Đạt',          1, '0564985124', 4000000, '2021-08-24', '2000-01-25', N'Quảng Ninh',   N'QL', '1000000018', 'NV00018', 'BP00004'),
('NV00019', N'Nguyễn Xuân',   N'Phúc',         1, '0546239565', 8000000, '2021-08-25', '2000-01-26', N'Huế',          N'NV', '1000000019', 'NV00018', 'BP00004'),
('NV00020', N'Lê Ngọc',       N'Linh',         0, '0212453202', 4000000, '2021-08-26', '2000-01-27', N'Vinh',         N'QL', '1000000020', 'NV00020', 'BP00001'),
('NV00021', N'Bùi Thúy',      N'Vân',          0, '0151254542', 6000000, '2021-08-27', '2000-01-28', N'Hải Phòng',    N'NV', '1000000021', 'NV00020', 'BP00001'),
('NV00022', N'Phan Thanh',    N'Hưng',         1, '0414124554', 4000000, '2021-08-28', '2000-01-29', N'Sơn La',       N'QL', '1000000022', 'NV00022', 'BP00002'),
('NV00023', N'Nguyễn Ngọc',   N'Tú',           1, '0415462125', 5000000, '2021-08-29', '2000-01-30', N'Hòa Bình',     N'NV', '1000000023', 'NV00022', 'BP00002'),
('NV00024', N'Nguyễn Quang',  N'Thắng',        1, '0623488545', 7000000, '2021-08-30', '2000-01-31', N'Hà Nam',       N'QL', '1000000024', 'NV00024', 'BP00003'),
('NV00025', N'Doãn Chí',      N'Kiên',         1, '0567898456', 6000000, '2021-08-31', '2000-02-01', N'Hà Nội',       N'NV', '1000000025', 'NV00024', 'BP00003'),
('NV00026', N'Đặng Hồng',     N'Nhung',        0, '0465224548', 5000000, '2021-09-01', '2000-02-02', N'Thanh Hóa',    N'QL', '1000000026', 'NV00026', 'BP00004'),
('NV00027', N'Nguyễn Minh',   N'Nguyệt',       0, '0152454584', 6000000, '2021-09-02', '2000-02-03', N'Thái Bình',    N'NV', '1000000027', 'NV00026', 'BP00004'),
('NV00028', N'Trần Bảo',      N'An',           0, '0457892411', 6000000, '2021-09-03', '2000-02-04', N'Hà Giang',     N'QL', '1000000028', 'NV00028', 'BP00001'),
('NV00029', N'Vũ Quang',      N'Tuyền',        1, '0548792342', 4000000, '2021-09-04', '2000-02-05', N'Bắc Ninh',     N'NV', '1000000029', 'NV00028', 'BP00001'),
('NV00030', N'Nguyễn Đức',    N'Nguyên',       1, '0372660785', 3000000, '2021-09-05', '2000-02-06', N'Bắc Ninh',     N'QL', '1000000030', 'NV00030', 'BP00002'),
('NV00031', N'Bùi Thanh',     N'Thanh',        0, '0866145535', 5000000, '2021-09-06', '2000-02-07', N'Bắc Giang',    N'NV', '1000000031', 'NV00030', 'BP00002'),
('NV00032', N'Trần Hương',    N'Diệu',         0, '0752345152', 4000000, '2021-09-07', '2000-02-08', N'Hải Dương',    N'QL', '1000000032', 'NV00032', 'BP00003'),
('NV00033', N'Phùng Quang',   N'Định',         1, '0477953165', 6000000, '2021-09-08', '2000-02-09', N'Ninh Bình',    N'NV', '1000000033', 'NV00032', 'BP00003'),
('NV00034', N'Nguyễn Bá',     N'Luân',         1, '0781246452', 8000000, '2021-09-09', '2000-02-10', N'Nam Định',     N'QL', '1000000034', 'NV00034', 'BP00004'),
('NV00035', N'Tống Doanh',    N'Chính',        1, '0455682122', 7000000, '2021-09-10', '2000-02-11', N'Bình Dương',   N'NV', '1000000035', 'NV00034', 'BP00004');


INSERT INTO CONCAI(ID_NV, HoTen, SinhNhat, Phai)
VALUES 
    ('NV00001', N'Phan Ngọc Kiều Linh', '2022-09-01', 0),
    ('NV00003', N'Vương Nhất Bắc',      '2023-03-08', 1),
    ('NV00004', N'Lê Thùy Dương',       '2022-06-05', 0),
    ('NV00035', N'Tống Thành Công',     '2021-06-13', 1),
    ('NV00032', N'Lương Anh Huy',       '2022-02-23', 1),
    ('NV00030', N'Nguyễn Bích Ngọc',    '2021-11-29', 0);



INSERT INTO CTDT (ID_CTDT, ThoiGian)
VALUES
    ('CT00001',  N'1 NĂM'),
    ('CT00002',  N'3 NĂM'),
    ('CT00003',  N'5 NĂM');


INSERT INTO THAMGIA(ID_NV, ID_CTDT)
VALUES
    ('NV00035', 'CT00001'),
    ('NV00002', 'CT00001'),
    ('NV00009', 'CT00002'),
    ('NV00011', 'CT00002'),
    ('NV00025', 'CT00003'),
    ('NV00019', 'CT00003'),
    ('NV00031', 'CT00003');


INSERT INTO CALAM (Ten, ThoiGian)
VALUES
    ('C1', '6:00:00'),
    ('C2', '6:00:00'),
    ('C3', '6:00:00');


INSERT INTO DONGCHAMCONG(ID_DCC,Ngay, TimeBD, TimeKT, TenCa, ID_NV)
VALUES
    ('DCC0001','2023-12-01', '06:00:00', '12:00:00', 'C1', 'NV00001'),
    ('DCC0002','2023-12-01', '12:00:00', '18:00:00', 'C2', 'NV00002'),
    ('DCC0003','2023-12-02', '06:00:00', '12:00:00', 'C1', 'NV00003'),
    ('DCC0004','2023-12-05', '18:00:00', '22:00:00', 'C3', 'NV00004'),
    ('DCC0005','2023-12-05', '06:00:00', '12:00:00', 'C1', 'NV00005'),
    ('DCC0006','2023-12-06', '06:00:00', '12:00:00', 'C1', 'NV00006'),
    ('DCC0007','2023-12-07', '12:00:00', '18:00:00', 'C2', 'NV00007'),
    ('DCC0008','2023-12-08', '06:00:00', '12:00:00', 'C1', 'NV00008'),
    ('DCC0009','2023-12-09', '18:00:00', '22:00:00', 'C3', 'NV00009'),
    ('DCC0010','2023-12-10', '06:00:00', '12:00:00', 'C1', 'NV00010'),
    ('DCC0011','2023-12-11', '12:00:00', '18:00:00', 'C2', 'NV00011'),
    ('DCC0012','2023-12-12', '06:00:00', '12:00:00', 'C1', 'NV00012'),
    ('DCC0013','2023-12-13', '12:00:00', '18:00:00', 'C2', 'NV00013'),
    ('DCC0014','2023-12-14', '06:00:00', '12:00:00', 'C1', 'NV00014'),
    ('DCC0015','2023-12-15', '06:00:00', '12:00:00', 'C1', 'NV00015'),
    ('DCC0016','2023-12-16', '12:00:00', '18:00:00', 'C2', 'NV00016'),
    ('DCC0017','2023-12-17', '06:00:00', '12:00:00', 'C1', 'NV00017'),
    ('DCC0018','2023-12-18', '18:00:00', '22:00:00', 'C3', 'NV00018'),
    ('DCC0019','2023-12-19', '06:00:00', '12:00:00', 'C1', 'NV00019'),
    ('DCC0020','2023-12-20', '12:00:00', '18:00:00', 'C2', 'NV00020'),
    ('DCC0021','2023-12-21', '06:00:00', '12:00:00', 'C1', 'NV00021'),
    ('DCC0022','2023-12-22', '12:00:00', '18:00:00', 'C2', 'NV00022'),
    ('DCC0023','2023-12-23', '06:00:00', '12:00:00', 'C1', 'NV00023'),
    ('DCC0024','2023-12-24', '06:00:00', '12:00:00', 'C1', 'NV00024'),
    ('DCC0025','2023-12-25', '12:00:00', '18:00:00', 'C2', 'NV00025'),
    ('DCC0026','2023-12-26', '06:00:00', '12:00:00', 'C1', 'NV00026'),
    ('DCC0027','2023-12-27', '18:00:00', '22:00:00', 'C3', 'NV00027'),
    ('DCC0028','2023-12-28', '06:00:00', '12:00:00', 'C1', 'NV00028'),
    ('DCC0029','2023-12-29', '12:00:00', '18:00:00', 'C2', 'NV00029'),
    ('DCC0030','2023-12-30', '06:00:00', '12:00:00', 'C1', 'NV00030'),
    ('DCC0031','2023-12-31', '12:00:00', '18:00:00', 'C2', 'NV00031'),
    ('DCC0032','2023-12-01', '06:00:00', '12:00:00', 'C1', 'NV00032'),
    ('DCC0033','2023-12-02', '12:00:00', '18:00:00', 'C2', 'NV00033'),
    ('DCC0034','2023-12-03', '06:00:00', '12:00:00', 'C1', 'NV00034'),
    ('DCC0035','2023-12-04', '12:00:00', '18:00:00', 'C2', 'NV00035');


INSERT INTO SANPHAM(ID_SP, Ten, DonViTinh, Gia, GiamGia, HSD, ID_NH)
VALUES
('SP00001', N'Meatdeli thịt xay tươi ướp sẵn',           N'kg', 75000, 28 , '2025-05-19', 'NH00001'),
('SP00002', N'Meatdeli sụn heo cắt lát',                 N'kg', 95000, 28 , '2024-06-12', 'NH00001'),
('SP00003', N'3F gà ướp xốt Hồng Kông đông lạnh',        N'khay', 165000, 24, '2023-11-29', 'NH00001'),
('SP00004', N'Meatdeli thịt lạc vai heo',                N'kg', 60000, 20, '2024-05-22', 'NH00001'),
('SP00005', N'Đặc sản lòng heo',                         N'kg', 120000, 20 , '2024-08-26', 'NH00001'),
('SP00006', N'Tôm sú',                                   N'kg', 600000, 15 , '2024-02-24', 'NH00001'),
('SP00007', N'Mực ống câu tươi Phú Quốc',                N'kg', 480000, 15 , '2024-10-08', 'NH00001'),
('SP00008', N'Cam ruột vàng úc',                         N'kg', 70000, 25, '2024-11-12', 'NH00006'),
('SP00009', N'Dưa lưới sạch Đế Vương Kinh',              N'quả', 100000, 20, '2024-02-18', 'NH00006'),
('SP00010', N'Cải thảo Wineco',                          N'kg', 20000, 20, '2023-11-26', 'NH00006'),
('SP00011', N'Súp lơ trắng WinEco',                      N'kg', 50000, 2, '2024-09-16', 'NH00006'),
('SP00012', N'Bí xanh WinEco',                           N'kg', 22000, 10, '2024-07-17', 'NH00006'),
('SP00013', N'Giá đỗ WinEco',                            N'gói', 9000, 20, '2023-12-07', 'NH00006'),
('SP00014', N'Nước giặt xả Golden King hương ngàn hoa',  N'can', 180000,40,'2024-05-23','NH00004'), 
('SP00015', N'Nước rủa chén Power',                      N'chai', 95000, 38, '2024-01-26', 'NH00004'),
('SP00016', N'Nước giặt LIX đậm đặc',                    N'chai', 195000, 35, '2024-04-08', 'NH00004'),
('SP00017', N'Nước lau sàn Power',                       N'can', 95000, 34, '2024-09-05', 'NH00004'),
('SP00018', N'Bột giặt hương hoa hồng WinMart Home',     N'gói', 30000, 34, '2024-07-17', 'NH00004'),
('SP00019', N'Xịt vải đam mê Downy',                     N'chai', 90000, 30, '2024-10-21', 'NH00004'),
('SP00020', N'Xúc xích Hanns xông khói tự nhiên',        N'gói', 70000, 30, '2024-03-11', 'NH00003'),
('SP00021', N'Bánh bao kim xa Kitkool',                  N'gói', 34000, 26, '2024-04-07', 'NH00003'),
('SP00022', N'Sanwhich khoai tây gạo lứt Momiji',        N'gói', 27000, 20, '2024-03-28', 'NH00003'),
('SP00023', N'Bánh tráng mắm ruốc',                      N'gói', 27000, 20, '2024-07-19', 'NH00003'),
('SP00024', N'Khô bò miếng Kiến Lĩnh vị Tứ Xuyên',       N'gói', 170000, 17, '2023-11-19', 'NH00003'),
('SP00025', N'Tôm viên kiKool',                          N'gói', 36000, 27, '2024-05-29', 'NH00003'),
('SP00026', N'Bò viên Kikool',                           N'gói', 110000, 21, '2024-09-12', 'NH00002'),
('SP00027', N'Ngự bảo giò lụa lá chuối',                 N'gói', 62000, 20,'2024-05-18' , 'NH00002'),
('SP00028', N'Chả bì que Ngự Bảo ớt xiêm xanh',          N'gói', 13000, 2, '2024-06-08', 'NH00002'),
('SP00029', N'Chả tôm gói Long Nhi',                     N'gói', 78000, 9, '2024-03-21', 'NH00002'),
('SP00030', N'Hàu sữa ruột tách vỏ',                     N'gói', 70000, 16, '2024-01-20', 'NH00002'),
('SP00031', N'Bộ cây lau nhà xoay tay',                  N'bộ', 868000, 31, '2024-05-10', 'NH00005'),
('SP00032', N'Bình nước nhựa Lock & Lock Pet',           N'cái', 65000, 22, '2024-01-11', 'NH00005'),
('SP00033', N'Chảo rán Lock & Lock',                     N'cái', 813000, 5, '2024-07-13', 'NH00005'),
('SP00034', N'Bình gữi nhiệt carlmann inox',             N'cái', 198000, 50, '2024-01-07', 'NH00005'),
('SP00035', N'Dụng củ băm nhỏ thực phẩm mini',           N'cái', 136000, 49, '2024-09-16', 'NH00005'),
('SP00036', N'Dao chặt Ecofamily Sunhouse',              N'cái', 403000, 46, '2024-02-26', 'NH00005'),
('SP00037', N'Thịt gà hộp Decham',						 N'hộp', 92000, 33, '2024-07-22', 'NH00007'),
('SP00038', N'Ngũ cốc ăn sáng Milo',                     N'gói', 92000, 23, '2024-03-10', 'NH00007'),
('SP00039', N'Pate gan hộp Halong Canfoco',              N'hộp', 33000, 20, '2024-03-19', 'NH00007'),
('SP00040', N'Bột mì đa dụng Meizan',                    N'gói', 30000, 17, '2024-05-04', 'NH00007'),
('SP00041', N'Ngũ cốc dinh dưỡng Froot Loops kellogg',   N'hộp', 71000, 12, '2024-01-26', 'NH00007');


INSERT INTO VOUCHER (ID_VC, GiaTri)
VALUES
    ('VC00001', '10000'),
    ('VC00002', '20000'),
    ('VC00003', '50000'),
    ('VC00004', '100000');


INSERT INTO KHACHHANG(ID_KH, Ho, Ten, Phai, SDT, Email, DiaChi, DiemTL)
VALUES
    ('KH00001', N'Nguyễn Văn',  N'Nam',   1, '0987654321', N'nguyenvan@gmail.com',  N'Hà Nội',    1000),
    ('KH00002', N'Trần Thị',    N'Ly',    0, '0987654322', N'tranthi@gmail.com',    N'Hà Nội',    2000),
    ('KH00003', N'Lê Anh',      N'Huy',   1, '0987655321', N'leanh@yahoo.com',      N'Hà Nội',    500),
    ('KH00004', N'Phạm Thùy',   N'Linh',  0, '0987657321', N'phamthuy@hotmail.com', N'Ninh Bình', 850),
    ('KH00005', N'Hoàng Minh',  N'Khánh', 1, '0987654325', N'hoangminh@gmail.com',  N'Hà Nội',    600),
    ('KH00006', N'Đặng Ngọc',   N'Linh',  0, '0987654329', N'dangngoc@yahoo.com',   N'Nam Định',  900),
    ('KH00007', N'Bùi Quốc',    N'Việt',  1, '0987654320', N'buiquoc@hotmail.com',  N'Hà Nam',    1200);


INSERT INTO MUA (ID_KH, ID_SP)
VALUES
    ('KH00001', 'SP00001'),    
	('KH00001', 'SP00002'),
    ('KH00002', 'SP00002'),
    ('KH00002', 'SP00012'),
    ('KH00002', 'SP00015'),
    ('KH00002', 'SP00020'),
    ('KH00002', 'SP00032'),
    ('KH00003', 'SP00003'),
	('KH00003', 'SP00004'),
	('KH00003', 'SP00005'),
    ('KH00004', 'SP00004'),
    ('KH00004', 'SP00016'),
    ('KH00004', 'SP00010'),
    ('KH00004', 'SP00011'),
    ('KH00005', 'SP00005'),
	('KH00005', 'SP00009');


INSERT INTO DOI(ID_KH, ID_VC, SoLuong, NgayDoi)
VALUES
    ('KH00001', 'VC00001', 1, '2023-02-12'),
	('KH00002', 'VC00002', 1, '2023-08-10'),
	('KH00003', 'VC00002', 1, '2023-01-11'),
	('KH00005', 'VC00003', 1, '2023-04-15');


INSERT INTO HOADON (ID_HD, PTTT, ThoiGianIn, TienNhan, ID_ST, ID_NV, ID_VC, ID_KH)
VALUES
    ('HD00001', N'TM', '2023-12-02 11:15:00', 347000,   'ST00001', 'NV00001', 'VC00001', 'KH00001'),
    ('HD00002', N'CK', '2023-12-02 09:02:00', 500000,   'ST00002', 'NV00002', 'VC00002', 'KH00002'),
    ('HD00003', N'CK', '2023-12-02 15:09:45', 80000,    'ST00004', 'NV00035', 'VC00002', 'KH00003'),
    ('HD00004', N'TM', '2023-12-02 12:00:00', 500000,   'ST00003', 'NV00009',  NULL,     'KH00004'),
    ('HD00005', N'TM', '2023-12-02 21:35:00', 800000,   'ST00001', 'NV00015', 'VC00003', 'KH00005');


INSERT INTO SP_TRONG_HD(ID_HD, ID_SP, SoLuong)
VALUES
    ('HD00001', 'SP00001', 1),
	('HD00001', 'SP00002', 1),
    ('HD00002', 'SP00002', 2),
    ('HD00002', 'SP00012', 1),
    ('HD00002', 'SP00015', 1),
    ('HD00002', 'SP00020', 1),
    ('HD00002', 'SP00032', 1),
    ('HD00003', 'SP00003', 1),
	('HD00003', 'SP00004', 1),
    ('HD00003', 'SP00005', 1),
    ('HD00004', 'SP00004', 1),
    ('HD00004', 'SP00016', 1),
    ('HD00004', 'SP00010', 1),
    ('HD00004', 'SP00011', 1),
    ('HD00005', 'SP00005', 3),
	('HD00005', 'SP00009', 3);


INSERT INTO KHOTONG (ID_KT, Ten, SucChua, DiaChi)
VALUES 
  ('KT00001', N'Bắc'  , 1000, N'Hà Nội'),
  ('KT00002', N'Trung', 1000, N'Đà Nẵng'),
  ('KT00003', N'Nam'  , 1000, N'Hồ Chí Minh');


INSERT INTO PHIEUNHAPXUAT (ID_P, ThoiGian,ID_NV)
VALUES 
  ('PNX0001', '2023-09-11 08:00:00','NV00003'),
  ('PNX0002', '2023-10-11 09:00:00','NV00012'),
  ('PNX0003', '2023-11-11 10:00:00','NV00003'),
  ('PNX0004', '2023-02-11 11:00:00','NV00003'),
  ('PNX0005', '2023-04-11 12:00:00','NV00003'),
  ('PNX0006', '2023-03-12 13:00:00','NV00003'),
  ('PNX0007', '2023-09-12 08:05:00','NV00012'),
  ('PNX0008', '2023-09-12 08:20:00','NV00012'),
  ('PNX0009', '2023-09-12 08:45:00','NV00012'),
  ('PNX0010', '2023-12-12 11:30:00','NV00012');


INSERT INTO THONGTIN (ID_P, ID_SP, SoLuong, TinhTrang)
VALUES 
  ('PNX0001', 'SP00001', 2,  N'Đã Nhận'),
  ('PNX0001', 'SP00002', 1,  N'Chưa Nhận'),
  ('PNX0001', 'SP00003', 4,  N'Chưa Nhận'),
  ('PNX0001', 'SP00005', 1,  N'Đã Nhận'),
  ('PNX0001', 'SP00006', 5,  N'Đã Nhận'),
  ('PNX0002', 'SP00002', 3,  N'CHưa Nhận'),
  ('PNX0002', 'SP00003', 3,  N'Đã Nhận'),
  ('PNX0002', 'SP00005', 1,  N'Đã Nhận'),
  ('PNX0002', 'SP00007', 1,  N'Chưa Nhận'),
  ('PNX0002', 'SP00009', 6,  N'Đã Nhận'),
  ('PNX0003', 'SP00010', 9,  N'Đã Nhận'),
  ('PNX0003', 'SP00012', 5,  N'Đã Nhận'),
  ('PNX0003', 'SP00017', 1,  N'Chưa Nhận'),
  ('PNX0003', 'SP00020', 4,  N'Chưa Nhận'),
  ('PNX0003', 'SP00011', 9,  N'Chưa Nhận'),
  ('PNX0004', 'SP00004', 15, N'Đã Nhận'),
  ('PNX0004', 'SP00012', 5,  N'Đã Nhận'),
  ('PNX0004', 'SP00017', 10, N'Chưa Nhận'),
  ('PNX0004', 'SP00020', 4,  N'Chưa Nhận'),
  ('PNX0004', 'SP00011', 9,  N'Chưa Nhận'),
  ('PNX0005', 'SP00005', 12, N'Đã Nhận'),
  ('PNX0005', 'SP00012', 5,  N'Đã Nhận'),
  ('PNX0005', 'SP00014', 8,  N'Chưa Nhận'),
  ('PNX0005', 'SP00009', 4,  N'Chưa Nhận'),
  ('PNX0005', 'SP00013', 9,  N'Chưa Nhận'),
  ('PNX0006', 'SP00026', 8,  N'Đã Nhận'),
  ('PNX0006', 'SP00012', 3,  N'Đã Nhận'),
  ('PNX0006', 'SP00009', 5,  N'Chưa Nhận'),
  ('PNX0006', 'SP00010', 4,  N'Chưa Nhận'),
  ('PNX0006', 'SP00001', 7,  N'Chưa Nhận'),
  ('PNX0007', 'SP00006', 2,  N'Đã Nhận'),
  ('PNX0007', 'SP00002', 5,  N'Đã Nhận'),
  ('PNX0007', 'SP00007', 1,  N'Chưa Nhận'),
  ('PNX0007', 'SP00010', 4,  N'Chưa Nhận'),
  ('PNX0007', 'SP00021', 9,  N'Chưa Nhận'),
  ('PNX0008', 'SP00016', 3,  N'Đã Nhận'),
  ('PNX0008', 'SP00017', 5,  N'Đã Nhận'),
  ('PNX0008', 'SP00007', 10, N'Chưa Nhận'),
  ('PNX0008', 'SP00022', 8,  N'Đã Nhận'),
  ('PNX0008', 'SP00018', 3,  N'Chưa Nhận'),
  ('PNX0009', 'SP00016', 8,  N'Đã Nhận'),
  ('PNX0009', 'SP00022', 6,  N'Đã Nhận'),
  ('PNX0009', 'SP00027', 4,  N'Chưa Nhận'),
  ('PNX0009', 'SP00029', 4,  N'Chưa Nhận'),
  ('PNX0009', 'SP00021', 6,  N'Chưa Nhận'),
  ('PNX0010', 'SP00026', 7,  N'Đã Nhận'),
  ('PNX0010', 'SP00015', 5,  N'Đã Nhận'),
  ('PNX0010', 'SP00007', 3,  N'Chưa Nhận'),
  ('PNX0010', 'SP00023', 8,  N'Đã Nhận'),
  ('PNX0010', 'SP00022', 8,  N'Chưa Nhận');



INSERT INTO NHACUNGCAP(ID_NCC, Ten, SDT, DiaChi, Email)
VALUES
('NCC0001', N'Nhà cung cấp 1',  '0779335789', N'Hà Nội',       N'ncc1@gmail.com'),
('NCC0002', N'Nhà cung cấp 2',  '0227461947', N'Thanh Hoá',    N'ncc2@gmail.com'),
('NCC0003', N'Nhà cung cấp 3',  '0150000002', N'Bình Dương',   N'ncc3@gmail.com'),
('NCC0004', N'Nhà cung cấp 4',  '0243656589', N'Nam Định',     N'ncc4@gmail.com'),
('NCC0005', N'Nhà cung cấp 5',  '0345125500', N'Hà Nam',       N'ncc5@gmali.com'),
('NCC0006', N'Nhà cung cấp 6',  '0467685665', N'Hải Phòng',    N'ncc6@gmail.com'),
('NCC0007', N'Nhà cung cấp 7',  '0178675464', N'Nhệ An',       N'ncc7@gmail.com'),
('NCC0008', N'Nhà cung cấp 8',  '0122445545', N'Hà Tĩnh',      N'ncc8@gmail.com'),
('NCC0009', N'Nhà cung cấp 9',  '0446765330', N'Đà Nẵng',      N'ncc9@gmail.com'),
('NCC0010', N'Nhà cung cấp 10', '0566796641', N'Cần Thơ',      N'ncc10@gmail.com');

INSERT INTO YEUCAU_KHO_NCC (ID_KT, ID_NCC, ID_P)
VALUES 
    ('KT00001', 'NCC0001', 'PNX0001'),
    ('KT00002', 'NCC0002', 'PNX0002'),
    ('KT00003', 'NCC0003', 'PNX0003'),
    ('KT00001', 'NCC0004', 'PNX0004'),
    ('KT00001', 'NCC0005', 'PNX0005');

  
INSERT INTO YEUCAU_KHO_ST (ID_KT, ID_ST, ID_P)
VALUES 
  ('KT00001', 'ST00001', 'PNX0001'),
  ('KT00003', 'ST00002', 'PNX0002'),
  ('KT00001', 'ST00003', 'PNX0003'),
  ('KT00002', 'ST00004', 'PNX0004'),
  ('KT00002', 'ST00005', 'PNX0005');

--1. Liệt kê tất cả các thông tin của những mặt hàng có giá từ 100000 đến 200000
SELECT * FROM SANPHAM
WHERE SANPHAM.Gia >= 100000 AND SANPHAM.Gia <= 200000

--2. Danh sách các mặt hàng thuộc ngành hàng ‘NH00001’, thông tin gồm: mã hàng hoá, tên hàng hoá, mã ngành hàng, tên ngành hàng
SELECT SANPHAM.ID_SP, SANPHAM.Ten, NGANHHANG.Ten AS SANPHAM_NGANHHANG
FROM SANPHAM
INNER JOIN NGANHHANG ON SANPHAM.ID_NH = NGANHHANG.ID_NH
WHERE SANPHAM.ID_NH = 'NH00001'
GROUP BY SANPHAM.ID_SP, SANPHAM.Ten, NGANHHANG.Ten;

--3. Danh sách những mặt hàng có HSD còn trên 1 tháng (30 ngày) , thông tin gồm: mã hàng hoá, tên hàng hoá, HSD( ngày)
SELECT ID_SP, Ten, DATEDIFF(day, GETDATE(), HSD) AS RemainingDays
FROM SANPHAM
WHERE DATEDIFF(day, GETDATE(), HSD) > 30;

--4. Liệt kê danh sách hàng hóa được cung cấp bởi những nhà cung cấp nào, thông tin gồm: mã hàng hóa, tên hàng hóa, tên ngành hàng, mã nhà cung cấp, tên nhà cung cấp
SELECT SANPHAM.ID_SP, SANPHAM.Ten, NGANHHANG.Ten, NHACUNGCAP.ID_NCC, NHACUNGCAP.Ten
FROM YEUCAU_KHO_NCC
JOIN PHIEUNHAPXUAT ON YEUCAU_KHO_NCC.ID_P = PHIEUNHAPXUAT.ID_P
JOIN THONGTIN ON THONGTIN.ID_P = PHIEUNHAPXUAT.ID_P
JOIN SANPHAM ON THONGTIN.ID_SP = SANPHAM.ID_SP
JOIN NGANHHANG ON NGANHHANG.ID_NH = SANPHAM.ID_NH
JOIN NHACUNGCAP ON YEUCAU_KHO_NCC.ID_NCC = NHACUNGCAP.ID_NCC
GROUP BY SANPHAM.ID_SP, SANPHAM.Ten, NGANHHANG.Ten, NHACUNGCAP.ID_NCC, NHACUNGCAP.Ten

--5. Liệt kê những sản phẩm có từ ‘Meatdeli’ trong tên sản phẩm
SELECT *
FROM SANPHAM
WHERE Ten LIKE '%Meatdeli%'

--6. Danh sách các mặt hàng trên 50.000 sau khi đã giảm giá, thông tin gồm: mã hàng hoá, tên hàng hoá, giá đã giảm
SELECT ID_SP,Ten, Gia*(100-GiamGia)/100 AS GIADAGIAM
FROM SANPHAM
WHERE Gia*(100-GiamGia)/100 > 50000

--7. Mã hoá đơn HD00001 gồm những mặt hàng nào, thông tin gồm:ID_KH,tên hàng hoá, số lượng
SELECT SANPHAM.ID_SP,SANPHAM.Ten,SP_TRONG_HD.SoLuong 
FROM SP_TRONG_HD
JOIN HOADON ON HOADON.ID_HD = SP_TRONG_HD.ID_HD
JOIN SANPHAM ON SP_TRONG_HD.ID_SP = SANPHAM.ID_SP
WHERE HOADON.ID_HD = 'HD00001'

--8. Tổng số hoá đơn của khách hàng tên Nam trong năm 2023,thông tin gồm: họ tên khách hàng, tổng số hoá đơn
SELECT KHACHHANG.Ho+' '+KHACHHANG.Ten AS HoTen,COUNT(HOADON.ID_KH) AS SoHD
FROM KHACHHANG 
JOIN HOADON ON KHACHHANG.ID_KH = HOADON.ID_KH
WHERE (ThoiGianIn BETWEEN '2023-1-1' AND '2023-12-31') AND (KHACHHANG.Ten LIKE '%Nam%')
GROUP BY HOADON.ID_KH,KHACHHANG.Ho,KHACHHANG.Ten

--9. Nhân viên NV00001 đã in hoá đơn cho những khách hàng nào, thông tin gồm: mã khách hàng, họ tên khách hàng
SELECT KHACHHANG.ID_KH,Ho+' '+Ten AS HoTen
FROM KHACHHANG 
JOIN HOADON ON KHACHHANG.ID_KH=HOADON.ID_KH
WHERE ID_NV='NV00001'

--10. Địa chỉ của siêu thị đã in ra hoá đơn HD00001
SELECT DiaChi
FROM SIEUTHI
WHERE ID_ST= (SELECT ID_ST FROM HOADON WHERE ID_HD='HD00001')

--11. Tổng cộng số tiền thanh toán của hoá đơn HD00005
SELECT SUM(SP_TRONG_HD.SoLuong*(SANPHAM.Gia*(100-SANPHAM.GiamGia)/100))-ISNULL(VOUCHER.GiaTri,0)
FROM SP_TRONG_HD
JOIN (HOADON JOIN VOUCHER ON HOADON.ID_VC=VOUCHER.ID_VC) ON SP_TRONG_HD.ID_HD=HOADON.ID_HD
JOIN SANPHAM ON SP_TRONG_HD.ID_SP=SANPHAM.ID_SP
WHERE SP_TRONG_HD.ID_HD='HD00005'
GROUP BY VOUCHER.GiaTri

--12. Khách hàng KH00003 dùng phương thức thanh toán nào nhiều nhất( Nếu số lần bằng nhau thì in ra cả 2)
SELECT PTTT
FROM HOADON
WHERE ID_KH = 'KH00003' 
GROUP BY PTTT
HAVING COUNT(PTTT) = (SELECT MAX(SoLan) 
					  FROM (SELECT COUNT(PTTT) as SoLan 
							FROM HOADON 
							WHERE ID_KH = 'KH00003' 
							GROUP BY PTTT) AS THANHTOAN)
--13. Những khách hàng nào đã từng mua có mã siêu thị cùng với khách hàng tên Nam , thông tin gồm: mã khách hàng, họ tên khách hàng
SELECT KHACHHANG.ID_KH,KHACHHANG.Ho+' '+KHACHHANG.Ten AS HoTen
FROM KHACHHANG
INNER JOIN HOADON ON KHACHHANG.ID_KH=HOADON.ID_KH
WHERE ID_ST= (SELECT HOADON.ID_ST
			  FROM KHACHHANG
			  INNER JOIN HOADON ON KHACHHANG.ID_KH=HOADON.ID_KH
			  WHERE KHACHHANG.Ten LIKE '%Nam%')
AND KHACHHANG.Ten NOT LIKE N'%Nam%'

--14. Liệt kê những khách hàng đổi voucher 50k, thông tin gồm:  mã khách hàng, họ tên khách hàng
SELECT KHACHHANG.ID_KH,KHACHHANG.Ho+' '+KHACHHANG.Ten AS HoTen
FROM KHACHHANG
JOIN (DOI JOIN VOUCHER ON DOI.ID_VC=VOUCHER.ID_VC) ON KHACHHANG.ID_KH=DOI.ID_KH
WHERE VOUCHER.GiaTri=50000

--15. Liệt kê những siêu thị mở từ 7h, thông tin gồm: mã siêu thị, tên siêu thị
SELECT ID_ST,Ten
FROM SIEUTHI
WHERE ThoiGianMoCua>='7:00:00'

--16. Siêu thị ST00004 mở cửa bao nhiêu tiếng
SELECT Ten,
(DATEDIFF(SECOND, ThoiGianMoCua, ThoiGianDongCua) / 3600) AS HOURS,
(DATEDIFF(SECOND, ThoiGianMoCua, ThoiGianDongCua) % 3600) / 60 AS MINUTES,
(DATEDIFF(SECOND, ThoiGianMoCua, ThoiGianDongCua) % 60) AS SECONDS
FROM SIEUTHI
WHERE ID_ST='ST00004'

--17. Tổng số khách hàng nam và tổng số khách hàng nữ, thông tin gồm: tổng nam, tổng nữ
SELECT SUM(CASE WHEN Phai=1 THEN 1 ELSE 0 END) AS TNam,
	   SUM(CASE WHEN Phai=0 THEN 1 ELSE 0 END) AS TNu
FROM KHACHHANG

--18. Danh sách những khách hàng có điểm tích luỹ từ 1000 trở lên, thông tin gồm: mã khách hàng, tên khách hàng
SELECT ID_KH,Ho+' '+Ten AS HoTen
FROM KHACHHANG
WHERE DiemTL>=1000

--19. Liệt kê những địa điểm có từ trên 2 khách hàng đang sinh sống
SELECT DiaChi
FROM KHACHHANG
GROUP BY DiaChi
HAVING COUNT(DiaChi)>=2

--20. Danh sách tất cả các thông tin nhân viên trên 20 tuổi, thông tin gồm: ID_NV, họ tên, số tuổi
SELECT ID_NV, Ho+' '+Ten AS HoTen,YEAR(GETDATE()) - YEAR(SinhNhat) AS SoTuoi
FROM NHANVIEN
WHERE YEAR(GETDATE()) - YEAR(SinhNhat) > 20

--21. Liệt kê những nhân viên có con cái, thông tin gồm: mã nhân viên, họ tên nhân viên
SELECT NHANVIEN.ID_NV,Ho+' '+Ten AS HoTen
FROM NHANVIEN JOIN CONCAI ON NHANVIEN.ID_NV=CONCAI.ID_NV

--22. Liệt kê những nhân viên nam có con gái trên 1 tuổi, thông tin gồm: mã nhân viên, họ tên nhân viên, họ tên con cái, sinh nhật con cái
SELECT NHANVIEN.ID_NV, Ho+' '+Ten AS HoTenNV, CONCAI.HoTen AS HoTenCC, CONCAI.SinhNhat
FROM NHANVIEN
JOIN CONCAI ON NHANVIEN.ID_NV = CONCAI.ID_NV
WHERE (NHANVIEN.Phai=1) AND (CONCAI.Phai=0) AND (YEAR(GETDATE())-YEAR(CONCAI.SinhNhat)>1)

--23. Tổng số nhân viên của mỗi bộ phận làm việc, thông tin gồm: mã bộ phân, tên bộ phận, tổng nhân viên
SELECT BOPHANLAMVIEC.ID_BP, BOPHANLAMVIEC.Ten, COUNT(ID_NV) AS TongNV
FROM BOPHANLAMVIEC
JOIN NHANVIEN ON BOPHANLAMVIEC.ID_BP=NHANVIEN.ID_BP
GROUP BY BOPHANLAMVIEC.ID_BP,BOPHANLAMVIEC.Ten

--24. Mỗi ca làm có bao nhiêu nhân viên làm việc
SELECT TenCa, COUNT(ID_NV) AS SoNV
FROM DONGCHAMCONG
GROUP BY TenCa

--25. Liệt kê những nhân viên không phải tham gia chương trình đào tạo , thông tin gồm: mã nhân viên, họ tên nhân viên
SELECT NHANVIEN.ID_NV,Ho+' '+Ten AS HoTen
FROM NHANVIEN
LEFT JOIN THAMGIA ON NHANVIEN.ID_NV = THAMGIA.ID_NV
WHERE ID_CTDT IS NULL

--26. Liệt kê những mặt hàng đã được yêu cầu giữa nhà cung cấp và siêu thị ngày 2023-12-12, thông tin gồm: mã hàng hóa, tên hàng hoá, số lượng
SELECT SANPHAM.ID_SP,SANPHAM.Ten,SoLuong
FROM PHIEUNHAPXUAT
JOIN THONGTIN ON PHIEUNHAPXUAT.ID_P=THONGTIN.ID_P
JOIN SANPHAM ON THONGTIN.ID_SP=SANPHAM.ID_SP
WHERE DATEPART(YEAR,PHIEUNHAPXUAT.ThoiGian) = '2023' 
AND DATEPART(MONTH,PHIEUNHAPXUAT.ThoiGian) = '12'
AND DATEPART(DAY,PHIEUNHAPXUAT.ThoiGian) = '12'

--27. Kho KT00001 được cung cấp bởi những nhà cung cấp nào,thông tin gồm: ID_NCC, tên nhà cung cấp
SELECT NHACUNGCAP.ID_NCC,NHACUNGCAP.Ten
FROM YEUCAU_KHO_NCC 
JOIN NHACUNGCAP ON YEUCAU_KHO_NCC.ID_NCC=NHACUNGCAP.ID_NCC
WHERE ID_KT='KT00001'

--28. Siêu thị nào khách hàng đến mua nhiều nhất, thông tin gồm: mã siêu thị, tên siêu thị, số khách đến mua 
SELECT SIEUTHI.ID_ST,SIEUTHI.Ten,COUNT(DISTINCT ID_KH) AS SoKH
FROM SIEUTHI
JOIN HOADON ON SIEUTHI.ID_ST = HOADON.ID_ST
GROUP BY SIEUTHI.ID_ST,SIEUTHI.Ten
HAVING COUNT(ID_KH)>=(SELECT MAX(KHACH) 
					  FROM (SELECT COUNT(DISTINCT ID_KH) AS KHACH 
							FROM HOADON 
							GROUP BY ID_ST ) AS TIMKHACH)

--29. Liệt kê những phiếu nhập xuất của yêu cầu giữa nhà cung cấp và kho tổng được in từ ngày 2023-08-12 đến 2023-12-13
SELECT * 
FROM YEUCAU_KHO_NCC
JOIN PHIEUNHAPXUAT ON YEUCAU_KHO_NCC.ID_P = PHIEUNHAPXUAT.ID_P
WHERE PHIEUNHAPXUAT.ThoiGian BETWEEN '2023-08-12' AND '2023-12-13'

--30. Liệt kê những sản phẩm của những phiếu nhập xuất nào có tình trạng ‘Chưa Nhận’ , thông tin gồm: ID_P, ID_SP, tên sản phẩm, số lượng
SELECT ID_P,SANPHAM.ID_SP,SoLuong
FROM THONGTIN 
JOIN SANPHAM ON THONGTIN.ID_SP=SANPHAM.ID_SP
WHERE TinhTrang=N'Chưa Nhận'

--31. Bộ phận làm việc nào có từ 3 nhân viên có mức lương trên 7 triệu , thông tin gồm: ID_BP, tên bộ phận
SELECT BOPHANLAMVIEC.ID_BP,BOPHANLAMVIEC.Ten
FROM NHANVIEN
JOIN BOPHANLAMVIEC ON NHANVIEN.ID_BP=BOPHANLAMVIEC.ID_BP
WHERE LuongCB >= 7000000
GROUP BY BOPHANLAMVIEC.ID_BP, BOPHANLAMVIEC.Ten
HAVING COUNT(ID_NV) >= 3

--32. Mức lương trung bình của các nhân viên có chức vụ ‘QL’
SELECT AVG(LuongCB)
FROM NHANVIEN
WHERE ChucVu = 'QL'

--33. Mỗi quản lý đang quản lí bao nhiêu nhân viên
SELECT ID_QL, COUNT(ID_NV) AS SoNV
FROM NHANVIEN
WHERE NHANVIEN.ChucVu NOT LIKE 'QL' 
GROUP BY ID_QL

--34. Số tiền trả lại cho khách hàng của hoá đơn HD00002
SELECT HOADON.TienNhan-(SUM(SP_TRONG_HD.SoLuong*(SANPHAM.Gia*(100-SANPHAM.GiamGia)/100))-ISNULL(VOUCHER.GiaTri,0))
FROM SP_TRONG_HD
JOIN (HOADON JOIN VOUCHER ON HOADON.ID_VC=VOUCHER.ID_VC) ON SP_TRONG_HD.ID_HD=HOADON.ID_HD
JOIN SANPHAM ON SP_TRONG_HD.ID_SP=SANPHAM.ID_SP
WHERE SP_TRONG_HD.ID_HD='HD00002'
GROUP BY HOADON.TienNhan,VOUCHER.GiaTri

--35. Cho biết những nhân viên có địa chỉ cùng với của nhân viên tên ‘Hoàng’
SELECT *
FROM NHANVIEN
WHERE DiaChi=(SELECT DiaChi 
			  FROM NHANVIEN 
			  WHERE Ten LIKE '%Hoàng%')
AND Ten NOT LIKE '%Hoàng%'

--36. Số lương cao nhất của mỗi bộ phận làm việc, thông tin gồm: bộ phận làm việc, lương cao nhất
SELECT BOPHANLAMVIEC.Ten, MAX(LuongCB) AS LuongMAX
FROM NHANVIEN
JOIN BOPHANLAMVIEC ON NHANVIEN.ID_BP = BOPHANLAMVIEC.ID_BP
GROUP BY BOPHANLAMVIEC.Ten

--37. Cho biết 3 sản phẩm được cung cấp bởi nhiều nhà cung cấp nhất, thông tin gồm: mã sản phẩm, tên sản phẩm, số nhà cung cấp
SELECT TOP(3) SANPHAM.ID_SP, SANPHAM.Ten, COUNT(SANPHAM.ID_SP) AS SoNCC
FROM YEUCAU_KHO_NCC
JOIN PHIEUNHAPXUAT ON YEUCAU_KHO_NCC.ID_P = PHIEUNHAPXUAT.ID_P
JOIN THONGTIN ON THONGTIN.ID_P = PHIEUNHAPXUAT.ID_P
JOIN SANPHAM ON THONGTIN.ID_SP = SANPHAM.ID_SP
GROUP BY SANPHAM.ID_SP, SANPHAM.Ten
ORDER BY COUNT(SANPHAM.ID_SP) DESC

--38. ‘Nhà cung cấp 3’ cung cấp những ngành hàng gì,thông tin gồm: mã ngành hàng, tên ngành hàng
SELECT DISTINCT NGANHHANG.ID_NH, NGANHHANG.Ten 
FROM YEUCAU_KHO_NCC
JOIN PHIEUNHAPXUAT ON YEUCAU_KHO_NCC.ID_P = PHIEUNHAPXUAT.ID_P
JOIN THONGTIN ON THONGTIN.ID_P = PHIEUNHAPXUAT.ID_P
JOIN SANPHAM ON THONGTIN.ID_SP = SANPHAM.ID_SP
JOIN NHACUNGCAP ON NHACUNGCAP.ID_NCC = YEUCAU_KHO_NCC.ID_NCC
JOIN NGANHHANG ON SANPHAM.ID_NH = NGANHHANG.ID_NH
WHERE NHACUNGCAP.Ten = N'Nhà cung cấp 3'

--39. Đuôi số 4321 là số điện thoại của khách hàng nào
SELECT ID_KH
FROM KHACHHANG
WHERE SDT LIKE '%4321'

--40. Giá các sản phẩm sau khi giảm giá, thông tin gồm: mã sản phẩm, tên sản phẩm, giá đã giảm
SELECT ID_SP,Ten,Gia * GiamGia/100 AS GiaDaGiam
FROM SANPHAM

--41. Khách hàng KH00002 đã mua bao nhiêu cân Meatdeli sụn heo cắt lát ngày 2023-12-02
SELECT SP_TRONG_HD.SoLuong
FROM HOADON
JOIN SP_TRONG_HD ON HOADON.ID_HD=SP_TRONG_HD.ID_HD
JOIN SANPHAM ON SP_TRONG_HD.ID_SP=SANPHAM.ID_SP
WHERE HOADON.ID_KH='KH00002' 
AND SANPHAM.Ten= N'Meatdeli sụn heo cắt lát'
AND DATEPART(YEAR,HOADON.ThoiGianIn)='2023'
AND DATEPART(MONTH,HOADON.ThoiGianIn)='12'
AND DATEPART(DAY,HOADON.ThoiGianIn)='02'

--42. Số điện thoại của nhân viên đã in phiếu nhập xuất hàng vào khung giờ 9h, thông tin gồm:ID_NV, họ tên nhân viên, số điện thoại nhân viên
SELECT NHANVIEN.ID_NV,Ho+' '+Ten AS HoTen,SDT
FROM NHANVIEN
JOIN PHIEUNHAPXUAT ON nhanvien.ID_NV = PHIEUNHAPXUAT.ID_NV
WHERE DATEPART(HOUR,PHIEUNHAPXUAT.ThoiGian)='9'

--43. Sản phẩm nào được mua nhiều nhất (số lượng mua nhiều nhất), thông tin gồm: mã sản phẩm, tên sản phẩm
SELECT SANPHAM.ID_SP, SANPHAM.Ten
FROM HOADON
JOIN SP_TRONG_HD ON HOADON.ID_HD = SP_TRONG_HD.ID_HD
JOIN SANPHAM ON SP_TRONG_HD.ID_SP = SANPHAM.ID_SP
GROUP BY SANPHAM.ID_SP, SANPHAM.Ten
HAVING SUM(SoLuong) = (SELECT MAX(Tong) 
						FROM (SELECT SUM(SoLuong) AS Tong
							  FROM HOADON
							  JOIN SP_TRONG_HD ON HOADON.ID_HD = SP_TRONG_HD.ID_HD
							  JOIN SANPHAM ON SP_TRONG_HD.ID_SP = SANPHAM.ID_SP
							  GROUP BY SANPHAM.ID_SP) AS TongSoLuong)

--44. Doanh thu( tiền) đã bán được mặt hàng ‘Đặc sản lòng heo’
SELECT SUM(SoLuong)*(Gia*(100-GiamGia)/100)
FROM HOADON
JOIN SP_TRONG_HD ON HOADON.ID_HD = SP_TRONG_HD.ID_HD
JOIN SANPHAM ON SP_TRONG_HD.ID_SP = SANPHAM.ID_SP
WHERE Ten = N'Đặc sản lòng heo'
GROUP BY Gia, GiamGia

--45. Liệt kê những nhân viên có chữ T và n trong tên
SELECT * FROM NHANVIEN
WHERE Ten LIKE '%T%n%'

--46. Sắp xếp danh sách nhân viên theo độ tuổi giảm dần
SELECT * FROM NHANVIEN
ORDER BY SinhNhat ASC

--47. Cập nhập lại tiền lương cơ bản của các quản lí tăng thêm 10% so với mức cũ
UPDATE NHANVIEN
SET LuongCB=LuongCB*1.1
WHERE ChucVu='QL'

--48. Hãy xoá tất cả các thông tin của những nhà cung cấp chưa cung cấp sản phẩm nào
DELETE FROM NHACUNGCAP
WHERE NOT EXISTS (SELECT *
				FROM YEUCAU_KHO_NCC
				WHERE NHACUNGCAP.ID_NCC=YEUCAU_KHO_NCC.ID_NCC)
--49. Thêm loại Voucher mới có ID là VC00005 và giá trị 200k
INSERT INTO VOUCHER VALUES
( 'VC00005', '200000')

--50. Liệt kê những nhân viên sinh năm 2004
SELECT * FROM NHANVIEN
WHERE YEAR(SinhNhat)=2004
