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
  
  select * from muster m ,siparis s
  where s.musteri_id=m.musteri_id group by  musteri_id
  having sum(adet*satis_fiyat)!=m.toplam_gelir
  
  