CREATE OR REPLACE TRIGGER employees_delete_log 
AFTER DELETE ON EMPLOYEES 
REFERENCING OLD AS OLD NEW AS NEW 
FOR EACH ROW 
BEGIN
   INSERT INTO emp_log
   (employee_id, first_name, last_name)
   VALUES
   (:OLD.employee_id, :OLD.first_name, :OLD.last_name);
END;


DELETE employees
WHERE employee_id=120


SELECT * FROM jobs