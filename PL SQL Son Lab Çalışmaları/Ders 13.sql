SELECT m.adi, m.soyadi, f.urun_id, f.adet, f.satis_fiyat
FROM musteri m
RIGHT OUTER JOIN fatura f
ON (m.musteri_id=f.musteri_id 
AND  m.adres_il='?STANBUL')