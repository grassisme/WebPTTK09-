-- =====================================================
-- Du lieu mau cho CSDL supermarket7 (chay sau schema.sql)
-- =====================================================
USE supermarket7;
SET NAMES utf8mb4;

-- ---------- Thanh vien ----------
INSERT INTO tblMember7 (id, userName, password, fullName, address, phone, email) VALUES
(1, 'kh01',  '123456', 'Nguyễn Văn An',   '12 Trần Duy Hưng, Cầu Giấy, Hà Nội',  '0912000001', 'an.nv@example.com'),
(2, 'kh02',  '123456', 'Trần Thị Bình',   '45 Quang Trung, Hà Đông, Hà Nội',     '0912000002', 'binh.tt@example.com'),
(3, 'kho01', '123456', 'Lê Văn Cường',    '8 Nguyễn Trãi, Thanh Xuân, Hà Nội',   '0913000003', 'cuong.lv@example.com'),
(4, 'gh01',  '123456', 'Phạm Văn Dũng',   '20 Xuân Thủy, Cầu Giấy, Hà Nội',      '0914000004', 'dung.pv@example.com'),
(5, 'gh02',  '123456', 'Hoàng Thị Em',    '3 Lê Trọng Tấn, Hà Đông, Hà Nội',     '0914000005', 'em.ht@example.com'),
(6, 'gh03',  '123456', 'Đỗ Văn Giang',    '99 Khuất Duy Tiến, Thanh Xuân, Hà Nội','0914000006', 'giang.dv@example.com');

INSERT INTO tblCustomer7 (tblMember7id, registerDate) VALUES
(1, '2026-01-15'),
(2, '2026-03-20');

INSERT INTO tblEmployee7 (tblMember7id, position) VALUES
(3, 'warehouse'),
(4, 'delivery'),
(5, 'delivery'),
(6, 'delivery');

INSERT INTO tblDeliveryStaff7 (tblEmployee7id, area, availableStatus) VALUES
(4, 'Cầu Giấy',   TRUE),
(5, 'Hà Đông',    TRUE),
(6, 'Thanh Xuân', FALSE);

-- ---------- Nha cung cap ----------
INSERT INTO tblSupplier7 (id, name, address, phone, email, contactPerson, description) VALUES
(1, 'Công ty CP Thực phẩm Minh Long', 'KCN Thăng Long, Đông Anh, Hà Nội', '02438000001', 'lienhe@minhlong.example.com', 'Ngô Minh Long', 'Chuyên cung cấp sữa và các sản phẩm từ sữa'),
(2, 'Công ty TNHH Phân phối An Phát', '150 Giải Phóng, Hai Bà Trưng, Hà Nội', '02438000002', 'sales@anphat.example.com', 'Vũ Thị Phát', 'Phân phối đồ uống, bánh kẹo, gia vị và thực phẩm khô');

-- ---------- Loai mat hang ----------
INSERT INTO tblCategory7 (id, name, description) VALUES
(1, 'Sữa và sản phẩm từ sữa', 'Sữa tươi, sữa chua, sữa đặc, sữa bột'),
(2, 'Đồ uống',                'Nước khoáng, trà, cà phê, nước ép'),
(3, 'Bánh kẹo',               'Bánh quy, kẹo, bánh mì đóng gói'),
(4, 'Gia vị và thực phẩm khô','Nước mắm, gạo, dầu ăn');

