-- Fast Fix Garage - Task 2: test data only
-- Import fast_fix_garage_main.sql FIRST, then this file.
-- Records preserved from the original database export.

USE `fast fix garage`;
SET NAMES utf8mb4;
START TRANSACTION;

-- Test data: catagory
INSERT INTO `catagory` (`IdCatagory`, `Label`, `Discount`) VALUES
(1, 'Standard', 0),
(2, 'Silver', 5),
(3, 'Gold', 10);

-- Test data: customer
INSERT INTO `customer` (`IdCustomer`, `IdCatagory`, `First Name`, `Last Name`, `Phone`, `Address`) VALUES
(1, 2, 'Hamad', 'Al-Balushi', 99123456, 'Seeb'),
(2, 1, 'Ahmed', 'Al-Harthy', 99234567, 'Muscat'),
(3, 3, 'Khalid', 'Al-Rashdi', 99345678, 'Barka'),
(4, 2, 'Saif', 'Al-Hinai', 99456789, 'Sohar'),
(5, 1, 'Ali', 'Al-Maamari', 99567890, 'Nizwa'),
(6, 3, 'Mohammed', 'Al-Abri', 99678901, 'Ibri'),
(7, 2, 'Salim', 'Al-Siyabi', 99789012, 'Seeb'),
(8, 1, 'Nasser', 'Al-Kindi', 99890123, 'Muscat');

-- Test data: mechanic
INSERT INTO `mechanic` (`IdMechanic`, `First Name Mechanic`, `Last Name Mechanic`, `Phone`) VALUES
(1, 'Salim', 'Al-Harthy', 98111111),
(2, 'Yusuf', 'Al-Balushi', 98222222),
(3, 'Ahmed', 'Al-Rashdi', 98333333),
(4, 'Khalid', 'Al-Hinai', 98444444),
(5, 'Ali', 'Al-Abri', 98555555);

-- Test data: part
INSERT INTO `part` (`IdPart`, `Part Name`, `Unit Price`) VALUES
(1, 'Oil filter', 4.000),
(2, 'Front brake pads (set)', 28.000),
(3, 'Engine oil 5W-30 (litre)', 2.500),
(4, 'Car battery', 45.000),
(5, 'Air filter', 6.000),
(6, 'Spark plug', 3.000),
(7, 'Wiper blade', 5.000),
(8, 'Brake fluid', 4.000),
(9, 'Coolant', 7.000),
(10, 'Tire', 30.000),
(11, 'AC filter', 8.000),
(12, 'Timing belt', 25.000),
(13, 'Headlight bulb', 6.000),
(14, 'Fuel filter', 9.000),
(15, 'Radiator hose', 12.000);

-- Test data: service
INSERT INTO `service` (`IdService`, `Service Name`, `HourlyRate`) VALUES
(1, 'Oil change', 12),
(2, 'Brake pad replacement', 16),
(3, 'Wheel alignment', 10),
(4, 'Engine diagnostic', 20),
(5, 'Battery replacement', 15),
(6, 'Tire rotation', 10),
(7, 'AC repair', 18),
(8, 'Transmission service', 25);

-- Test data: qualification
INSERT INTO `qualification` (`IdMechanic`, `IdService`) VALUES
(1, 1),
(1, 3),
(1, 4),
(1, 6),
(2, 1),
(2, 2),
(2, 5),
(3, 3),
(3, 4),
(3, 7),
(4, 5),
(4, 6),
(4, 8),
(5, 2),
(5, 7),
(5, 8);

-- Test data: vehicle
INSERT INTO `vehicle` (`IdVehicle`, `IdCustomer`, `Plate`, `Make`, `Model`, `Year`) VALUES
(1, 1, '4521 AB', 'Toyota', 'Corolla', 2018),
(2, 1, '6732 CD', 'Nissan', 'Sunny', 2020),
(3, 2, '7843 EF', 'Honda', 'Civic', 2019),
(4, 3, '8954 GH', 'Toyota', 'Camry', 2021),
(5, 4, '9065 JK', 'Hyundai', 'Elantra', 2022),
(6, 5, '1176 LM', 'Kia', 'Sportage', 2020),
(7, 6, '2287 NP', 'Ford', 'Focus', 2017),
(8, 7, '3398 QR', 'Mazda', 'Mazda 3', 2021),
(9, 8, '4409 ST', 'Toyota', 'Yaris', 2019);

-- Test data: invoice
INSERT INTO `invoice` (`IdInvoice`, `IdVehicle`, `InvoiceNo`, `InvoiceDate`, `DiscountPct`, `VatRate`) VALUES
(25, 1, '26-00457', '2026-10-14', 10, 5),
(26, 3, '26-00458', '2026-10-15', 0, 5),
(27, 6, '26-00459', '2026-10-16', 0, 5),
(28, 4, '26-00460', '2026-10-17', 10, 5),
(29, 5, '26-00461', '2026-10-18', 5, 5),
(30, 7, '26-00462', '2026-10-19', 10, 5),
(31, 8, '26-00463', '2026-10-20', 5, 5),
(32, 2, '26-00464', '2026-10-21', 5, 5),
(33, 1, '26-00465', '2026-10-22', 5, 5),
(34, 3, '26-00466', '2026-10-23', 0, 5),
(35, 4, '26-00467', '2026-10-24', 10, 5),
(36, 5, '26-00468', '2026-10-25', 5, 5);

-- Test data: labour line
INSERT INTO `labour line` (`LineNo`, `IdInvoice`, `IdService`, `IdMechanic`, `Hours`, `Rate Charged`) VALUES
(1, 25, 1, 1, 0.50, 12),
(2, 25, 2, 2, 2.00, 16),
(3, 25, 3, 1, 1.00, 10),
(4, 26, 4, 1, 10.00, 20),
(5, 27, 4, 3, 10.00, 20),
(6, 28, 8, 4, 2.00, 25),
(7, 29, 5, 2, 1.00, 15),
(8, 30, 7, 3, 1.50, 18),
(9, 31, 2, 5, 1.00, 16),
(10, 32, 6, 4, 1.00, 10),
(11, 33, 1, 2, 0.50, 12),
(12, 34, 3, 1, 2.00, 10),
(13, 35, 8, 5, 2.00, 25),
(14, 36, 5, 4, 1.00, 15);

-- Test data: part line
INSERT INTO `part line` (`PartLineNo`, `IdInvoice`, `IdPart`, `Quantity`, `Price Charged`) VALUES
(1, 25, 1, 1, 4.000),
(2, 25, 2, 1, 28.000),
(3, 25, 3, 4, 2.500),
(4, 26, 4, 1, 45.000),
(5, 27, 4, 1, 45.000),
(6, 28, 12, 1, 25.000),
(7, 29, 4, 1, 45.000),
(8, 30, 11, 1, 8.000),
(9, 31, 2, 1, 28.000),
(10, 32, 10, 1, 30.000),
(11, 33, 3, 4, 3.000),
(12, 34, 8, 1, 4.000),
(13, 35, 9, 1, 7.000),
(14, 36, 7, 1, 5.000);

COMMIT;
