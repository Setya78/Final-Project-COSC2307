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
