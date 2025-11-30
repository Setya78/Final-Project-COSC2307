--=========================================
--1. REFERENCE / LOOKUP TABLES
--=========================================

--1.1 PENALTY RULE

CREATE TABLE penaltyrule (
	penalty_rule_id		SERIAL PRIMARY KEY,
	penalty_type 		VARCHAR(100), 		--FIXED/PERCENTAGE
	penalty_amount		NUMERIC(10,2),
	grace_period_days	INT,
	rule_description	TEXT
);

--1.2 BILLING CYCLE TYPE 

CREATE TABLE billingcycletype (
	billing_cycle_type_id	SERIAL PRIMARY KEY,
	name_billing_cycle 		VARCHAR(50), 		 -- 'MONTHLY', 'WEEKLY', ...
	description		    	TEXT
);

--1.3 CONTRACT STATUS

CREATE TABLE contractstatus (
	contract_status_id		SERIAL PRIMARY KEY,
	status_code 			VARCHAR(100), 		--'ACTIVE', 'ENDED', 'CANCELLED', ...
	description				TEXT
);

--1.4 CHARGE STATUS

CREATE TABLE chargestatus (
	charge_status_id		SERIAL PRIMARY KEY,
	status_code 			VARCHAR(100), 		--'OPEN', 'PARTIALLY_PAID', 'PAID', ...
	description				TEXT
);

--1.5 PAYMENT METHOD

CREATE TABLE paymentmethod (
	payment_method_id		SERIAL PRIMARY KEY,
	method_code 			VARCHAR(100), 		--'CASH', 'INTERAC', 'BANK_TRANSFER', ...
	description				TEXT
);


--=========================================
--2. MASTER DATA
--=========================================

--2.1 LANDLORD

CREATE TABLE landlord (
	landlord_id		SERIAL PRIMARY KEY,
	first_name 		VARCHAR(100) NOT NULL,
	last_name		VARCHAR(100) NOT NULL,
	business_name	VARCHAR(150),
	email			VARCHAR(150)UNIQUE NOT NULL,
	phone			VARCHAR(20),
	interac_contact	VARCHAR(150)
);

--1.2 PROPERTY
CREATE TABLE property (
	property_id		SERIAL PRIMARY KEY,
	landlord_id 	INT NOT NULL REFERENCES landlord(landlord_id),
	property_name	VARCHAR(150),
	property_type	VARCHAR(50),
	full_address	TEXT,
	post_code		VARCHAR(15)
);

--1.3 UNIT
CREATE TABLE unit (
	unit_id			SERIAL PRIMARY KEY,
	property_id 	INT NOT NULL REFERENCES property(property_id),
	unit_code		VARCHAR(50),
	capacity		INT,
	unit_type		VARCHAR(50),
	unit_status		VARCHAR(50)
);

--1.4 TENANT
CREATE TABLE tenant (
	tenant_id			SERIAL PRIMARY KEY,
	first_name      	 VARCHAR(100) NOT NULL,
    last_name       	 VARCHAR(100) NOT NULL,
    tenant_occupation 	VARCHAR(100),
    email           	 VARCHAR(150) UNIQUE,
    phone           	 VARCHAR(20),
    id_type          	VARCHAR(50),
    id_number        	VARCHAR(100)
);

--=========================================
--3. CORE TRANSACTION TABLES
--=========================================

--3.1 CONTRACT
CREATE TABLE contract (
	contract_id				SERIAL PRIMARY KEY,
	unit_id			 		INT NOT NULL REFERENCES unit(unit_id),
    tenant_id       		INT NOT NULL REFERENCES tenant(tenant_id),
    penalty_rule_id			INT NOT NULL REFERENCES penaltyrule(penalty_rule_id),
    billing_cycle_type_id	INT NOT NULL REFERENCES billingcycletype(billing_cycle_type_id),
	start_date				DATE NOT NULL,
	end_date				DATE,
	base_rent_amount		NUMERIC(10,2) NOT NULL,
	billing_day				INT, 			--1-31 invoicing day
	contract_status_id		INT NOT NULL REFERENCES contractstatus(contract_status_id),

--Security deposit
	security_deposit_amount			NUMERIC(10,2),
	security_deposit_status 		VARCHAR(50), --HELD/PARTIAL_REFUND/FULL_REFUND/FORFEITED
	security_deposit_received_date	DATE,
	security_deposit_refund_date	DATE,

--Reminder configuration
	reminder_days_before_due		INT,	--example 3 days before due date
	reminder_days_after_due			INT,	--example 5 days after due date

	CHECK (billing_day IS NULL OR (billing_day BETWEEN 1 AND 31))
);

