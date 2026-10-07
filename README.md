# SQL_Data_Warehouse_Project
Personal Project. Creating a SQL Data Warehouse with dummy data, using SQL server. For learning and practice purposes.

Building a Data Warehouse following medallion architecture, with source data coming from csv files. Project covers loading and processing of data in the first layer, performing data cleaning and data enrichment processes to standardize the data in the second layer, and finally building business ready views and tables with aggregations and advanced business logics in the final layer. 

(Project in Progress)

----------------------------------------------------------------------------------------------------------

# Sources

The data comes from two source files, 'source_crm' and 'source_erp', located in the Datasets folder of this project. The data is represented using csv files, and is not intended to be representative of any real world business.

-----------------------------------------------------------------------------------------------------------

# Warehouse Architecture

This Data Warehouse follows a medallion architectural scheme, composed of three layers in which the data is processed:

- **Bronze Layer**: This is the first, or lower, level of the Data Warehouse. The purpose of this layer is to import data from the source into the warehouse, maintaining the structure of the source data without any modifications.

-  **Silver Layer**: This is the second, or middle, level of the Data Warehouse. The purpose of this layer is to perform data cleaning on the incoming source data. First, the data is loaded in from the bronze layer tables, and then modifications are performed on the new silver layer tables to prepare and structure the data for analytical use. Modifications include the introduction of new columns for combining tables, trimming and reformatting qualitative values, replacement of Nulls where appropriate following business rules, and removal of duplicate entries.

-   **Gold Layer**: This is the third, or top, level of the Data Warehouse. The purpose of this layer is use data in the silver layer to prepare a series of views, following a star schema, ready to use for business analytics and reporting. No data is loaded in this layer. Instead, data from the silver tables is aggregated and reorganised into a central fact view detailing sales figures, with two branching dimension views containing detailed information about the customers and products.



