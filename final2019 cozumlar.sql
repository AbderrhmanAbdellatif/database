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
	 
	 3)select toplamsatis.aders_il from 
	   (select aders_il, satis_id ,fiyat from musteri m , urunsatis us 
	   where m.musteri_id=us.musteri_id ) toplamsatis
	   ,
	   (select satis_id ,sum(odeme) toplam  from takist_odeme 
	   group by  satis_id) taksitödemesi
	  
	   where taksitödemesi.satis_id=toplamsatis.satis_id
	   and taksitödemesi.toplam=toplamsatis.fiyat
	   
	   ( ilişkisel EMIN DEGILIM)
	   A=(ρ m(musteri) m.musteri_id=us.musteri_id X ρ us(urunsatis) )
       B=(γ sum(odeme)->toplam (takist_odeme))
       C=AXC
       D=σ(A.satis_id=B.satis_id and  σ B.toplam = A.fiyat (C))
       π m.aders_il D

     4. Ürün satın almasına rağmen ödeme yapmamış
        kişileri SQL bulunuz 	
		
   	    select m.musteri_id from  musteri m , urunsatis us  
        m.musteri_id=us.musteri_id and us.toplama_odeme=0
7. (15) Aşağıdaki analize uygun ilişkisel veri modelini çiziniz. 
       Bir izin takip sistemi tasarlanacaktır.
	   Kişiler çalışma sürelerine göre yıllık, ücretsiz gibi 
	   farklı türlerde izin hakkı kazanmaktadır.
	   Kişiler ancak hak kazandıkları türde izin kullanabilir. 
	   Kişilerin İzni geçirdikleri adresler takip etmektedir.
	   İzin alma süreci izin talebi ile başlamaktadır.
	   Birim amiri ve genel müdür
       gibi çeşitli onaylardan geçen talep izne dönüşür.  
	   
8.İkinci soruda verilen modeli kullanarak grup ve küme operatörü 
       kullanmadan, yaptığı tüm satın almalardaki tüm taksitini ödeyen 
	   müşterilerin durumunu borçsuz 
       olarak update eden PL/SQL kodu yazınız. 
	   
	   DECLARE
	   cursor c_muster is select * from
	   musteri m , urunsatis us , taksitödeme t 
	   where m.musteri_id=us.musteri_id and 
	   us.satis_id=t.satis_id;
	   toplamtakst number;
	   temp_fiyat number;
	   temp_mus_id c_muster%rowtype;
	   begin
	   for r1 in c_muster loop
	    for r2 in c_muster loop
         if(r1.satis_id=r2.satis_id) then
            temp_fiyat=r1.fiyat;		 
	        for r3 in c_muster loop
			if(r2.satis_id=r3.satis_id) then
			 toplamtakst=r3.odeme
			 end loop;
			 temp_mus_id=musteri_id;
		end loop;
        if toplamtakst=temp_fiyat then 
           update musteri set durum='Borçsuz'
		    where musteri_id=temp_mus_id;
		end if ;
       toplamtakst :=0;
	   temp_fiyat :=0;
	   end loop;	
		(emin degilim )	 
	   
9. (7) Herhangi bir taksiti ödenmiş bir satış işlemini 
       değiştirmeyi ve silmeyi engelleyen bir 
       tablo trigger PLSQL kodunu yazınız.  	   