------------------
--- Creating empty Data Warehouse
------------------

USE master;

CREATE DATABASE ProjectDataWarehouse;

USE ProjectDataWarehouse;

----------------------
--- Creating schema for each planned layer
----------------------

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO