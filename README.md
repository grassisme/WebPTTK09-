# Supermarket7 – Hệ thống quản lí siêu thị trực tuyến

JSP + JDBC + MySQL **hoặc SQL Server**, Tomcat 9, JDK 11, Maven (war). Chỉ cài 2 module:

1. **Search Item 7** – Khách hàng tìm kiếm mặt hàng, xem chi tiết, thêm vào giỏ.
2. **Approve And Export Order 7** – Nhân viên kho duyệt đơn, chọn NV giao hàng, xuất hàng, in hoá đơn.

## Cây thư mục

```
PTTK.WEB/
├── pom.xml
├── README.md
├── sql/
│   ├── schema_sqlserver.sql   data_sqlserver.sql   (SQL Server / SSMS)
│   └── schema_mysql.sql       data_mysql.sql       (MySQL)
└── src/main/
    ├── java/supermarket7/
    │   ├── model/
    │   │   ├── Member7.java          Customer7.java       Employee7.java
    │   │   ├── WarehouseStaff7.java  DeliveryStaff7.java
    │   │   ├── Supplier7.java        Category7.java       Item7.java
    │   │   ├── ShoppingCart7.java    CartLine7.java
    │   │   ├── OnlineOrder7.java     OrderLine7.java
    │   │   └── Invoice7.java (abstract)  OnlineInvoice7.java
    │   └── dao/
    │       ├── DAO7.java             (lớp cha, giữ Connection dùng chung)
    │       ├── MemberDAO7.java       (hỗ trợ đăng nhập)
    │       ├── CategoryDAO7.java     ItemDAO7.java        ShoppingCartDAO7.java
    │       ├── OnlineOrderDAO7.java  OrderLineDAO7.java
    │       └── DeliveryStaffDAO7.java InvoiceDAO7.java
    ├── resources/
    │   └── db.properties
    └── webapp/
        ├── WEB-INF/web.xml
        ├── css/style.css
        ├── images/no-image.svg
        ├── Login7.jsp  doLogin7.jsp  doLogout7.jsp
        ├── customer/
        │   ├── CustomerHome7.jsp  SearchItem7.jsp  ItemDetail7.jsp
        │   └── doAddToCart7.jsp
        └── warehouse/
            ├── WarehouseHome7.jsp  OrderList7.jsp  OrderDetail7.jsp
            ├── ChooseDeliveryStaff7.jsp  PrintInvoice7.jsp
            └── doExport7.jsp
```

## Hướng dẫn chạy

> Script MySQL và script SQL Server **không dùng lẫn được**: chạy script MySQL trong SSMS sẽ báo
> `Incorrect syntax near the keyword 'SET'`.

### 1A. Tạo CSDL – SQL Server (SSMS)

Mở trong SSMS và Execute lần lượt `sql/schema_sqlserver.sql` rồi `sql/data_sqlserver.sql`
(hoặc dùng sqlcmd):

```bash
sqlcmd -S .\TEN_INSTANCE -E -f 65001 -i sql/schema_sqlserver.sql
sqlcmd -S .\TEN_INSTANCE -E -f 65001 -i sql/data_sqlserver.sql
```

**Để Java (JDBC) kết nối được SQL Server** (chỉ làm một lần):

1. Mở **SQL Server Configuration Manager** → *SQL Server Network Configuration* → *Protocols for
   TEN_INSTANCE* → **TCP/IP** → *Enable*.
2. Chuột phải TCP/IP → Properties → tab *IP Addresses* → mục **IPAll**: xoá *TCP Dynamic Ports*,
   đặt **TCP Port = 1433**.
3. *SQL Server Services* → Restart dịch vụ `SQL Server (TEN_INSTANCE)`.
4. Có tài khoản đăng nhập kiểu SQL (vd `sa`): SSMS → Security → Logins → `sa` → đặt mật khẩu,
   tab *Status* chọn *Login: Enabled*; server phải bật *SQL Server and Windows Authentication mode*.

### 1B. Tạo CSDL – MySQL 8

```bash
mysql -u root -p < sql/schema_mysql.sql
mysql -u root -p --default-character-set=utf8mb4 < sql/data_mysql.sql
```

### 2. Sửa `src/main/resources/db.properties`

Mặc định đang dùng SQL Server; chỉ cần sửa `db.user` / `db.password`:

