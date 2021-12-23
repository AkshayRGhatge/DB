create table car1 as select * from si.car;

select * from car1;

--1 
create index index_cust_name on car1(carserial,custname);   
--2
select * from car1 where caryear IN(1998,2000) 
and extcolor IN('BLACK','BLUE');
--3
create bitmap index bitmap_cust_name on car1(caryear,extcolor);
--4
create table emp1 as select * from hr.employees;


