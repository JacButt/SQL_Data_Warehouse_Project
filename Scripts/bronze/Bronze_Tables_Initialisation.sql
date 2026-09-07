/*
-------------------------------------------------
For Initialisation of empty database tables corresponding to source csv files
-------------------------------------------------

This script checks to see if any table matching the source file already exists in the database, and drops it if so.
It then creates a new empty table with columns matching that of the source file, following the naming convention bronze.<source_name>_<file_name>.
This process is repeated individually to create a table matching each file in the source systems 'crm' and 'erp'.

WARNING:

	This script drops all data from the tables ('bronze.crm_cust_info', 'bronze.crm_prd_info', 'bronze.crm_sales_details', 
	'bronze.erp_cust_az12', 'bronze.erp_loc_a101', 'bronze.erp_px_cat_g1v2'). Take caution to ensure any relevant data is backed up before executing.

*/



USE ProjectDataWarehouse;
GO




IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info (
	cst_id				INT,
	cst_key				NVARCHAR(50),
	cst_firstname		NVARCHAR(50),
	cst_lastname		NVARCHAR(50),
	cst_marital_status	NVARCHAR(50),
	cst_gndr			NVARCHAR(50),
	cst_create_date		DATE
);


IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
	prd_id				INT,
	prd_key				NVARCHAR(50),
	prd_nm				NVARCHAR(50),
	prd_cost			INT,
	prd_line			NVARCHAR(50),
	prd_start_dt		DATETIME,
	prd_end_dt			DATETIME
);


IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
	sls_ord_num			NVARCHAR(50),
	sls_prd_key			NVARCHAR(50),
	sls_cust_id			INT,
	sls_order_dt		INT,
	sls_ship_dt			INT,
	sls_due_dt			INT,
	sls_sales			INT,
	sls_quantity		INT,
	sls_price			INT
);


IF OBJECT_ID ('bronze.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12 (
	cid					NVARCHAR(50),
	bdate			DATE,
	gen					NVARCHAR(50)
);


IF OBJECT_ID ('bronze.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101(
	cid					NVARCHAR(50),
	cntry				NVARCHAR(50)
);


IF OBJECT_ID ('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2 (
	id					NVARCHAR(50),
	cat					NVARCHAR(50),
	subcat				NVARCHAR(50),
	maintenance			NVARCHAR(50)
);