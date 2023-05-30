/*********************************************
 * UANL
 * FCFM
 * Maestría en Ciencias de Datos
 * 1421582. Claudia Lissette Gutiérrez Díaz
 ********************************************/

/*Creación de Base de Datos Servicio_Clientes*/
DROP DATABASE IF EXISTS Servicio_Clientes;
CREATE DATABASE Servicio_Clientes;

/*Inicio de uso de Base de Datos*/
USE Servicio_Clientes;

/*Eliminación de tablas */
DROP TABLE IF EXISTS Quejas;
DROP TABLE IF EXISTS Asunto_Subasunto;
DROP TABLE IF EXISTS Producto_Subproducto;
DROP TABLE IF EXISTS Sucursales;
DROP TABLE IF EXISTS Companias;
DROP TABLE IF EXISTS Estados;
DROP TABLE IF EXISTS Medios_Comunicacion;
DROP TABLE IF EXISTS Estatus_Quejas;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Subproductos;
DROP TABLE IF EXISTS Asuntos;
DROP TABLE IF EXISTS Subasuntos;


/*Compañías*/
CREATE TABLE Companias(
	id int NOT NULL auto_increment PRIMARY KEY,
	nombre varchar(100)
);

INSERT INTO Companias (nombre)
VALUES('Wells Fargo & Company'),
('Santander Bank US'),
('Franklin Credit Management'),
('Bank of America'),
('NRA Group, LLC'),
('SunTrust Banks, Inc.'),
('Citibank'),
('JPMorgan Chase & Co.'),
('Asset Management Professionals, LLC'),
('Ocwen'),
('Synchrony Financial'),
('Experian'),
('U.S. Bancorp'),
('Equifax'),
('Navient Solutions, Inc.'),
('Northland Group, Inc.'),
('Santander Consumer USA Holdings Inc'),
('Land/Home Financial Services'),
('Amex'),
('Nationstar Mortgage');

/*Estados*/
CREATE TABLE Estados(
	id int NOT NULL auto_increment PRIMARY KEY,
	nombre varchar(50),
	abreviacion varchar(2)
);

INSERT INTO Estados (nombre, abreviacion)
VALUES ('Armed Forces Americas', 'AA'),
('Armed Forces Canada', 'AE'),
('Alaska', 'AK'),
('Alabama', 'AL'),
('Armed Forces Pacific', 'AP'),
('Arkansas', 'AR'),
('American Samoa', 'AS'),
('Arizona', 'AZ'),
('California', 'CA'),
('Colorado', 'CO'),
('Connecticut', 'CT'),
('District of Columbia', 'DC'),
('Delaware', 'DE'),
('Florida', 'FL'),
('Federate States of Micronesia', 'FM'),
('Georgia', 'GA'),
('Guam', 'GU'),
('Hawaii', 'HI'),
('Iowa', 'IA'),
('Idaho', 'ID'),
('Illinois', 'IL'),
('Indiana', 'IN'),
('Kansas', 'KS'),
('Kentucky', 'KY'),
('Louisiana', 'LA'),
('Massachusetts', 'MA'),
('Maryland', 'MD'),
('Maine', 'ME'),
('Marshall Islands', 'MH'),
('Michigan', 'MI'),
('Minnesota', 'MN'),
('Missouri', 'MO'),
('Northern Mariana Islands', 'MP'),
('Mississippi', 'MS'),
('Montana', 'MT'),
('North Carolina', 'NC'),
('North Dakota', 'ND'),
('Nebraska', 'NE'),
('New Hampshire', 'NH'),
('New Jersey', 'NJ'),
('New Mexico', 'NM'),
('Nevada', 'NV'),
('New York', 'NY'),
('Ohio', 'OH'),
('Oklahoma', 'OK'),
('Oregon', 'OR'),
('Pennsylvania', 'PA'),
('Puerto Rico', 'PR'),
('Palau', 'PW'),
('Rhode Island', 'RI'),
('South Carolina', 'SC'),
('South Dakota', 'SD'),
('Tennessee', 'TN'),
('Texas', 'TX'),
('Utah', 'UT'),
('Virginia', 'VA'),
('Virgin Islands', 'VI'),
('Vermont', 'VT'),
('Washington', 'WA'),
('Wisconsin', 'WI'),
('West Virginia', 'WV'),
('Wyoming', 'WY');

