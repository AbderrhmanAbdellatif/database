DECLARE 
  P_NO NUMBER(10) DEFAULT 1000;
BEGIN
  P_NO := P_NO + 100;
  DBMS_OUTPUT.PUT_LINE(P_NO);
END;  

---------------------------------------------
DECLARE
 P_EMP_NO     HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
 P_FIRST_NAME HR.EMPLOYEES.FIRST_NAME%TYPE;
 P_LAST_NAME  HR.EMPLOYEES.LAST_NAME%TYPE;
BEGIN
 P_EMP_NO:=101;
 SELECT FIRST_NAME,LAST_NAME INTO P_FIRST_NAME,P_LAST_NAME
 FROM HR.EMPLOYEES WHERE EMPLOYEE_ID=P_EMP_NO;
 DBMS_OUTPUT.PUT_LINE(P_FIRST_NAME||' '||P_LAST_NAME);
END;
 
-----------------------------------------------------
SELECT * FROM HR.JOBS;
-----------------------------------------------------
DECLARE 
 P_JOB_ID  HR.JOBS.JOB_ID%TYPE;
 P_JOB_TITLE HR.JOBS.JOB_TITLE%TYPE;
 P_MIN_SALARY HR.JOBS.MIN_SALARY%TYPE;
 P_MAX_SALARY HR.JOBS.MAX_SALARY%TYPE;
BEGIN
 P_JOB_ID:='FI_MGR';
 P_JOB_TITLE:='Finance Manager';
 SELECT MIN_SALARY,MAX_SALARY INTO P_MIN_SALARY,P_MAX_SALARY
 FROM HR.JOBS WHERE JOB_ID=P_JOB_ID AND JOB_TITLE=P_JOB_TITLE;
 DBMS_OUTPUT.PUT_LINE(P_MIN_SALARY||'  '||P_MAX_SALARY);
END;
-------------------------------------------------------------
SELECT * FROM  HR.EMPLOYEES;
-------------------------------------------------------------
DECLARE 
 P_EMP_NO HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
 R_EMP HR.EMPLOYEES%ROWTYPE;
BEGIN
 P_EMP_NO :=100;
 SELECT * INTO R_EMP
 FROM HR.EMPLOYEES
 WHERE EMPLOYEE_ID=P_EMP_NO;
 DBMS_OUTPUT.PUT_LINE(R_EMP.FIRST_NAME||' '||R_EMP.LAST_NAME||' '||R_EMP.PHONE_NUMBER);
END;
-------------------------------------------------------------
SELECT * FROM  HR.JOBS;
-------------------------------------------------------------
DECLARE
  P_JOBS HR.JOBS%ROWTYPE;
  P_JOBS_ID HR.JOBS.JOB_ID%TYPE;
BEGIN
  P_JOBS_ID:='AD_PRES';
  SELECT * INTO P_JOBS
  FROM HR.JOBS
  WHERE JOB_ID=P_JOBS_ID;
  DBMS_OUTPUT.PUT_LINE(P_JOBS.MIN_SALARY||' '||P_JOBS.MAX_SALARY);
END;
--------------------------------------------------------------
DECLARE
 P_EMP_NO HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
 TYPE EMP_ISIM_TYPE IS RECORD (
    FIRST_NAME HR.EMPLOYEES.FIRST_NAME%TYPE,
    LAST_NAME  HR.EMPLOYEES.LAST_NAME%TYPE,
    SALARY NUMBER,
    PHONE_NUMBER HR.EMPLOYEES.PHONE_NUMBER%TYPE
 );
 EMP_ISIM EMP_ISIM_TYPE;
BEGIN
 P_EMP_NO:=100;
 SELECT FIRST_NAME,LAST_NAME ,SALARY,PHONE_NUMBER INTO EMP_ISIM
 FROM  HR.EMPLOYEES WHERE EMPLOYEE_ID=P_EMP_NO;
 DBMS_OUTPUT.PUT_LINE(EMP_ISIM.FIRST_NAME||' '||EMP_ISIM.LAST_NAME
  ||' '||EMP_ISIM.SALARY
  ||' '||EMP_ISIM.PHONE_NUMBER);
END;  

