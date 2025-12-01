# Power BI Analytics Report – Room Rental Management System

This folder contains the Power BI dashboard used to analyze rental, payment, and occupancy data for the Room Rental Management System (RRMS).  
All data is loaded directly from the PostgreSQL database using a live connection.

---

## Dashboard Insights Included

### 1. **Occupancy Rate**
Shows the percentage of units currently occupied.  
In this sample dataset, the occupancy rate is **75%**, indicating strong utilization of available rental units.

### 2. **Outstanding Balance**
Displays the total unpaid rent at the moment.  
The dashboard shows an **Outstanding Balance of 57.60K**, representing rent charges that have been issued but not yet paid.

### **3. Total Rent Generated**
Shows the sum of all rent charges issued within the selected period.  
The current value is **312.00K**, reflecting overall rental performance.

---

## **Monthly Payment Breakdown**
A horizontal bar chart showing **Total Payment by Month**  
(January, February, March).  
This chart helps visualize monthly cash inflows and payment consistency.

---

## **Payment Method Distribution**
A pie chart showing the **breakdown of payment methods** used by tenants:
- Cash payment  
- Credit or debit card  
- Interac e-transfer  

Each method currently represents **33.33%** in the sample data.

---

## **Data Source**
The dashboard connects to:
- **Database:** PostgreSQL  
- **Name:** `room_rental_management`  
- **Connection:** Standard user (`dijaga_user`)  
- **Load Mode:** Import mode  

---

## **How to Use**
1. Open **RRMS_Report.pbix** in Power BI Desktop  
2. Ensure PostgreSQL is running locally  
3. Refresh the dataset to load the latest data  
4. Interact with visuals to explore rental performance  

---

## **Purpose**
This dashboard is included as part of the final project deliverables to demonstrate the ability to:
- Extract and analyze data from a relational database  
- Build meaningful business insights from a rental management system  
- Present key performance metrics using Power BI


---
  # Power BI Measures for RRMS Dashboard

This folder contains the DAX measures used to generate the analytics in the Power BI report for the Room Rental Management System (RRMS).  
These measures power the KPI cards, charts, and calculations inside the dashboard.




