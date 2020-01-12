DECLARE 
  emp_count PLS_INTEGER;
BEGIN
  SELECT count(*) INTO emp_count FROM employees;
  dbms_output.put_line('Emp adet: ' || emp_count);
  remove_emp(101);
  SELECT count(*) INTO emp_count FROM employees;
  DBMS_OUTPUT.PUT_LINE('Emp adet: ' || emp_count);
  
END;