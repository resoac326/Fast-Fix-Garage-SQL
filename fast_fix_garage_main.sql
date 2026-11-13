-- Fast Fix Garage - Task 2: database structure (no test records)
-- Import this file FIRST, then import data.sql.
-- Database schema, InnoDB tables, keys and constraints.

CREATE DATABASE IF NOT EXISTS `fast fix garage`
  CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `fast fix garage`;

SET NAMES utf8mb4;

-- ============================================================
-- Table: catagory
-- ============================================================
CREATE TABLE `catagory` (
  `IdCatagory` int(11) NOT NULL,
  `Label` varchar(255) NOT NULL,
  `Discount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- Table: customer
-- ============================================================
CREATE TABLE `customer` (
  `IdCustomer` int(11) NOT NULL,
  `IdCatagory` int(11) NOT NULL,
  `First Name` varchar(255) NOT NULL,
  `Last Name` varchar(255) NOT NULL,
  `Phone` int(11) NOT NULL,
  `Address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- Table: mechanic
-- ============================================================
CREATE TABLE `mechanic` (
  `IdMechanic` int(11) NOT NULL,
  `First Name Mechanic` varchar(255) NOT NULL,
  `Last Name Mechanic` varchar(255) NOT NULL,
  `Phone` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- Table: part
-- ============================================================
CREATE TABLE `part` (
  `IdPart` int(11) NOT NULL,
  `Part Name` varchar(100) NOT NULL,
  `Unit Price` decimal(10,3) NOT NULL,
  CONSTRAINT `chk_unit_price` CHECK (`Unit Price` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- Table: service
-- ============================================================
CREATE TABLE `service` (
  `IdService` int(11) NOT NULL,
  `Service Name` varchar(255) NOT NULL,
  `HourlyRate` int(11) NOT NULL,
  CONSTRAINT `chk_hourly_rate` CHECK (`HourlyRate` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- Table: qualification
-- ============================================================
CREATE TABLE `qualification` (
  `IdMechanic` int(11) NOT NULL,
  `IdService` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- Table: vehicle
-- ============================================================
CREATE TABLE `vehicle` (
  `IdVehicle` int(11) NOT NULL,
  `IdCustomer` int(11) NOT NULL,
  `Plate` varchar(255) NOT NULL,
  `Make` varchar(255) NOT NULL,
  `Model` varchar(255) NOT NULL,
  `Year` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- Table: invoice
-- ============================================================
CREATE TABLE `invoice` (
  `IdInvoice` int(11) NOT NULL,
  `IdVehicle` int(11) NOT NULL,
  `InvoiceNo` varchar(8) NOT NULL,
  `InvoiceDate` date NOT NULL,
  `DiscountPct` int(11) NOT NULL,
  `VatRate` int(11) NOT NULL DEFAULT 5,
  CONSTRAINT `chk_discount` CHECK (`DiscountPct` BETWEEN 0 AND 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- Table: labour line
-- ============================================================
CREATE TABLE `labour line` (
  `LineNo` int(11) NOT NULL,
  `IdInvoice` int(11) NOT NULL,
  `IdService` int(11) NOT NULL,
  `IdMechanic` int(11) NOT NULL,
  `Hours` decimal(5,2) NOT NULL,
  `Rate Charged` int(11) NOT NULL,
  CONSTRAINT `chk_hours` CHECK (`Hours` > 0),
  CONSTRAINT `chk_labour_rate` CHECK (`Rate Charged` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- Table: part line
-- ============================================================
CREATE TABLE `part line` (
  `PartLineNo` int(11) NOT NULL,
  `IdInvoice` int(11) NOT NULL,
  `IdPart` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Price Charged` decimal(10,3) NOT NULL,
  CONSTRAINT `chk_quantity` CHECK (`Quantity` > 0),
  CONSTRAINT `chk_part_price` CHECK (`Price Charged` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Indexes, primary keys, unique keys and foreign keys

ALTER TABLE `catagory`
  ADD PRIMARY KEY (`IdCatagory`);

ALTER TABLE `customer`
  ADD PRIMARY KEY (`IdCustomer`),
  ADD KEY `customer_ibfk_1` (`IdCatagory`);

ALTER TABLE `invoice`
  ADD PRIMARY KEY (`IdInvoice`),
  ADD UNIQUE KEY `InvoiceNo` (`InvoiceNo`),
  ADD KEY `invoice_ibfk_1` (`IdVehicle`);

ALTER TABLE `labour line`
  ADD PRIMARY KEY (`LineNo`),
  ADD KEY `labour line_ibfk_1` (`IdInvoice`),
  ADD KEY `labour line_ibfk_3` (`IdService`),
  ADD KEY `fk_mechanic_qualification` (`IdMechanic`,`IdService`);

ALTER TABLE `mechanic`
  ADD PRIMARY KEY (`IdMechanic`);

ALTER TABLE `part`
  ADD PRIMARY KEY (`IdPart`);

ALTER TABLE `part line`
  ADD PRIMARY KEY (`PartLineNo`),
  ADD KEY `part line_ibfk_1` (`IdInvoice`),
  ADD KEY `part line_ibfk_2` (`IdPart`);

ALTER TABLE `qualification`
  ADD PRIMARY KEY (`IdMechanic`,`IdService`),
  ADD KEY `qualification_ibfk_2` (`IdService`);

ALTER TABLE `service`
  ADD PRIMARY KEY (`IdService`);

ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`IdVehicle`),
  ADD KEY `vehicle_ibfk_1` (`IdCustomer`);

ALTER TABLE `catagory`
  MODIFY `IdCatagory` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `customer`
  MODIFY `IdCustomer` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `invoice`
  MODIFY `IdInvoice` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `labour line`
  MODIFY `LineNo` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `mechanic`
  MODIFY `IdMechanic` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `part`
  MODIFY `IdPart` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `part line`
  MODIFY `PartLineNo` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `service`
  MODIFY `IdService` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `vehicle`
  MODIFY `IdVehicle` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`IdCatagory`) REFERENCES `catagory` (`IdCatagory`) ON UPDATE CASCADE;

ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`IdVehicle`) REFERENCES `vehicle` (`IdVehicle`) ON UPDATE CASCADE;

ALTER TABLE `labour line`
  ADD CONSTRAINT `fk_mechanic_qualification` FOREIGN KEY (`IdMechanic`,`IdService`) REFERENCES `qualification` (`IdMechanic`, `IdService`) ON UPDATE CASCADE,
  ADD CONSTRAINT `labour line_ibfk_1` FOREIGN KEY (`IdInvoice`) REFERENCES `invoice` (`IdInvoice`) ON UPDATE CASCADE,
  ADD CONSTRAINT `labour line_ibfk_2` FOREIGN KEY (`IdMechanic`) REFERENCES `mechanic` (`IdMechanic`) ON UPDATE CASCADE,
  ADD CONSTRAINT `labour line_ibfk_3` FOREIGN KEY (`IdService`) REFERENCES `service` (`IdService`) ON UPDATE CASCADE;

ALTER TABLE `part line`
  ADD CONSTRAINT `part line_ibfk_1` FOREIGN KEY (`IdInvoice`) REFERENCES `invoice` (`IdInvoice`) ON UPDATE CASCADE,
  ADD CONSTRAINT `part line_ibfk_2` FOREIGN KEY (`IdPart`) REFERENCES `part` (`IdPart`) ON UPDATE CASCADE;

ALTER TABLE `qualification`
  ADD CONSTRAINT `qualification_ibfk_1` FOREIGN KEY (`IdMechanic`) REFERENCES `mechanic` (`IdMechanic`) ON UPDATE CASCADE,
  ADD CONSTRAINT `qualification_ibfk_2` FOREIGN KEY (`IdService`) REFERENCES `service` (`IdService`) ON UPDATE CASCADE;

ALTER TABLE `vehicle`
  ADD CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`IdCustomer`) REFERENCES `customer` (`IdCustomer`) ON UPDATE CASCADE;

