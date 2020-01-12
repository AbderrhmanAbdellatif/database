CREATE OR REPLACE FUNCTION get_max_sal_emp_id
RETURN NUMBER IS
 
  CURSOR c_max_sal IS 
     SELECT MAX(salary) FROM employees;
   p_max_sal pls_integer;   
  CURSOR c_max_sal_emp(max_sal IN pls_integer) IS 
     SELECT employee_id
     FROM employees
     WHERE salary=max_sal;
  p_emp_id VARCHAR2(100);   
     
BEGIN
 OPEN c_max_sal;
 fetch c_max_sal INTO p_max_sal;
 CLOSE c_max_sal; 
 
 OPEN c_max_sal_emp(p_max_sal);
 fetch c_max_sal_emp INTO p_emp_id;
 CLOSE c_max_sal_emp;
 
 RETURN (p_emp_id);
END;

SELECT get_max_sal_emp_name() FROM dual

SELECT * FROM employees
WHERE employee_id=get_max_sal_emp_id()