--------------------------------------------------------------
DECLARE 

 TYPE DIZI_TYPE IS VARRAY(5) OF NUMBER;
 DIZI DIZI_TYPE := DIZI_TYPE(10,20,10,1,20);
BEGIN
 DBMS_OUTPUT.PUT_LINE(DIZI(1)+DIZI(2));
END; 
---------------------------------------------------------------
DECLARE 
 TYPE ARRAY_TYPE IS VARRAY(5) OF NUMBER;
 ARRAY_ ARRAY_TYPE:=ARRAY_TYPE(10,100,10,1,20);
BEGIN 
 DBMS_OUTPUT.PUT_LINE(ARRAY_(1)+ARRAY_(2));
END; 
--------------------------------------------------------------
DECLARE 
  P_EMP_NO HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
  R_EMP HR.EMPLOYEES%ROWTYPE;
BEGIN
 P_EMP_NO:=100;
 SELECT * INTO R_EMP FROM HR.EMPLOYEES WHERE EMPLOYEE_ID=P_EMP_NO;
 IF R_EMP.SALARY > 10000 THEN
    DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' YUKSEK');
 ELSIF r_emp.salary >1000 AND r_emp.salary<=10000 THEN
      DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' ORTA');
 ELSE 
       DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||'DUSUK');
 END IF;
END;
---------------------------------------------------------------
DECLARE
  P_EMP_NO HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
  R_EMP HR.EMPLOYEES%ROWTYPE;
  I PLS_INTEGER:=100;
BEGIN
   WHILE I<110 LOOP
     SELECT * INTO R_EMP FROM HR.EMPLOYEES WHERE 
     EMPLOYEE_ID=I;
     
    IF R_EMP.SALARY > 10000 THEN
    DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' YUKSEK');
    ELSIF r_emp.salary >1000 AND r_emp.salary<=10000 THEN
      DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' ORTA');
    ELSE 
       DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||'DUSUK');
    END IF;
    I:=I+1;
   END LOOP;
END;
----------------------------------------------------------
DECLARE
   P_EMP_NO HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
   R_EMP HR.EMPLOYEES%ROWTYPE;
BEGIN 
   FOR I IN REVERSE 100..120 LOOP
   SELECT * INTO R_EMP 
   FROM HR.EMPLOYEES
   WHERE EMPLOYEE_ID=I;
   IF R_EMP.SALARY > 10000 THEN
    DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' YUKSEK');
    ELSIF r_emp.salary >1000 AND r_emp.salary<=10000 THEN
      DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||' ORTA');
    ELSE 
       DBMS_OUTPUT.PUT_LINE(R_EMP.SALARY||'DUSUK');
    END IF;
    END LOOP;
END;    
-----------------------------------------------------------
-- PRINT ALL PERONS IN HR.EMPLOYEES
DECLARE
   CURSOR C_EMP IS SELECT * FROM HR.EMPLOYEES;
BEGIN
  FOR R_EMP IN C_EMP LOOP
  DBMS_OUTPUT.PUT_LINE(R_EMP.FIRST_NAME||' '||C_EMP%ROWCOUNT);
  END LOOP;
END;  
-------------------------------------------------------------
DECLARE
    CURSOR c_emp IS SELECT * FROM hr.employees;
    r_emp c_emp%ROWTYPE; 
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO r_emp;
        EXIT WHEN c_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(r_emp.first_name||' '||r_emp.salary||' '||c_emp%ROWCOUNT);
    END LOOP;
    
    CLOSE c_emp;
END  ;
-----------------------------------------------------------------
declare
   cursor c_job is select * from hr.jobs;
   e_job c_job%rowtype;
begin
   open c_job;
  loop
     fetch c_job into e_job;
     EXIT WHEN c_job%NOTFOUND;
             DBMS_OUTPUT.PUT_LINE(
                    e_job.job_id
             ||' '||e_job.MAX_SALARY
             ||' '||e_job.MIN_SALARY
             ||' '||c_job%rowcount);
  end loop;
    close c_job;
end;
-------------------------------------------------
--Tüm departmentleri yazdırınız
declare
  cursor c_dprt is select * from hr.departments;
  p_dpert c_dprt%rowtype;
