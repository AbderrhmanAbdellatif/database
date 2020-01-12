Aşağıdaki tanımları yapınız. 
a. Hareket yönetiminin temel özellik ve komutlarının çalışma mantığını açıklayınız
  a(cevap).DML İşlemlerinin bütünleşik yapılmasını sağlar.
  Eş zamanlılık ve kurarma mekanizamalrı  hareket yönetimi ile bütünleşiktir.
  Temel komutları Commit (Kalıcı saklama), ROLLBACK kalıcı geri alma, 
  SAVEPOINT (kısmi geri almadır.)
  
b.  İlişkisel cebri tanımlayınız. İlişkisel (complete) set nedir? 
İlişkisel cebrin SQL’e göre üstünlükleri nelerdir? Günümüzde hangi amaçlarla kullanılmaktadır? 

  b(cevap). ilişkisel modelde veriler üzerinde yapılacak işlemler kümesini,
  matematikteki küme teorisine benzer biçiminde tanımlayan bir dildir. Sorgu,
  gösterim, birleşim ve fark operatörlerine ilişkisel 
  set ismi verilir ve diğer tüm operatörler bu operatörlerin 
  bileşiminden oluşturulabilir. Kısmen Prosedürel olması,
  kısa sembolik yazılımı ve bölme gibi işlemler SQL’e göre üstünlükleridir. 
  Günümüzde SQL iyileştirme, SQL çalışma planı oluşturma ve akademik çalışmalarda kullanılmaktadır
  
2 soru )
a. Kalem alan müşterilerin sattığı ürünlerin isimlerini klasik ve doğal (NATURAL) bileşkeyle bulunuz
a)SELECT s.urun_id FROM ALIS a, SATIS s WHERE a.musteri_id=s.musteri_id AND a.urun_id='Kalem' 
b)SELECT s.urun_id FROM ALIS a, NATURAL JOIN SATIS s WHERE a.urun_id='Kalem'

b. Maliyet olarak toplamda aldığından fazla mal satan müşterilerin isimlerini listeleyiniz.

SELECT m.adi,m.soyadi FROM  (SELECT müşteri_id, SUM(fiyat*.adet) toplam_alis FROM ALIS  GROUP BY musteri_id) 
alis_t (SELECT müşteri_id, SUM(fiyat * adet) toplam_satis FROM SATIS  GROUP BY musteri_id) 
satis_t ,muster m
WHERE alis_t.musteri_id=satis_t.musteri_id AND 
satis_t.toplam_satis>alis_t.toplam_alis and
m.muster_id=alis_t.muster_id

c. Müşteri ve Ürün adedi bazında sattığı ve
aldığı ürün adedi eşit olan “İSTANBUL’da” yaşayan kişilerin isimlerini listeleyiniz.

select (toplam_alis_adet.adi||' '||+toplam_alis_adet.soyadi from 
(select aders_il,musteri_id, sum(adet) toplam form
 muster m , alis a group by a.musteri_id ) toplam_alis_adet,
(select m.aders_il , musteri_id, sum(adet)toplam form
 muster m , satis s group by s.musteri_id ) toplam_satis_adet
 ,
 where toplam_alis_adet.musteri_id= toplam_satis_adet.muster_id 
 and toplam_alis_adet.aders_il='istanbul' 
 and  toplam_satis_adet.aders_il='istanbul'
 and toplam_satis_adet.toplam=toplam_alis_adet.toplam
 
d. Müşterilerin aldığı değere göre ucuz sattıkları ürünleri silen kodu yazınız.
 delete from satis s where exists (
  select * from alis a , muster m where a.muster_id=m.muster_id
  and a.urun_id=s.urun_id where a.fiyat>s.fiyat
 )
 
3. 2a ve 2b. Şıklarını ilişkisel cebirle çözünüz.   
a. Kalem alan müşterilerin sattığı ürünlerin isimlerini klasik ve doğal (NATURAL) bileşkeyle bulunuz.
mus_urun ← (σ a.urun_id=’kalem’(ρ a(alis)  a.musteri_id=s.musteri_id ρ s(satis))) 
b-Maliyet olarak toplamda aldığından fazla mal satan müşterilerin isimlerini listeleyiniz
 A = γ muster_id;sum(fiyat * adet) -> toplam_alis (Alis)
B = γ muster_id;sum(fiyat * adet) -> toplam_satis (satis)
π adi,soyadi(σ A.muster_id=B_muster_id and A.toplam_alis<B.toplamsatis and muster.muster_id=B.msuter.id (A ⨝ B ⨝ muster))



