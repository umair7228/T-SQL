-- Triggers are like stored procedure
-- Trigger based on certain action i.e: Insertion, Updation, Deletion

------------- CREATEING FIRST TABLE Employee
CREATE TABLE Employee
(
	Emp_ID INT IDENTITY,
	Emp_name VARCHAR(30),
	Emp_sal DECIMAL(10, 2)
);

INSERT INTO Employee (Emp_name, Emp_sal)
VALUES
	('Umair', 1000),
	('Salman', 2000),
	('Noman', 3000);

------------- CREATEING SECOND TABLE Employee_Audit
CREATE TABLE Employee_Audit (
	Emp_ID INT,
	Emp_name VARCHAR(30),
	Emp_sal DECIMAL(10, 2),
	Audit_Action VARCHAR(100),
	Audit_Timestamp DATETIME
);

-- Trigger for INSERTION

CREATE TRIGGER audit_insertion_employees
ON Employee
FOR INSERT
AS 
	DECLARE @empid INT;
	DECLARE @empname VARCHAR(30);
	DECLARE @empsal DECIMAL(10, 2);
	DECLARE @audit VARCHAR(100);

	SELECT @empid = i.Emp_ID FROM INSERTED i;
	SELECT @empname = i.Emp_name FROM INSERTED i;
	SELECT @empsal = i.Emp_sal FROM INSERTED i;
	SELECT @audit = 'Insert Record = After Insert Trigger';

	INSERT INTO Employee_Audit
	VALUES (
		@empid,
		@empname,
		@empsal,
		@audit,
		GETDATE()
	);

	PRINT 'AFTER INSERT TRIGGER FIRED';



SELECT * FROM Employee;
SELECT * FROM Employee_Audit;

INSERT INTO Employee (Emp_name, Emp_sal)
VALUES
	('Arsalan', 4000);


CREATE TRIGGER trg_after_update
ON Employee
FOR UPDATE
AS
	DECLARE @empid INT;
	DECLARE @empname VARCHAR(30);
	DECLARE @empsal DECIMAL(10, 2);
	DECLARE @audit VARCHAR(100);

	SELECT @empid = i.Emp_ID FROM INSERTED i;
	SELECT @empname = i.Emp_name FROM INSERTED i;
	SELECT @empsal = i.Emp_sal FROM INSERTED i;
	
	IF UPDATE (Emp_Name)
		SET @audit = 'Update Record, After Update Trigger, Name Updated';
	IF UPDATE (Emp_sal)
		SET @audit = 'Update Record, After Update Trigger, Sal Updated';

	INSERT INTO Employee_Audit
	VALUES (
		@empid,
		@empname,
		@empsal,
		@audit,
		GETDATE()
	);

	PRINT 'AFTER UPDATE TRIGGER FIRED';

UPDATE Employee
SET Emp_name = 'Luqman'
WHERE Emp_ID = '2';

SELECT * FROM Employee_Audit;

CREATE TRIGGER trg_after_delete
ON Employee
AFTER DELETE
AS 
	DECLARE @empid INT;
	DECLARE @empname VARCHAR(30);
	DECLARE @empsal DECIMAL(10, 2);
	DECLARE @audit VARCHAR(100);

	SELECT @empid = i.Emp_ID FROM INSERTED i;
	SELECT @empname = i.Emp_name FROM INSERTED i;
	SELECT @empsal = i.Emp_sal FROM INSERTED i;
	SELECT @audit = 'Deleted, After Delete Trigger';

	INSERT INTO Employee_Audit
	VALUES (
		@empid,
		@empname,
		@empsal,
		@audit,
		GETDATE()
	);

	PRINT 'AFTER DELETE TRIGGER FIRED';

DELETE FROM Employee
WHERE Emp_name = 'Luqman';

SELECT * FROM Employee_Audit;


CREATE TABLE Employees (
	Emp_ID INT IDENTITY,
	Emp_fname VARCHAR(30),
	Emp_lname VARCHAR(30)
);

