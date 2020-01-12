DECLARE 
  P_NO NUMBER(10) DEFAULT 1000;
BEGIN
  P_NO := P_NO + 100;
  DBMS_OUTPUT.PUT_LINE(P_NO);
END;  

---------------------------------------------
DECLARE
 P_EMP_NO     HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
 P_FIRST_NAME HR.EMPLOYEES.FIRST_NAME%TYPE;
 P_LAST_NAME  HR.EMPLOYEES.LAST_NAME%TYPE;
BEGIN
 P_EMP_NO:=101;
 SELECT FIRST_NAME,LAST_NAME INTO P_FIRST_NAME,P_LAST_NAME
 FROM HR.EMPLOYEES WHERE EMPLOYEE_ID=P_EMP_NO;
 DBMS_OUTPUT.PUT_LINE(P_FIRST_NAME||' '||P_LAST_NAME);
END;
 
-----------------------------------------------------
SELECT * FROM HR.JOBS;
-----------------------------------------------------
DECLARE 
 P_JOB_ID  HR.JOBS.JOB_ID%TYPE;
 P_JOB_TITLE HR.JOBS.JOB_TITLE%TYPE;
 P_MIN_SALARY HR.JOBS.MIN_SALARY%TYPE;
 P_MAX_SALARY HR.JOBS.MAX_SALARY%TYPE;
BEGIN
 P_JOB_ID:='FI_MGR';
 P_JOB_TITLE:='Finance Manager';
 SELECT MIN_SALARY,MAX_SALARY INTO P_MIN_SALARY,P_MAX_SALARY
 FROM HR.JOBS WHERE JOB_ID=P_JOB_ID AND JOB_TITLE=P_JOB_TITLE;
 DBMS_OUTPUT.PUT_LINE(P_MIN_SALARY||'  '||P_MAX_SALARY);
END;
-------------------------------------------------------------
SELECT * FROM  HR.EMPLOYEES;
-------------------------------------------------------------
DECLARE 
 P_EMP_NO HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
 R_EMP HR.EMPLOYEES%ROWTYPE;
BEGIN
 P_EMP_NO :=100;
 SELECT * INTO R_EMP
 FROM HR.EMPLOYEES
 WHERE EMPLOYEE_ID=P_EMP_NO;
 DBMS_OUTPUT.PUT_LINE(R_EMP.FIRST_NAME||' '||R_EMP.LAST_NAME||' '||R_EMP.PHONE_NUMBER);
END;
-------------------------------------------------------------
SELECT * FROM  HR.JOBS;
-------------------------------------------------------------
DECLARE
  P_JOBS HR.JOBS%ROWTYPE;
  P_JOBS_ID HR.JOBS.JOB_ID%TYPE;
BEGIN
  P_JOBS_ID:='AD_PRES';
  SELECT * INTO P_JOBS
  FROM HR.JOBS
  WHERE JOB_ID=P_JOBS_ID;
  DBMS_OUTPUT.PUT_LINE(P_JOBS.MIN_SALARY||' '||P_JOBS.MAX_SALARY);
END;
--------------------------------------------------------------
DECLARE
 P_EMP_NO HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
 TYPE EMP_ISIM_TYPE IS RECORD (
    FIRST_NAME HR.EMPLOYEES.FIRST_NAME%TYPE,
    LAST_NAME  HR.EMPLOYEES.LAST_NAME%TYPE,
    SALARY NUMBER,
    PHONE_NUMBER HR.EMPLOYEES.PHONE_NUMBER%TYPE
 );
 EMP_ISIM EMP_ISIM_TYPE;
BEGIN
 P_EMP_NO:=100;
 SELECT FIRST_NAME,LAST_NAME ,SALARY,PHONE_NUMBER INTO EMP_ISIM
 FROM  HR.EMPLOYEES WHERE EMPLOYEE_ID=P_EMP_NO;
 DBMS_OUTPUT.PUT_LINE(EMP_ISIM.FIRST_NAME||' '||EMP_ISIM.LAST_NAME
  ||' '||EMP_ISIM.SALARY
  ||' '||EMP_ISIM.PHONE_NUMBER);
END;  

--------------------------------------------------------------
DECLARE 

 TYPE DIZI_TYPE IS VARRAY(5) OF NUMBER;
 DIZI DIZI_TYPE := DIZI_TYPE(10,20,10,1,20);
BEGIN
 DBMS_OUTPUT.PUT_LINE(DIZI(1)+DIZI(2));
END; 
---------------------------------------------------------------
DECLARE 
 TYPE ARRAY_TYPE IS VARRAY(5) OF NUMBER;
 ARRAY_ ARRAY_TYPE:=ARRAY_TYPE(10,100,10,1,20);
BEGIN 
 DBMS_OUTPUT.PUT_LINE(ARRAY_(1)+ARRAY_(2));
END; 
--------------------------------------------------------------
DECLARE 
  P_EMP_NO HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
  R_EMP HR.EMPLOYEES%ROWTYPE;
