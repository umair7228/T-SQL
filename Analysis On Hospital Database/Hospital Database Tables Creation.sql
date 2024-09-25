--CREATE DATABASE Hospitals;
--drop database Hospitals

CREATE TABLE Physician (
  EmployeeID INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  Position NVARCHAR(255) NOT NULL,
  SSN INT NOT NULL
); 

CREATE TABLE Department (
  DepartmentID INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  Head INT NOT NULL
    CONSTRAINT fk_Physician_EmployeeID FOREIGN KEY REFERENCES Physician(EmployeeID)
);

CREATE TABLE Affiliated_With (
  Physician INT NOT NULL
    CONSTRAINT fk_Affiliated_Physician FOREIGN KEY REFERENCES Physician(EmployeeID),
  Department INT NOT NULL
    CONSTRAINT fk_Affiliated_Department FOREIGN KEY REFERENCES Department(DepartmentID),
  PrimaryAffiliation BIT NOT NULL,
  PRIMARY KEY(Physician, Department)
);

CREATE TABLE Proceduretable (
  Code INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  Cost DECIMAL(18, 2) NOT NULL
);

CREATE TABLE Trained_In (
  Physician INT NOT NULL
    CONSTRAINT fk_TrainedIn_Physician FOREIGN KEY REFERENCES Physician(EmployeeID),
  Treatment INT NOT NULL
    CONSTRAINT fk_TrainedIn_Procedure FOREIGN KEY REFERENCES Proceduretable(Code),
  CertificationDate DATETIME NOT NULL,
  CertificationExpires DATETIME NOT NULL,
  PRIMARY KEY(Physician, Treatment)
);

CREATE TABLE Patient (
  SSN INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  Address NVARCHAR(255) NOT NULL,
  Phone NVARCHAR(15) NOT NULL,
  InsuranceID INT NOT NULL,
  PCP INT NOT NULL
    CONSTRAINT fk_Patient_EmployeeID FOREIGN KEY REFERENCES Physician(EmployeeID)
);

CREATE TABLE Nurse (
  EmployeeID INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  Position NVARCHAR(255) NOT NULL,
  Registered BIT NOT NULL,
  SSN INT NOT NULL
);

CREATE TABLE Appointment (
  AppointmentID INT PRIMARY KEY NOT NULL,
  Patient INT NOT NULL
    CONSTRAINT fk_Appointment_Patient FOREIGN KEY REFERENCES Patient(SSN),
  PrepNurse INT
    CONSTRAINT fk_Appointment_Nurse FOREIGN KEY REFERENCES Nurse(EmployeeID),
  Physician INT NOT NULL
    CONSTRAINT fk_Appointment_Physician FOREIGN KEY REFERENCES Physician(EmployeeID),
  Start DATETIME NOT NULL,
  [End] DATETIME NOT NULL, -- Using square brackets for 'End' to avoid conflict with the reserved keyword
  ExaminationRoom NVARCHAR(255) NOT NULL
);

CREATE TABLE Medication (
  Code INT PRIMARY KEY NOT NULL,
  Name NVARCHAR(255) NOT NULL,
  Brand NVARCHAR(255) NOT NULL,
  Description NVARCHAR(255) NOT NULL
);

CREATE TABLE Prescribes (
  Physician INT NOT NULL
    CONSTRAINT fk_Prescribes_Physician FOREIGN KEY REFERENCES Physician(EmployeeID),
  Patient INT NOT NULL
    CONSTRAINT fk_Prescribes_Patient FOREIGN KEY REFERENCES Patient(SSN),
  Medication INT NOT NULL
    CONSTRAINT fk_Prescribes_Medication FOREIGN KEY REFERENCES Medication(Code),
  Date DATETIME NOT NULL,
  Appointment INT
    CONSTRAINT fk_Prescribes_Appointment FOREIGN KEY REFERENCES Appointment(AppointmentID),
  Dose NVARCHAR(255) NOT NULL,
  PRIMARY KEY(Physician, Patient, Medication, Date)
);

CREATE TABLE Block (
  Floor INT NOT NULL,
  Code INT NOT NULL,
  PRIMARY KEY(Floor, Code)
); 

CREATE TABLE Room (
  Number INT PRIMARY KEY NOT NULL,
  Type NVARCHAR(255) NOT NULL,
  BlockFloor INT NOT NULL,
  BlockCode INT NOT NULL,
  Unavailable BIT NOT NULL,
  FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block(Floor, Code)
);

CREATE TABLE On_Call (
  Nurse INT NOT NULL
    CONSTRAINT fk_OnCall_Nurse FOREIGN KEY REFERENCES Nurse(EmployeeID),
  BlockFloor INT NOT NULL,
  BlockCode INT NOT NULL,
  Start DATETIME NOT NULL,
  [End] DATETIME NOT NULL,  -- Use square brackets for 'End' to avoid conflicts with the reserved keyword
  PRIMARY KEY(Nurse, BlockFloor, BlockCode, Start, [End]),
  FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block(Floor, Code)
);

CREATE TABLE Stay (
  StayID INT PRIMARY KEY NOT NULL,
  Patient INT NOT NULL
    CONSTRAINT fk_Stay_Patient FOREIGN KEY REFERENCES Patient(SSN),
  Room INT NOT NULL
    CONSTRAINT fk_Stay_Room FOREIGN KEY REFERENCES Room(Number),
  Start DATETIME NOT NULL,
  [End] DATETIME NOT NULL  -- Use square brackets for 'End' to avoid conflicts with the reserved keyword
);

CREATE TABLE Undergoes (
  Patient INT NOT NULL
    CONSTRAINT fk_Undergoes_Patient FOREIGN KEY REFERENCES Patient(SSN),
  ProcedureCode INT NOT NULL  -- Renamed from Proceduretable to ProcedureCode
    CONSTRAINT fk_Undergoes_Procedure FOREIGN KEY REFERENCES Proceduretable(Code),
  Stay INT NOT NULL
    CONSTRAINT fk_Undergoes_Stay FOREIGN KEY REFERENCES Stay(StayID),
  Date DATETIME NOT NULL,
  Physician INT NOT NULL
    CONSTRAINT fk_Undergoes_Physician FOREIGN KEY REFERENCES Physician(EmployeeID),
  AssistingNurse INT
    CONSTRAINT fk_Undergoes_Nurse FOREIGN KEY REFERENCES Nurse(EmployeeID),
  PRIMARY KEY(Patient, ProcedureCode, Stay, Date)
);
