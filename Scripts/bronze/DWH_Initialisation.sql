/*
-------------------------------------------------
For Initialisation of Database and Schemas
-------------------------------------------------

This script is used to create a new database titled 'ProjectDataWarehouse' after checking if it already exists.
If the database does already exist, it is dropped and recreated.
After this, the script creates three schemas inside the database, titled 'bronze', 'silver', and 'gold'

WARNING:

	Running this script will drop the entirety of 'ProjectDataWarehouse' if it already exists.
	Take caution when executing and ensure that any existing data is properly backed up beforehand.

*/

USE master;
GO

--------------------------------
--- Checking for existence of current Database
--------------------------------

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'ProjectDataWarehouse')
BEGIN
	ALTER DATABASE ProjectDataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE ProjectDataWarehouse;
END;
GO

-------------------------------
--- Creating the Database ProjectDataWarehouse
-------------------------------

CREATE DATABASE ProjectDataWarehouse;

USE ProjectDataWarehouse;

----------------------------------
--- Creating schemas for each planned layer in the Data Warehouse
----------------------------------

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
