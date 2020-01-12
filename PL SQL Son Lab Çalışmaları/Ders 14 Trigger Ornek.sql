CREATE OR REPLACE PACKAGE emp_kontrol AS

FUNCTION emp_count(p_dept_id IN departments.department_id%TYPE) 
RETURN NUMBER;

END emp_kontrol;


CREATE OR REPLACE PACKAGE BODY emp_kontrol AS

FUNCTION emp_count(p_dept_id IN departments.department_id%TYPE) 
RETURN NUMBER AS
  CURSOR c_count IS
  SELECT count(*)
  FROM employees
  WHERE department_id=p_dept_id;
  p_adet NUMBER;
BEGIN
  OPEN c_count;
  fetch c_count INTO p_adet;
  CLOSE c_count;
  RETURN (p_adet);
  
END;

END emp_kontrol;


CREATE OR REPLACE TRIGGER emp_adet_control
BEFORE INSERT OR UPDATE ON employees
FOR EACH ROW 
DECLARE
  p_adet NUMBER;
BEGIN 
  p_adet:=emp_kontrol.emp_count(:NEW.deparment_id);
  IF p_adet>10 THEN
    raise_application_error(-20100,'Bir birimde 10''dan fazla ki?i çal??amaz.');
  END IF;
END; 

INSERT INTO employees
(employee_id,first_name,last_name, department_id,hire_date,email,job_id)
VALUES
(1109,'AHMET','AK',30,SYSDATE,'a@b.com8', 'SA_REP' );

SELECT emp_kontrol.emp_count(90) from dual

DELETE FROM employees
WHERE employee_id=1108


create or replace TRIGGER emp_silme_control
BEFORE DELETE OR UPDATE ON employees
FOR EACH ROW 
DECLARE
  p_adet NUMBER;
BEGIN 
  p_adet:=emp_kontrol.emp_count(:OLD.department_id);
  IF p_adet<=3 THEN
    raise_application_error(-20101,'Bir birimde 3''ten az ki?i çal??amaz.');
  END IF;
END;

SELECT * FROM employees
where department_id=33

UPDATE employees
SET salary=6000
WHERE employee_id=103

UPDATE employees
SET salary=emp_kontrol.emp_count(department_id)*1000
WHERE salary>10000


CREATE OR REPLACE TRIGGER dept_mgr_kontrol 
BEFORE INSERT OR UPDATE ON departments 
FOR EACH ROW 
DECLARE
  CURSOR c_emp
   IS SELECT department_id FROM employees
      WHERE employee_id=:NEW.manager_id;
  r_emp NUMBER;
BEGIN 
OPEN c_emp;
fetch c_emp INTO r_emp;
CLOSE c_emp;
   IF r_emp<>100 THEN
      raise_application_error(-20101,'Yöneticiler sadece genel müdürlükte çal??abilir.');
   END IF;
END; 

SELECT * FROM employees WHERE  department_id=100