DECLARE
  p_adet PLS_INTEGER:=0;  
BEGIN
  FOR emp_rec IN (SELECT * FROM employees) loop
    p_adet:=p_adet+1;
  END loop;
  DBMS_OUTPUT.PUT_LINE('Toplam adet = '||p_adet);
END;