--3.2 RENT CHARGE
CREATE TABLE rentcharge (
	rent_charge_id			SERIAL PRIMARY KEY,
	contract_id				INT NOT NULL REFERENCES contract(contract_id),
	charge_period			VARCHAR(20),		--example '2025-Jan'
	period_start			DATE,
	period_end				DATE,
	due_date				DATE,
	base_amount				NUMERIC(10,2),
	penalty_amount			NUMERIC(10,2),
	total_amount_due		NUMERIC(10,2),
	charge_status_id		INT REFERENCES chargestatus(charge_status_id),


	--Invoice Fields
	invoice_number			VARCHAR(50) UNIQUE,
	invoice_sent_at			TIMESTAMP,
	last_reminder_sent_at	TIMESTAMP
);

--3.3 PAYMENT
CREATE TABLE payment (
	payment_id				SERIAL PRIMARY KEY,
	rent_charge_id			INT NOT NULL REFERENCES rentcharge(rent_charge_id),
	payment_date			DATE,
	amount_paid				NUMERIC(10,2),
	payment_method_id		INT NOT NULL REFERENCES paymentmethod(payment_method_id),
	payment_status			VARCHAR(50),  --'POSTED, 'PENDING, 'VOID','...'
	payment_category		VARCHAR(50),  --'RENT'. 'SECURITY DEPOSIT IN', 'SECURITY DEPOSIT REFUND', '...' 
	reference_number 		VARCHAR(100)  --bank/e transfer reference number

);


--=========================================
--4. UNIT ASSET AND UTILITY
--=========================================

--4.1 UNIIT ASSET
CREATE TABLE unitasset (
	unit_asset_id			SERIAL PRIMARY KEY,
	unit_id					INT NOT NULL REFERENCES unit(unit_id),
	asset_name				VARCHAR(150),
	quantity				INT,
	condition				VARCHAR(100)
);

--4.2 UNIIT UTILITY
CREATE TABLE unitutility (
	unit_utility_id			SERIAL PRIMARY KEY,
	unit_id					INT NOT NULL REFERENCES unit(unit_id),
	utility_type			VARCHAR(100), --Hydro, Gas, Electricity, Internet, ...
	billing_method			VARCHAR(100) --include in rent, separate bill, etc
);


--=========================================
--5. NOTIFICATION LOG (EMAIL / REMINDER)
--=========================================

CREATE TABLE rentcharge_notification (
	notification_id			SERIAL PRIMARY KEY,
	rent_charge_id			INT NOT NULL REFERENCES rentcharge(rent_charge_id),
	notification_type		VARCHAR(30) NOT NULL, -- INOVICE SENT, DUE REMINDER, ...
	channel					VARCHAR(20) NOT NULL,  --Email, ...
	sent_at					TIMESTAMP NOT NULL,
	status					VARCHAR(20) NOT NULL,  --SUCCESS, FAILED
	error_message			TEXT
);


-- =======================================================
-- 6. INDEXES 
-- =======================================================

CREATE INDEX idx_property_landlord    ON property(landlord_id);
CREATE INDEX idx_unit_property        ON unit(property_id);
CREATE INDEX idx_contract_unit        ON contract(unit_id);
CREATE INDEX idx_contract_tenant      ON contract(tenant_id);
CREATE INDEX idx_rentcharge_contract  ON rentcharge(contract_id);
CREATE INDEX idx_rentcharge_due_date  ON rentcharge(due_date);
CREATE INDEX idx_payment_rentcharge   ON payment(rent_charge_id);
CREATE INDEX idx_notification_rent    ON rentcharge_notification(rent_charge_id);
