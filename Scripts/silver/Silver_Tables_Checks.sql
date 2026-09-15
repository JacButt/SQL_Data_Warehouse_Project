/*

--------------------------------------------------------------------
Data quality checks for silver layer tables
--------------------------------------------------------------------

The purpose of this script is to perform a series of quality checks on the silver layer tables, to check for any issues with the modifications done to data being loaded from the bronze tables.


*/

USE ProjectDataWarehouse;
GO

---------------------------------------------------------------------
--- Checking Table silver.crm_cust_info
---------------------------------------------------------------------

-- Checking for Null or duplicate entries in the primary key
-- Expectation: No results

SELECT
	cst_id,
	COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING cst_id IS NULL OR COUNT(*) > 1

-- Checking for empty spaces in the string value
-- Expectation: no results

SELECT
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr
FROM silver.crm_cust_info
WHERE TRIM(cst_firstname) != cst_firstname OR TRIM(cst_lastname) != cst_lastname 
	OR TRIM(cst_marital_status) != cst_marital_status OR TRIM(cst_gndr) != cst_gndr

-- Checking for consistency with gndr column
-- Expectation: No more than three distinct values, 'Male', 'Female', and 'N/A'

SELECT DISTINCT
	cst_gndr
FROM silver.crm_cust_info

-- Checking for consistency with marital_status column
-- Expectation: No more than three distinct values, 'Married', 'Single', and 'N/A'

SELECT DISTINCT
	cst_marital_status
FROM silver.crm_cust_info


---------------------------------------------------------------------
--- Checking Table silver.crm_prd_info
---------------------------------------------------------------------

-- Checking for Null or duplicate entries in the primary key
-- Expectation: No results

SELECT
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING prd_id IS NULL OR COUNT(*) > 1

-- Checking for empty spaces in the string value
-- Expectation: no results

SELECT
	prd_nm
FROM silver.crm_prd_info
WHERE TRIM(prd_nm) != prd_nm

-- Checking for Nulls and negative values in the prd_cost column
-- Expectation: No results

SELECT
	prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0

-- Checking for consistency with prd_line column
-- Expectation: No more than five distinct values, 'Mountain', 'Road', 'Touring', 'Other Sales' and 'N/A'

SELECT DISTINCT
	prd_line
FROM silver.crm_prd_info

-- Checking prd_start_dt and prd_end_dt columns, to see if any end dates come before start dates, or any start dates are Null
-- Expectation: No results

SELECT
	prd_start_dt,
	prd_end_dt
FROM silver.crm_prd_info
WHERE prd_start_dt IS NULL OR prd_end_dt < prd_start_dt

---------------------------------------------------------------------
--- Checking Table silver.crm_sales_details
---------------------------------------------------------------------

-- Checking consistency with the key sls_cust_id used to join with the silver.crm_cust_info table 
-- Expectation: No results

SELECT
	sls_cust_id
FROM silver.crm_sales_details
WHERE sls_cust_id NOT IN (
	SELECT
		cst_id
	FROM silver.crm_cust_info
);

-- Checking consistency with the key sls_prd_key used to join with the silver.crm_prd_info table 
-- Expectation: No results

SELECT
	sls_prd_key
FROM silver.crm_sales_details
WHERE sls_prd_key NOT IN (
	SELECT
		prd_key
	FROM silver.crm_prd_info
); 

-- Checking for Null or negative values in the sales, quantity, and price columns
-- Expectation: No results

SELECT
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_quantity IS NULL OR sls_quantity < 0 OR sls_sales IS NULL
	OR sls_sales < 0 OR sls_price IS NULL OR sls_price < 0;

-- Checking relationship between sales, quantity, and price. Want Sales = Price * Quantity.
-- Expectation: No results

SELECT
	sls_sales,
	sls_quantity,
	sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_price * sls_quantity;


---------------------------------------------------------------------
--- Checking Table silver.erp_cust_az12
---------------------------------------------------------------------

-- Checking consistency with the key cid used to join with crm_cust_info
-- Expectation: No results

SELECT
	cid
FROM silver.erp_cust_az12
WHERE cid NOT IN (
	SELECT
		cst_key
	FROM silver.crm_cust_info
)

-- Checking consistency with bdate, should not have any dates in the future.
-- Expectation: No results

SELECT
	bdate
FROM silver.erp_cust_az12
WHERE bdate > GETDATE();

-- Checking for consistency in gen (gender) column.
-- Expectation: No more than 3 distinct values: 'Male', 'Female', and 'N/A'

SELECT 
	DISTINCT gen
FROM silver.erp_cust_az12;


---------------------------------------------------------------------
--- Checking Table silver.erp_loc_a101
---------------------------------------------------------------------


-- Checking consistency in the key cid used to join with crm_cust_info table
-- Expectation: No results

SELECT
	cid
FROM silver.erp_loc_a101
WHERE cid NOT IN (
	SELECT 
		cst_key
	FROM silver.crm_cust_info
);

-- Checking consistency in cntry column. 
-- Expectation: Full Country names with capitalised first letter (e.g. 'Germany') or 'N/A'

SELECT
	DISTINCT cntry
FROM silver.erp_loc_a101;


---------------------------------------------------------------------
--- Checking Table silver.erp_px_cat_g1v2
---------------------------------------------------------------------

-- Checking for unwanted spaces in qualitative columns
-- Expectation: No results

SELECT
	cat,
	subcat,
	maintenance
FROM silver.erp_px_cat_g1v2
WHERE TRIM(cat) != cat OR TRIM(subcat) != subcat OR TRIM(maintenance) != maintenance;

-- Checking consistency in cat column.
-- Expectation: Full category name with capitalised first letter (e.g. 'Bikes')

SELECT
	DISTINCT cat
FROM silver.erp_px_cat_g1v2;

-- Checking consistency in subcat column.
-- Expectation: Full category name with capitalised first letter (e.g. 'Bike Racks')

SELECT
	DISTINCT subcat
FROM silver.erp_px_cat_g1v2;

-- Checking consistency in maintenance column.
-- Expectation: 'No' or 'Yes'

SELECT
	DISTINCT maintenance
FROM silver.erp_px_cat_g1v2;
