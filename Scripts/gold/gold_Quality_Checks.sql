/*

--------------------------------------------------------------------------
Gold Layer Quality Checks
--------------------------------------------------------------------------

The purpose of this script is to run a series of checks on the data quality of the gold layer. 
In particular we check for the uniqueness of primary keys, proper formatting for the qualitative columns (no unwanted spaces, no repetition, correct capitalisation etc),
and for constistency in sales figures (no negative values, correct business logics are followed etc).

This script should be run after new data is loaded into the warehouse, to help check for any data quality issues that could affect reporting and analysis.


*/


USE ProjectDataWarehouse;
GO

---------------------------------------------------------------
-- Checks for gold.dim_customers
---------------------------------------------------------------

-- Checking for uniqueness of customer key 
-- Expectation: No results

SELECT
	customer_key,
	COUNT(*)
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- Checking for unwanted spacing in qualitative columns
-- Expectation: No results

SELECT
	customer_number,
	first_name,
	last_name,
	country,
	marital_status,
	gender
FROM gold.dim_customers
WHERE TRIM(customer_number) != customer_number OR TRIM(first_name) != first_name OR TRIM(last_name) != last_name
	OR TRIM(country) != country OR TRIM(marital_status) != marital_status OR TRIM(gender) != gender;


-- Checking customer number, should be a 10 digit code
-- Expectation: No results

SELECT
	customer_number
FROM gold.dim_customers
WHERE LEN(customer_number) != 10;

-- Checking possible values for customer country
-- Expectation: Full country names with capitalised first letter (e.g. 'Canada') or 'N/A'

SELECT DISTINCT
	country
FROM gold.dim_customers;

-- Checking possible values for customer marital status
-- Expectation: 'Married', 'Single' or 'N/A'

SELECT DISTINCT
	marital_status
FROM gold.dim_customers;

-- Checking possible values for customer gender
-- Expectation: 'Male', 'Female', or 'N/A'

SELECT DISTINCT
	gender
FROM gold.dim_customers;

-- Checking consistency of customer birth dates, customers should not have birth dates in the future.
-- Expectation: No results

SELECT 
	birth_date
FROM gold.dim_customers
WHERE birth_date > GETDATE();



---------------------------------------------------------------
-- Checks for gold.dim_products
---------------------------------------------------------------


-- Checking for uniqueness of product key 
-- Expectation: No results

SELECT
	product_key,
	COUNT(*)
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- Checking for unwanted spacing in qualitative columns
-- Expectation: No results

SELECT
	product_number,
	product_name,
	category_id,
	category,
	sub_category,
	maintenance,
	product_line
FROM gold.dim_products
WHERE TRIM(product_number) != product_number OR TRIM(product_name) != product_name OR TRIM(category_id) != category_id OR TRIM(category) != category
		OR TRIM(sub_category) != sub_category OR TRIM(maintenance) != maintenance OR TRIM(product_line) != product_line;


-- Checking costs, should not be negative or Null
-- Expectation: No results

SELECT
	cost
FROM gold.dim_products
WHERE cost < 0 OR cost IS NULL


-- Checking start_date, should be before current date
-- Expectation: No results

SELECT
	start_date
FROM gold.dim_products
WHERE start_date > GETDATE();



---------------------------------------------------------------
-- Checks for gold.fact_sales
---------------------------------------------------------------

-- Checking consistency with sales_amount, quantity, and price. Should have no null values or negative numbers
-- Expectation: No results

SELECT
	sales_amount,
	quantity,
	price
FROM gold.fact_sales
WHERE sales_amount < 0 OR sales_amount IS NULL OR quantity < 0 OR quantity IS NULL OR price < 0 OR price IS NULL;

-- Checking business logic for sales. Should have sales amount = quantity * price
-- Expectation: No results

SELECT
	sales_amount,
	quantity,
	price
FROM gold.fact_sales
WHERE sales_amount != quantity * price;

-- Checking consistency in dates: should not have shipping and order dates in the future, and should have order date before shipping date before due date
-- Expectation: No results

SELECT
	order_date,
	shipping_date,
	due_date
FROM gold.fact_sales
WHERE shipping_date > GETDATE() OR order_date > GETDATE() OR order_date > shipping_date OR order_date > due_date OR shipping_date > due_date;

