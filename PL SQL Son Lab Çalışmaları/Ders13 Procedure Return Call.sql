DECLARE 
  emp_count PLS_INTEGER;
BEGIN
  SELECT count(*) INTO emp_count FROM employees;
  dbms_output.put_line('Emp adet: ' || emp_count);
  remove_emp_return_count(101,emp_count);
  DBMS_OUTPUT.PUT_LINE('Emp adet: ' || emp_count);
  
END;