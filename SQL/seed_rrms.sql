-- 1) LOOKUP
INSERT INTO penaltyrule (penalty_type, penalty_amount, grace_period_days, rule_description)
VALUES 
  ('FIXED', 25.00, 3, 'Flat $25 after 3 days overdue');

INSERT INTO billingcycletype (name_billing_cycle, description)
VALUES 
  ('MONTHLY', 'Monthly billing cycle');

INSERT INTO contractstatus (status_code, description)
VALUES 
  ('ACTIVE', 'Active contract'),
  ('ENDED', 'Ended contract');

INSERT INTO chargestatus (status_code, description)
VALUES 
  ('OPEN', 'Not fully paid'),
  ('PAID', 'Fully paid');

INSERT INTO paymentmethod (method_code, description)
VALUES 
  ('CASH', 'Cash payment'),
  ('INTERAC', 'Interac e-transfer');


-- 2) MASTER
INSERT INTO landlord (first_name, last_name, business_name, email, phone, interac_contact)
VALUES 
  ('Daniel', 'Roberto', 'DR Rentals', 'droberto@example.com', '7051112222', 'daniel.interac@example.com');

INSERT INTO property (landlord_id, property_name, property_type, full_address, post_code)
VALUES 
  (1, 'Queen Street House', 'House', '123 Queen St, Sault Ste. Marie, ON', 'P6A 1A1');

INSERT INTO unit (property_id, unit_code, capacity, unit_type, unit_status)
VALUES
  (1, 'Unit-101', 1, 'Room', 'OCCUPIED'),
  (1, 'Unit-102', 1, 'Room', 'VACANT');

INSERT INTO tenant (first_name, last_name, tenant_occupation, email, phone, id_type, id_number)
VALUES
  ('Jeremy', 'Sunn', 'Student', 'sunn@example.com', '7053334444', 'Passport', 'P1234567');


-- 3) CONTRACT
INSERT INTO contract (
    unit_id, tenant_id, penalty_rule_id, billing_cycle_type_id,
    start_date, end_date, base_rent_amount, billing_day,
    contract_status_id,
    security_deposit_amount, security_deposit_status,
    security_deposit_received_date,
    reminder_days_before_due, reminder_days_after_due
)
VALUES
  (1, 1, 2, 1,
   '2025-01-01', NULL, 700.00, 1,
   1,
   700.00, 'HELD',
   '2024-12-28',
   3, 5);


-- 4) RENTCHARGE (example 2 months)
INSERT INTO rentcharge (
    contract_id, charge_period, period_start, period_end,
    due_date, base_amount, penalty_amount, total_amount_due,
    charge_status_id, invoice_number, invoice_sent_at
)
VALUES
  (3, '2025-Jan', '2025-01-01', '2025-01-31',
   '2025-01-01', 700.00, 0.00, 700.00,
   1, 'INV-2025-01-0001', '2024-12-29'),
  (3, '2025-Feb', '2025-02-01', '2025-02-28',
   '2025-02-01', 700.00, 0.00, 700.00,
   1, 'INV-2025-02-0001', '2025-01-29');

-- 5) PAYMENT
INSERT INTO payment (
    rent_charge_id, payment_date, amount_paid,
    payment_method_id, payment_status, payment_category, reference_number
)
VALUES
  (5, '2025-01-01', 700.00, 2, 'POSTED', 'RENT', 'ETR-REF-001'),
  (6, '2025-02-03', 700.00, 2, 'POSTED', 'RENT', 'ETR-REF-002');

