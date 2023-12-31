CREATE TABLE calisanlar(
	id char(5) PRIMARY KEY,
	isim varchar(50) UNIQUE,
	maas int NOT NULL,
	ise_baslama date
);

INSERT INTO calisanlar VALUES('10002', 'Donatello' ,12000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10003', null, 5000, '2018-04-14');--isim için NOT NULL yok, kabul eder
INSERT INTO calisanlar VALUES('10005', 'Michelangelo', 5000, '2018-04-14');--+
INSERT INTO calisanlar VALUES('', 'April', 2000, '2018-04-14');--empty NULL değildir

INSERT INTO calisanlar VALUES('10004', 'Donatello', 5000, '2018-04-14');--isim için UNIQUE var, kabul etmez
INSERT INTO calisanlar VALUES('10006', 'Leonardo', null, '2019-04-12');--mass NOT NULL
INSERT INTO calisanlar VALUES('10007', 'Raphael', '', '2018-04-14');--maas int olmalıydı
INSERT INTO calisanlar VALUES('', 'Ms.April', 2000, '2018-04-14');--PK:UNIQUE, 2.empty
INSERT INTO calisanlar VALUES('10002', 'Splinter' ,12000, '2018-04-14');--PK:UNIQUE
INSERT INTO calisanlar VALUES( null, 'Fred' ,12000, '2018-04-14');--PK:NOT NULL

INSERT INTO calisanlar VALUES('10008', 'Barnie' ,10000, '2018-04-14');
INSERT INTO calisanlar VALUES('10009', 'Wilma' ,11000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Betty' ,12000, '2018-04-14');

SELECT * FROM calisanlar

CREATE TABLE adresler(
	adres_id char(5),
	sokak varchar(50),
	cadde varchar(50),
	sehir varchar(50),
	FOREIGN KEY(adres_id) REFERENCES calisanlar(id)
);

INSERT INTO adresler VALUES('10003','Ninja Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Kaya Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Taş Sok', '30.Cad.','Konya');

INSERT INTO adresler VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO adresler VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');

SELECT * FROM adresler

SELECT * FROM calisanlar;

----------------------------------------------------------------

--14-WHERE CONDITION(koşulu)
--calisanlar tablosundan ismi 'Donatello' olanları listeleyiniz.
SELECT * FROM calisanlar WHERE isim='Donatello';

SELECT * FROM calisanlar WHERE maas>5000

--calisanlar tablosundan maası 5000den fazla olanların sadece isim ve maaşlarını listeleyiniz.
SELECT isim,maas FROM calisanlar WHERE maas>5000;

--adresler tablosundan sehiri 'Konya' ve 
--adres_id si 10002 olan tüm verileri getir
SELECT * FROM adresler WHERE sehir='Konya' AND adres_id='10002';

--sehiri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getir.
SELECT cadde,sehir FROM adresler WHERE sehir='Konya' OR sehir='Bursa';

--15-DELETE FROM .. WHERE.. komutu:koşula uyan kayıtları tablodan siler

CREATE TABLE ogrenciler1
(
	id int,
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu int       
);

INSERT INTO ogrenciler1 VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO ogrenciler1 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler1 VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO ogrenciler1 VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO ogrenciler1 VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO ogrenciler1 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler1 VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler1 VALUES(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM ogrenciler1;

--id=123 olan kaydı siliniz.
DELETE FROM ogrenciler1 WHERE id=123;
--ismi Kemal Tan olan kaydı siliniz.
DELETE FROM ogrenciler1 WHERE isim='Kemal Tan';
--ismi Ahmet Ran veya Veli Han olan kayıtları siliniz.
DELETE FROM ogrenciler1 WHERE isim='Ahmet Ran' OR isim='Veli Han'

--ÖDEV--
-- ismi Mustafa Bak ve id'si 128 olan kaydı siliniz.
DELETE FROM ogrenciler1 WHERE isim='Mustafa Bak ' OR id=128
-- id'si 122, 125 veya 126 olanları silelim.
DELETE FROM ogrenciler1 WHERE id=122 OR id=125 OR id=126
-- id 'si 126'dan büyük olan kayıtları silelim.
DELETE FROM ogrenciler1 WHERE id>126;

---------------------------------------------------------

SELECT * FROM adresler

--16-a-Tablodaki tüm verileri silme:DELETE FROM .. komutunu koşulsuz kullanırsak 
--tablodaki tüm kayıtları siler, talo kalır

---students tablosundaki tüm kayıtları siliniz.
DELETE FROM adresler;--tablodaki tüm kayıtlar silinir ancak tablo silinmez

--16-b-Tablodaki tüm verileri silme:TRUNCATE TABLE
SELECT * FROM adresler;

--doctors tablosundaki tüm kayıtları siliniz.
TRUNCATE TABLE adresler;--bu komut ile bir koşul belirtemeyiz, WHERE kullanılamaz.

DROP TABLE adresler;

SELECT * FROM calisanlar
TRUNCATE TABLE calisanlar;
DROP TABLE calisanlar;

SELECT * FROM ogrenciler1
DROP TABLE ogrenciler1;

---------------------------------------------------

--18-on delete cascade:kademeli silme işlemini aktif hale getirir
CREATE TABLE ogrenciler
(
	id int primary key,  
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu int
);--parent

CREATE TABLE notlar( 
	ogrenci_id int,
	ders_adi varchar(30),
	yazili_notu int,
	CONSTRAINT notlar_fk FOREIGN KEY (ogrenci_id) REFERENCES ogrenciler(id)
	ON DELETE CASCADE	
);--child

INSERT INTO ogrenciler VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler VALUES(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);
INSERT INTO notlar VALUES ('127', 'Matematik',90);
INSERT INTO notlar VALUES (null, 'tarih',90);

SELECT * FROM ogrenciler
SELECT * FROM notlar

--notlar tablosundan id=123 olan kaydı siliniz.
DELETE FROM notlar WHERE ogrenci_id=123;

--talebeler tablosundan id=126 olan kaydı siliniz.
DELETE FROM ogrenciler WHERE id=126;--parent
--parenttan kayıt silmek istediğimizde CASCADE özelliğinden önce varsa 
--childdan ilişkili olan kaydı siler sonra parenttan siler

DELETE FROM ogrenciler;--parenttaki kayıtlar ile birlikte childda referans alan kayıtları da siler
TRUNCATE TABLE notlar;--parenttaki kayıtlar ile birlikte childda referans alan kayıtları da siler

SELECT * FROM ogrenciler
SELECT * FROM notlar

DROP TABLE notlar
DROP TABLE ogrenciler
DROP TABLE IF EXISTS ogrenciler

---------------------------------------------------

CREATE TABLE musteriler  (
	urun_id int,  
	musteri_isim varchar(50),
	urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler

--19-Tabloyu silme:tabloyu SCHEMADAN kaldırma
--sairler tablosunu siliniz.
DROP TABLE sairler;--DDL
--talebeler tablosunu siliniz.
DROP TABLE talebeler;--ilişki tanımlı old. için silmez
DROP TABLE talebeler CASCADE;--ilişki iptal edilip silme gerçekleşir

--talebeler1 tablosunu siliniz.
DROP TABLE IF EXISTS talebeler1;--hata almamak için

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.
SELECT * 
FROM musteriler 
WHERE urun_isim='Orange' 
	OR urun_isim='Apple' 
	OR urun_isim='Apricot'
	
SELECT * 
FROM musteriler 
WHERE urun_isim IN ('Orange','Apple','Apricot')

SELECT * 
FROM musteriler 
WHERE urun_isim NOT IN ('Orange','Apple','Apricot')

SELECT *
FROM musteriler
WHERE urun_id BETWEEN 20 AND 40;

--Müşteriler tablosunda urun_id 20 den küçük veya 30 dan büyük olan urunlerin tum bilgilerini listeleyiniz
SELECT *
FROM musteriler
WHERE urun_id<20 OR urun_id>30;

--Müşteriler tablosunda urun_id 20 ile 40(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz
SELECT *
FROM musteriler
WHERE urun_id BETWEEN 20 AND 40;

SELECT *
FROM musteriler
WHERE urun_id>=20 AND urun_id<=40;

----------------------------------

CREATE TABLE calisanlar (
	id int, 
	isim VARCHAR(50), 
	sehir VARCHAR(50), 
	maas int, 
	isyeri VARCHAR(20)
);

INSERT INTO calisanlar VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

SELECT * FROM calisanlar

CREATE TABLE markalar
(
	marka_id int, 
	marka_isim VARCHAR(20), 
	calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM markalar;

SELECT MAX(maas) FROM calisanlar;
SELECT MIN(maas) FROM calisanlar;
--calisanlar tablosunda tüm çalışanların toplam maaşını gösteriniz.
SELECT SUM(maas) FROM calisanlar;

-----------------------------------------------

SELECT ROUND(AVG(maas)) FROM calisanlar;

--calisanlar tablosunda tüm çalışanların sayısını gösteriniz.
SELECT COUNT(id) FROM calisanlar;

--calisanlar tablosunda maaşı 2500 olan çalışanların sayısını gösteriniz.
SELECT COUNT(*) FROM calisanlar WHERE maas=2500;

SELECT * FROM calisanlar

CREATE TABLE workers(
	calisan_id char(9),
	calisan_isim varchar(50),
	calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT calisan_id AS id,calisan_isim AS isim FROM workers;

SELECT calisan_id AS id,calisan_isim ||' - '||calisan_dogdugu_sehir FROM workers;