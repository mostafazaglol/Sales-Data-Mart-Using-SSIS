# Sales-Data-Mart-Using-SSIS

1. Data Source & Destination
Source: AdventureWorks2014 database

Destination: Eo-AdventureWorksDW2014 (Data Warehouse)

2. Data Modeling (Star Schema)
Dimension Tables: Dim_Product, Dim_Customer, Dim_Territory, Dim_Date

Fact Table: Fact_Sales

Each dimension includes:

Primary Keys, Foreign Keys

Source System Code

Slowly Changing Dimension (SCD) fields: Start_Date, End_Date, Is_Current

Indexes for performance

3. SSIS ETL Process
Built using SSIS Project, connecting with OLE DB to Source and Destination

4. ETL for Each Table
a. Dim_Product / Dim_Customer
OLE DB Source → Lookup (join with other tables)

Derived Columns (replace NULLs)

SCD Transformation (Type 0, 1, 2)

Load to DW

b. Dim_Date
Generated using Python script (2000–2030)

Used Data Conversion for correct types

Load to DW

c. Dim_Territory
Created Lookup_Country table

Joined with source to replace country codes with full names

Load to DW

d. Fact_Sales
Joined SalesOrderHeader and SalesOrderDetail using Merge Join

Sorted data by SalesOrderID (using SortKeyPosition)

Lookups for dimension keys (with Ignore Failure)

Derived Columns for calculated fields (Extended_Sales, Extended_Cost)

Load to DW

5. Full Load vs Incremental Load
Full Load:
Truncate Fact_Sales before load (via Execute SQL Task)

Reload all data every run

Incremental Load:
Created meta_control_table with last_load_date

Compare ModifiedDate with:

last_load_date

current_run_time

Updated last_load_date after each run

Only new/updated rows are loaded

Ensures efficient incremental updates

Notes
Used 31/12/2099 as default to detect errors in loading

All lookups handled unknown values with default ID = 0
