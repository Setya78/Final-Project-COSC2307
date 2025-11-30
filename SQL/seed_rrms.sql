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

