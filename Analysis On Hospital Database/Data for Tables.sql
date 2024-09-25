-- Insert into Physician
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (1, 'John Dorian', 'Staff Internist', 111111111);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (2, 'Elliot Reid', 'Attending Physician', 222222222);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (3, 'Christopher Turk', 'Surgical Attending Physician', 333333333);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (4, 'Percival Cox', 'Senior Attending Physician', 444444444);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (5, 'Bob Kelso', 'Head Chief of Medicine', 555555555);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (6, 'Todd Quinlan', 'Surgical Attending Physician', 666666666);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (7, 'John Wen', 'Surgical Attending Physician', 777777777);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (8, 'Keith Dudemeister', 'MD Resident', 888888888);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (9, 'Molly Clock', 'Attending Psychiatrist', 999999999);


-- Insert into Department
INSERT INTO Department (DepartmentID, Name, Head) VALUES (1, 'General Medicine', 4);
INSERT INTO Department (DepartmentID, Name, Head) VALUES (2, 'Surgery', 7);
INSERT INTO Department (DepartmentID, Name, Head) VALUES (3, 'Psychiatry', 9);

-- Insert into Affiliated_With
INSERT INTO Affiliated_With (Physician, Department, PrimaryAffiliation) VALUES (1, 1, 1);
INSERT INTO Affiliated_With (Physician, Department, PrimaryAffiliation) VALUES (2, 1, 1);
INSERT INTO Affiliated_With (Physician, Department, PrimaryAffiliation) VALUES (3, 1, 0);
INSERT INTO Affiliated_With (Physician, Department, PrimaryAffiliation) VALUES (3, 2, 1);
INSERT INTO Affiliated_With (Physician, Department, PrimaryAffiliation) VALUES (4, 1, 1);
INSERT INTO Affiliated_With (Physician, Department, PrimaryAffiliation) VALUES (5, 1, 1);
INSERT INTO Affiliated_With (Physician, Department, PrimaryAffiliation) VALUES (6, 2, 1);
INSERT INTO Affiliated_With (Physician, Department, PrimaryAffiliation) VALUES (7, 1, 0);
INSERT INTO Affiliated_With (Physician, Department, PrimaryAffiliation) VALUES (7, 2, 1);
INSERT INTO Affiliated_With (Physician, Department, PrimaryAffiliation) VALUES (8, 1, 1);
INSERT INTO Affiliated_With (Physician, Department, PrimaryAffiliation) VALUES (9, 3, 1);

-- Insert into Proceduretable
INSERT INTO Proceduretable (Code, Name, Cost) VALUES (1, 'Reverse Rhinopodoplasty', 1500.0);
INSERT INTO Proceduretable (Code, Name, Cost) VALUES (2, 'Obtuse Pyloric Recombobulation', 3750.0);
INSERT INTO Proceduretable (Code, Name, Cost) VALUES (3, 'Folded Demiophtalmectomy', 4500.0);
INSERT INTO Proceduretable (Code, Name, Cost) VALUES (4, 'Complete Walletectomy', 10000.0);
INSERT INTO Proceduretable (Code, Name, Cost) VALUES (5, 'Obfuscated Dermogastrotomy', 4899.0);
INSERT INTO Proceduretable (Code, Name, Cost) VALUES (6, 'Reversible Pancreomyoplasty', 5600.0);
INSERT INTO Proceduretable (Code, Name, Cost) VALUES (7, 'Follicular Demiectomy', 25.0);

-- Insert into Patient
INSERT INTO Patient (SSN, Name, Address, Phone, InsuranceID, PCP) VALUES (100000001, 'John Smith', '42 Foobar Lane', '555-0256', 68476213, 1);
INSERT INTO Patient (SSN, Name, Address, Phone, InsuranceID, PCP) VALUES (100000002, 'Grace Ritchie', '37 Snafu Drive', '555-0512', 36546321, 2);
INSERT INTO Patient (SSN, Name, Address, Phone, InsuranceID, PCP) VALUES (100000003, 'Random J. Patient', '101 Omgbbq Street', '555-1204', 65465421, 2);
INSERT INTO Patient (SSN, Name, Address, Phone, InsuranceID, PCP) VALUES (100000004, 'Dennis Doe', '1100 Foobaz Avenue', '555-2048', 68421879, 3);

-- Insert into Nurse
INSERT INTO Nurse (EmployeeID, Name, Position, Registered, SSN) VALUES (101, 'Carla Espinosa', 'Head Nurse', 1, 111111110);
INSERT INTO Nurse (EmployeeID, Name, Position, Registered, SSN) VALUES (102, 'Laverne Roberts', 'Nurse', 1, 222222220);
INSERT INTO Nurse (EmployeeID, Name, Position, Registered, SSN) VALUES (103, 'Paul Flowers', 'Nurse', 0, 333333330);
INSERT INTO Nurse (EmployeeID, Name, Position, Registered, SSN) VALUES (104, 'Grace Ritchie', 'Nurse', 0, 333344441);

