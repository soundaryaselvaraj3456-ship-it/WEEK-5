-- ============================================================
-- Week 5: Payment Transaction Management System
-- SQL Table Creation Script
-- ============================================================

-- Drop tables if they already exist (for clean re-runs)
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

-- ------------------------------------------------------------
-- 1. Customers Table (from previous module)
-- ------------------------------------------------------------
CREATE TABLE Customers (
    Customer_ID   INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email         VARCHAR(100),
    Phone         VARCHAR(15)
);

-- ------------------------------------------------------------
-- 2. Orders Table (from previous module)
-- ------------------------------------------------------------
CREATE TABLE Orders (
    Order_ID     INT PRIMARY KEY,
    Customer_ID  INT NOT NULL,
    Order_Date   DATE NOT NULL,
    Total_Amount DECIMAL(10,2) NOT NULL CHECK (Total_Amount > 0),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- ------------------------------------------------------------
-- 3. Payment Table (NEW)
-- ------------------------------------------------------------
CREATE TABLE Payment (
    Payment_ID         VARCHAR(10)  PRIMARY KEY,
    Order_ID           INT          NOT NULL UNIQUE,          -- UNIQUE enforces 1:1 relationship
    Payment_Date       DATE         NOT NULL DEFAULT CURRENT_DATE,
    Payment_Mode       VARCHAR(20)  NOT NULL,                 -- UPI / Card / Net Banking / Cash
    Payment_Status     VARCHAR(10)  NOT NULL,                 -- Success / Failed / Pending
    Transaction_Amount DECIMAL(10,2) NOT NULL CHECK (Transaction_Amount > 0),

    -- Foreign Key constraint
    CONSTRAINT fk_payment_order
        FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

-- Optional: Add CHECK constraints for allowed values (MySQL 8.0.16+ / PostgreSQL)
-- ALTER TABLE Payment
--     ADD CONSTRAINT chk_payment_mode
--         CHECK (Payment_Mode IN ('UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Cash on Delivery'));
--
-- ALTER TABLE Payment
--     ADD CONSTRAINT chk_payment_status
--         CHECK (Payment_Status IN ('Success', 'Failed', 'Pending'));

-- ------------------------------------------------------------
-- Verification
-- ------------------------------------------------------------
-- SHOW CREATE TABLE Payment;
-- DESCRIBE Payment;
