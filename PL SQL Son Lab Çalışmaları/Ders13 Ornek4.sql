CREATE OR REPLACE FUNCTION get_max_sal_emp_name 
RETURN VARCHAR2 IS
 
  CURSOR c_max_sal IS 
     SELECT MAX(salary) FROM employees;
   p_max_sal pls_integer;   
  CURSOR c_max_sal_emp(max_sal IN pls_integer) IS 
     SELECT first_name||' '||last_name 
     FROM employees
     WHERE salary=max_sal;
  p_emp_name VARCHAR2(100);   
     
BEGIN
 OPEN c_max_sal;
 fetch c_max_sal INTO p_max_sal;
 CLOSE c_max_sal; 
 
 OPEN c_max_sal_emp(p_max_sal);
 fetch c_max_sal_emp INTO p_emp_name;
 CLOSE c_max_sal_emp;
 
 RETURN (p_emp_name);
END;