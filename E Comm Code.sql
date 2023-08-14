create database E_Comm;
use E_comm;


CREATE TABLE ecommercechurn 
(
    CustomerID	INT,
    Churn	INT,
    Tenure	INT,
	PreferredLoginDevice	VARCHAR(100),
    CityTier	int,
    WarehouseToHome	INT,
    PreferredPaymentMode	VARCHAR(100),
    Gender	VARCHAR(30),
    HourSpendOnApp	INT,
    NumberOfDeviceRegistered	INT,
    PreferedOrderCat	VARCHAR(512),
    SatisfactionScore	INT,
    MaritalStatus	VARCHAR(50),
    NumberOfAddress	INT,
    Complain	int,
    OrderAmountHikeFromlastYear	INT,
    CouponUsed	int,
    OrderCount	int,
    DaySinceLastOrder	text,
    CashbackAmount int
);

select *,convert(DaySinceLastOrder,decimal) as num1 from ecommercechurn;


select * from ecommercechurn;

drop table ecommercechurn;

desc ecommercechurn;


LOAD DATA INFILE 
"D:/Ecommerce Data/E Commer.csv"
into table  ecommercechurn
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
lines terminated by '\n'
IGNORE 1 ROWS
(CustomerID, 
 Churn,  @Tenure, PreferredLoginDevice, CityTier, @WarehouseToHome,  PreferredPaymentMode , Gender ,
@HourSpendOnApp , NumberOfDeviceRegistered , PreferedOrderCat , SatisfactionScore , MaritalStatus ,  NumberOfAddress , 
Complain ,@OrderAmountHikeFromlastYear , @CouponUsed , @OrderCount , DaySinceLastOrder ,  CashbackAmount 
)    
SET Tenure  = NULLIF(@Tenure, ''),
	WarehouseToHome = nullif(@WarehouseToHome ,''),
    HourSpendOnApp = nullif(@HourSpendOnApp , ''),
    OrderAmountHikeFromlastYear  = nullif(@OrderAmountHikeFromlastYear, ''),
    CouponUsed = nullif(@CouponUsed , ''),
    OrderCount = nullif(@OrderCount ,'');


   


UPDATE ecommercechurn
SET DaySinceLastOrder = IFNULL(DaySinceLastOrder, 0);



 -- specify column names in the same order as in your CSV




drop table ecommercechurn;

select * from  ecommercechurn;

-- 1. Finding the total number of customers --

select distinct count(customerID) as TotalNumberOfCustomers from  ecommercechurn;

-- There are 5,630 customers found in this dataset. --

-- 2. Checking for duplicate rows -- 

select CustomerID , count(CustomerID) as Count
from ecommercechurn group by CustomerID having count(CustomerID) > 1;

-- The query returns an empty table, showing there are no duplicate rows.--

-- 3. Checking for null values -- 

SELECT 'Tenure' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE Tenure IS NULL 
UNION
SELECT 'WarehouseToHome' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE warehousetohome IS NULL 
UNION
SELECT 'HourSpendonApp' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE hourspendonapp IS NULL
UNION
SELECT 'OrderAmountHikeFromLastYear' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE orderamounthikefromlastyear IS NULL 
UNION
SELECT 'CouponUsed' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE couponused IS NULL 
UNION
SELECT 'OrderCount' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE ordercount IS NULL 
UNION
SELECT 'DaySinceLastOrder' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE daysincelastorder IS NULL ;


desc ecommercechurn;

alter table ecommercechurn  modify column Churn int;



alter table ecommercechurn modify column DaySinceLastOrder  int;

select * from ecommercechurn;


ALTER TABLE ecommercechurn
ADD CustomerStatus NVARCHAR(50);




select * from ecommercechurn;

select count(*) from ecommercechurn;

drop table  ecommercechurn;

SELECT * FROM ecommercechurn ORDER BY CustomerID DESC LIMIT 100;


-- Data Cleaning 

-- 1. Finding the total number of customers

SELECT DISTINCT
    COUNT(CustomerID) AS TotalNumberofCustomers
FROM
    ecommercechurn;


-- 2. Checking for duplicate rows

SELECT 
    CustomerID, COUNT(CustomerID) AS Count
FROM
    ecommercechurn
GROUP BY CustomerID
HAVING COUNT(CustomerID) > 1;


-- 3. Checking for null values

SELECT 'Tenure' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE Tenure IS NULL 
UNION
SELECT 'WarehouseToHome' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE warehousetohome IS NULL 
UNION
SELECT 'HourSpendonApp' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE hourspendonapp IS NULL
UNION
SELECT 'OrderAmountHikeFromLastYear' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE orderamounthikefromlastyear IS NULL 
UNION
SELECT 'CouponUsed' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE couponused IS NULL 
UNION
SELECT 'OrderCount' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE ordercount IS NULL 
UNION
SELECT 'DaySinceLastOrder' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE daysincelastorder IS NULL;