-- Insert into Appointment
INSERT INTO Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, [End], ExaminationRoom) VALUES (13216584, 100000001, 101, 1, '2008-04-24 10:00', '2008-04-24 11:00', 'A');
INSERT INTO Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, [End], ExaminationRoom) VALUES (26548913, 100000002, 101, 2, '2008-04-24 10:00', '2008-04-24 11:00', 'B');
INSERT INTO Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, [End], ExaminationRoom) VALUES (36549879, 100000001, 102, 1, '2008-04-25 10:00', '2008-04-25 11:00', 'A');
INSERT INTO Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, [End], ExaminationRoom) VALUES (46846589, 100000004, 103, 4, '2008-04-25 10:00', '2008-04-25 11:00', 'B');
INSERT INTO Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, [End], ExaminationRoom) VALUES (59871321, 100000004, NULL, 4, '2008-04-26 10:00', '2008-04-26 11:00', 'C');
INSERT INTO Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, [End], ExaminationRoom) VALUES (69879231, 100000003, 103, 2, '2008-04-26 11:00', '2008-04-26 12:00', 'C');
INSERT INTO Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, [End], ExaminationRoom) VALUES (76983231, 100000001, NULL, 3, '2008-04-26 12:00', '2008-04-26 13:00', 'C');
INSERT INTO Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, [End], ExaminationRoom) VALUES (86213939, 100000004, 102, 9, '2008-04-27 10:00', '2008-04-21 11:00', 'A');
INSERT INTO Appointment (AppointmentID, Patient, PrepNurse, Physician, Start, [End], ExaminationRoom) VALUES (93216548, 100000002, 101, 2, '2008-04-27 10:00', '2008-04-27 11:00', 'B');

-- Insert into Medication
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (1, 'Procrastin-X', 'X', 'N/A');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (2, 'Thesisin', 'Foo Labs', 'N/A');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (3, 'Awakin', 'Bar Laboratories', 'N/A');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (4, 'Crescavitin', 'Baz Industries', 'N/A');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (5, 'Melioraurin', 'Snafu Pharmaceuticals', 'N/A');

-- Insert into Prescribes
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (1, 100000001, 1, '2008-04-24 10:47', 13216584, '5');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (9, 100000004, 2, '2008-04-27 10:53', 86213939, '10');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (9, 100000004, 2, '2008-04-30 16:53', NULL, '5');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (1, 100000004, 3, '2024-01-10', NULL, '2');

-- Insert into Block
INSERT INTO Block VALUES(1,1);
INSERT INTO Block VALUES(1,2);
INSERT INTO Block VALUES(1,3);
INSERT INTO Block VALUES(2,1);
INSERT INTO Block VALUES(2,2);
INSERT INTO Block VALUES(2,3);
INSERT INTO Block VALUES(3,1);
INSERT INTO Block VALUES(3,2);
INSERT INTO Block VALUES(3,3);
INSERT INTO Block VALUES(4,1);
INSERT INTO Block VALUES(4,2);
INSERT INTO Block VALUES(4,3);

-- Insert into Room
INSERT INTO Room VALUES(101,'Single',1,1,0);
INSERT INTO Room VALUES(102,'Single',1,1,0);
INSERT INTO Room VALUES(103,'Single',1,1,0);
INSERT INTO Room VALUES(111,'Single',1,2,0);
INSERT INTO Room VALUES(112,'Single',1,2,1);
INSERT INTO Room VALUES(113,'Single',1,2,0);
INSERT INTO Room VALUES(121,'Single',1,3,0);
INSERT INTO Room VALUES(122,'Single',1,3,0);
INSERT INTO Room VALUES(123,'Single',1,3,0);
INSERT INTO Room VALUES(201,'Single',2,1,1);
INSERT INTO Room VALUES(202,'Single',2,1,0);
INSERT INTO Room VALUES(203,'Single',2,1,0);
INSERT INTO Room VALUES(211,'Single',2,2,0);
INSERT INTO Room VALUES(212,'Single',2,2,0);
INSERT INTO Room VALUES(213,'Single',2,2,1);
INSERT INTO Room VALUES(221,'Single',2,3,0);
INSERT INTO Room VALUES(222,'Single',2,3,0);
INSERT INTO Room VALUES(223,'Single',2,3,0);
INSERT INTO Room VALUES(301,'Single',3,1,0);
INSERT INTO Room VALUES(302,'Single',3,1,1);
INSERT INTO Room VALUES(303,'Single',3,1,0);
INSERT INTO Room VALUES(311,'Single',3,2,0);
INSERT INTO Room VALUES(312,'Single',3,2,0);
INSERT INTO Room VALUES(313,'Single',3,2,0);
INSERT INTO Room VALUES(321,'Single',3,3,1);
INSERT INTO Room VALUES(322,'Single',3,3,0);
INSERT INTO Room VALUES(323,'Single',3,3,0);
INSERT INTO Room VALUES(401,'Single',4,1,0);
INSERT INTO Room VALUES(402,'Single',4,1,1);
INSERT INTO Room VALUES(403,'Single',4,1,0);
INSERT INTO Room VALUES(411,'Single',4,2,0);
INSERT INTO Room VALUES(412,'Single',4,2,0);
INSERT INTO Room VALUES(413,'Single',4,2,0);
INSERT INTO Room VALUES(421,'Single',4,3,1);
INSERT INTO Room VALUES(422,'Single',4,3,0);
INSERT INTO Room VALUES(423,'Single',4,3,0);

INSERT INTO On_Call VALUES(101,1,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(101,1,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(102,1,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(103,1,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

INSERT INTO Stay VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO Stay VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO Stay VALUES(3217,100000004,112,'2008-05-02','2008-05-03');

INSERT INTO Undergoes VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO Undergoes VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO Undergoes VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO Undergoes VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO Undergoes VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO Undergoes VALUES(100000004,4,3217,'2008-05-13',3,103);

INSERT INTO Trained_In VALUES(3,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,7,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,5,'2007-01-01','2007-12-31');
INSERT INTO Trained_In VALUES(6,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,3,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,4,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,7,'2008-01-01','2008-12-31');
