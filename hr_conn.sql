--Kay?tlar? tekil getirme
--DISTINCT

SELECT  DISTINCT first_name FROM employees

--Takma isim

SELECT first_name ||' '||last_name AS isim
FROM employees e

--Tüm kolonlar? seçmek

SELECT email,employees.* FROM employees
SELECT email,e.* FROM employees e

-- Matematiksel i?lemler

SELECT salary, salary+1000 zamli FROM employees

--Say?sal + metin kolon
SELECT salary,first_name || (salary+1000) zamli FROM employees


--?lk harfi H olan ki?ileri bulunuz.
SELECT first_name 
FROM employees
where first_name LIKE 'H%'


--?kinci harfi i olan ki?ileri bulunuz.
SELECT first_name 
FROM employees
WHERE first_name LIKE '_i%' 

--?kinci harfi i olan ki?ileri bulunuz.
SELECT first_name 
FROM employees
WHERE first_name LIKE '_i\%%' ESCAPE '\'

--
SELECT 'Ahmet''in' FROM dual
SELECT '''Ahmet''in''' FROM dual
SELECT '''' FROM dual

SELECT sysdate FROM employees

--BETWEEN operatörü
SELECT * FROM employees
WHERE salary BETWEEN 5000 AND 10000

--IN OPERATÖRÜ

SELECT * FROM employees
WHERE job_id IN ('ST_MAN','IT_PROG')

--NOT IN OPERATÖRÜ

SELECT * FROM employees
WHERE job_id NOT IN ('ST_MAN','IT_PROG',NULL)

--NULL aritmati?i
SELECT * FROM employees
WHERE commission_pct IS NULL

SELECT * FROM employees
WHERE nvl(commission_pct,-1)=-1

select * from employees

SELECT salary, commission_pct,NVL(commission_pct,0),
salary+nvl(commission_pct,0)  
FROM employees

--Verilerin s?ralanmas?

SELECT * FROM employees
ORDER BY department_id, first_name,last_name


SELECT * FROM employees
ORDER BY first_name DESC,last_name DESC

SELECT first_name ||' '||last_name isim
FROM employees
WHERE first_name ||' '||last_name ='AHMET AK'
ORDER BY isim

--Verilerin gruplanmas?

--Departmanlardaki ortalama maa?
SELECT NVL(department_id,0)+10, TRUNC(AVG(salary),2)
FROM employees
GROUP BY NVL(department_id,0)

--
SELECT salary FROM employees
WHERE department_id=100

SELECT AVG(salary) FROM employees
WHERE department_id=100

SELECT count(commission_pct) fROM employees


--HAVING
-- Ortalama maa?? 10000 üzerinde olan departmanlar? bulunuz.

SELECT department_id, avg(salary)
FROM employees
WHERE first_name ='Ahmet'
GROUP BY department_id
HAVING avg(salary)>10000 

-- 90 nolu birimde çal??an unvanlar?n ortalama maa??

SELECT job_id, avg(salary) ort
FROM employees
WHERE department_id =  90
GROUP BY job_id  
ORDER BY ort

-- 90 nolu birimde çal??an ortalamasi 6700 üzerinde olan unvanlar bulunuz?

SELECT job_id, avg(salary) ort
FROM employees
WHERE department_id =  90
GROUP BY job_id  
HAVING AVG(salary)>6700
ORDER BY ort

--1700 Nolu birimde çal??an ki?ileri bulunuz
SELECT * FROM employees
WHERE department_id IN 
       (SELECT department_id FROM departments
        WHERE location_id=1700)
        
--Ortalama maa?tan çok kazanan ki?ileri bulunuz.

SELECT * FROM employees
WHERE salary>(SELECT avg(salary)
              FROM employees)

--100 numaral? birimin yöneticisinin maaa?? ?
SELECT * FROM employees
WHERE manager_id=( SELECT manager_id 
                    FROM departments
                    WHERE department_id=100)

-- Çal??t??? birimin yöneticisi olan ki?ileri bulunuz.

SELECT * FROM employees
WHERE (employee_id, department_id) IN 
                          (SELECT manager_id,department_id
                           FROM departments)
--Kendi biriminin ortalamas?ndan daha yüksek maa? 
-- alan ki?ilerin bulunuz.


SELECT * FROM employees ust
WHERE salary>(SELECT avg(salary)
              FROM employees alt
              WHERE alt.department_id=ust.department_id)



SELECT avg(salary)
              FROM employees alt
              WHERE alt.department_id=50

--Yönetti?i ki?ilerin herhangi biriyle ayn? maa?? alan ki?ileri bulunuz. 
SELECT * FROM employees ust
WHERE salary IN (SELECT salary
                 FROM employees alt
                 WHERE alt.manager_id=ust.employee_id)

-- Kendi birimi haricindeki 
-- birimlerde çal??an ki?ileri yöneten yöneticileri bulunuz.
SELECT *
FROM employees ust
WHERE employee_id IN (SELECT manager_id
                      FROM employees alt
                      WHERE alt.department_id!=ust.department_id)
                    
                      
SELECT *
FROM employees ust
WHERE employee_id IN (SELECT manager_id
                      FROM departments alt
                      WHERE alt.department_id!=ust.department_id)
                      
-- Asya bölgesinde çal??an ki?ileri bulunuz.
SELECT *
FROM employees
WHERE department_id IN
  (SELECT department_id FROM departments
  WHERE location_id IN
    (SELECT location_id FROM locations
    WHERE country_id IN
      (SELECT country_id FROM countries
       WHERE region_id =
        (SELECT region_id FROM regions WHERE region_name='Americas'
        )
      )
    )
  )


-- Tüm ki?iler ve çal??t??? birimlerin isimlerini yanyana göteriniz.
SELECT employee_id, first_name, last_name, department_id,
       (SELECT department_name 
        FROM departments d 
        WHERE d.department_id=e.department_id) dept_name
FROM employees e

--Inline view
--en yüksek maa? ortalamas?na sahip birimin ortalama maa??n? bulunuz.
SELECT max(ortalama_maas) FROM (SELECT department_id, avg(salary) ortalama_maas   
              FROM employees 
              GROUP BY department_id)


--en yüksek maa? ortalamas?na sahip birimin ad?n? bulunuz.
SELECT * FROM departments
WHERE department_id IN
(SELECT department_id 
              FROM employees 
              HAVING avg(salary) = (SELECT MAX(ortalama_maas) 
                                   FROM (SELECT department_id, 
                                          avg(salary) ortalama_maas   
                                   FROM employees 
                                   GROUP BY department_id))
              GROUP BY department_id)
              