/*Sucursales*/
CREATE TABLE Sucursales(
	id int NOT NULL auto_increment PRIMARY KEY,
	id_compania int,
	FOREIGN KEY (id_compania) REFERENCES Companias(id),
	id_estado int,
	FOREIGN KEY (id_estado) REFERENCES Estados(id),
	codigo_postal int
);

/*Ocupamos una temporal de transición*/
CREATE TABLE Temporal(
	nombre varchar(100),
	abreviacion varchar(2),
	codigo_postal int
);

INSERT INTO Temporal (nombre, abreviacion, codigo_postal)
VALUES ('Wells Fargo & Company', 'VA', 24540),
('Wells Fargo & Company', 'CA', 95992),
('Santander Bank US', 'NY', 10065),
('Wells Fargo & Company', 'GA', 30084),
('Franklin Credit Management', 'CT', 6106),
('Bank of America', 'TX', 75025),
('NRA Group, LLC', 'VA', 20147),
('SunTrust Banks, Inc.', 'FL', 32818),
('Citibank', 'OH', 45247),
('Wells Fargo & Company', 'NV', 89511),
('Bank of America', 'NC', 27949),
('JPMorgan Chase & Co.', 'CA', 90703),
('Citibank', 'CA', 95821),
('Asset Management Professionals, LLC', 'PA', 19145),
('Wells Fargo & Company', 'PA', 19145),
('JPMorgan Chase & Co.', 'NY', 14092),
('Ocwen', 'FL', 33426),
('JPMorgan Chase & Co.', 'NY', 10019),
('Citibank', 'NJ', 7604),
('Synchrony Financial', 'WA', 98548);

INSERT INTO Sucursales (id_compania, id_estado, codigo_postal)
SELECT c.id, e.id, t.codigo_postal
FROM Temporal t
INNER JOIN companias c
	ON c.nombre  = t.nombre
INNER JOIN estados e
	ON e.abreviacion  = t.abreviacion;
	
DROP TABLE Temporal;

/*Medios de Comunicación*/
CREATE TABLE Medios_Comunicacion(
	id int NOT NULL auto_increment PRIMARY KEY,
	nombre varchar(20)
);

INSERT INTO Medios_Comunicacion (nombre)
VALUES ('Phone'),
('Web'),
('Fax'),
('Referral'),
('Postal mail'),
('Email');

/*Estatus Quejas*/
CREATE TABLE Estatus_Quejas(
	id int NOT NULL auto_increment PRIMARY KEY,
	descripcion varchar(40)
);

INSERT INTO Estatus_Quejas (descripcion)
VALUES ('Closed with explanation'),
('Closed'),
('Closed with non-monetary relief'),
('Closed with monetary relief'),
('Untimely response'),
('Closed without relief'),
('Closed with relief'),
('In progress');

/*Productos*/
CREATE TABLE Productos(
	id int NOT NULL auto_increment PRIMARY KEY,
	nombre varchar(50)
);

INSERT INTO Productos (nombre)
VALUES ('Consumer Loan'),
('Bank account or service'),
('Mortgage'),
('Debt collection'),
('Credit card'),
('Credit reporting'),
('Student loan'),
('Money transfers'),
('Payday loan'),
('Other financial service'),
('Prepaid card'),
('Virtual currency');

/*Subproductos*/
CREATE TABLE Subproductos(
	id int NOT NULL auto_increment PRIMARY KEY,
	nombre varchar(50)
);

