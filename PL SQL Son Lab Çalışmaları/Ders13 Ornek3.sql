CREATE OR REPLACE FUNCTION get_dept_emp_count
(p_department_id IN NUMBER)
RETURN NUMBER IS
  p_adet pls_integer:=0;
  CURSOR c_emp IS 
     SELECT count(*) FROM employees
     WHERE department_id=p_department_id;
BEGIN
 OPEN c_emp;
 fetch c_emp INTO p_adet;
 CLOSE c_emp;
 RETURN (p_adet);
END;

SELECT department_name,GET_DEPT_EMP_COUNT(department_id)
FROM departments