### Data Dictionary for the gold layer

## Overview

The gold layer forms the business level data representation, structured to support reporting and analytical tasks. It consists of **dimension tables** and **fact tables** formatted for specific business use cases.

----------------------------------------------------------------------------------------------------------------------------------

#1. gold.dim_customers

- **Purpose**: Stores all relevant customer details from the database, organised in one table.
- **Columns**:


| **Column Name** | **Data type** | **Description** |  
|-----------------|---------------|-----------------|
| customer_key    |  INT          |  Surrogate key used to uniquely intentify each record in the customers dimension.  |   
| customer_id     |  INT          |         Unique numerical identifier assigned to each customer. |   
| customer_number |  NVARCHAR(50) |  Unique alphanumeric identifier assigned to each customer, used for tracking and referencing (e.g. 'AW00011000').  |   
|    first_name | NVARCHAR(50) | First name of the customer, as recorded in the system (e.g. 'Jon'). |
|    last_name | NVARCHAR(50) | Last name or family name of the customer, as recorded in the system (e.g. 'Yang'). |
|    country | NVARCHAR(50) | Customers country of residence (e.g. 'Germany').|
|    marital_status | NVARCHAR(50) | Marital Status of the customer ('Married' or 'Single'). |
|    gender | NVARCHAR(50) | Gender of the customer ('Male' or 'Female'). |
|    birth_date | DATE | Birth date for the customer, recorded in the format YYYY-MM-DD (e.g. 1993-02-04). |
|    create_date | DATETIME2 | Date and time for creation of customer record inside the system. |

----------------------------------------------------------------------------------------------------------------------------------

#2. gold.dim_products

- **Purpose**: Stores all relevant product details from the database, organised in one table with only up-to-date information included.
- **Columns**:


| **Column Name** | **Data type** | **Description** |  
|-----------------|---------------|-----------------|
| product_key    |  INT          |  Surrogate key used to uniquely intentify each record in the products dimension.  |   
| product_id     |  INT          |         Unique numerical identifier assigned to each product. |   
| product_number |  NVARCHAR(50) |  Unique alphanumeric identifier assigned to each product, used for tracking and referencing (e.g. 'FR-R92B-58').  |   
|    product_name | NVARCHAR(50) | Name of the product, as recorded in the system (e.g. 'HL Road Frame - Black- 58').|
|    category_id | NVARCHAR(50) | Unique alphanumeric identifier assigned to each product category. |
|    category | NVARCHAR(50) | Name of the product category (e.g. 'Bikes').|
|    sub_category | NVARCHAR(50) | Name of the product sub-category (e.g. 'Mountain Bikes'). |
|    maintenance_required | NVARCHAR(50) | Indicates if the product requires maintenance ('Yes' or 'No'). |
|    product_line | NVARCHAR(50) | The specific product line to which the product belongs (e.g. 'Road', 'Mountain'). |
|    cost | INT | The current cost of the product recorded in the system. |
|    start_date | DATE | The date in which the product became available for sale or use, stored in the format YYYY-MM-DD (e.g. 2003-07-01). |

----------------------------------------------------------------------------------------------------------------------------------

#3. gold.fact_sales

- **Purpose**: Stores records of each sales interaction, with transactional data.
- **Columns**:


| **Column Name** | **Data type** | **Description** |  
|-----------------|---------------|-----------------|
| order_number    |  NVARCHAR(50)         |  Unique alphanumeric identifier for each sales order (e.g. 'SO43697')  |   
| product_key    |  INT          |    Surrogate key linking the order to the products dimension table. |   
| customer_key |  INT |  Surrogate key linking the order to the customers dimension table.  |   
|    order_date | DATE | Date the order was placed, stored in the format YYYY-MM-DD (e.g. '2010-12-29'). |
|    shipping_date | DATE | Date the order was shipped, stored in the format YYYY-MM-DD (e.g. '2010-12-29'). |
|    due_date | DATE | Date the order is due for delivery, stored in the format YYYY-MM-DD (e.g. '2010-12-29').|
|    sales_amount | INT | The total monetary amount of the sales transaction. |
|    quantity | INT | The total quantity of the product ordered in the sales transaction. |
|    price | INT | The price of the product ordered in the sales transaction, per product unit. |