-- ---------- Mat hang ----------
INSERT INTO tblItem7 (id, name, unit, salePrice, quantityInStock, image, description, businessStatus, tblCategory7id, tblSupplier7id) VALUES
(1,  'Sữa tươi tiệt trùng có đường 1L', 'Hộp', 38000,  50, 'sua-tuoi-co-duong.jpg',   'Sữa tươi tiệt trùng có đường, hộp giấy 1 lít.', TRUE, 1, 1),
(2,  'Sữa tươi tiệt trùng không đường 1L', 'Hộp', 36000, 40, 'sua-tuoi-khong-duong.jpg', 'Sữa tươi tiệt trùng không đường, hộp giấy 1 lít.', TRUE, 1, 1),
(3,  'Sữa chua ăn có đường (lốc 4 hộp)', 'Lốc', 28000, 30, 'sua-chua.jpg',            'Sữa chua ăn có đường, lốc 4 hộp x 100g.', TRUE, 1, 1),
(4,  'Sữa đặc có đường 380g',          'Lon', 25000,   0, 'sua-dac.jpg',              'Sữa đặc có đường, lon 380g. Tạm hết hàng.', TRUE, 1, 1),
(5,  'Sữa bột trẻ em 900g',            'Hộp', 420000, 12, 'sua-bot.jpg',              'Sữa bột dinh dưỡng cho trẻ từ 1 đến 3 tuổi, hộp 900g.', TRUE, 1, 1),
(6,  'Nước khoáng thiên nhiên 500ml',  'Chai', 6000,  200, 'nuoc-khoang.jpg',          'Nước khoáng thiên nhiên đóng chai 500ml.', TRUE, 2, 2),
(7,  'Trà xanh đóng chai 455ml',       'Chai', 10000, 120, 'tra-xanh.jpg',             'Trà xanh vị chanh, chai 455ml.', TRUE, 2, 2),
(8,  'Cà phê sữa đá lon 235ml',        'Lon', 15000,  80, 'ca-phe-sua.jpg',           'Cà phê sữa pha sẵn, lon 235ml.', TRUE, 2, 2),
(9,  'Nước cam ép 1L',                 'Hộp', 45000,  25, 'nuoc-cam.jpg',             'Nước cam ép nguyên chất, hộp 1 lít.', TRUE, 2, 2),
(10, 'Bánh quy bơ 400g',               'Hộp', 65000,  35, 'banh-quy-bo.jpg',          'Bánh quy bơ hộp thiếc 400g.', TRUE, 3, 2),
(11, 'Kẹo dẻo trái cây 100g',          'Gói', 18000,  60, 'keo-deo.jpg',              'Kẹo dẻo nhiều vị trái cây, gói 100g.', TRUE, 3, 2),
(12, 'Bánh mì sandwich 400g',          'Gói', 22000,   3, 'banh-mi-sandwich.jpg',     'Bánh mì sandwich lát, gói 400g.', TRUE, 3, 2),
(13, 'Nước mắm cá cơm 500ml',          'Chai', 42000, 45, 'nuoc-mam.jpg',             'Nước mắm cá cơm 35 độ đạm, chai 500ml.', TRUE, 4, 2),
(14, 'Gạo thơm 5kg',                   'Túi', 135000, 20, 'gao-thom.jpg',             'Gạo thơm hạt dài, túi 5kg.', TRUE, 4, 2),
(15, 'Dầu ăn đậu nành 1L',             'Chai', 52000,  2, 'dau-an.jpg',               'Dầu đậu nành tinh luyện, chai 1 lít.', TRUE, 4, 2),
(16, 'Sữa tươi hương dâu 180ml',       'Hộp', 8000,   15, 'sua-dau.jpg',              'Ngừng kinh doanh - không hiển thị khi tìm kiếm.', FALSE, 1, 1);

-- ---------- Don hang truc tuyen (chua xuat) ----------
INSERT INTO tblOnlineOrder7 (id, orderDate, deliveryAddress, receiverPhone, paymentMethod, status, tblCustomer7id) VALUES
(1, '2026-11-10', '12 Trần Duy Hưng, Cầu Giấy, Hà Nội', '0912000001', 'Thanh toán khi nhận hàng', 'chua xuat', 1),
(2, '2026-11-11', '45 Quang Trung, Hà Đông, Hà Nội',    '0912000002', 'Chuyển khoản',             'chua xuat', 2),
(3, '2026-11-12', '25 Láng Hạ, Đống Đa, Hà Nội',        '0987000111', 'Thanh toán khi nhận hàng', 'chua xuat', 1);

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