begin
  open c_dprt;
  loop
  fetch c_dprt into p_dpert;
  EXIT WHEN c_dprt%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE(
                    p_dpert.DEPARTMENT_ID
             ||' '||p_dpert.DEPARTMENT_NAME
             ||' '||p_dpert.MANAGER_ID
             ||' '||c_dprt%rowcount);
 end loop;
 close c_dprt;
 end;
 ----------------------------------------------
 create table kisi (select * from hr.employees)
create or replace package per as
 function get_peronsel_sayi(p_daprt_id in number) return number;
 function get_peronsel_name(p_personel_id in number)  return varchar;
 PROCEDURE maas_azalt;
end per;

create or replace  package body per as 
   function get_peronsel_sayi(p_daprt_id in number) return number as
   cursor c_peronel_sayi is 
   select count(*) from hr.employees where department_id=p_daprt_id;
   sounc number;
   begin
   open c_peronel_sayi;
   fetch c_peronel_sayi into  sounc;
   close c_peronel_sayi;
   return sounc;
end;
  function get_peronsel_name(p_personel_id in number)  return varchar as
   cursor c_per is select (FIRST_NAME ||'  '||LAST_NAME) from kisi where EMPLOYEE_ID=p_personel_id;
   isim varchar(20);
   begin
   open c_per;
   fetch c_per into isim;
   close c_per;
   return isim;
end;
  PROCEDURE maas_azalt is 
  cursor c_emp is 
  select * from kisi;
  r_emp hr.employees%rowtype;
  begin
  open c_emp;
  fetch c_emp into r_emp;
  close c_emp;
  update kisi set salary=salary*0.9
  where employee_id=r_emp.employee_id;
  commit;
end;
end per;
select per.get_peronsel_sayi(d.department_id) from hr.departments d;
select per.get_peronsel_name(k.employee_id) isimler from kisi k ;
select * from kisi;
------------------------------------------------------------------------
create or replace procedure emp_up(
  p_emp_id in number,
  p_salary in number,
  p_hatali out varchar2,
  p_update_number out number ) as 
begin
 p_hatali:='hatali';
 update  kisi 
 set salary=p_salary
 where employee_id=p_emp_id;
 p_hatali:='islem tamam';
 p_update_number:= sql%rowcount;
end emp_up;

declare 
   sounc varchar2(70);
   p_kayit_Sayisi number;
begin
  emp_up(100,500,sounc,p_kayit_Sayisi);
  DBMS_OUTPUT.PUT_LINE(sounc ||' '||p_kayit_sayisi);
end;
  
select * from kisi;
-----------------------------------------------------------------------
--Personellerin maaşının azalmasını engelleyen bir trigger yazınız.
create or replace trigger personel_maas_kontorl
before update of salary on kisi
REFERENCING old as old new as new
FOR EACH ROW
begin 
  if :new.salary<:old.salary then
     raise_application_error(-20101,'maas azalamaz');
  end if;
end ;

CREATE OR REPLACE TRIGGER PERSONEL_SAYI_KONTROL
AFTER INSERT OR UPDATE ON kisi 
REFERENCING old AS old new AS new
FOR EACH ROW
DECLARE
    p_sayi NUMBER;
BEGIN
    p_sayi:=personel_pack.get_personel_sayi(:new.department_id);
    IF (p_sayi>10) THEN
        RAISE_APPLICATION_ERROR(-20101,'Birimlerde 10 kişiden fazla çalışamaz.');
    END IF;
END;
----------------------------------------------------------------------------------
-- 2. İstanbul’da yaşayan öğrencilerin aldığı derslerin isimlerini ANSI EQUI ve INNER bileşkeyle bulunuz. 

select * from ogrenci o , ders s , not n where o.ogrenci_id=n.ogrenci_id
 and 
 n.ders_id=s.ders_id and
 aders_il='istanbul'
 
 
 select * from ogrenci o inner join ders_not using(ogrenci_id)
 inner join ders using(ders_id) where aders_il='istanbul' 
 
 -- BA notu 70-80 aralığındaysa kaç öğrencinin 2011 yılında herhangi bir dersten ‘BA’ aldığını bulunuz
 
 select count(*) from  ogrenci o , not n , ders d 
 where ( not between 70 AND 80 ) and yil='2011'  
 
 select count(*) from  ogrenci where ogrenci_id in (
    select ogrenci_id from not n , ders d where n.ders_id=d.ders_id
   	 and yil='2011' and 
	 n.not between 70 and 80  
   ) 
