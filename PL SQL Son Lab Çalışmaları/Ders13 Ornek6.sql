DECLARE
  CURSOR c_avg_sal IS 
     SELECT department_id,avg(salary) avg_sal
     FROM employees
     GROUP BY department_id ;
     
BEGIN
  FOR r_sal IN c_avg_sal loop
     UPDATE employees
     SET salary=r_sal.avg_sal
     WHERE department_id = r_sal.department_id
       AND salary>r_sal.avg_sal;
  END LOOP;
END;
