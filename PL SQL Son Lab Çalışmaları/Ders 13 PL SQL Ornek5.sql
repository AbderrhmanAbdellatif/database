DECLARE
  TYPE emp_table_type IS TABLE OF employees%rowtype;
  emp_table emp_table_type;
  CURSOR c_emp IS SELECT * FROM employees
                  ORDER BY first_name,last_name;
BEGIN 
  OPEN c_emp;
  fetch c_emp BULK COLLECT INTO emp_table;
  CLOSE c_emp;
  
  FOR i IN emp_table.FIRST..emp_table.LAST-1 loop
 
    IF (substr(emp_table(i).first_name,1,1)<> substr(emp_table(i+1).first_name,1,1)
        AND emp_table(i).salary<15001) THEN
        UPDATE employees
        SET salary=15000
        WHERE employee_id=emp_table(i).employee_id;
        dbms_output.put_line(emp_table(i).first_name ||emp_table(i+1).first_name||emp_table(i+1).salary   );
    END IF;
  END loop;
  COMMIT;
   dbms_output.put_line('Tamamland?');
END;