-- Hem Matematik hem fizik dersinde öğrencilerin ortalaması aynı olan illeri bulunuz.
 select Adres_id from OGRENCI where ogrenci_id in (
 select ogrenci_id from 
 (select ogrenci_id,Avg(NOT) ortf from  ogrenci o , not n , ders d where o.ogrenci_id=n.ogrenci_id 
 and n.ders_id=d.ders_id and n.ders_id='FIZ' GROUP BY ogrenci_id) fizik ,
 (select ogrenci_id,Avg(NOT) ortm from  ogrenci o , not n , ders d where o.ogrenci_id=n.ogrenci_id 
 and n.ders_id=d.ders_id and n.ders_id='MAT' GROUP BY ogrenci_id) Mat where fizik.ortf=Mat.ortm 
 )
 
 
 select aders_il,avg(not) from  ogrenci o , ders_not d 
 where o.ogrenci_id=d.ogrenci_id and ders_id="MAT" GROUP BY aders_il
 INTERSECT
 select aders_il,avg(not) from  ogrenci o , ders d 
 where o.ogrenci_id=d.ogrenci_id and ders_id="FIZ"
 GROUP BY aders_il
 
 
SELECT * FROM (SELECT adres_il,AVG(not) ortalama
FROM öğrenci o, ders_not d
WHERE o.öğrenci_id=d. öğrenci_id
AND ders_id=’MAT’
GROUP BY adres_il) mat_ort,
(SELECT adres_il,AVG(not) ortalama
FROM öğrenci o, ders_not d
WHERE o.öğrenci_id=d. öğrenci_id
AND ders_id=’FIZ’
GROUP BY adres_il) fiz_ort
WHERE mat_ort.adres_il=fiz_ort.adres_il
AND mat_ort. Ortalama=fiz_ort. Ortalama

--Hiç ders almayan öğrencilerin durumun “Pasif” olarak UPDATE ediniz.
update ogrenci set durum = 'pastif' where ogrenci_id in(
select ogrenci_id from ogrenci where ogrenci_id not in (
select ogrenci_id from not ));


-- 2. (18) İstanbul’da yaşayan ve avans kullanmış personellere ödenen toplam ücretleri personel
--  bazında listeleyiniz.
-- a. ANSI INNER Bileşke
-- b. Klasik Bileşke

SELECT sum(tutar) FROM PERSONEL P , MAAS M where p.personel_id= m.personel_id and  aders_il='istanbul' 
and turu='avans' GROUP BY personel_id 
select sum(tutar) from  PERSONEL P INNER JOIN MAAS M  USING (PERSONEL_ID) 
where aders_il='istanbul' and turu='avans' GROUP BY personel_id 

SELECT personel_id, SUM(maas)
FROM personel p, maas m
WHERE p.personel_id=m.personel_id
 AND p.personel_id IN (SELECT personel_id FROM maas WHERE turu=’AVANS’)
AND adres_id = ’İSTANBUL’
GROUP BY personel_id

--(15) Ücretine 2016 yılında zam almayan kişileri listeleyiniz. (İpucu: tuturı takip eden aylarda
--hiç artmamış)
select * from 
(select * from maas where yil==2016) a ,
(select * from maas where yil!=2016) b  where a.personel_id=b.personel_id and a.turu<>b.turu;

 SELECT * FROM PERSONEL
 WHERE personel_id NOT IN 
 (SELECT * 
 FROM MAAS m,MAAS s
 WHERE m.personel_id=s.personel_id
 AND s.tutar>m.tutar
 AND s.ay_id>m.ay_id
 AND s.yil=2016 AND s.turu='Maaş'
 AND m.yil=2016 AND m.turu='Maaş');
-- (15) İ.K’da çalışan ve 2016 yılında aldığı avansları aynı yıl içinde tümüyle ödeyen personelleri
 -- SQL ile listeleyiniz.