INSERT INTO Subproductos (nombre)
VALUES ('Vehicle loan'),
('Checking account'),
('Conventional fixed mortgage'),
('Other (i.e. phone, health club, etc.)'),
('I do not know'),
(''),
('Other mortgage'),
('Credit card'),
('Conventional adjustable mortgage (ARM)'),
('Other bank product/service'),
('Non-federal student loan'),
('FHA mortgage'),
('(CD) Certificate of deposit'),
('Home equity loan or line of credit'),
('Vehicle lease'),
('Savings account'),
('Federal student loan'),
('Mortgage'),
('Reverse mortgage'),
('Auto'),
('Installment loan'),
('Medical'),
('VA mortgage'),
('Domestic (US) money transfer'),
('International money transfer'),
('Personal line of credit'),
('Second mortgage'),
('Cashing a check without an account'),
('Payday loan'),
('Check cashing'),
('Mobile wallet'),
('Government benefit payment card'),
('Gift or merchant card'),
('General purpose card'),
('Title loan'),
('Foreign currency exchange'),
('Refund anticipation check'),
('Debt settlement'),
('Payroll card'),
('Other special purpose card'),
('ID prepaid card'),
('Credit repair'),
('Pawn loan'),
('Electronic Benefit Transfer / EBT card'),
('Money order'),
('Transit card'),
('Travelerâ€™s/Cashierâ€™s checks'),
('Federal student loan servicing');


/*Productos - Subproductos*/
CREATE TABLE Producto_Subproductos(
	id int NOT NULL auto_increment PRIMARY KEY,
	id_producto int,
	FOREIGN KEY (id_producto) REFERENCES Productos(id),
	id_subproducto int,
	FOREIGN KEY (id_subproducto) REFERENCES Subproductos(id)
);

/*Ocupamos una temporal de transición*/
CREATE TABLE Temporal (
	producto varchar(50),
	subproducto varchar(50)
);

INSERT INTO Temporal (producto, subproducto)
VALUES ('Consumer Loan', 'Vehicle loan'),
('Bank account or service', 'Checking account'),
('Mortgage', 'Conventional fixed mortgage'),
('Debt collection', 'Other (i.e. phone, health club, etc.)'),
('Debt collection', 'I do not know'),
('Credit card', ''),
('Mortgage', 'Other mortgage'),
('Debt collection', 'Credit card'),
('Credit reporting', ''),
('Mortgage', 'Conventional adjustable mortgage (ARM)'),
('Bank account or service', 'Other bank product/service'),
('Student loan', 'Non-federal student loan'),
('Mortgage', 'FHA mortgage'),
('Bank account or service', '(CD) Certificate of deposit'),
('Mortgage', 'Home equity loan or line of credit'),
('Consumer Loan', 'Vehicle lease'),
('Bank account or service', 'Savings account'),
('Debt collection', 'Federal student loan'),
('Debt collection', 'Mortgage'),
('Mortgage', 'Reverse mortgage'),
('Debt collection', 'Auto'),
('Consumer Loan', 'Installment loan'),
('Debt collection', 'Medical'),
('Debt collection', 'Non-federal student loan'),
('Mortgage', 'VA mortgage'),
('Money transfers', 'Domestic (US) money transfer'),
('Money transfers', 'International money transfer'),
('Consumer Loan', 'Personal line of credit'),
('Mortgage', 'Second mortgage'),
('Bank account or service', 'Cashing a check without an account'),
('Payday loan', 'Payday loan'),
('Debt collection', 'Payday loan'),
('Other financial service', 'Check cashing'),
('Prepaid card', 'Mobile wallet'),
('Prepaid card', 'Government benefit payment card'),
('Prepaid card', 'Gift or merchant card'),
('Prepaid card', 'General purpose card'),
('Consumer Loan', 'Title loan'),
('Other financial service', 'Foreign currency exchange'),
('Other financial service', 'Refund anticipation check'),
('Other financial service', 'Debt settlement'),
('Prepaid card', 'Payroll card'),
('Prepaid card', 'Other special purpose card'),
('Prepaid card', 'ID prepaid card'),
('Other financial service', 'Credit repair'),
('Consumer Loan', 'Pawn loan'),
('Prepaid card', 'Electronic Benefit Transfer / EBT card'),
('Other financial service', 'Money order'),
('Prepaid card', 'Transit card'),
('Other financial service', 'Travelerâ€™s/Cashierâ€™s checks'),
('Student loan', 'Federal student loan servicing'),
('Virtual currency', 'Domestic (US) money transfer'),
('Virtual currency', 'International money transfer');

INSERT INTO Producto_Subproductos (id_producto, id_subproducto)
SELECT p.id, s.id
FROM Temporal t
INNER JOIN Productos p
	ON p.nombre = t.producto
INNER JOIN Subproductos s
	ON s.nombre = t.subproducto;
	
DROP TABLE Temporal;

