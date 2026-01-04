USE Payroll_DW;
GO

-- 1. Вимір часу
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Quarter INT,
    Month INT,
    MonthName NVARCHAR(20),
    Day INT,
    DayOfWeekName NVARCHAR(20)
);

-- 2. Вимір Працівників (з підтримкою SCD Type 2) [cite: 72, 153]
CREATE TABLE DimEmployees (
    EmpSK INT PRIMARY KEY IDENTITY(1,1), -- Surrogate Key
    EmpID INT, -- Business Key з OLTP
    FullName NVARCHAR(150),
    CurrentDept NVARCHAR(100),
    CurrentPosition NVARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    IsCurrent BIT
);

-- 3. Таблиця фактів: Нарахування 
CREATE TABLE FactAccruals (
    FactAccrualKey BIGINT PRIMARY KEY IDENTITY(1,1),
    DateKey INT REFERENCES DimDate(DateKey),
    EmpSK INT REFERENCES DimEmployees(EmpSK),
    Amount DECIMAL(18, 2),
    AccrualType NVARCHAR(50)
);

-- 4. Таблиця фактів: Облік часу 
CREATE TABLE FactWorkTime (
    FactTimeKey BIGINT PRIMARY KEY IDENTITY(1,1),
    DateKey INT REFERENCES DimDate(DateKey),
    EmpSK INT REFERENCES DimEmployees(EmpSK),
    HoursWorked INT,
    ActivityType NVARCHAR(50)
);
-- 5. Вимір Департаментів
CREATE TABLE DimDepartments (
    DeptKey INT PRIMARY KEY IDENTITY(1,1),
    DeptID INT, -- Бізнес-ключ з джерела
    DeptName NVARCHAR(100)
);

-- 6. Вимір Посад (DimPositions)
CREATE TABLE DimPositions (
    PosKey INT PRIMARY KEY IDENTITY(1,1),
    PositionID INT,
    Title NVARCHAR(100),
    BaseRate DECIMAL(18, 2)
);

-- 7. Вимір Типів Активності (DimActivity)
-- Для аналізу Working Day, Overtime
CREATE TABLE DimActivity (
    ActivityKey INT PRIMARY KEY IDENTITY(1,1),
    ActivityType NVARCHAR(50)
);