select * from 
      ( select PERSONEL_ID,sum(tutar) toplam from  maas where PERSONEL_ID in (
       select PERSONEL_ID from  PERSONEL where birim_id in  (
       select birim_id from  birim_1 where birim_adi='I.K')) and turu='AVANS' and yil=2016 group by PERSONEL_ID) avans
       ,
       ( select PERSONEL_ID,sum(tutar) toplam from  maas where PERSONEL_ID in (
       select PERSONEL_ID from  PERSONEL where birim_id in  (
       select birim_id from  birim_1 where birim_adi='I.K')) and turu='odeme' and yil=2016 group by PERSONEL_ID) odeme
       where avans.PERSONEL_ID=odeme.PERSONEL_ID and avans,toplam=odeme.toplam

--  (10) Avans almasına rağmen hiç ödeme yapmayan personelleri listeleyiniz.(SQL küme operatörleri)
SELECT * FROM personel WHERE personel_id IN
(SELECT personel_id FROM maas WHERE turu='Avans')
MINUS
(SELECT personel_id FROM maas WHERE turu='Ödeme')

--2. (10) “Ahmet Ak ” yönetimindeki “Açık” ambarlardaki malzeme hareketlerini malzeme
-- sırasıyla SQL kullanarak listeleyiniz
select * from hareket where ambar_id in (
select ambar_ID from ambar where durum='acik' and SORUMLU_ID in (
select personel_id from personel where Adi='ahmet' and Soyadi='ak'))
order by hareket_no 

  
  
select * 
from personel pe, ambar am, hareket ha
where pe.personel_id = am.sorumlu_id
and am.sorumlu_id not in (select sorumlu_id 
                            from ambar
                            where am.durum = 'kapali')
and am.ambar_id = ha.ambar_id
and pe.adi ||' '||pe.SOYADI = 'ahmet ak'
order by ha.hareket_no 

--(25) İstanbul’da yaşayan kişilerin sorumlu olduğu ambarlardaki toplam giren ve çıkan
-- malzeme sayısını bulunuz.
select * from PERSONEL p , AMBAR buyukamber ,
(select * from 
(select h.ambar_id ambarg, count(*) Gikis from  ambar a , hareket h where a.ambar_id=h.ambar_id
and turu='giris'  group by h.ambar_id  ) giris ,
(select h.ambar_id ambarc , count(*) cikis from  ambar a , hareket h where a.ambar_id=h.ambar_id
and turu='cikis'  group by h.ambar_id ) cikis 
where giris.ambarg=cikis.ambarc) durum where 
buyukamber.Ambar_id=durum.ambarg and buyukamber.Sorumlu_Id=p.Personel_id and ADRES_IL='istanbul';



select * from HAREKET;
select * 
from personel pe,ambar am, (select gi.ambar_id, gi.girenMalzemeSayisi, ci.cikanMalzemeSayisi from
                                (select ambar_id, count(*) girenMalzemeSayisi
                                from hareket
                                where turu = 'giris'
                                group by ambar_id) gi,
                                (select ambar_id, count(*) cikanMalzemeSayisi
                                from hareket
                                where turu = 'cikis'
                                group by ambar_id) ci
                            where gi.ambar_id= ci.ambar_id) so
where am.ambar_id= so.ambar_id
and pe.personel_id = am.sorumlu_id
and ADRES_IL='istanbul'



-- (15) Giren toplam malzeme miktarı, çıkan toplam malzeme miktarından fazla olan ambarların
-- isimlerini bulunuz.

select 	AMBAR_ADI from  AMBAR where Ambar_id in (
select AMBARG  from 
(select h.ambar_id ambarg, sum(toplam) toplamgiris from  ambar a , hareket h where a.ambar_id=h.ambar_id
and turu='giris'  group by h.ambar_id ) giris ,
(select h.ambar_id ambarc , sum(toplam) toplamcikis from  ambar a , hareket h where a.ambar_id=h.ambar_id
and turu='cikis' group by h.ambar_id ) cikis 
where giris.ambarg=cikis.ambarc and giris.toplamgiris>cikis.toplamcikis)

select ambar_adi
from ambar am,(select gi.ambar_id, gi.girenToplamMalzemeMiktari, ci.cikanToplamMalzemeMiktari 
                from(select ambar_id, sum(toplam) girenToplamMalzemeMiktari
                        from hareket
                        where turu = 'giris'
                        group by ambar_id) gi,
                    (select ambar_id, sum(toplam) cikanToplamMalzemeMiktari
                        from hareket
                        where turu = 'cikis'
                        group by ambar_id) ci
                where gi.ambar_id= ci.ambar_id
                and gi.girenToplamMalzemeMiktari > ci.cikanToplamMalzemeMiktari)sonuc
