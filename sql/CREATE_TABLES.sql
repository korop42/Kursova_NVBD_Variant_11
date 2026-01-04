USE Payroll_LargeDB;
GO

CREATE TABLE dbo.Departments (
    DeptID INT PRIMARY KEY IDENTITY(1,1),
    DeptName NVARCHAR(100) NOT NULL
);


CREATE TABLE dbo.Positions (
    PositionID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    BaseRate DECIMAL(18, 2)
);


CREATE TABLE dbo.Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(200) NOT NULL,
    DeptID INT FOREIGN KEY REFERENCES dbo.Departments(DeptID),
    PositionID INT FOREIGN KEY REFERENCES dbo.Positions(PositionID),
    HireDate DATE,
    IsCurrent BIT DEFAULT 1
);

CREATE TABLE dbo.Accruals (
    AccrualID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES dbo.Employees(EmployeeID),
    AccrualDate DATE NOT NULL,
    Amount DECIMAL(18, 2) NOT NULL
);

CREATE TABLE dbo.TimeTracking (
    TrackingID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES dbo.Employees(EmployeeID),
    WorkDate DATE NOT NULL,
    HoursWorked INT NOT NULL,
    ActivityType NVARCHAR(50) -- Наприклад: 'Project', 'Overtime', 'Meeting'
);

CREATE TABLE dbo.Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES dbo.Employees(EmployeeID),
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(18, 2) NOT NULL,
    PaymentMethod NVARCHAR(50)
);

CREATE TABLE dbo.Vacations (
    VacationID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES dbo.Employees(EmployeeID),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    VacationType NVARCHAR(50)
);