-- 3.1 Handling null values

UPDATE ecommercechurn
SET Tenure = (
    SELECT AVG(Tenure) 
    FROM (
        SELECT Tenure
        FROM ecommercechurn
        WHERE Tenure IS NOT NULL
    ) AS temp
)
WHERE Tenure IS NULL;


UPDATE ecommercechurn
SET WarehouseToHome = (
    SELECT AVG(WarehouseToHome) 
    FROM (
        SELECT WarehouseToHome
        FROM ecommercechurn
        WHERE WarehouseToHome IS NOT NULL
    ) AS temp
)
WHERE WarehouseToHome IS NULL;

select * from ecommercechurn;

UPDATE ecommercechurn
SET WarehouseToHome = (
    SELECT AVG(WarehouseToHome) 
    FROM (
        SELECT WarehouseToHome
        FROM ecommercechurn
        WHERE WarehouseToHome IS NOT NULL
    ) AS temp
)
WHERE WarehouseToHome IS NULL;


select * from ecommercechurn;

UPDATE ecommercechurn
SET HourSpendOnApp = (
    SELECT AVG(HourSpendOnApp) 
    FROM (
        SELECT HourSpendOnApp
        FROM ecommercechurn
        WHERE HourSpendOnApp IS NOT NULL
    ) AS temp
)
WHERE HourSpendOnApp IS NULL;


select * from ecommercechurn;

UPDATE ecommercechurn
SET OrderAmountHikeFromlastYear = (
    SELECT AVG(OrderAmountHikeFromlastYear) 
    FROM (
        SELECT OrderAmountHikeFromlastYear
        FROM ecommercechurn
        WHERE OrderAmountHikeFromlastYear IS NOT NULL
    ) AS temp
)
WHERE HourSpendOnApp IS NULL;



UPDATE ecommercechurn
SET OrderAmountHikeFromLastYear = (
    SELECT AVG(OrderAmountHikeFromLastYear) 
    FROM (
        SELECT OrderAmountHikeFromLastYear
        FROM ecommercechurn
        WHERE OrderAmountHikeFromLastYear IS NOT NULL
    ) AS temp
)
WHERE OrderAmountHikeFromLastYear IS NULL;


UPDATE ecommercechurn
SET OrderCount = (
    SELECT AVG(OrderCount) 
    FROM (
        SELECT OrderCount
        FROM ecommercechurn
        WHERE OrderCount IS NOT NULL
    ) AS temp
)
WHERE OrderCount IS NULL;






UPDATE ecommercechurn
SET CouponUsed = (
    SELECT AVG(CouponUsed) 
    FROM (
        SELECT CouponUsed
        FROM ecommercechurn
        WHERE CouponUsed IS NOT NULL
    ) AS temp
)
WHERE CouponUsed IS NULL;


-- 4. Creating a new column from an already existing “churn” column 

ALTER TABLE ecommercechurn
ADD CustomerStatus NVARCHAR(50);

UPDATE ecommercechurn
SET CustomerStatus = 
CASE 
    WHEN Churn = 1 THEN 'Churned' 
    WHEN Churn = 0 THEN 'Stayed'
END;

select * from  ecommercechurn;

select CustomerStatus , count(CustomerStatus) as StatusCount from ecommercechurn group by  CustomerStatus;

-- 5. Creating a new column from an already existing “complain” column

ALTER TABLE ecommercechurn
ADD ComplainRecieved NVARCHAR(10);

UPDATE ecommercechurn
SET ComplainRecieved =  
CASE 
    WHEN complain = 1 THEN 'Yes'
    WHEN complain = 0 THEN 'No'
END;

select ComplainRecieved , count(ComplainRecieved) as StatusCount from ecommercechurn group by  ComplainRecieved;

-- 6.1 Fixing redundancy in “PreferedLoginDevice” Column

select distinct preferredlogindevice 
from ecommercechurn;

UPDATE ecommercechurn
SET preferredlogindevice = 'phone'
WHERE preferredlogindevice = 'mobile phone';

select distinctrow
preferredlogindevice  from ecommercechurn ;

-- 6.2 Fixing redundancy in “PreferedOrderCat” Columns

select distinct preferedordercat 
from ecommercechurn;


UPDATE ecommercechurn
SET preferedordercat = 'Mobile Phone'
WHERE Preferedordercat = 'Mobile';


select distinctrow
preferedordercat   from ecommercechurn ;

-- 6.3 Fixing redundancy in “PreferredPaymentMode” Column

select distinct PreferredPaymentMode 
from ecommercechurn;


UPDATE ecommercechurn
SET PreferredPaymentMode  = 'Cash on Delivery'
WHERE PreferredPaymentMode  = 'COD';

