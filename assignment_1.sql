--------------------------------------------------------
--  File created - Thursday-June-18-2020   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure ASSIGNMENT_CURSOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "S4_GHATGE"."ASSIGNMENT_CURSOR" AS

BEGIN
  DECLARE
   
   cursor myCursor is    
               SELECT * FROM patients;
   currRow patients%ROWTYPE; 
  BEGIN
         open myCursor;
          
    LOOP
      fetch myCursor into currRow;  
       exit when (myCursor%NOTFOUND);
  
      DBMS_OUTPUT.put_line(currRow.fname || ',' || currRow.Lname);
      IF currRow.aptno IS NULL
       THEN
       DBMS_OUTPUT.PUT_LINE(currRow.streetno || ' ' || currRow.addr1 || ' ' || currRow.addr2 );
       DBMS_OUTPUT.PUT_LINE(currRow.city || ',' || currRow.prov || ',' || currRow.postalcode );
       ELSE
       DBMS_OUTPUT.PUT_LINE('#' ||currrow.aptno || '-' || currRow.streetno || ' ' || currRow.addr1  || ' ' || currRow.addr2 );
       DBMS_OUTPUT.PUT_LINE(currRow.city || ',' || currRow.prov || ',' || currRow.postalcode );
       
      END IF;
    
    
       IF (currRow.age > 40)
       THEN
       DBMS_OUTPUT.put_line('DEAR MR/MRS ' || currRow.lname || ',');
       ELSE
       DBMS_OUTPUT.put_line('DEAR ' || currRow.fname || ',');
      END IF;
         DBMS_OUTPUT.put_line('Thank you for being our patient. We wish you and your family a very nice holiday season and look ');
         DBMS_OUTPUT.put_line('forward to seeing you again in the new year');
         DBMS_OUTPUT.put_line('Sincerly,');
          DBMS_OUTPUT.put_line('Dr Keith Black');
            DBMS_OUTPUT.put_line('-----------------------------------------------------------------------------');
    END LOOP;
         close myCursor;
    
   END;
END ASSIGNMENT_CURSOR;

/
