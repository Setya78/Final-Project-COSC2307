--=========================================
--1. REFERENCE / LOOKUP TABLES
--=========================================

--1.1 PENALTY RULE

CREATE TABLE penaltyrule (
	penalty_rule_id		SERIAL PRIMARY KEY,
	penalty_type 		VARCHAR(100), 		--FIXED/PERCENTAGE
	penalty_amount		NUMERIC(10,2),
	grace_period_days	INT,
	rule_description	TEXT,
);




--=========================================
--1. MASTER DATA
--=========================================

--1.1 LANDLORD

CREATE TABLE landlord (
	landlord_id		SERIAL PRIMARY KEY,
	first_name 		VARCHAR(100) NOT NULL,
	last_name		VARCHAR(100) NOT NULL,
	business_name	VARCHAR(150),
	email			VARCHAR(150)UNIQUE NOT NULL,
	phone			VARCHAR(20),
	interac_contact	VARCHAR(150),
);

--1.2 PROPERTY
CREATE TABLE property (
	property_id		SERIAL PRIMARY KEY,
	lanlord_id 		INT NOT NULL REFERENCES landlord(lanlord_id),
	property_name	VARCHAR(150),
	property_type	VARCHAR(50),
	full_address	TEXT,
	post_code		VARCHAR(15),
);

-- 1.3 UNIT
CREATE TABLE unit (
	unit_id 		SERIAL NUMBER KEY,
	)