```properties
db.driver=com.microsoft.sqlserver.jdbc.SQLServerDriver
db.url=jdbc:sqlserver://localhost:1433;databaseName=supermarket7;encrypt=true;trustServerCertificate=true
db.user=sa
db.password=<mật khẩu sa của bạn>
```

Dùng MySQL thì comment 4 dòng trên và bỏ comment 4 dòng MySQL bên dưới trong file.
Code DAO viết SQL chung, chạy được trên cả hai CSDL.

### 3. Build war

```bash
mvn clean package
```

Kết quả: `target/supermarket7.war`.

### 4a. Deploy Tomcat 9

Copy `target/supermarket7.war` vào `<TOMCAT_HOME>/webapps/`, chạy `bin/startup.bat`, mở
<http://localhost:8080/supermarket7/>.

### 4b. Hoặc chạy bằng SmartTomcat trong IntelliJ

1. Mở thư mục `PTTK.WEB` trong IntelliJ (nhận là project Maven), chờ tải xong thư viện.
2. Chạy Maven `compile` một lần (để `db.properties` được copy vào `target/classes`).
3. Run → Edit Configurations → `+` → **Smart Tomcat**:
   - Tomcat Server: thư mục Tomcat 9
   - Deployment Directory: `src/main/webapp`
   - Context Path: `/supermarket7`
   - Use classpath of module: `supermarket7`
4. Run, mở <http://localhost:8080/supermarket7/>.

## Tài khoản mẫu (mật khẩu đều là `123456`)

| Tài khoản | Vai trò | Ghi chú |
|---|---|---|
| `kh01` | Khách hàng – Nguyễn Văn An | vào module Tìm kiếm mặt hàng |
| `kh02` | Khách hàng – Trần Thị Bình | |
| `kho01` | Nhân viên kho – Lê Văn Cường | vào module Duyệt đơn hàng |

## Kịch bản kiểm thử nhanh

- **Module 1**: đăng nhập `kh01` → Tìm kiếm mặt hàng → gõ `sữa` → ra nhiều mặt hàng
  ("Sữa đặc có đường 380g" ở trạng thái *Hết hàng*, "Sữa tươi hương dâu" ngừng kinh doanh nên không hiện).
  Bấm *Xem* → *Thêm vào giỏ hàng* → hộp thông báo "Đã thêm mặt hàng vào giỏ hàng".
  Mặt hàng hết hàng thì nút bị khoá. Để trống từ khoá → "Vui lòng nhập tên mặt hàng cần tìm".
- **Module 2**: đăng nhập `kho01` → Duyệt đơn hàng → 3 đơn chưa xuất.
  - Đơn **#2** (bánh mì sandwich đặt 5, tồn 3) → *Xuất hàng* → báo thiếu hàng, ở lại trang.
  - Đơn **#1** hoặc **#3** → *Xuất hàng* → chọn NV giao hàng (2 người rảnh) → *Xác nhận xuất*
    → hoá đơn → *In hoá đơn* → "Xuất hàng thành công" → *Về danh sách đơn* (đơn vừa xuất đã biến mất, tồn kho đã bị trừ).

## Ghi chú thiết kế

- JSP gọi thẳng DAO; mọi SQL nằm trong DAO, dùng `PreparedStatement`.
- `DAO7` giữ `protected static Connection con` dùng chung; thêm `public static getConnection()` để
  `doExport7.jsp` (khác package) điều khiển transaction `setAutoCommit(false) / commit / rollback`.
- `MemberDAO7.checkLogin()` và `doLogout7.jsp` là phần hỗ trợ đăng nhập tối thiểu (ngoài 2 module).
- `totalAmount` không lưu CSDL: đơn hàng tính bằng `SUM(quantity*salePrice)` trong
  `getUnexportedOrder()`, chi tiết đơn tính lại từ các dòng.
- `updateExportStatus` chỉ cập nhật khi đơn còn `'chua xuat'` và `updateStock` chỉ trừ khi
  `quantityInStock >= quantity` → hai NV kho xuất trùng một đơn thì người sau bị rollback.
- Ảnh mặt hàng: đặt file vào `src/main/webapp/images/` đúng tên trong cột `image`;
  thiếu ảnh sẽ hiện `no-image.svg`.
