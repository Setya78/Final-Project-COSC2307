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

