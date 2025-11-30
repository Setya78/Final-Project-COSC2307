
-- =======================================================
-- INDEXES 
-- =======================================================

CREATE INDEX idx_property_landlord    ON property(landlord_id);
CREATE INDEX idx_unit_property        ON unit(property_id);
CREATE INDEX idx_contract_unit        ON contract(unit_id);
CREATE INDEX idx_contract_tenant      ON contract(tenant_id);
CREATE INDEX idx_rentcharge_contract  ON rentcharge(contract_id);
CREATE INDEX idx_rentcharge_due_date  ON rentcharge(due_date);
CREATE INDEX idx_payment_rentcharge   ON payment(rent_charge_id);
CREATE INDEX idx_notification_rent    ON rentcharge_notification(rent_charge_id);