/*Asuntos*/
CREATE TABLE Asuntos(
	id int NOT NULL auto_increment PRIMARY KEY,
	descripcion varchar(50)
);

INSERT INTO Asuntos (descripcion)
VALUES ('Managing the loan or lease'),
('Using a debit or ATM card'),
('Account opening, closing, or management'),
('Deposits and withdrawals'),
('Loan servicing, payments, escrow account'),
('Cont''d attempts collect debt not owed'),
('Billing statement'),
('Loan modification,collection,foreclosure'),
('Communication tactics'),
('APR or interest rate'),
('Credit monitoring or identity protection'),
('Application, originator, mortgage broker'),
('Incorrect information on credit report'),
('Repaying your loan'),
('Delinquent account'),
('Problems caused by my funds being low'),
('Improper use of my credit report'),
('Settlement process and costs'),
('Billing disputes'),
('Credit line increase/decrease'),
('Payoff process'),
('Unable to get credit report/credit score'),
('Closing/Cancelling account'),
('Credit reporting company''s investigation'),
('Taking/threatening an illegal action'),
('Credit determination'),
('Identity theft / Fraud / Embezzlement'),
('Improper contact or sharing of info'),
('Disclosure verification of debt'),
('Transaction issue'),
('Balance transfer fee'),
('Other'),
('Problems when you are unable to pay'),
('Making/receiving payments, sending money'),
('Late fee'),
('Advertising and marketing'),
('Credit card protection / Debt protection'),
('Application processing delay'),
('Credit decision / Underwriting'),
('False statements or representation'),
('Customer service / Customer relations'),
('Incorrect/missing disclosures or info'),
('Cash advance'),
('Shopping for a loan or lease'),
('Other transaction issues'),
('Taking out the loan or lease'),
('Money was not available when promised'),
('Getting a loan'),
('Unsolicited issuance of credit card'),
('Privacy'),
('Bankruptcy'),
('Convenience checks'),
('Other fee'),
('Balance transfer'),
('Fraud or scam'),
('Overlimit fee'),
('Account terms and changes'),
('Forbearance / Workout plans'),
('Rewards'),
('Dealing with my lender or servicer'),
('Shopping for a line of credit'),
('Arbitration'),
('Other service issues'),
('Managing the line of credit'),
('Cash advance fee'),
('Can''t repay my loan'),
('Wrong amount charged or received'),
('Charged fees or interest I didn''t expect'),
('Can''t stop charges to bank account'),
('Can''t contact lender'),
('Applied for loan/did not receive money'),
('Sale of account'),
('Received a loan I didn''t apply for'),
('Payment to acct not credited'),
('Charged bank acct wrong day or amt'),
('Customer service/Customer relations'),
('Unauthorized transactions/trans. issues'),
('Managing, opening, or closing account'),
('Fees'),
('Unexpected/Other fees'),
('Lender repossessed or sold the vehicle'),
('Lost or stolen check'),
('Adding money'),
('Lender damaged or destroyed vehicle'),
('Advertising, marketing or disclosures'),
('Excessive fees'),
('Disclosures'),
('Lender sold the property'),
('Overdraft, savings or rewards features'),
('Incorrect exchange rate'),
('Lost or stolen money order'),
('Credit reporting'),
('Collection practices'),
('Collection debt dispute'),
('Lender damaged or destroyed property');

/*Subasuntos*/
CREATE TABLE Subasuntos(
	id int NOT NULL auto_increment PRIMARY KEY,
	descripcion varchar(50)
);