where am.ambar_id = sonuc.ambar_id

-- Tüm ambarlardaki toplam malzeme tutarını, giriş ve çıkış hareketleri arasındaki fark
-- olacak şekilde update ediniz
select girisid,  (cikis.toplams-giris.toplamg) giriş_ve_çıkış_hareketleri_arasındaki_fark   from 
(select a.Ambar_Id girisid , sum(toplam) toplamg from  ambar a , hareket h where a.Ambar_Id=h.Ambar_Id 
and turu='giris'  group by  a.Ambar_Id) giris 
,
(select a.Ambar_Id cikisid , sum(toplam) toplams from  ambar a , hareket h where a.Ambar_Id=h.Ambar_Id 
and turu='cikis'  group by  a.Ambar_Id) cikis 
where giris.girisid=cikis.cikisid 
;


update ambar am
SET toplam_tutar = (select girenToplamMalzemeTutari - cikanToplamMalzemeTutari girenVeCikanToplamMalzemeFarki
                        from(select ambar_id, sum(toplam) girenToplamMalzemeTutari
                                from hareket
                                where turu = 'giris'
                                group by ambar_id) gi,
                            (select ambar_id, sum(toplam) cikanToplamMalzemeTutari
                                from hareket
                                where turu = 'cikis'
                                group by ambar_id) ci
                        where gi.ambar_id= ci.ambar_id
                        and am.ambar_id= ci.ambar_id)
--Sorumlu atanmamış, giriş hareketi olan ancak çıkış hareketi olmayan ambarları silen
-- kodu yazınız.

select * from hareket where ambar_id in (
select Ambar_id from ambar a where sorumlu_id is null) and turu!='cikis';

select * from ambar

where
ambar_id not in (select distinct ambar_id
                        from hareket
                        where turu = 'cikis')
                        
--a. İşleri veren kişileri işin numarası ve
-- maliyetiyle birlikte listeleyiniz.

select p.*,is_no,maliyet from personel p , gorev g , isler i
where  p.peronsel_id=g.veren_id 
and    g.gorevid=i.gorevid 



--b. İlleri, kaç adet görev yapıldığına göre
--çoktan aza sıralayınız.

select count(gorevid) adet from peronsel p , gorev g 
where p.peronsel_id=g.veren_id group by aders_il order by adet 


--c. Verdiği herhangi bir görevdeki işlerin
--toplam maliyeti 100 TL’yi aşan kişileri
--bulunuz.
select * from peronsel , gorev (
select  gorevid gid ,sum(maliyet) from  gorev g, isler i 
where g.gorevid=i.gorevid  group by gorevid having  sum(maliyet)>100 ) gorevd
) where gorevd.id=gorev.goreid and gorev.veren_id=peronsel_id


--d. Aldığı görevlerdeki işlerin toplam
--maliyeti verdiği görevlerinkinden az
-- olan kişileri bulunuz.
SELECT * FROM personel WHERE personel_id IN
(SELECT alan_id FROM
(SELECT alan_id,SUM(maliyet) tutar
FROM gorev g, isler i
WHERE g.gorev_id=i.gorev_id
GROUP BY alan_id) alan,
(SELECT veren_id,SUM(maliyet) tutar
FROM gorev g, isler i
WHERE g.gorev_id=i.gorev_id
GROUP BY veren_id) veren
WHERE alan.alan_id=veren.veren_id
AND alan.tutar>veren.tutar)

--e. İstanbul’da verilmiş ve tüm işleri
--kapanmış görevlerin durumunu kapalı
--olarak UPDATE eden kodu yazınız.
update gorev 
set durum='kapali' where gorev_id in (
select  g.goreid from  peronsel p ,gorev g , isler i 
where p.peronsel_id=g.veren_id
and g.goreid=i.gorev_id
and aders_il='istanbul'
i.durum='kapali')


UPDATE gorev
SET durum='Kapalı'
WHERE veren_id IN (SELECT personel_id
FROM personel
WHERE adres_il='İstanbul')
 AND gorev_id NOT IN (SELECT gorev_id
 FROM isler
 WHERE durum!='Kapalı')
