-- =====================================================
-- He thong quan li sieu thi truc tuyen - CSDL supermarket7
-- MySQL 8.x
-- =====================================================
DROP DATABASE IF EXISTS supermarket7;
CREATE DATABASE supermarket7 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE supermarket7;

CREATE TABLE tblMember7 (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    userName  VARCHAR(50)  NOT NULL UNIQUE,
    password  VARCHAR(100) NOT NULL,
    fullName  VARCHAR(100) NOT NULL,
    address   VARCHAR(255),
    phone     VARCHAR(20),
    email     VARCHAR(100)
);

CREATE TABLE tblCustomer7 (
    tblMember7id INT PRIMARY KEY,
    registerDate DATE,
    FOREIGN KEY (tblMember7id) REFERENCES tblMember7(id)
);

CREATE TABLE tblEmployee7 (
    tblMember7id INT PRIMARY KEY,
    position     VARCHAR(50) NOT NULL,   -- 'warehouse','saler','manager','delivery'
    FOREIGN KEY (tblMember7id) REFERENCES tblMember7(id)
);

CREATE TABLE tblDeliveryStaff7 (
    tblEmployee7id  INT PRIMARY KEY,
    area            VARCHAR(100),
    availableStatus BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (tblEmployee7id) REFERENCES tblEmployee7(tblMember7id)
);

CREATE TABLE tblSupplier7 (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(150) NOT NULL,
    address       VARCHAR(255),
    phone         VARCHAR(20),
    email         VARCHAR(100),
    contactPerson VARCHAR(100),
    description   VARCHAR(500)
);

CREATE TABLE tblCategory7 (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    description VARCHAR(500)
);

CREATE TABLE tblItem7 (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(150) NOT NULL,
    unit            VARCHAR(50),
    salePrice       FLOAT NOT NULL,
    quantityInStock INT NOT NULL DEFAULT 0,
    image           VARCHAR(255),
    description     VARCHAR(1000),
    businessStatus  BOOLEAN NOT NULL DEFAULT TRUE,
    tblCategory7id  INT NOT NULL,
    tblSupplier7id  INT NOT NULL,
    FOREIGN KEY (tblCategory7id) REFERENCES tblCategory7(id),
    FOREIGN KEY (tblSupplier7id) REFERENCES tblSupplier7(id)
);

CREATE TABLE tblShoppingCart7 (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    createdDate    DATE,
    tblCustomer7id INT NOT NULL UNIQUE,
    FOREIGN KEY (tblCustomer7id) REFERENCES tblCustomer7(tblMember7id)
);

CREATE TABLE tblCartLine7 (
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    quantity           INT NOT NULL,
    tblShoppingCart7id INT NOT NULL,
    tblItem7id         INT NOT NULL,
    FOREIGN KEY (tblShoppingCart7id) REFERENCES tblShoppingCart7(id),
    FOREIGN KEY (tblItem7id) REFERENCES tblItem7(id)
);

CREATE TABLE tblOnlineOrder7 (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    orderDate       DATE,
    deliveryAddress VARCHAR(255),
    receiverPhone   VARCHAR(20),
    paymentMethod   VARCHAR(50),
    status          VARCHAR(50) NOT NULL DEFAULT 'chua xuat',   -- 'chua xuat' | 'da xuat'
    tblCustomer7id  INT NOT NULL,
    FOREIGN KEY (tblCustomer7id) REFERENCES tblCustomer7(tblMember7id)
);

CREATE TABLE tblOrderLine7 (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    quantity          INT NOT NULL,
    salePrice         FLOAT NOT NULL,
    tblOnlineOrder7id INT NOT NULL,
    tblItem7id        INT NOT NULL,
    FOREIGN KEY (tblOnlineOrder7id) REFERENCES tblOnlineOrder7(id),
    FOREIGN KEY (tblItem7id) REFERENCES tblItem7(id)
);

CREATE TABLE tblInvoice7 (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    invoiceDate DATE NOT NULL
);

CREATE TABLE tblOnlineInvoice7 (
    tblInvoice7id       INT PRIMARY KEY,
    tblOnlineOrder7id   INT NOT NULL UNIQUE,
    tblEmployee7id      INT NOT NULL,
    tblDeliveryStaff7id INT NOT NULL,
    FOREIGN KEY (tblInvoice7id) REFERENCES tblInvoice7(id),
    FOREIGN KEY (tblOnlineOrder7id) REFERENCES tblOnlineOrder7(id),
    FOREIGN KEY (tblEmployee7id) REFERENCES tblEmployee7(tblMember7id),
    FOREIGN KEY (tblDeliveryStaff7id) REFERENCES tblDeliveryStaff7(tblEmployee7id)
);

-- ===== Cac bang bo sung cho du CSDL (khong dung trong 2 module) =====
CREATE TABLE tblCounterInvoice7 (
    tblInvoice7id  INT PRIMARY KEY,
    tblEmployee7id INT NOT NULL,
    FOREIGN KEY (tblInvoice7id) REFERENCES tblInvoice7(id),
    FOREIGN KEY (tblEmployee7id) REFERENCES tblEmployee7(tblMember7id)
);

CREATE TABLE tblInvoiceLine7 (
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    quantity           INT NOT NULL,
    salePrice          FLOAT NOT NULL,
    tblCounterInvoice7id INT NOT NULL,
    tblItem7id         INT NOT NULL,
    FOREIGN KEY (tblCounterInvoice7id) REFERENCES tblCounterInvoice7(tblInvoice7id),
    FOREIGN KEY (tblItem7id) REFERENCES tblItem7(id)
);

CREATE TABLE tblImportReceipt7 (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    importDate     DATE NOT NULL,
    tblSupplier7id INT NOT NULL,
    tblEmployee7id INT NOT NULL,
    FOREIGN KEY (tblSupplier7id) REFERENCES tblSupplier7(id),
    FOREIGN KEY (tblEmployee7id) REFERENCES tblEmployee7(tblMember7id)
);

CREATE TABLE tblImportReceiptLine7 (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    quantity            INT NOT NULL,
    importPrice         FLOAT NOT NULL,
    tblImportReceipt7id INT NOT NULL,
    tblItem7id          INT NOT NULL,
    FOREIGN KEY (tblImportReceipt7id) REFERENCES tblImportReceipt7(id),
    FOREIGN KEY (tblItem7id) REFERENCES tblItem7(id)
);
