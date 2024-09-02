-- SQL Server MERGE ==> DML
-- Assume we have source table called S from where we will pick the data & we have target table T to where we have to dump data

/*
syntax:
MERGE target_table USING 
*/

-- source --> staging --> target
-- (real-time)

CREATE DATABASE Umair;
go

CREATE SCHEMA info;
go

ALTER SCHEMA info TRANSFER p_data;


CREATE TABLE full_name (
	first_name VARCHAR(255),
	last_name VARCHAR(255)
)


INSERT INTO full_name (first_name, last_name)
VALUES (
	('umair'),
	('nawaz')
)

DROP TABLE IF EXISTS full_name;
DROP SCHEMA IF EXISTS info;
DROP DATABASE IF EXISTS Umair;