INSERT INTO Subasuntos (descripcion)
VALUES (''),
('Debt is not mine'),
('Debt was paid'),
('Frequent or repeated calls'),
('Problem cancelling or closing account'),
('Public record'),
('Repaying your loan'),
('Report improperly shared by CRC'),
('Threatened to take legal action'),
('Information is not mine'),
('Problem getting my free annual report'),
('Account status'),
('Problem with statement of dispute'),
('Sued w/o proper notification of suit'),
('Account terms'),
('No notice of investigation status/result'),
('Talked to a third party about my debt'),
('Not given enough info to verify debt'),
('Contacted me after I asked not to'),
('Debt was discharged in bankruptcy'),
('Problems when you are unable to pay'),
('Attempted to collect wrong amount'),
('Personal information'),
('Right to dispute notice not received'),
('Called after sent written cease of comm'),
('Problem getting report or credit score'),
('Sued where didn''t live/sign for debt'),
('Threatened to sue on too old debt'),
('Getting a loan'),
('Used obscene/profane/abusive language'),
('Threatened arrest/jail if do not pay'),
('Indicated committed crime not paying'),
('Investigation took too long'),
('Debt resulted from identity theft'),
('Contacted employer after asked not to'),
('Reinserted previously deleted info'),
('Called outside of 8am-9pm'),
('Billing dispute'),
('Inadequate help over the phone'),
('Received marketing offer after opted out'),
('Seized/Attempted to seize property'),
('Impersonated an attorney or official'),
('Need information about my balance/terms'),
('Problem with fraud alerts'),
('Not disclosed as an attempt to collect'),
('Attempted to/Collected exempt funds'),
('Account terms and changes'),
('Indicated shouldn''t respond to lawsuit'),
('Contacted me instead of my attorney'),
('Can''t get flexible payment options'),
('Report shared with employer w/o consent'),
('Charged fees or interest I didn''t expect'),
('Can''t stop charges to bank account'),
('Can''t contact lender'),
('Applied for loan/did not receive money'),
('Receiving unwanted marketing/advertising'),
('Received a loan I didn''t apply for'),
('Payment to acct not credited'),
('Received bad information about my loan'),
('Charged bank acct wrong day or amt'),
('Keep getting calls about my loan'),
('Trouble with how payments are handled'),
('Can''t temporarily postpone payments'),
('Can''t decrease my monthly payments'),
('Having problems with customer service'),
('Don''t agree with fees charged'),
('Can''t qualify for a loan'),
('Qualify for a better loan than offered'),
('Insurance terms');

/*Asuntos - Subasuntos*/
CREATE TABLE Asunto_Subasuntos(
	id int NOT NULL auto_increment PRIMARY KEY,
	id_asunto int,
	FOREIGN KEY (id_asunto) REFERENCES Asuntos(id),
	id_subasunto int,
	FOREIGN KEY (id_subasunto) REFERENCES Subasuntos(id)
);

/*Ocupamos una temporal de transición*/
CREATE TABLE Temporal (
	asunto varchar(50),
	subasunto varchar(50)
);

INSERT INTO Temporal (asunto, subasunto)
VALUES ('Managing the loan or lease', ''),
('Using a debit or ATM card', ''),
('Account opening, closing, or management', ''),
('Deposits and withdrawals', ''),
('Loan servicing, payments, escrow account', ''),
('Cont''d attempts collect debt not owed', 'Debt is not mine'),
('Cont''d attempts collect debt not owed', 'Debt was paid'),
('Billing statement', ''),
('Loan modification,collection,foreclosure', ''),
('Communication tactics', 'Frequent or repeated calls'),
('APR or interest rate', ''),
('Credit monitoring or identity protection', 'Problem cancelling or closing account'),
('Application, originator, mortgage broker', ''),
('Incorrect information on credit report', 'Public record'),
('Repaying your loan', 'Repaying your loan'),
('Delinquent account', ''),
('Problems caused by my funds being low', ''),
('Improper use of my credit report', 'Report improperly shared by CRC'),
('Settlement process and costs', ''),
('Billing disputes', '');

INSERT INTO Asunto_Subasuntos (id_asunto, id_subasunto)
SELECT a.id, s.id
FROM Temporal t
INNER JOIN Asuntos a
	ON a.descripcion = t.asunto
INNER JOIN subasuntos s
	ON s.descripcion = t.subasunto;

DROP TABLE Temporal;

/*Quejas*/

CREATE TABLE Quejas(
	id int NOT NULL auto_increment PRIMARY KEY,
	fecha_recepcion datetime,
	fecha_envio datetime,
	id_producto_subproducto int,
	FOREIGN KEY (id_producto_subproducto) REFERENCES Producto_Subproductos(id),
	id_asunto_subasunto int,
	FOREIGN KEY (id_asunto_subasunto) REFERENCES Asunto_Subasuntos(id),
	descripcion_queja varchar(3000),
	descripcion_solucion varchar(3000),
	id_sucursal int,
	FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id),
	etiquetas varchar(50),
	consentimiento_cliente TINYINT,
	id_medio_comunicacion int,
	FOREIGN KEY (id_medio_comunicacion) REFERENCES Medios_Comunicacion(id),
	id_estatus_queja int,
	FOREIGN KEY (id_estatus_queja) REFERENCES Estatus_Quejas(id),
	respuesta_a_tiempo TINYINT,
	se_abre_disputa tinyint
);

