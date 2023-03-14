# 1
SELECT
E_name
FROM
employee_Details
WHERE
E_name LIKE 'A%A';#QUESTION 1
SELECT
E_name
FROM
employee_Details
WHERE
E_name LIKE 'A%A';
# 2
SELECT DISTINCT(E_name) FROM employee_details WHERE
E_name IN (SELECT C_name FROM customer AS cus);
#3
CREATE VIEW PaymentNotDone AS
SELECT * FROM logistics_Emp
WHERE PAYMENT_STATUS = 'NOT PAID';
SELECT * FROM PaymentNotDone;
#4
SET @total_count = 0;
SELECT COUNT(*) INTO @total_count FROM payment_details;
SELECT
PAYMENT_MODE,
ROUND((COUNT(PAYMENT_MODE) / @total_count) * 100,2)
AS Percentage_Contribution
FROM
Payment_Details
GROUP BY PAYMENT_MODE;
#5
ALTER TABLE logistics_Emp
ADD COLUMN TOTAL_PAYABLE_CHARGES FLOAT AFTER AMOUNT;
UPDATE logistics_Emp
SET TOTAL_PAYABLE_CHARGES = SH_CHARGES + AMOUNT;
SELECT TOTAL_PAYABLE_CHARGES FROM logistics_Emp;
#6
SELECT MAX(TOTAL_PAYABLE_CHARGES) FROM logistics_Emp;
#7
SELECT C_ID, C_NAME, START_DATE, END_DATE,
ROUND(DATEDIFF(END_DATE, START_DATE)/365,0)
AS Membership_Years FROM logistics_Emp
HAVING Membership_Years > 10;
#8
SELECT * FROM logistics_Emp
HAVING DATEDIFF(DELIVERY_DATE, SENT_DATE)=1;
#9
SELECT
SH_CONTENT, SUM(AMOUNT) AS Content_Wise_Amount
FROM
logistics_Emp
GROUP BY (SH_CONTENT)
ORDER BY Content_Wise_Amount DESC
LIMIT 5;
#10
SELECT SH_CONTENT, COUNT(SH_CONTENT)
AS Content_Wise_Count
FROM logistics_Emp
GROUP BY(SH_CONTENT)
ORDER BY Content_Wise_Count DESC
LIMIT 5;
#11
CREATE VIEW TXLogistics AS
SELECT * FROM logistics_Emp
WHERE E_BRANCH = 'TX';
SELECT * FROM TXLogistics;
#12
ALTER VIEW TXLogistics
AS SELECT *, AMOUNT - ((AMOUNT * 5)/100) AS New_Price
FROM logistics_Emp
WHERE E_BRANCH = 'TX';
SELECT * FROM TXLogistics;
#13
DROP VIEW TXLogistics;
#14
SELECT * FROM logistics_Emp WHERE E_BRANCH = 'NY';
UPDATE logistics_Emp
SET E_BRANCH = 'NJ'
WHERE E_BRANCH = 'NY';
SELECT * FROM logistics_Emp;
#15
SELECT DISTINCT(E_DESIGNATION) FROM Employee_Details;
#16
SET @total_count = 0;
SELECT COUNT(*) INTO @total_count FROM logistics_Emp;
SELECT C_TYPE, (COUNT(C_TYPE)/@total_count)*100
AS Contribution FROM logistics_Emp
GROUP BY C_TYPE;
#17
ALTER TABLE logistics_Emp
CHANGE SER_TYPE SERVICE_TYPE VARCHAR (15);
SELECT SERVICE_TYPE FROM logistics_emp;
#18
SELECT SERVICE_TYPE, COUNT(SERVICE_TYPE)
AS Frequency
FROM logistics_Emp
GROUP BY SERVICE_TYPE
ORDER BY Frequency DESC;
#19
SELECT SH_ID, SH_CONTENT, SH_WEIGHT FROM Shipment_Details
WHERE SH_WEIGHT > (SELECT AVG(SH_WEIGHT) FROM
Shipment_Details);
#QUESTION SSOT
CREATE TABLE logistics_Emp AS
SELECT
emp.E_ID, ship.SH_ID, Cust.C_ID, pmt.PAYMENT_ID,
memb.M_ID,
emp.E_NAME, emp.E_ADDR, emp.E_BRANCH,
emp.E_DESIGNATION, emp.E_CONT_NO,
ship.SH_DOMAIN, ship.SH_CONTENT,
ship.SR_ADDR, ship.SH_WEIGHT, ship.SER_TYPE, ship.SH_CHARGES,
cust.C_NAME, cust.C_TYPE, cust.C_ADDR,
cust.C_CONT_NO, cust.C_EMAIL_ID,
stat.SENT_DATE, stat.DELIVERY_DATE, stat.Current_Status,
pmt.AMOUNT, pmt.PAYMENT_STATUS, pmt.PAYMENT_DATE,
pmt.PAYMENT_MODE,
memb.Start_Date, memb.End_Date
FROM
EMPLOYEE_Details AS emp
INNER JOIN
employee_manages_shipment AS ems ON emp.E_ID = ems.Employee_E_ID
INNER JOIN
SHIPMENT_Details AS ship ON ship.SH_ID = ems.Shipment_SH_ID
INNER JOIN
customer AS cust ON Cust.C_ID = ship.C_ID
INNER JOIN
STATUS AS stat ON ship.SH_ID = stat.SH_ID
INNER JOIN
payment_details AS pmt ON ship.SH_ID = pmt.SH_ID
INNER JOIN
MEMBERSHIP AS memb ON memb.M_ID = cust.M_ID;
select * from logistics_Emp;
