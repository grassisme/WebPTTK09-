-- =====================================================
-- Du lieu mau cho CSDL supermarket7 - SQL Server
-- (chay sau schema_sqlserver.sql)
-- =====================================================
USE supermarket7;
GO

-- ---------- Thanh vien ----------
SET IDENTITY_INSERT tblMember7 ON;
INSERT INTO tblMember7 (id, userName, password, fullName, address, phone, email) VALUES
(1, N'kh01',  N'123456', N'Nguyễn Văn An',  N'12 Trần Duy Hưng, Cầu Giấy, Hà Nội',   '0912000001', N'an.nv@example.com'),
(2, N'kh02',  N'123456', N'Trần Thị Bình',  N'45 Quang Trung, Hà Đông, Hà Nội',      '0912000002', N'binh.tt@example.com'),
(3, N'kho01', N'123456', N'Lê Văn Cường',   N'8 Nguyễn Trãi, Thanh Xuân, Hà Nội',    '0913000003', N'cuong.lv@example.com'),
(4, N'gh01',  N'123456', N'Phạm Văn Dũng',  N'20 Xuân Thủy, Cầu Giấy, Hà Nội',       '0914000004', N'dung.pv@example.com'),
(5, N'gh02',  N'123456', N'Hoàng Thị Em',   N'3 Lê Trọng Tấn, Hà Đông, Hà Nội',      '0914000005', N'em.ht@example.com'),
(6, N'gh03',  N'123456', N'Đỗ Văn Giang',   N'99 Khuất Duy Tiến, Thanh Xuân, Hà Nội','0914000006', N'giang.dv@example.com');
SET IDENTITY_INSERT tblMember7 OFF;

INSERT INTO tblCustomer7 (tblMember7id, registerDate) VALUES
(1, '2026-01-15'),
(2, '2026-03-20');

INSERT INTO tblEmployee7 (tblMember7id, position) VALUES
(3, 'warehouse'),
(4, 'delivery'),
(5, 'delivery'),
(6, 'delivery');

INSERT INTO tblDeliveryStaff7 (tblEmployee7id, area, availableStatus) VALUES
(4, N'Cầu Giấy',   1),
(5, N'Hà Đông',    1),
(6, N'Thanh Xuân', 0);

-- ---------- Nha cung cap ----------
SET IDENTITY_INSERT tblSupplier7 ON;
INSERT INTO tblSupplier7 (id, name, address, phone, email, contactPerson, description) VALUES
(1, N'Công ty CP Thực phẩm Minh Long', N'KCN Thăng Long, Đông Anh, Hà Nội', '02438000001', N'lienhe@minhlong.example.com', N'Ngô Minh Long', N'Chuyên cung cấp sữa và các sản phẩm từ sữa'),
(2, N'Công ty TNHH Phân phối An Phát', N'150 Giải Phóng, Hai Bà Trưng, Hà Nội', '02438000002', N'sales@anphat.example.com', N'Vũ Thị Phát', N'Phân phối đồ uống, bánh kẹo, gia vị và thực phẩm khô');
SET IDENTITY_INSERT tblSupplier7 OFF;

-- ---------- Loai mat hang ----------
SET IDENTITY_INSERT tblCategory7 ON;
INSERT INTO tblCategory7 (id, name, description) VALUES
(1, N'Sữa và sản phẩm từ sữa',  N'Sữa tươi, sữa chua, sữa đặc, sữa bột'),
(2, N'Đồ uống',                 N'Nước khoáng, trà, cà phê, nước ép'),
(3, N'Bánh kẹo',                N'Bánh quy, kẹo, bánh mì đóng gói'),
(4, N'Gia vị và thực phẩm khô', N'Nước mắm, gạo, dầu ăn');
SET IDENTITY_INSERT tblCategory7 OFF;

