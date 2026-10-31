-- ============================================================
-- Week 5: Payment Insertion Queries + Sample Data
-- ============================================================

-- ------------------------------------------------------------
-- Sample Customers
-- ------------------------------------------------------------
INSERT INTO Customers (Customer_ID, Customer_Name, Email, Phone) VALUES
(101, 'Aarav Sharma',     'aarav.sharma@email.com',  '9876543210'),
(102, 'Priya Patel',      'priya.patel@email.com',   '9123456780'),
(103, 'Rohan Mehta',      'rohan.mehta@email.com',   '9988776655'),
(104, 'Sneha Reddy',      'sneha.reddy@email.com',   '9765432109'),
(105, 'Vikram Singh',     'vikram.singh@email.com',  '9654321098');

-- ------------------------------------------------------------
-- Sample Orders (completed orders that need payments)
-- ------------------------------------------------------------
INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount) VALUES
(5001, 101, '2025-09-12', 2500.00),
(5002, 102, '2025-09-15', 4500.00),
(5003, 103, '2025-09-18', 1800.00),
(5004, 104, '2025-09-20', 3200.00),
(5005, 105, '2025-09-22', 5500.00),
(5006, 101, '2025-09-25', 1200.00),
(5007, 102, '2025-09-28', 3900.00),
(5008, 103, '2025-10-01', 2750.00),
(5009, 104, '2025-10-03', 4100.00),
(5010, 105, '2025-10-05', 1500.00);

-- ------------------------------------------------------------
-- Payment Records
-- Different payment modes + various statuses
-- ------------------------------------------------------------
INSERT INTO Payment (Payment_ID, Order_ID, Payment_Date, Payment_Mode, Payment_Status, Transaction_Amount) VALUES
('P101', 5001, '2025-09-12', 'UPI',               'Success', 2500.00),
('P102', 5002, '2025-09-15', 'Credit Card',       'Failed',  4500.00),
('P103', 5003, '2025-09-18', 'Net Banking',       'Success', 1800.00),
('P104', 5004, '2025-09-20', 'Debit Card',        'Success', 3200.00),
('P105', 5005, '2025-09-22', 'UPI',               'Pending', 5500.00),
('P106', 5006, '2025-09-25', 'Cash on Delivery',  'Success', 1200.00),
('P107', 5007, '2025-09-28', 'Credit Card',       'Failed',  3900.00),
('P108', 5008, '2025-10-01', 'UPI',               'Success', 2750.00),
('P109', 5009, '2025-10-03', 'Net Banking',       'Pending', 4100.00),
('P110', 5010, '2025-10-05', 'Debit Card',        'Success', 1500.00);

-- ------------------------------------------------------------
-- Update payment status after transaction processing
-- (Example: mark a previously pending payment as Success)
-- ------------------------------------------------------------
UPDATE Payment
SET Payment_Status = 'Success',
    Payment_Date   = CURRENT_DATE
WHERE Payment_ID = 'P105';

-- ------------------------------------------------------------
-- Retrieve payment details for a specific order
-- ------------------------------------------------------------
SELECT *
FROM Payment
WHERE Order_ID = 5001;

-- ------------------------------------------------------------
-- Verify all inserted payments
-- ------------------------------------------------------------
SELECT * FROM Payment ORDER BY Payment_ID;
