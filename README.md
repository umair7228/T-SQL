# SQL Server (t-SQL)

_NOTE: This repository is part of cloud data engineering roadmap for getting hands on t-SQL on Microsoft SQL Server_

## What is SQL Server?

- Relational database management system (RDBMS) developed by Mricosoft.
- Similar to other RDBMS software, SQL Server is built on top of SQL.
- SQL Server is tied to Transact-SQL, or T-SQL which includes a set of proprietary programming constructs.

## SQL Server Architecture

SQL Server consists of two main components:

- Database Engine
    - Core component of the SQL Server is the Database Engine
    - Comprises a relational engine that **processes queries** and a **storage engine** that **manages database files, pages, indexes**, etc
    - Additionally, the database engine creates database objects such as stored procedures, views, and triggers.

- SQLOS
    - Under the relational engine and storage engine lies the SQL Server Operating System, or SQLOS.
    - SQLOS provides services such as **memory** and **I/O management**, as well as **exception handling** and **synchronization** services.

![sql-server-architecture](https://github.com/umair7228/T-SQL/assets/154393500/73806d9d-3b3f-47b3-8b5b-4f3b094fa93e)


## Others tools

- SSMS used for database development
- SSIS used for data management
- SSAS used for analysis
- SSRS used for reporting

_NOTE: SSMS & SSIS are important skillset for Data Engineers_

## Summary
- SQL server architecture includes a **database engine** and **SQL server operation system (SQLOS)**
- SQL server offers a set of tools for working with data effectively
- SQL server has different editions including developer edition, expression, enterprise, and standard
