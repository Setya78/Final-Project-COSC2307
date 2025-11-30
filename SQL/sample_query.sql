
--1) List all landlords
SELECT landlord_id, first_name, last_name, business_name, email
FROM landlord ORDER BY landlord_id;

--2) List properties under each landlord
SELECT p.property_id, p.property_name, p.property_type, 
       p.landlord_id, l.business_name
FROM property p
JOIN landlord l ON p.landlord_id = l.landlord_id
ORDER BY p.property_id;

--3) Show all units with their property
SELECT u.unit_id, u.unit_code, u.unit_status, 
       p.property_name, p.property_type
FROM unit u
JOIN property p ON u.property_id = p.property_id
ORDER BY u.unit_id;

--4) List active contracts with tenant and unit detail
SELECT c.contract_id, 
       t.first_name || ' ' || t.last_name AS tenant_name,
       u.unit_code, c.start_date, c.base_rent_amount
FROM contract c
JOIN tenant t ON c.tenant_id = t.tenant_id
JOIN unit u ON c.unit_id = u.unit_id
WHERE c.contract_status_id = 1     -- ACTIVE
ORDER BY c.contract_id;

--5) Monthly rent charges 
SELECT rent_charge_id, contract_id, charge_period, 
       due_date, total_amount_due, charge_status_id
FROM rentcharge
ORDER BY rent_charge_id;

--6) Rent charges with tenant name & property
SELECT r.rent_charge_id, r.charge_period, r.total_amount_due,
       t.first_name, t.last_name,
       u.unit_code, p.property_name
FROM rentcharge r
JOIN contract c ON r.contract_id = c.contract_id
JOIN tenant t ON c.tenant_id = t.tenant_id
JOIN unit u ON c.unit_id = u.unit_id
JOIN property p ON u.property_id = p.property_id;

--7) Payments listing with method
SELECT p.payment_id, p.rent_charge_id, p.payment_date, 
       p.amount_paid, pm.method_code, p.reference_number
FROM payment p
JOIN paymentmethod pm ON p.payment_method_id = pm.payment_method_id
ORDER BY p.payment_id;

--8) Unpaid or partially paid rent charges
SELECT r.rent_charge_id, r.charge_period, r.total_amount_due,
       r.charge_status_id
FROM rentcharge r
WHERE r.charge_status_id <> 2;     -- NOT PAID IN FULL

--9) Calculate tenant outstanding balance
SELECT t.tenant_id, t.first_name, t.last_name,
       SUM(r.total_amount_due) - COALESCE(SUM(p.amount_paid), 0) AS outstanding_balance
FROM tenant t
JOIN contract c ON t.tenant_id = c.tenant_id
JOIN rentcharge r ON c.contract_id = r.contract_id
LEFT JOIN payment p ON r.rent_charge_id = p.rent_charge_id
GROUP BY t.tenant_id, t.first_name, t.last_name
ORDER BY outstanding_balance DESC;

--10) Monthly revenue summary 
SELECT DATE_TRUNC('month', p.payment_date) AS month,
       SUM(p.amount_paid) AS total_revenue
FROM payment p
GROUP BY DATE_TRUNC('month', p.payment_date)
ORDER BY month;

--11) Property occupancy rate
SELECT p.property_id, p.property_name,
       COUNT(u.unit_id) AS total_units,
       SUM(CASE WHEN u.unit_status = 'OCCUPIED' THEN 1 ELSE 0 END) AS occupied_units,
       ROUND(
         SUM(CASE WHEN u.unit_status = 'OCCUPIED' THEN 1 ELSE 0 END)::numeric 
         / COUNT(u.unit_id) * 100, 2
       ) AS occupancy_rate
FROM property p
JOIN unit u ON p.property_id = u.property_id
GROUP BY p.property_id, p.property_name
ORDER BY occupancy_rate DESC;

--12) Overdue rentcharge list (no payment + due passed)
SELECT r.rent_charge_id, r.due_date, r.total_amount_due,
       t.first_name, t.last_name, u.unit_code
FROM rentcharge r
JOIN contract c ON r.contract_id = c.contract_id
JOIN tenant t ON c.tenant_id = t.tenant_id
JOIN unit u ON c.unit_id = u.unit_id
LEFT JOIN payment p ON r.rent_charge_id = p.rent_charge_id
WHERE p.payment_id IS NULL
  AND r.due_date < CURRENT_DATE;
