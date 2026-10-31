-- ============================================================
-- Week 5: Payment Analysis Reports
-- ============================================================

-- ------------------------------------------------------------
-- REPORT 1: Payment Mode Analysis
-- ------------------------------------------------------------

-- Number of transactions using each payment mode
SELECT 
    Payment_Mode,
    COUNT(*) AS Number_of_Transactions
FROM Payment
GROUP BY Payment_Mode
ORDER BY Number_of_Transactions DESC;

-- Most preferred payment method
SELECT 
    Payment_Mode AS Most_Preferred_Method,
    COUNT(*) AS Transaction_Count
FROM Payment
GROUP BY Payment_Mode
ORDER BY Transaction_Count DESC
LIMIT 1;

-- Number of UPI transactions
SELECT COUNT(*) AS UPI_Transactions
FROM Payment
WHERE Payment_Mode = 'UPI';

-- Number of Card payments (Credit + Debit)
SELECT COUNT(*) AS Card_Payments
FROM Payment
WHERE Payment_Mode IN ('Credit Card', 'Debit Card');

-- ------------------------------------------------------------
-- REPORT 2: Revenue Analysis
-- ------------------------------------------------------------

-- Total revenue generated (only successful payments)
SELECT 
    SUM(Transaction_Amount) AS Total_Revenue
FROM Payment
WHERE Payment_Status = 'Success';

-- Revenue by payment method
SELECT 
    Payment_Mode,
    SUM(Transaction_Amount) AS Revenue,
    COUNT(*) AS Successful_Transactions
FROM Payment
WHERE Payment_Status = 'Success'
GROUP BY Payment_Mode
ORDER BY Revenue DESC;

-- Average transaction amount (successful payments)
SELECT 
    ROUND(AVG(Transaction_Amount), 2) AS Average_Transaction_Amount
FROM Payment
WHERE Payment_Status = 'Success';

-- Overall statistics
SELECT 
    COUNT(*)                                    AS Total_Transactions,
    SUM(CASE WHEN Payment_Status = 'Success' THEN 1 ELSE 0 END) AS Successful,
    SUM(CASE WHEN Payment_Status = 'Failed'  THEN 1 ELSE 0 END) AS Failed,
    SUM(CASE WHEN Payment_Status = 'Pending' THEN 1 ELSE 0 END) AS Pending,
    SUM(CASE WHEN Payment_Status = 'Success' THEN Transaction_Amount ELSE 0 END) AS Total_Revenue,
    ROUND(AVG(CASE WHEN Payment_Status = 'Success' THEN Transaction_Amount END), 2) AS Avg_Successful_Amount
FROM Payment;

-- ------------------------------------------------------------
-- REPORT 3: Customer Payment History
-- ------------------------------------------------------------

SELECT 
    c.Customer_Name,
    o.Order_ID,
    p.Payment_ID,
    p.Payment_Mode,
    p.Transaction_Amount AS Amount,
    p.Payment_Status,
    p.Payment_Date
FROM Customers c
JOIN Orders o   ON c.Customer_ID = o.Customer_ID
JOIN Payment p  ON o.Order_ID   = p.Order_ID
ORDER BY c.Customer_Name, o.Order_ID;

-- Customer-wise total successful payment amount
SELECT 
    c.Customer_Name,
    COUNT(p.Payment_ID) AS Total_Payments,
    SUM(CASE WHEN p.Payment_Status = 'Success' THEN p.Transaction_Amount ELSE 0 END) AS Total_Paid
FROM Customers c
JOIN Orders o   ON c.Customer_ID = o.Customer_ID
JOIN Payment p  ON o.Order_ID   = p.Order_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Paid DESC;
