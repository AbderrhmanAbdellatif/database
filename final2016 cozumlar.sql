1. (15) Aşağıdaki tanımları yapınız. 
a. Veritabanı tasarımında kullanılan anahtar türlerinin üçünü açıklayınız.  
 Süper Anahtar, İlişkideki tüm nitelik değerlerini belirleyen ve iki farklı
 satırda aynı değeri alamayan nitelik alt kümesidir. 

 Aday anahtar: Kaydı belirleyen minimum alan kümeleridir. 
 Birincil Anahtar:Anahtarlar arasında kaydı tanımlamak için
 en uygun aday anahtar kümesidir. 


b. Fonksiyonel bağımlılık adaya anahtar ilişkisi nasıl kurulmaktadır. Belirtiniz.  
 Bir nitelik değeri diğer bir niteliğin değerini kesin belirliyorsa 
 aralarında fonksiyonel bağımlılık vardır denir. 
 Fonksiyonel bağımlılık gerçek hayatta nitelikler 
 arası ilişkilerden çıkartılır. 
2. (30) Aşağıdaki soruları verilen veri modeli göre cevaplandırınız.
	
a. Toplam geliri 100 TL üzerindeki müşterilerin 
   temsilcilerinin hangi illerde yaşadığını bulunuz. 
   
   select mt.aders_il from  muster m , musteri_temsilcisi mt
   where m.toplam_gelir>=100 and m.temsilci_id=mt.personel_id
   
b. İstanbul’da hiç açık siparişi olmayan müşteri temsilcilerini bulunuz.   
   select mt.adi,mt.soyadi from  musteri_temsilcisi mt , musteri m 
   where m.temsilci_id=mt.personel_id and mt.aders_il='istanbul'
   and not in (select * from sipariş s  where s.musteri_id=m.musteri_id
   and s.durum='acik')
 
c. Toplam gelir alanı siparişlerden
  kazanılan toplam tutara uymayan müşterileri bulunuz
  
  select m.soyadi,m.adi,m.musteri_id from muster m ,siparis s
  where s.musteri_id=m.musteri_id group by  musteri_id
  having sum(adet*satis_fiyat)!=toplam_gelir
  
 d. İlk müşterisinin toplam sipariş tutarı diğer müşterilerinden 
    fazla olan müşteri temsilcilerini bulunuz. 
	(select musteri_id ,sum(adet*satis_fiyat)  toplam from musteri_temsilcisi mt , siparis s 
	where mt.musteri_id=s.musteri_id group by musteri_id)İlk_müşterisinin_toplam_sipariş 
	,
	(select musteri_id ,sum(adet*satis_fiyat) 
	toplam from musteri m , siparis s 
	where m.musteri_id=s.musteri_id group by musteri_id
	)müşterileri_toplam_sipariş 
	where 
	müşterileri_toplam_sipariş.musteri_id=İlk_müşterisinin_toplam_sipariş.musteri_id
	and müşterileri_toplam_sipariş.toplam>İlk_müşterisinin_toplam_sipariş.toplam
	
e. Temsilci bazında toplam geliri en yüksek müşteriyi ilk müşteri olarak UPDATE eden kodu yazınız. 
UPDATE musteri_temsilcisi mt SET ilkmusteri =(SELECT musteri_id FROM musteri m1   
WHERE m1.temsilci_id=mt.personel_id  
 AND toplam_gelir > ALL (SELECT musteri_id FROM musteri m2   
 WHERE m2.temsilci_id=mt.personel_id   
AND m2.musteri_id!=m1.musteri_id     AND toplam_gelir)); 

3. (12) 2a ve 2c. Sıklarını ilişkisel cebirle çözünüz. 
2a) π mt.adi,mt.soyadi ((ρ mt (musteri_temsilcisi))
  X mt.personel_id=m.temsilci_id (ρ m (σmusteri.toplam_gelir>=100 (musteri)))) 
2c) σ¬(m.toplam_gelir=SUM(s.adet*s.satis_fiyat) ((ρ m (musteri)) X 
m.musteri_id=s.musteri_id (ρs (siparis)))  

5. (10) Verilen {ABCDE} ilişkisel kümenin adaya anahtar(larını) bulunuz ve
       hangi normal formdadır. Açıklayınız? 
BCNF’a uygun hale gelene kadar normalize ediniz
ABC -> D
AC->E 
A -> B
A->D 
5)

ABC aday anahtar
R1={ABCE}
R2={AD}
Geçişli bağlılık olmadığı için 3NF’a uygun haldedir. 
Fakat aday anahtar içinde olan B’nin her zaman determinant olması gerekir. 
Bu yüzden BCNF’ye göre de düzenlemek gerekir


6) Bir havalimanı tamir ekibinin görev takip sistemi tasarlanacaktır.
 Bu sistemde personeller çeşitli ekiplerde görev alarak tamir işlemlerini
 yürütmektedir. Görevlerin amacı ve başlangıç bitiş tarihi bulunmaktadır.
 Her ekibin sorumlu olduğu iller bulunmaktadır. Bir personel birden
 fazla ekipte görev alabilir. Ancak içinde bulunduğu ekibin tamir 
 sahası dışında çalışamaz. Ekipler görevlere çeşitli uçaklarla girmektedir.
 Bir ile hangi uçakla uçulduğuna göre uçuş maliyeti değişmektedir. 
 
 7.Aşağıda verilen PL/SQL fonksiyonunu çağırarak
             müşteri bazında toplam tutarı ekrana yazdıran
			 bir PL/SQL kodu yazınız.Yazdırmak için 
			 DBMS_OUTPUT.PUT_LINE kullanılabilir.  
			 
FUNCTION get_Toplam(p_id IN pls_integer) RETURN pls_integer AS  
  CURSOR c1 IS  SELECT SUM(adet) sayi FROM sipariş WHERE musteri_id=p_id;      
   r1 c1%ROWTYPE;
   BEGIN  
   OPEN c1; 
   FETCH c1 INTO r1; 
   CLOSE c1;   
   RETURN (r1.sayi);
   END;			 
7)   
declare
   cursor c1 is 
     select musteri_id ,adi,soyadi, from musteri
	 r1 c1%ROWTYPE;
begin
   open c1;	 
   for cr in c1 loop
   DBMS_OUTPUT.PUT_LINE(cr.adi || cr.soyadi || get_Toplam(cr.musteri_id));
   end loop;
   close c1;
end;