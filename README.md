# 📊 Sales Data Mart Using SSIS

This project demonstrates how to build a **Sales Data Mart** using **SQL Server Integration Services (SSIS)** and the **AdventureWorks2014** database as the data source. It includes **data modeling**, **ETL development**, and both **full and incremental data loading** strategies.

---

## 🏗️ Project Structure

- **Source Database**: `AdventureWorks2014`
- **Destination Data Warehouse**: `Eo-AdventureWorksDW2014`

---

## ⭐ Data Modeling (Star Schema)

- **Dimension Tables**:
  - `Dim_Product`
  - `Dim_Customer`
  - `Dim_Territory`
  - `Dim_Date`
- **Fact Table**:
  - `Fact_Sales`

> All dimension tables include:
> - Primary Keys & Foreign Keys  
> - Source System Code  
> - Slowly Changing Dimensions (SCD): `Start_Date`, `End_Date`, `Is_Current`  
> - Performance Indexes

---

## 🔄 ETL Process with SSIS

### 🔌 Connections

- **OLE DB** used for source and destination connections.

### 📥 Dimension Table Loads

#### 🧾 Dim_Product / Dim_Customer
- OLE DB Source  
- **Lookup** to enrich data  
- **Derived Columns** to handle nulls  
- **SCD Transformation** (Type 0, 1, 2)  
- Load to DWH

#### 📅 Dim_Date
- Generated using **Python** (from 2000 to 2030)  
- Used **Data Conversion** to match destination data types  
- Loaded to DWH

#### 🌍 Dim_Territory
- Created `Lookup_Country` table for country name mapping  
- Joined with source to replace codes with full names  
- Loaded to DWH

### 🧮 Fact_Sales
- Merge Join between `SalesOrderHeader` and `SalesOrderDetail` (sorted by `SalesOrderID`)  
- Lookup for dimension keys (with **Ignore Failure**)  
- Derived Columns:
  - `Extended_Sales` = Quantity × Unit Price  
  - `Extended_Cost` = Quantity × Cost  
- Loaded to DWH

---

## 🧹 Full Load Process

- Uses **Execute SQL Task** to `TRUNCATE` `Fact_Sales` before loading.  
- Reloads all data on every run.

---

## 🔁 Incremental Load Process

- Created `meta_control_table` to track `last_load_date`  
- Compares `ModifiedDate` with:
  - `last_load_date` (from table)  
  - `current_run_time` (system time)  
- Updates `last_load_date` after each successful load  
- Only loads new/updated records

> ⚠️ Default value `2099-12-31` used to detect loading errors during testing.

---

## ✅ Key Notes

- All lookup failures map to default `Unknown` records (ID = 0).  
- SCD ensures history tracking for dimension changes.  
- Efficient and optimized ETL using sorting, lookups, and derived columns.

---

## 📂 Technologies Used

- SQL Server 2019  
- SSIS (SQL Server Integration Services)  
- Python (for Date Dimension generation)
