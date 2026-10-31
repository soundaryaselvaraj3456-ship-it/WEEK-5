# Payment Transaction Management System
## Week 5 – Payment Table Design

### 1. Payment Entity

| Attribute            | Data Type      | Description                          | Constraints                  |
|----------------------|----------------|--------------------------------------|------------------------------|
| Payment_ID           | VARCHAR(10)    | Unique payment identifier            | PRIMARY KEY                  |
| Order_ID             | INT            | Order reference                      | FOREIGN KEY → Orders(Order_ID), NOT NULL |
| Payment_Date         | DATE           | Date of transaction                  | NOT NULL, DEFAULT CURRENT_DATE |
| Payment_Mode         | VARCHAR(20)    | UPI / Card / Net Banking / Cash      | NOT NULL                     |
| Payment_Status       | VARCHAR(10)    | Success / Failed / Pending           | NOT NULL                     |
| Transaction_Amount   | DECIMAL(10,2)  | Paid amount                          | NOT NULL, CHECK (> 0)        |

### 2. Relationship with Orders

- **Cardinality**: One-to-One  
  - Each Order can have **at most one** Payment transaction.  
  - Each Payment belongs to **exactly one** Order.

```
Order (1) ──────── (1) Payment
```

**Constraints Applied**:
- Primary Key: `Payment_ID`
- Foreign Key: `Order_ID` REFERENCES `Orders(Order_ID)`
- NOT NULL on `Payment_Mode` and `Payment_Status`
- CHECK constraint: `Transaction_Amount > 0`

### 3. Assumed Existing Tables (from previous modules)

```sql
-- Customers (from Customer Management Module)
CREATE TABLE Customers (
    Customer_ID   INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email         VARCHAR(100),
    Phone         VARCHAR(15)
);

-- Orders (from Order Management Module)
CREATE TABLE Orders (
    Order_ID     INT PRIMARY KEY,
    Customer_ID  INT NOT NULL,
    Order_Date   DATE NOT NULL,
    Total_Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);
```

### 4. Design Notes

- `Payment_ID` is kept as VARCHAR to allow business-friendly IDs (e.g., P101, P102).
- One-to-one relationship is enforced by making `Order_ID` UNIQUE in the Payment table (in addition to being a Foreign Key).
- `Payment_Mode` values used: 'UPI', 'Credit Card', 'Debit Card', 'Net Banking', 'Cash on Delivery'.
- `Payment_Status` values used: 'Success', 'Failed', 'Pending'.