-- ---------- Mat hang ----------
SET IDENTITY_INSERT tblItem7 ON;
INSERT INTO tblItem7 (id, name, unit, salePrice, quantityInStock, image, description, businessStatus, tblCategory7id, tblSupplier7id) VALUES
(1,  N'Sữa tươi tiệt trùng có đường 1L',    N'Hộp',  38000,  50, N'sua-tuoi-co-duong.jpg',    N'Sữa tươi tiệt trùng có đường, hộp giấy 1 lít.', 1, 1, 1),
(2,  N'Sữa tươi tiệt trùng không đường 1L', N'Hộp',  36000,  40, N'sua-tuoi-khong-duong.jpg', N'Sữa tươi tiệt trùng không đường, hộp giấy 1 lít.', 1, 1, 1),
(3,  N'Sữa chua ăn có đường (lốc 4 hộp)',   N'Lốc',  28000,  30, N'sua-chua.jpg',             N'Sữa chua ăn có đường, lốc 4 hộp x 100g.', 1, 1, 1),
(4,  N'Sữa đặc có đường 380g',              N'Lon',  25000,   0, N'sua-dac.jpg',              N'Sữa đặc có đường, lon 380g. Tạm hết hàng.', 1, 1, 1),
(5,  N'Sữa bột trẻ em 900g',                N'Hộp', 420000,  12, N'sua-bot.jpg',              N'Sữa bột dinh dưỡng cho trẻ từ 1 đến 3 tuổi, hộp 900g.', 1, 1, 1),
(6,  N'Nước khoáng thiên nhiên 500ml',      N'Chai',  6000, 200, N'nuoc-khoang.jpg',          N'Nước khoáng thiên nhiên đóng chai 500ml.', 1, 2, 2),
(7,  N'Trà xanh đóng chai 455ml',           N'Chai', 10000, 120, N'tra-xanh.jpg',             N'Trà xanh vị chanh, chai 455ml.', 1, 2, 2),
(8,  N'Cà phê sữa đá lon 235ml',            N'Lon',  15000,  80, N'ca-phe-sua.jpg',           N'Cà phê sữa pha sẵn, lon 235ml.', 1, 2, 2),
(9,  N'Nước cam ép 1L',                     N'Hộp',  45000,  25, N'nuoc-cam.jpg',             N'Nước cam ép nguyên chất, hộp 1 lít.', 1, 2, 2),
(10, N'Bánh quy bơ 400g',                   N'Hộp',  65000,  35, N'banh-quy-bo.jpg',          N'Bánh quy bơ hộp thiếc 400g.', 1, 3, 2),
(11, N'Kẹo dẻo trái cây 100g',              N'Gói',  18000,  60, N'keo-deo.jpg',              N'Kẹo dẻo nhiều vị trái cây, gói 100g.', 1, 3, 2),
(12, N'Bánh mì sandwich 400g',              N'Gói',  22000,   3, N'banh-mi-sandwich.jpg',     N'Bánh mì sandwich lát, gói 400g.', 1, 3, 2),
(13, N'Nước mắm cá cơm 500ml',              N'Chai', 42000,  45, N'nuoc-mam.jpg',             N'Nước mắm cá cơm 35 độ đạm, chai 500ml.', 1, 4, 2),
(14, N'Gạo thơm 5kg',                       N'Túi', 135000,  20, N'gao-thom.jpg',             N'Gạo thơm hạt dài, túi 5kg.', 1, 4, 2),
(15, N'Dầu ăn đậu nành 1L',                 N'Chai', 52000,   2, N'dau-an.jpg',               N'Dầu đậu nành tinh luyện, chai 1 lít.', 1, 4, 2),
(16, N'Sữa tươi hương dâu 180ml',           N'Hộp',   8000,  15, N'sua-dau.jpg',              N'Ngừng kinh doanh - không hiển thị khi tìm kiếm.', 0, 1, 1);
SET IDENTITY_INSERT tblItem7 OFF;

-- ---------- Don hang truc tuyen (chua xuat) ----------
SET IDENTITY_INSERT tblOnlineOrder7 ON;
INSERT INTO tblOnlineOrder7 (id, orderDate, deliveryAddress, receiverPhone, paymentMethod, status, tblCustomer7id) VALUES
(1, '2026-11-10', N'12 Trần Duy Hưng, Cầu Giấy, Hà Nội', '0912000001', N'Thanh toán khi nhận hàng', 'chua xuat', 1),
(2, '2026-11-11', N'45 Quang Trung, Hà Đông, Hà Nội',    '0912000002', N'Chuyển khoản',             'chua xuat', 2),
(3, '2026-11-12', N'25 Láng Hạ, Đống Đa, Hà Nội',        '0987000111', N'Thanh toán khi nhận hàng', 'chua xuat', 1);
SET IDENTITY_INSERT tblOnlineOrder7 OFF;

SET IDENTITY_INSERT tblOrderLine7 ON;
INSERT INTO tblOrderLine7 (id, quantity, salePrice, tblOnlineOrder7id, tblItem7id) VALUES
-- Don 1: du hang
(1, 2, 38000,  1, 1),
(2, 1, 65000,  1, 10),
(3, 6, 6000,   1, 6),
-- Don 2: banh mi sandwich dat 5, ton kho chi con 3 -> KHONG DU HANG
(4, 5, 22000,  2, 12),
(5, 2, 10000,  2, 7),
-- Don 3: du hang
(6, 1, 420000, 3, 5),
(7, 1, 135000, 3, 14),
(8, 2, 45000,  3, 9);
SET IDENTITY_INSERT tblOrderLine7 OFF;
GO