/*Tabla temporal de transición*/
CREATE TABLE Temporal(
	fecha_recepcion datetime,
	fecha_envio datetime,
	producto varchar(50),
	subproducto varchar(50),
	asunto varchar(50),
	subasunto varchar(50),
	descripcion_queja varchar(3000),
	descripcion_solucion varchar(3000),
	compania varchar(100),
	estado varchar(2),
	sucursal int,
	etiquetas varchar(50),
	consentimiento_cliente TINYINT,
	medio_comunicacion varchar(20),
	estatus_queja varchar(50),
	respuesta_a_tiempo TINYINT,
	se_abre_disputa tinyint
);

INSERT INTO Temporal (fecha_recepcion, fecha_envio, producto, subproducto, asunto, subasunto, descripcion_queja,
	descripcion_solucion, compania, estado, sucursal, etiquetas, consentimiento_cliente, medio_comunicacion,
	estatus_queja, respuesta_a_tiempo, se_abre_disputa)
VALUES ('2013-07-29', '2013-07-29', 'Consumer Loan', 'Vehicle loan', 'Managing the loan or lease', '', '', '', 'Wells Fargo & Company', 'VA', 24540, '', 0, 'Phone', 'Closed with explanation', 1, 0),
('2013-07-29', '2013-07-29', 'Bank account or service', 'Checking account', 'Using a debit or ATM card', '', '', '', 'Wells Fargo & Company', 'CA', 95992, 'Older American', 0, 'Web', 'Closed with explanation', 1, 0),
('2013-07-29', '2013-07-29', 'Bank account or service', 'Checking account', 'Account opening, closing, or management', '', '', '', 'Santander Bank US', 'NY', 10065, '', 0, 'Fax', 'Closed', 1, 0),
('2013-07-29', '2013-07-30', 'Bank account or service', 'Checking account', 'Deposits and withdrawals', '', '', '', 'Wells Fargo & Company', 'GA', 30084, '', 0, 'Web', 'Closed with explanation', 1, 0),
('2013-07-29', '2013-07-30', 'Mortgage', 'Conventional fixed mortgage', 'Loan servicing, payments, escrow account', '', '', '', 'Franklin Credit Management', 'CT', 6106, '', 0, 'Web', 'Closed with explanation', 1, 0),
('2013-07-29', '2013-07-30', 'Bank account or service', 'Checking account', 'Deposits and withdrawals', '', '', '', 'Bank of America', 'TX', 75025, '', 0, 'Web', 'Closed with explanation', 1, 0),
('2013-07-29', '2013-08-07', 'Debt collection', 'Other (i.e. phone, health club, etc.)', 'Cont''d attempts collect debt not owed', 'Debt is not mine', '', '', 'NRA Group, LLC', 'VA', 20147, '', 0, 'Web', 'Closed with non-monetary relief', 1, 0),
('2013-07-29', '2013-08-01', 'Debt collection', 'I do not know', 'Cont''d attempts collect debt not owed', 'Debt was paid', '', '', 'SunTrust Banks, Inc.', 'FL', 32818, '', 0, 'Referral', 'Closed with explanation', 1, 1),
('2013-07-29', '2013-07-30', 'Credit card', '', 'Billing statement', '', '', '', 'Citibank', 'OH', 45247, '', 0, 'Referral', 'Closed with explanation', 1, 1),
('2013-07-29', '2013-07-30', 'Mortgage', 'Other mortgage', 'Loan servicing, payments, escrow account', '', '', '', 'Wells Fargo & Company', 'NV', 89511, '', 0, 'Referral', 'Closed with explanation', 1, 1),
('2013-07-29', '2013-07-30', 'Mortgage', 'Other mortgage', 'Loan modification,collection,foreclosure', '', '', '', 'Bank of America', 'NC', 27949, '', 0, 'Referral', 'Closed with non-monetary relief', 1, 0),
('2013-07-29', '2013-07-30', 'Mortgage', 'Other mortgage', 'Loan servicing, payments, escrow account', '', '', '', 'JPMorgan Chase & Co.', 'CA', 90703, '', 0, 'Referral', 'Closed with explanation', 1, 0),
('2013-07-29', '2013-07-31', 'Mortgage', 'Other mortgage', 'Loan modification,collection,foreclosure', '', '', '', 'Citibank', 'CA', 95821, '', 0, 'Referral', 'Closed with explanation', 1, 1),
('2013-07-29', '2013-08-01', 'Debt collection', 'Credit card', 'Communication tactics', 'Frequent or repeated calls', '', '', 'Asset Management Professionals, LLC', 'PA', 19145, 'Older American', 0, 'Phone', 'Closed with explanation', 0, 0),
('2013-07-29', '2013-08-01', 'Debt collection', 'Credit card', 'Communication tactics', 'Frequent or repeated calls', '', '', 'Wells Fargo & Company', 'PA', 19145, 'Older American', 0, 'Phone', 'Closed with non-monetary relief', 1, 0),
('2013-07-29', '2013-07-31', 'Mortgage', 'Conventional fixed mortgage', 'Loan modification,collection,foreclosure', '', '', '', 'JPMorgan Chase & Co.', 'NY', 14092, '', 0, 'Phone', 'Closed with explanation', 1, 0),
('2013-07-29', '2013-07-31', 'Mortgage', 'Conventional fixed mortgage', 'Loan modification,collection,foreclosure', '', '', '', 'Ocwen', 'FL', 33426, '', 0, 'Web', 'Closed with explanation', 1, 1),
('2013-07-29', '2013-07-30', 'Mortgage', 'Conventional fixed mortgage', 'Loan modification,collection,foreclosure', '', '', '', 'JPMorgan Chase & Co.', 'NY', 10019, '', 0, 'Web', 'Closed with explanation', 1, 1),
('2013-07-29', '2013-07-30', 'Mortgage', 'Conventional fixed mortgage', 'Loan servicing, payments, escrow account', '', '', '', 'Citibank', 'NJ', 7604, '', 0, 'Web', 'Closed with explanation', 1, 0),
('2013-07-29', '2013-07-29', 'Credit card', '', 'APR or interest rate', '', '', '', 'Synchrony Financial', 'WA', 98548, '', 0, 'Web', 'Closed with monetary relief', 1, 0);