BEGIN
 P_EMP_NO:=100;
 SELECT * INTO R_EMP FROM HR.EMPLOYEES WHERE EMPLOYEE_ID=P_EMP_NO;
 IF R_EMP.SALARY > 10000 THEN
    DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' YUKSEK');
 ELSIF r_emp.salary >1000 AND r_emp.salary<=10000 THEN
      DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' ORTA');
 ELSE 
       DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||'DUSUK');
 END IF;
END;
---------------------------------------------------------------
DECLARE
  P_EMP_NO HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
  R_EMP HR.EMPLOYEES%ROWTYPE;
  I PLS_INTEGER:=100;
BEGIN
   WHILE I<110 LOOP
     SELECT * INTO R_EMP FROM HR.EMPLOYEES WHERE 
     EMPLOYEE_ID=I;
     
    IF R_EMP.SALARY > 10000 THEN
    DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' YUKSEK');
    ELSIF r_emp.salary >1000 AND r_emp.salary<=10000 THEN
      DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' ORTA');
    ELSE 
       DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||'DUSUK');
    END IF;
    I:=I+1;
   END LOOP;
END;
----------------------------------------------------------
DECLARE
   P_EMP_NO HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
   R_EMP HR.EMPLOYEES%ROWTYPE;
BEGIN 
   FOR I IN REVERSE 100..120 LOOP
   SELECT * INTO R_EMP 
   FROM HR.EMPLOYEES
   WHERE EMPLOYEE_ID=I;
   IF R_EMP.SALARY > 10000 THEN
    DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' YUKSEK');
    ELSIF r_emp.salary >1000 AND r_emp.salary<=10000 THEN
      DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' ORTA');
    ELSE 
       DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||'DUSUK');
    END IF;
    END LOOP;
END;    
-----------------------------------------------------------
-- PRINT ALL PERONS IN HR.EMPLOYEES
DECLARE
   CURSOR C_EMP IS SELECT * FROM HR.EMPLOYEES;
BEGIN
  FOR R_EMP IN C_EMP LOOP
  DBMS_OUTPUT.PUT_LINE(R_EMP.FIRST_NAME||' '||C_EMP%ROWCOUNT);
  END LOOP;
END;  
-------------------------------------------------------------
DECLARE
    CURSOR c_emp IS SELECT * FROM hr.employees;
    r_emp c_emp%ROWTYPE; 
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO r_emp;
        EXIT WHEN c_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(r_emp.first_name||' '||r_emp.salary||' '||c_emp%ROWCOUNT);
    END LOOP;
    
    CLOSE c_emp;
END  ;
-----------------------------------------------------------------
declare
   cursor c_job is select * from hr.jobs;
   e_job c_job%rowtype;
begin
   open c_job;
  loop
     fetch c_job into e_job;
     EXIT WHEN c_job%NOTFOUND;
             DBMS_OUTPUT.PUT_LINE(
                    e_job.job_id
             ||' '||e_job.MAX_SALARY
             ||' '||e_job.MIN_SALARY
             ||' '||c_job%rowcount);
  end loop;
    close c_job;
end;
-------------------------------------------------
--Tüm departmentleri yazdırınız
declare
  cursor c_dprt is select * from hr.departments;
  p_dpert c_dprt%rowtype;
begin
  open c_dprt;
  loop
  fetch c_dprt into p_dpert;
  EXIT WHEN c_dprt%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE(
                    p_dpert.DEPARTMENT_ID
             ||' '||p_dpert.DEPARTMENT_NAME
             ||' '||p_dpert.MANAGER_ID
             ||' '||c_dprt%rowcount);
 end loop;
 close c_dprt;
 end;
 ----------------------------------------------
 create table kisi (select * from hr.employees)
create or replace package per as
 function get_peronsel_sayi(p_daprt_id in number) return number;
 function get_peronsel_name(p_personel_id in number)  return varchar;
 PROCEDURE maas_azalt;
end per;

create or replace  package body per as 
   function get_peronsel_sayi(p_daprt_id in number) return number as
   cursor c_peronel_sayi is 
   select count(*) from hr.employees where department_id=p_daprt_id;
   sounc number;
   begin
   open c_peronel_sayi;
   fetch c_peronel_sayi into  sounc;
   close c_peronel_sayi;
   return sounc;
end;
  function get_peronsel_name(p_personel_id in number)  return varchar as
   cursor c_per is select (FIRST_NAME ||'  '||LAST_NAME) from kisi where EMPLOYEE_ID=p_personel_id;
   isim varchar(20);
   begin
   open c_per;
   fetch c_per into isim;
   close c_per;
   return isim;
end;
  PROCEDURE maas_azalt is 
  cursor c_emp is 
  select * from kisi;
  r_emp hr.employees%rowtype;
  begin
  open c_emp;
  fetch c_emp into r_emp;
  close c_emp;
  update kisi set salary=salary*0.9
  where employee_id=r_emp.employee_id;
  commit;
end;
end per;
select per.get_peronsel_sayi(d.department_id) from hr.departments d;
select per.get_peronsel_name(k.employee_id) isimler from kisi k ;
select * from kisi;

