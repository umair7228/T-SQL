/* 
  Inner Join
Question 1: Write a query to retrieve details of all appointments along with the physician's and 
patient's names.
 */
select
	Appointment.AppointmentID,
	Physician.Name,
	Patient.Name
from Appointment
inner join Physician
	on Physician.EmployeeID = Appointment.Physician
inner join Patient
	on Patient.SSN = Appointment.Patient;


/*
Question 2: Retrieve all nurses and their on-call schedules, including those who may not have
            any on-call assignments.
*/

select *
from Nurse
left join On_Call
	on On_Call.Nurse = Nurse.EmployeeID;

/*
3. GROUP BY WITH HAVING CLAUSE
Question: Show the number of procedures each physician is trained in, but only show physicians 
who are trained in more than 2 procedures.

*/
select * from Proceduretable;
select * from Trained_In where Treatment = 3;

select
	Proceduretable.Name,
	count(Trained_In.Treatment) as no_of_procedure
from Proceduretable
inner join Trained_In
	on Proceduretable.Code = Trained_In.Treatment
group by Proceduretable.Name
having count(Trained_In.Treatment) > 2;

/*
4. SUBQUERY  - FROM
Retrieve the name of the patient and the details of the most expensive procedure they
underwent during their stay, including the procedure code and cost.
*/
select TOP(1)
	patient_name,
	ProcedureCode,
	Cost
from (
select
	Patient.Name as patient_name,
	Undergoes.ProcedureCode,
	Proceduretable.Cost
from Patient
inner join Undergoes
	on Patient.SSN = Undergoes.Patient
inner join Proceduretable
	on Undergoes.ProcedureCode = Proceduretable.Code) as sub_query
order by sub_query.Cost DESC;


/*Question 2 (WHERE Subquery): List all physicians who have prescribed a medication "Awakin"
in its description.
*/
select * from Physician;
select * from Medication;

select Physician.Name
from Prescribes
inner join Physician
	on Prescribes.Physician = Physician.EmployeeID
where Prescribes.Medication = (
	select Code
	from Medication
	where Name = 'Awakin'
);

/* 5. UNION
Question: Write a query to list all physicians and nurses, combining their names in a single result set.
*/

select Physician.Name, 'Physician' as role 
from Physician
union
select Nurse.Name, 'Nurse' as role
from Nurse

/*
6. CTEs (Common Table Expressions)
Question: Use a CTE to list all nurses who assisted in procedures, along with the number of
procedures they assisted in.
*/

WITH nurse_assisted AS (
	SELECT
		n.Name AS NurseName,
		COUNT(u.ProcedureCode) AS ProceduresAssisted
	FROM Nurse n
	JOIN Undergoes u
		ON n.EmployeeID = u.AssistingNurse
	GROUP BY n.Name
)

SELECT
	NurseName,
	ProceduresAssisted
FROM nurse_assisted;

/*7. CASE
Question: Write a query to classify physicians based on the number of procedures they are trained
in (<3: 'Basic', 3-5: 'Intermediate', >5: 'Advanced').
*/
select Physician.Name, count(Proceduretable.Name) as num_proc,
	case
		when count(Proceduretable.Name) < 3 then 'Basic'
		when count(Proceduretable.Name) >= 3 and count(Proceduretable.Name) <= 5 then 'Intermediate'
		when count(Proceduretable.Name) > 5 then 'Advance'
	end as no_of_proc
from physician
inner join trained_in
	on Physician.EmployeeID = Trained_In.Physician
inner join Proceduretable
	on Trained_In.Treatment = Proceduretable.Code
group by Physician.Name

/*
8. COALESCE
Question: Retrieve all patients, showing their primary care physician (PCP). 
If a PCP is not assigned, display "No PCP".
*/

SELECT 
    patient.name AS PatientName,
    COALESCE(physician.name, 'No PCP') AS PrimaryCarePhysician
FROM 
    patient
LEFT JOIN 
    physician ON patient.pcp = physician.employeeid;


/*
9. VIEWS
Question: Create a view to simplify the retrieval of appointment information,
including the patient's and physician's names and the appointment start time.
*/

CREATE VIEW AppointmentInfo AS
SELECT
	ap.AppointmentID,
	pt.Name AS PatientName,
	p.Name AS PhysicianName,
	ap.Start AS AppointmentStartTime
FROM Appointment ap
JOIN Patient pt
	ON ap.Patient = pt.SSN
JOIN Physician p
	ON ap.Physician = p.EmployeeID;

SELECT * FROM AppointmentInfo;

/*
10. STORED PROCEDURES
Question: Write a stored procedure that takes a physician's ID and retrieves all procedures that physician has performed.
*/

select * from Undergoes;
select * from Proceduretable;

CREATE PROCEDURE get_physician_procedures
    @PhysicianID INT
AS
BEGIN
    SELECT 
        pr.Code AS ProcedureCode,
        pr.Name AS ProcedureName,
        pr.Cost AS ProcedureCost,
        u.Date AS ProcedureDate
    FROM 
        Undergoes u
    JOIN 
        Proceduretable pr
			ON u.ProcedureCode = pr.code
    WHERE 
        u.physician = @PhysicianID;
END;


EXEC get_physician_procedures 3;

/*
11. INDEXES
Question: Create an index on the Stay table's Room column to optimize queries that search by room number.
*/

CREATE INDEX room_number_index
ON Stay (room);



