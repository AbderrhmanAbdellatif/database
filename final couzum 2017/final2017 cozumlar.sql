1. (12) Aşağıdaki tanımları yapınız. 
a. Veri ambarı sistemlerin temel özelliklerini ve 
  klasik ilişkisel yaklaşımdan farklarını açıklayınız.
b. Varlık ilişki diyagramı ve ilişkisel veri modeli arasındaki
  farkları kullanım amacını düşünerek açıklayınız. 
c. İlişkisel modele geçişte birebir ve çoktan çoğa ilişkiler nasıl çözülebilir.
 Açıklayınız. 
 
a) Datalar veri ambarında küplerde bulunur ve bu küplerde datalar her 
   türlü sonucu vericek şekilde saklanır ama ilişkisel modelde datalar
   tablolarda saklıdır ve istediğim istenilen sonuç için SQL
    sorguları yazılmalıdır küplerde ise bunlar hazırdır.
b) Varlık diyagramı varlıkların ilişkisel modele çevrilmesinde yardımcı olur. 
     Öncelikle varlık diyagramı çizilir ilişkiler belli olur ve bu varlık modeline göre
     ilişkisel modele çevrilir.
c) Varlık ilişki diyagramındaki çoğa çok ilişkiler ilişkisel veritabanında 
oluşturulamaz. Hangi kayıtların silişkili olduğu bilgisi 
     ara bir tabloda saklanır. İki varlık da bağlantı tablosuna 
	 ayrı ayrı birden çoğa ilişkiyle bağlanır 
     Birebir ilişkinin de ilişkisel modelde karşılığı yoktur.
	 Bu ilişki  analizdeki ihtiyaca göre varlıkların tek tabloda birleştirilmesi
     ,birincil anahtarların aynı yapılması veya kodlamayla çözülebilir
 	 
2. (33) Aşağıdaki soruları verilen veri modeli göre cevaplandırınız
a. select adi,soyadi from alis a ,musteri m 
    where m.musteri_id=a.musteri_id and tarih=2010 and malzeme_id='kalem'

b. select * from musteri m , alis a where m.musteri_id=a.musteri_id
   and a.malzeme_id = ( selet alt.malzeme_id from  alis alt 
    group by alt.malzeme_id having count(*)>1)

c.select m.adi,m.soyadi from
  (select *  from musteri m , alis a ,malzeme mz
  where m.musteri_id=a.musteri_id and mz.aders_il=m.aders_il) 
  intersect
 (select * from musteri m , satis s 
  where m.musteri_id=s.musteri_id ) 

d.Sattığı kalem tutarı sattığı silgi tutarından fazla olan mağazaları bulunuz. 
select kalem.magaza_id from
 (select magaza_id , sum(tutar) toplamsatilan from malzeme mz,satis s 
  where mz.malzeme_id=satis.malzeme_id and malzemeid='kalem'
  group by magaza_id
  )kalem, 
  (select magaza_id , sum(tutar) toplamsatilan from malzeme mz,satis s 
  where mz.malzeme_id=satis.malzeme_id and malzemeid='silgi'
  group by magaza_id
  )silgi
  where kalem.toplamsatilan>silgi.toplamsatilan

e.Müşterinin mağaza bazında alım ve satımları 
       sürekli sorgulanıyorsa nasıl bir denormalizasyon yapılması gerekir.
       Bunun için gerekli UPDATE ifadesini yazınız. 
  
  
3.2a ve 2c. sıklarını ilişkisel cebirle çözünüz. 
 2a)
 π adi,soyadi
 (σ a.malzeme_id='kalem' ∧ a.tarih=2010 ρ a (alis) )
 X
(σ a.musteri_id=m.musteri_id ρ m (musteri))

2c )Bakarsiniz

5. (10) yukarıda verilen modelde 
 { malzemeId, tarih -> tutar},
 {musteriId, MalzemeId, magazaId -> Tutar}, 
 {musteriID, SatisId -> malzemeId, tarih, tutar, magazaId } 
 
 fonksiyonel bağımlılıkları varsa bu tablo (ilişki) hangi normal formdadır. 
 BCNF’a ulaşıncaya kadar normalize ediniz. 

5)Aday anahtar:  (musteri_id,satis_id) 
- Model de kismi bagimlilik yoktur. Yani 2.normal formdadır
- 3.normal formda olmak için asal olmayan niteliklerin yani 
    aday anahtar olmayan niteliklerin 
    bağımlılıklarından kurtulmak gerekir. 
	
3NF: 
R1{müşteri_id, satis_id, malzeme_id, tarih} 
R2{malzeme_id, tarih, tutar} 
R3{müşteri_id,malzeme_id, mağaza_id, tutar} 
 
müşteri_id, satis_id -> malzeme_id, tarih 
malzeme_id,tarih -> tutar 
müşteri_id,malzeme_id, mağaza_id -> tutar

6.Aşağıdaki analize uygun ilişkisel veri modelini çiziniz. Bir inşaat takip sistemi tasarlanacaktır.
  Şirket binalar yapmaktadır. Bunlarla ilgili maliyet, bina alanı ve adres bilgilerini takip etmektedir. 
  Bir binada sıva, boya gibi farklı türlerde görevler yapılmaktadır.
  Her görev ayrı ayrı takip edilmektedir. Çalışanlar görev türüne  
  göre çeşitli ekiplerde görevlendirmektedir. Her çalışan sadece bir ekipte görev yapabilir. Bir ekip aynı tarihte iki göreve birden başlayamaz. Ancak farklı tarihlerde farklı binalarda çalışabilmektedir.
  Her inşaatın ve görevin başlangıç bitiş tarihi bulunmaktadır.
7-    İkinci soruda verilen modelde müşteri adı bazında toplam alış tutarını 
       grup fonksiyonu kullanmadan  ekrana yazdıran bir
       PL/SQL kodu yazınız. Yazdırmak için DBMS_OUTPUT.PUT_LINE kullanılabili
	
7)  declare 
    cursor c1 is select m.musteriId,m.adi,tutar
    from musteri m, alis a where m.musteri_id=a.musteri_id ;
    toplamalis PLS_INTEGER;
   	begin
	for r1 in c1 loop
       for r2 in r1 loop 
          if (r1.musteriId=r2.musteriId) then
               toplamalis=toplamalis+tutar;
		  end if 
        end loop;
		DBMS_OUTPUT.PUT_LINE(r1.adi||toplamalis);
		toplamalis:=0;
	end loop;
    end;	