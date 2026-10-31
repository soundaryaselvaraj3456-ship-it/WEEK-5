# Week 5: Payment Transaction Management System

## Submission Contents

| File | Description |
|------|-------------|
| `01_Payment_Table_Design.md` | Payment entity design, attributes, constraints, and relationship explanation |
| `02_Updated_ER_Diagram.md` | Text-based updated ER diagram showing Order–Payment (1:1) relationship |
| `03_SQL_Table_Creation_Script.sql` | Complete DDL script (Customers, Orders, Payment) with all constraints |
| `04_Payment_Insertion_Queries.sql` | Sample data + INSERT statements + status update examples |
| `05_Transaction_Status_Queries.sql` | Queries for successful / failed / pending transactions + retry updates |
| `06_Payment_Analysis_Reports.sql` | Payment Mode Analysis, Revenue Analysis, Customer Payment History |

## How to Run

1. Execute `03_SQL_Table_Creation_Script.sql` first (creates all tables).
2. Execute `04_Payment_Insertion_Queries.sql` (loads sample data).
3. Run queries from `05_Transaction_Status_Queries.sql` and `06_Payment_Analysis_Reports.sql` as needed.

Compatible with MySQL 8+, MariaDB, PostgreSQL (minor syntax adjustments may be needed for DEFAULT CURRENT_DATE on some older engines).

## Key Design Decisions

- **One-to-One** relationship enforced by `UNIQUE` constraint on `Payment.Order_ID`.
- `Payment_ID` is `VARCHAR` to support business-friendly IDs (P101, P102…).
- CHECK constraint ensures `Transaction_Amount > 0`.
- NOT NULL constraints on `Payment_Mode` and `Payment_Status`.
- Sample data covers all required payment modes and statuses.
- 
