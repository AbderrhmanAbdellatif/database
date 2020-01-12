CREATE OR REPLACE PROCEDURE remove_emp_return_count 
(p_employee_id NUMBER, tot_emps out NUMBER )  AS
  
BEGIN
   SELECT count(*)-1 INTO tot_emps FROM employees;
   DELETE FROM employees
   WHERE employee_id = p_employee_id; 
END;


