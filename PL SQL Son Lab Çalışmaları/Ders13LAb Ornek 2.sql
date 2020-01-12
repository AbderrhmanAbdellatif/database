CREATE OR REPLACE FUNCTION get_personel_count
RETURN NUMBER IS
  p_adet pls_integer:=0;
  CURSOR c_emp IS 
     SELECT * FROM employees;
BEGIN
  FOR emp_rec IN c_emp LOOP
    p_adet:=p_adet+1;
  END loop;
  dbms_output.put_line('Toplam adet = '||p_adet);
  return (p_adet);
END;

DECLARE 
BEGIN
  dbms_output.put_line('Toplam adet = '||get_personel_count());
END;