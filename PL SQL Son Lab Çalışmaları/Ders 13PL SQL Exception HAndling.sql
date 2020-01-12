DECLARE

BEGIN 
  INSERT INTO jobs
  (job_id,job_title)
  VALUES
  ('AD_PRES','AD_PRES');
exception WHEN dup_val_on_index THEN
  dbms_output.put_line('Çift kay?t hatas?'); 
END;