CREATE TABLE Employee_log (
	Emp_id INT,
	Emp_fname VARCHAR(30),
	Emp_lname VARCHAR(30),
	Log_action VARCHAR(100),
	Log_timestamp DATETIME
);

CREATE TRIGGER insert_trg
ON Employees
FOR INSERT
AS
	DECLARE @empid INT;
	DECLARE @empfname VARCHAR;
	DECLARE @emplname VARCHAR;
	DECLARE @log_audit VARCHAR;

	SELECT @empid = i.Emp_id FROM INSERTED i;
	SELECT @empfname = i.Emp_fname FROM INSERTED i;
	SELECT @emplname = i.Emp_lname FROM INSERTED i;
	SELECT @log_audit = 'Inserted, After Insert Trigger';

	INSERT INTO Employee_log
	VALUES (
		@empid,
		@empfname,
		@emplname,
		@log_audit,
		GETDATE());

	PRINT 'AFTER INSERT TRIGGER FIRED';

INSERT INTO Employees
VALUES 
	('Noman', 'Khan');

select * from Employee_log;


CREATE TRIGGER update_trg
ON Employees
FOR UPDATE
AS
	DECLARE @empid INT;
	DECLARE @empfname VARCHAR;
	DECLARE @emplname VARCHAR;
	DECLARE @log_audit VARCHAR;

	SELECT @empid = i.Emp_id FROM INSERTED i;
	SELECT @empfname = i.Emp_fname FROM INSERTED i;
	SELECT @emplname = i.Emp_lname FROM INSERTED i;
	
	IF UPDATE (Emp_fname)
		SET @log_audit = 'Update Record, After Update Trigger, fname Updated';
	IF UPDATE (Emp_lname)
		SET @log_audit = 'Update Record, After Update Trigger, lname Updated';

	INSERT INTO Employee_log
	VALUES (
		@empid,
		@empfname,
		@emplname,
		@log_audit,
		GETDATE());

	PRINT 'AFTER UPDATE TRIGGER FIRED';

UPDATE Employees
SET Emp_fname = 'Salman'
WHERE Emp_ID = 2;


CREATE TRIGGER delete_trg
ON Employees
AFTER DELETE
AS
	DECLARE @empid INT;
	DECLARE @empfname VARCHAR;
	DECLARE @emplname VARCHAR;
	DECLARE @log_audit VARCHAR;

	SELECT @empid = i.Emp_id FROM INSERTED i;
	SELECT @empfname = i.Emp_fname FROM INSERTED i;
	SELECT @emplname = i.Emp_lname FROM INSERTED i;
	SELECT @log_audit = 'Deleted, After Delete Trigger'

	INSERT INTO Employee_log
	VALUES (
		@empid,
		@empfname,
		@emplname,
		@log_audit,
		GETDATE());

	PRINT 'AFTER DELETE TRIGGER FIRED';


DELETE FROM Employees
WHERE Emp_ID = 2;

select * from Employees;


CREATE TRIGGER after_insert_trg
ON Employees
AFTER INSERT
AS
	DECLARE @empid INT;
	DECLARE @empfname VARCHAR;
	DECLARE @emplname VARCHAR;
	DECLARE @log_audit VARCHAR;

	SELECT @empid = i.Emp_id FROM INSERTED i;
	SELECT @empfname = i.Emp_fname FROM INSERTED i;
	SELECT @emplname = i.Emp_lname FROM INSERTED i;
	SELECT @log_audit = 'Record Inserted'

	INSERT INTO Employee_log
	VALUES (
		@empid,
		@empfname,
		@emplname,
		@log_audit,
		GETDATE());

	PRINT 'AFTER_INSERT TRIGGER FIRED';

INSERT INTO Employees
VALUES
	('Niaz', 'Ali'),
	('Arsalan', 'Nawaz');


select * from Employee_log;

SELECT * FROM Employee_Audit;