select distinctrow
PreferredPaymentMode   from ecommercechurn ;


-- 6.4 Fixing wrongly entered values in “WarehouseToHome” column

SELECT DISTINCT warehousetohome
FROM ecommercechurn;


UPDATE ecommercechurn
SET warehousetohome = '27'
WHERE warehousetohome = '127';

UPDATE ecommercechurn
SET warehousetohome = '26'
WHERE warehousetohome = '126';



select * from ecommercechurn;








-- ## Data Exploration ## 

-- 1. What is the overall customer churn rate?

SELECT 
    TotalNumberofCustomers,
    TotalNumberofChurnedCustomers,
    CAST((TotalNumberofChurnedCustomers * 1.0 / TotalNumberofCustomers * 1.0) * 100
        AS DECIMAL (10 , 2 )) AS ChurnRate
FROM (SELECT 
        COUNT(*) AS TotalNumberofCustomers
FROM ecommercechurn) AS Total,
    (SELECT 
        COUNT(*) AS TotalNumberofChurnedCustomers
FROM ecommercechurn WHERE
        CustomerStatus = 'churned') AS Churned;

-- The churn rate of 16.84% indicates that a significant portion of customers --
-- in the dataset have ended their association with the company.


select * from ecommercechurn;

-- 2. How does the churn rate vary based on the preferred login device?

SELECT preferredlogindevice,
        COUNT(*) AS TotalCustomers from ecommercechurn GROUP BY preferredlogindevice;
        
SELECT preferredlogindevice,
         SUM('churned') AS ChurnedCustomers from ecommercechurn GROUP BY preferredlogindevice;
         
SELECT preferredlogindevice,
       SUM(CASE WHEN churn_status = 'churned' THEN 1 ELSE 0 END) AS ChurnedCustomers
FROM ecommercechurn
GROUP BY preferredlogindevice;
		

         
SELECT preferredlogindevice,
        CAST(SUM ('churned') * 1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS ChurnRate
FROM ecommercechurn
GROUP BY preferredlogindevice;

SELECT preferredlogindevice,
        CAST(COUNT(CASE WHEN column_name = 'churned' THEN 1 ELSE NULL END) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS ChurnRate
FROM ecommercechurn
GROUP BY preferredlogindevice;


SELECT preferredlogindevice, 
        COUNT(*) AS TotalCustomers,
        SUM(churn) AS ChurnedCustomers,
        CAST(SUM (churn) * 1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS ChurnRate
FROM ecommercechurn
GROUP BY preferredlogindevice;

select * from ecommercechurn;


-- 3. What is the distribution of customers across different city tiers?

SELECT 
    citytier,
    COUNT(*) AS TotalCustomer,
    SUM(churn) AS churendCustomers,
    CAST(SUM(churn) * 1.0 / COUNT(*) * 100 AS DECIMAL (10 , 2 )) AS ChurnRate
FROM
    ecommercechurn
GROUP BY citytier
ORDER BY churnrate DESC;

-- 4. Is there any correlation between the warehouse-to-home distance and customer churn? -- 

ALTER TABLE ecommercechurn
ADD warehousetohomerange NVARCHAR(50);

UPDATE ecommercechurn
SET warehousetohomerange =
CASE 
    WHEN warehousetohome <= 10 THEN 'Very close distance'
    WHEN warehousetohome > 10 AND warehousetohome <= 20 THEN 'Close distance'
    WHEN warehousetohome > 20 AND warehousetohome <= 30 THEN 'Moderate distance'
    WHEN warehousetohome > 30 THEN 'Far distance'
END;

update ecommercechurn 
set warehousetohomerange =
case 
	when warehousetohome <= 10 then 'very close distance'
    when warehousetohome > 10 and warehousetohome <= 20 then 'Close distance'
    when warehousetohome > 20 and warehousetohome <= 30 then 'Moderate distance'
    when warehousetohome > 30 then 'Far distace'
end;

select  distinctrow warehousetohomerange from ecommercechurn ;

-- Finding a correlation between warehouse to home and churn rate. -- 

SELECT 
    warehousetohomerange,
    COUNT(*) AS TotalCustomer,
    SUM(Churn) AS CustomerChurn,
    CAST(SUM(churn) * 1.0 / COUNT(*) * 100 AS DECIMAL (10 , 2 )) AS churnrate
FROM
    ecommercechurn
GROUP BY warehousetohomerange
ORDER BY Churnrate DESC;

select count(*) from ecommercechurn;


-- 5. Which is the most preferred payment mode among churned customers?

SELECT preferredpaymentmode,
       COUNT(*) AS TotalCustomer,
       SUM(Churn) AS CustomerChurn,
       CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL(10,2)) AS Churnrate
FROM ecommercechurn
GROUP BY preferredpaymentmode
ORDER BY Churnrate DESC;

-- 6. What is the typical tenure for churned customers?

ALTER TABLE ecommercechurn
ADD TenureRange NVARCHAR(50);
UPDATE ecommercechurn
SET TenureRange =
CASE 
    WHEN tenure <= 6 THEN '6 Months'
    WHEN tenure > 6 AND tenure <= 12 THEN '1 Year'
    WHEN tenure > 12 AND tenure <= 24 THEN '2 Years'
    WHEN tenure > 24 THEN 'more than 2 years'
END;

-- Finding typical tenure for churned customers--

SELECT TenureRange,
       COUNT(*) AS TotalCustomer,
       SUM(Churn) AS CustomerChurn,
       CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL(10,2)) AS Churnrate
FROM ecommercechurn
GROUP BY TenureRange
ORDER BY Churnrate DESC;


-- 7. Is there any difference in churn rate between male and female customers?-- 

SELECT gender,
       COUNT(*) AS TotalCustomer,
       SUM(Churn) AS CustomerChurn,
       CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL(10,2)) AS Churnrate
