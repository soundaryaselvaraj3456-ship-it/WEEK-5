# Updated ER Diagram – Order ↔ Payment Relationship

## Conceptual ER Diagram (Text Representation)

```
┌─────────────────────┐         ┌─────────────────────┐
│     Customers       │         │       Orders        │
├─────────────────────┤         ├─────────────────────┤
│ PK Customer_ID      │◄───┐    │ PK Order_ID         │
│    Customer_Name    │    │    │ FK Customer_ID      │
│    Email            │    │    │    Order_Date       │
│    Phone            │    │    │    Total_Amount     │
└─────────────────────┘    │    └─────────────────────┘
                           │              │
                           │              │ 1
                           │              │
                           │              │
                           │              ▼ 1
                           │    ┌─────────────────────┐
                           │    │      Payment        │
                           │    ├─────────────────────┤
                           │    │ PK Payment_ID       │
                           └─── │ FK Order_ID (UNIQUE)│
                                │    Payment_Date     │
                                │    Payment_Mode     │
                                │    Payment_Status   │
                                │    Transaction_Amount│
                                └─────────────────────┘
```

## Relationship Description

| Relationship       | Type     | Description                                      |
|--------------------|----------|--------------------------------------------------|
| Customers – Orders | 1 : N    | One customer can place many orders               |
| Orders – Payment   | 1 : 1    | Each order has exactly one payment transaction   |

## Cardinality & Participation

- **Orders side**: Total participation (every order should eventually have a payment record).
- **Payment side**: Total participation (every payment must belong to an existing order).
- Enforced by:
  - Foreign Key on `Payment.Order_ID`
  - UNIQUE constraint on `Payment.Order_ID` (ensures one-to-one)

## Attributes of Payment Entity

- **Payment_ID** (Primary Key)
- **Order_ID** (Foreign Key + Unique)
- **Payment_Date**
- **Payment_Mode**
- **Payment_Status**
- **Transaction_Amount**
