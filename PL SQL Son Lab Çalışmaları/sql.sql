CREATE OR REPLACE PACKAGE p_pack AS  
       FUNCTION get_personel_sayi(p_department_id in number) return number; 
     
END;

 CREATE OR REPLACE PACKAGE BODY p_pack AS  
       FUNCTION get_personel_sayi(p_department_id in number) return number as 
       cursor c_per_sayi is  
       select count(*) from hr.employees 
       where department_id=p_department_id; 
       sounc number; 
      BEGIN 
       open c_per_Sayi; 
       fetch c_per_sayi into sounc; 
       close c_per_Sayi; 
END; 
 
END p_pack;