 (12) Aşağıdaki tanımları yapınız. Gerekirse yorum ekleyiniz. 
 a. Normalizasyon işleminin gerçek hayatta doğrudan uygulanmasındaki
   zorlukları açıklayınız.
   Normalizasyon, veri tabanlarına seviyelerle (normal formlar) uygulanır.
   Başarılı bir şekilde uygulandığında normalizasyon işlemi veri tabanının
   süratini büyük oranda artırır. Veri tabanının sabit diskteki boyutunu 
   azaltır. Ayrıca veri tutarlılığını artırarak veri tekrarlarını engeller.
 
 b. OLTP ve OLAP sistemleri arasındaki temel farkları açıklayınız. 
 
 Karşılaştırma için temel	OLTP	OLAP
    OLTP:  bir çevrimiçi işlem sistemidir ve veritabanı değişikliğini yönetir.
	OLAP:   bir çevrimiçi veri alma ve veri analiz sistemidir.
	
 c. Veri modelleme süreci aşamalarını kısaca açıklayınız.
 
2)Aşağıdaki soruları verilen veri modeli göre istenen dille cevaplandırınız. 
2. (12) İZMİR’deki müşterilerin fiyatı 500 TL üzerinde ve satın aldıkları toplam ürün tutarlarını ürün temelinde
     ANSI INNER bileşke ve klasik bileşke kullanarak bulunuz
	2)
 	 select musteri_id,sum(fiyat) from  musteri m inner join urunsatis us
	 on m.musteri_id=us.musteri_id and fiyat<500
     GROUP by  	musteri_id 
	 
	 select musteri_id,sum(fiyat) from  musteri m ,urunsatis us
	 where m.musteri_id=us.musteri_id and fiyat<500
     GROUP by  	musteri_id 
(14) Borcu olmayan (taksit ödemesi toplama eşit) müşterilerin yaşadıkları
     şehirleri İlişkisel Cebirle ve SQL ile gösteriniz.	
	 
	 3)select m.aders_il from 
	   (select  satis_id ,sum(fiyat) toplam from musteri m , urunsatis us 
	   where m.musteri_id=us.musteri_id 
	   group by satis_id) toplamsatis
	   ,
	   (select satis_id ,sum(odeme) toplam  from takist_odeme 
	   group by  satis_id) taksitödemesi
	   ,musteri m 
	   where taksitödemesi.satis_id=taksitödemesi.satis_id
	   and taksitödemesi.toplam=toplamsatis.toplam 
	   and toplamsatis.musteri_id=m.musteri_id
	   