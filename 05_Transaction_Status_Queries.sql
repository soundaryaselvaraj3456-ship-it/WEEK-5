-- ============================================================
-- Week 5: Manage Successful and Failed Transactions
-- ============================================================

-- 1. Display all successful payments
SELECT *
FROM Payment
WHERE Payment_Status = 'Success'
ORDER BY Payment_Date;

-- 2. Find failed transactions
SELECT *
FROM Payment
WHERE Payment_Status = 'Failed'
ORDER BY Payment_Date;

-- 3. Count total successful and failed payments
SELECT 
    Payment_Status,
    COUNT(*) AS Total_Count
FROM Payment
WHERE Payment_Status IN ('Success', 'Failed')
GROUP BY Payment_Status;

-- Alternative: side-by-side counts
SELECT 
    SUM(CASE WHEN Payment_Status = 'Success' THEN 1 ELSE 0 END) AS Successful_Payments,
    SUM(CASE WHEN Payment_Status = 'Failed'  THEN 1 ELSE 0 END) AS Failed_Payments,
    SUM(CASE WHEN Payment_Status = 'Pending' THEN 1 ELSE 0 END) AS Pending_Payments
FROM Payment;

-- 4. Update failed payments after retry
-- Example: Retry payment P102 and mark it Success
UPDATE Payment
SET Payment_Status = 'Success',
    Payment_Date   = CURRENT_DATE
WHERE Payment_ID = 'P102'
  AND Payment_Status = 'Failed';

-- Another retry example
UPDATE Payment
SET Payment_Status = 'Success',
    Payment_Date   = CURRENT_DATE
WHERE Payment_ID = 'P107'
  AND Payment_Status = 'Failed';

-- 5. Identify pending transactions
SELECT *
FROM Payment
WHERE Payment_Status = 'Pending'
ORDER BY Payment_Date;

-- Bonus: List of orders that still have pending/failed payments
SELECT 
    o.Order_ID,
    o.Customer_ID,
    o.Total_Amount,
    p.Payment_ID,
    p.Payment_Mode,
    p.Payment_Status
FROM Orders o
JOIN Payment p ON o.Order_ID = p.Order_ID
WHERE p.Payment_Status IN ('Pending', 'Failed')
ORDER BY o.Order_ID;