FROM ecommercechurn
GROUP BY gender
ORDER BY Churnrate DESC;


-- 8. How does the average time spent on the app differ for churned and non-churned customers?-- 

SELECT customerstatus, avg(hourspendonapp) AS AverageHourSpentonApp
FROM ecommercechurn
GROUP BY customerstatus;


-- 9. Does the number of registered devices impact the likelihood of churn?--

SELECT NumberofDeviceRegistered,
       COUNT(*) AS TotalCustomer,
       SUM(Churn) AS CustomerChurn,
       CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL(10,2)) AS Churnrate
FROM ecommercechurn
GROUP BY NumberofDeviceRegistered
ORDER BY Churnrate DESC;


-- 10. Which order category is most preferred among churned customers?

SELECT preferedordercat,
       COUNT(*) AS TotalCustomer,
       SUM(Churn) AS CustomerChurn,
       CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL(10,2)) AS Churnrate
FROM ecommercechurn
GROUP BY preferedordercat
ORDER BY Churnrate DESC;


-- 11. Is there any relationship between customer satisfaction scores and churn?--

SELECT satisfactionscore,
       COUNT(*) AS TotalCustomer,
       SUM(Churn) AS CustomerChurn,
       CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL(10,2)) AS Churnrate
FROM ecommercechurn
GROUP BY satisfactionscore
ORDER BY Churnrate DESC;

-- 12. Does the marital status of customers influence churn behavior?--

SELECT maritalstatus,
       COUNT(*) AS TotalCustomer,
       SUM(Churn) AS CustomerChurn,
       CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL(10,2)) AS Churnrate
FROM ecommercechurn
GROUP BY maritalstatus
ORDER BY Churnrate DESC;


-- 13. How many addresses do churned customers have on average?--

SELECT AVG(numberofaddress) AS Averagenumofchurnedcustomeraddress
FROM ecommercechurn
WHERE customerstatus = 'stayed';

-- 14. Do customer complaints influence churned behavior?

SELECT complainrecieved,
       COUNT(*) AS TotalCustomer,
       SUM(Churn) AS CustomerChurn,
       CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL(10,2)) AS Churnrate
FROM ecommercechurn
GROUP BY complainrecieved
ORDER BY Churnrate DESC;


-- 15. How does the use of coupons differ between churned and non-churned customers?-- 

SELECT customerstatus, SUM(couponused) AS SumofCouponUsed
FROM ecommercechurn
GROUP BY customerstatus;

-- 16. What is the average number of days since the last order for churned customers?--

SELECT AVG(daysincelastorder) AS AverageNumofDaysSinceLastOrder
FROM ecommercechurn
WHERE customerstatus = 'churned';


-- 17. Is there any correlation between cashback amount and churn rate?--

ALTER TABLE ecommercechurn
ADD cashbackamountrange NVARCHAR(50);

UPDATE ecommercechurn
SET cashbackamountrange =
CASE 
    WHEN cashbackamount <= 100 THEN 'Low Cashback Amount'
    WHEN cashbackamount > 100 AND cashbackamount <= 200 THEN 'Moderate Cashback Amount'
    WHEN cashbackamount > 200 AND cashbackamount <= 300 THEN 'High Cashback Amount'
    WHEN cashbackamount > 300 THEN 'Very High Cashback Amount'
END;


select distinctrow
cashbackamountrange from ecommercechurn;


-- Finding the correlation between cashback amount range and churned rate-- 

SELECT cashbackamountrange,
       COUNT(*) AS TotalCustomer,
       SUM(Churn) AS CustomerChurn,
       CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL(10,2)) AS Churnrate
FROM ecommercechurn
GROUP BY cashbackamountrange
ORDER BY Churnrate DESC;



select * from ecommercechurn;











