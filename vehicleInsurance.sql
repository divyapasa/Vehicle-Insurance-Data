***Vehicle Insurance Data Analysis***

--Querying the database tables
SELECT * FROM Insurance
SELECT * FROM Customer

-- Total records 
SELECT count( * ) as  total_record FROM Customer

-- Created a view
--Policy holder details 
CREATE VIEW [Policy_Holders] AS
SELECT c.ID, c.Education, c.EmploymentStatus, c.Gender, c.Marital_Status, c.Location_Code, c.Income, i.NumberofPolicies, i.clv
FROM Customer c
JOIN Insurance i
ON c.ID = i.ID

SELECT * FROM Policy_Holders

-- Querying policy_Holders view table to find Income > 40000 and clv(customer lifetime value) 
SELECT ID, clv, Income
FROM Policy_Holders
where Income > 40000 and clv > 15000
ORDER BY clv DESC

--Customers division based on the coverage they choose
SELECT Coverage, COUNT(ID) as Total_Customers
FROM Insurance
WHERE Coverage is not null
GROUP BY Coverage

--Customers who has taken Premium coverage and where the Policy type is Personal Auto
SELECT COUNT(ID) as Total_Customers, Coverage     
FROM Insurance
WHERE Coverage = 'Premium' and PolicyType = 'Personal Auto' 
GROUP BY Coverage


SELECT COUNT(ID) as Total_Customers, Coverage     
FROM Insurance
WHERE PolicyType = 'Personal Auto' 
GROUP BY Coverage

-- Customers who are paying monthly premium more than $100 since the last claim 
SELECT i.ID, i.MonthlyPremiumAuto, i.MonthsSinceLastClaim, c.Vehicle_Size
FROM Customer c
JOIN Insurance i
ON c.ID = i.ID
WHERE MonthlyPremiumAuto > 100
ORDER BY MonthlyPremiumAuto DESC

--Filtering through customers who pay Monthly premuim greater than 100 and the vehicle they use
SELECT COUNT(i.ID) AS NumberOfCustomers, c.Vehicle_Size
FROM Customer c
JOIN Insurance i
ON c.ID = i.ID
WHERE i.MonthlyPremiumAuto > 100
GROUP BY c.Vehicle_Size

--Customers division based on the gender 
SELECT COUNT(ID) AS Customers, Gender
FROM Customer
WHERE Gender is not null
GROUP BY Gender

--How policyholder's EmploymentStatus and Marital.Status associated with Number.of.Policies ?
SELECT  c.EmploymentStatus, COUNT(i.NumberofPolicies) AS CountOfPolicies
FROM Customer c
JOIN Insurance i
ON c.ID = i.ID
GROUP BY c.EmploymentStatus
ORDER BY CountOfPolicies DESC

--Policy type and policy agent
SELECT SalesChannel,COUNT(ID) AS Policies_Sold
FROM Insurance
GROUP BY SalesChannel

--Customers who did not claim at all and the monthly premium they pay, vehicle_class, Vehicle_size
SELECT c.ID,i.MonthlyPremiumAuto, c.Vehicle_Class, c.Vehicle_Size
FROM Customer c
JOIN Insurance i
ON c.ID = i.ID
WHERE MonthsSinceLastClaim = 0
ORDER BY MonthlyPremiumAuto DESC

--Cars division based on Vehicle class
SELECT Vehicle_Class, COUNT(ID) AS Total_Cars
FROM Customer 
GROUP BY Vehicle_Class

--To find the highest clv
SELECT clv 
FROM Insurance
ORDER BY clv DESC

-- Find customers whose clv is greater than 15000
SELECT i.ID, i.clv, c.EmploymentStatus, c.Income
FROM Customer c
JOIN Insurance i
ON c.ID = i.ID
WHERE clv > 15000
ORDER BY clv DESC

SELECT i.ID, i.clv, c.EmploymentStatus, c.Income
FROM Customer c
JOIN Insurance i
ON c.ID = i.ID
WHERE clv < 15000
ORDER BY clv DESC

--customers who are employed and clv greater than 15000
SELECT c.EmploymentStatus, i.clv
FROM Customer c
JOIN Insurance i
ON c.ID = i.ID
WHERE EmploymentStatus = 'Employed' and clv > 15000
ORDER BY clv DESC
 
--customers who claimed recently 
SELECT ID, MonthsSinceLastClaim
FROM Insurance
WHERE MonthsSinceLastClaim < 10

SELECT COUNT(ID) AS Recent_Claims, MonthsSinceLastClaim
FROM Insurance
WHERE MonthsSinceLastClaim < 10
GROUP BY MonthsSinceLastClaim

--
SELECT COUNT(ID) AS NoOfLuxCars, Vehicle_Class
FROM Customer
WHERE Vehicle_Class  like '%lux%'
GROUP BY Vehicle_Class

-----END-----

