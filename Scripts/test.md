### Data Dictionary for the gold layer

## Overview

The gold layer forms the business level data representation, structured to support reporting and analytical tasks. It consists of **dimension tables** and **fact tables** formatted for specific business use cases.

----------------------------------------------------------------------------------------------------------------------------------


| **Column Name** | **Data type** | **Description** |  
|-----------------|---------------|-----------------|
| customer_key    |  INT          |  Surrogate key used to uniquely intentify each record in the customers dimension.  |   
| customer_id     |  INT          |         Unique numerical identifier assigned to each customer. |   
| customer_number |  NVARCHAR(50) |  Unique alphanumeric identifier assigned to each customer, used for tracking and referencing.  |   
|    first_name | NVARCHAR(50) | First name of the customer, as recorded in the system. |
|    last_name | NVARCHAR(50) | Last name or family name of the customer, as recorded in the system. |
|    country | NVARCHAR(50) | Customers country of residence (e.g. 'Germany').|
|    marital_status | NVARCHAR(50) | Marital Status of the customer (e.g. 'Married' or 'Single'). |
|    gender | NVARCHAR(50) | Gender of the customer (e.g. 'Male' or 'Female'). |
|    birth_date | DATE | Birth date for the customer, recorded in the format YYYY-MM-DD (e.g. 1993-02-04). |
|    create_date | DATETIME2 | Date and time for creation of customer record inside the system. |
