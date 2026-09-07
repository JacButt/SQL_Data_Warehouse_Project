/*
------------------------------------------------------
Bulk loading source data into bronze layer tables
------------------------------------------------------

This script defines a stored procedure 'bronze.load_bronze' that can be executed to bulk load the source data into the bronze layer data warehouse tables.
Each table is first truncated before the source data is loaded into the now emptied table, with the stored procedure tracking the time spent loading data into each table as well as the total execution time.

WARNING:

	This script truncates the bronze layer tables ('bronze.crm_cust_info', 'bronze.crm_prd_info', 'bronze.crm_sales_details', 
	'bronze.erp_cust_az12', 'bronze.erp_loc_a101', 'bronze.erp_px_cat_g1v2') before loading, removing any data contained inside. 
	Please ensure any relevant pre-existing data from these tables is backed up before executing this script or the stored procedure 'bronze.load_bronze'.
*/



USE ProjectDataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @overall_start_time DATETIME, @overall_end_time DATETIME;
	DECLARE @start_time DATETIME, @end_time DATETIME;

	BEGIN TRY
		PRINT '--------------------------';
		PRINT 'Loading Bronze Layer';
		PRINT '--------------------------';

		PRINT '--------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------';

		SET @overall_start_time = GETDATE();

		-----------------------------------------
		--- crm_cust_info table
		-----------------------------------------

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data into Table: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\jacob\Documents\sql project resources\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------------------------';

		-----------------------------------------
		--- crm_prd_info table
		-----------------------------------------

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data into Table: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\jacob\Documents\sql project resources\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------------------------';


		-----------------------------------------
		--- crm_sales_details table
		-----------------------------------------

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data into Table: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\jacob\Documents\sql project resources\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------------------------';


		PRINT '--------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------';

		-----------------------------------------
		--- erp_cust_az12 table
		-----------------------------------------

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_CUST_AZ12;

		PRINT '>> Inserting Data into Table: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\jacob\Documents\sql project resources\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------------------------';


		-----------------------------------------
		--- erp_loc_a101 table
		-----------------------------------------

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_LOC_A101;

		PRINT '>> Inserting Data into Table: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\Users\jacob\Documents\sql project resources\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------------------------';


		-----------------------------------------
		--- erp_PX_CAT_G1V2 table
		-----------------------------------------

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

		PRINT '>> Inserting Data into Table: bronze.erp_px_cat_g1v2'
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\Users\jacob\Documents\sql project resources\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------------------------';

		SET @overall_end_time = GETDATE();
		PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(second, @overall_start_time, @overall_end_time) AS NVARCHAR) + ' seconds';

	END TRY

	BEGIN CATCH
		PRINT '----------------------------------';
		PRINT 'Error occured during loading bronze layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '----------------------------------';
	END CATCH
END

--------------------------------
--- Stored procedure execution command, uncomment to execute
--------------------------------

--- EXEC bronze.load_bronze