INSERT INTO Quejas (fecha_recepcion, fecha_envio, id_producto_subproducto, id_asunto_subasunto, descripcion_queja,
	descripcion_solucion, id_sucursal, etiquetas, consentimiento_cliente, id_medio_comunicacion,
	id_estatus_queja, respuesta_a_tiempo, se_abre_disputa)
SELECT t.fecha_recepcion, t.fecha_envio, ps.id, asu.id, t.descripcion_queja,
	t.descripcion_solucion, suc.id, t.etiquetas, t.consentimiento_cliente, mc.id,
	eq.id, t.respuesta_a_tiempo, t.se_abre_disputa
FROM Temporal t
INNER JOIN productos p
	ON p.nombre  = t.producto
INNER JOIN subproductos s
	ON s.nombre = t.subproducto
INNER JOIN producto_subproductos ps 
	ON ps.id_producto = p.id 
	AND ps.id_subproducto  = s.id
INNER JOIN asuntos a
	ON a.descripcion  = t.asunto
INNER JOIN subasuntos sa
	ON sa.descripcion = t.subasunto
INNER JOIN asunto_subasuntos asu 
	ON asu.id_asunto = a.id
	AND asu.id_subasunto = sa.id
INNER JOIN companias c 
	ON c.nombre  = t.compania
INNER JOIN estados e 
	ON e.abreviacion = t.estado
INNER JOIN sucursales suc
	ON suc.id_compania  = c.id 
	AND suc.id_estado  = e.id 
	AND suc.codigo_postal  = t.sucursal
INNER JOIN medios_comunicacion mc 
	ON mc.nombre  = t.medio_comunicacion
INNER JOIN estatus_quejas eq
	ON eq.descripcion = t.estatus_queja;

DROP TABLE Temporal;