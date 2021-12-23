--1 Write a pl/sql block to find out how many cars has a salesman sold.
--  You have to prompt the user for the salesman name.  Use SI database

set serveroutput on;
DECLARE
   salemen varchar2(20) :='&salemen';
   c_custname si.saleinv.custname%TYPE;
BEGIN

SELECT COUNT(custname)  INTO c_custname FROM si.saleinv WHERE
    salesman LIKE UPPER(salemen);
 
dbms_output.put_line('Total number of car that  ' ||salemen|| 'sold are:'||c_custname);

END;
/

--2 Write a pl/sql script to create a procedure that receives argument as servinv# 
--and prints the service information corresponding to that servinv#. Write appropriate procedure call. Use SI database.

CREATE OR REPLACE PROCEDURE serviceNum
    (servin si.servinv.servinvno%type)
IS
    serv_Date si.servinv.servdate%type;
    cust_Name si.servinv.custname%type;
    car_Serial si.servinv.carserial%type;
    parts_Cost si.servinv.partscost%type;
    labor_Cost si.servinv.laborcost%type;
    tax_Rate si.servinv.taxrate%type;
BEGIN
    SELECT servdate, custname, carserial, partscost, laborcost, taxrate 
    into serv_Date, cust_Name, car_Serial, parts_Cost, labor_Cost, tax_Rate
    from si.servinv
    where servinvno=servin;
    DBMS_output.put_line('SERVINV No: '|| servin || ' SERVDATE' || serv_Date ||' CUSTName: '||cust_Name||
    ' CARSERIAL: '||car_Serial|| ' PARTSCOST: '||parts_cost||
    ' LABORCOST: '||labor_Cost||' TAXRATE: '||tax_Rate);
END;
/
Execute serviceNum('W1823');

--3 Create a pl/sql script to print the average sale price of the cars
--sold for each make and model, having the average sale price greater than 400500. Use SI database
DECLARE
carsale_Price NUMBER; 
car_Make VARCHAR2(10);
car_Model VARCHAR2(10);

    
    cursor averagesp IS 
    SELECT c.carmake, c.carmodel, AVG(s.carsaleprice)
        INTO car_Make,car_Model,carsale_Price
    FROM SI.car c
        INNER JOIN SI.saleinv s
        ON c.carserial=s.carserial
        GROUP BY c.carmake, c.carmodel
        HAVING AVG(s.carsaleprice) > 400500;
    
BEGIN
    OPEN averagesp;
    
    LOOP
    FETCH averagesp into car_Make, car_Model, carsale_Price;
    EXIT WHEN(averagesp%NOTFOUND);
    
    dbms_output.put_line('CARMAKE :' || car_Make || ' ' || 'CARMODEL :' || car_Model || ' '
    || 'AVGSALEPRICE : '||carsale_Price);
    END LOOP;

CLOSE averagesp;
END;
/

  
--4 Write a pl/sql script to create a function that receives argument as Department 
--Name and returns total number of Employees working in that Department. Write appropriate function call. Use HR database

CREATE OR REPLACE FUNCTION totalEmp
(
dept_Name IN hr.departments.department_name%TYPE
)
RETURN NUMBER IS totalcount NUMBER;

BEGIN
    SELECT COUNT(*) INTO totalcount from hr.Employees e inner join hr.departments d 
    on (d.department_id=e.department_id) where d.department_name= dept_Name;
    
RETURN totalcount;
END;
/



--FUNCTION CALLS
DECLARE
    total hr.departments.department_name%TYPE;
BEGIN
total := totalEmp('IT');
dbms_output.put_line('Total Number of Employees working in IT department is '|| total);


END;
/
