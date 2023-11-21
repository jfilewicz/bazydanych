CREATE SCHEMA ksiegowosc;

CREATE TABLE ksiegowosc.pracownicy (
id_pracownika INT PRIMARY KEY,
imie CHAR(20) NOT NULL,
nazwisko CHAR(30) NOT NULL,
adres CHAR(30),
telefon INT	
);

CREATE TABLE ksiegowosc.godziny (
id_godziny INT PRIMARY KEY,
data date,
liczba_godzin INT,
id_pracownika INT NOT NULL
);

CREATE TABLE ksiegowosc.pensje (
id_pensji INT PRIMARY KEY,
stanowisko CHAR(45),
kwota money
);

CREATE TABLE ksiegowosc.premie (
id_premii INT PRIMARY KEY,
rodzaj CHAR(20),
kwota money
);

ALTER TABLE ksiegowosc.godziny
ADD CONSTRAINT id_pracownikaFK
FOREIGN KEY (id_pracownika) REFERENCES
ksiegowosc.pracownicy(id_pracownika);

CREATE TABLE ksiegowosc.wynagrodzenie (
id_wynagrodzenia INT PRIMARY KEY,
data date,
id_pracownika INT,
id_godziny INT,
id_pensji INT,
id_premii INT,
CONSTRAINT id_pracownikafk
	FOREIGN KEY (id_pracownika)
		REFERENCES ksiegowosc.pracownicy(id_pracownika),
CONSTRAINT id_godzinyfk
	FOREIGN KEY (id_godziny)
		REFERENCES ksiegowosc.godziny(id_godziny),
CONSTRAINT id_pensjifk
	FOREIGN KEY (id_pensji)
		REFERENCES ksiegowosc.pensje(id_pensji),
CONSTRAINT id_premiifk
	FOREIGN KEY (id_premii)
		REFERENCES ksiegowosc.premie(id_premii)
);

INSERT INTO ksiegowosc.pracownicy
(id_pracownika,imie,nazwisko,adres,telefon)
VALUES
(1, 'Adam', 'Nowak', 'Sienkiewicza 27', 123123123),
(2, 'Bartłomiej', 'Głupczyk', 'Wesoła 18', 510255789),
(3, 'Judyta', 'Wilska', 'Ogrodowa 2', 450222778),
(4, 'Jan', 'Kowalski', 'Słoneczna 51', 779560455),
(5, 'Stanisław', 'Wilkowski', 'Miła 13', 677783204),
(6, 'Jakub', 'Jabłoński', 'Pogodna 64', 675834599),
(7, 'Karolina', 'Pomocna', 'Niebieska 2', 556384673),
(8, 'Aleksandra', 'Karpińska', 'Bursztynowa 12', 648573684),
(9, 'Bernadeta', 'Wnuk-Lipińska', 'Karmelowa 33', 647895876),
(10, 'Renata', 'Okońska', 'Rzeczna 72', 758844587);

INSERT INTO ksiegowosc.godziny
(id_godziny, data, liczba_godzin , id_pracownika)
VALUES
(1, '28-10-2023', 180, 1),
(2, '8-10-2023', 170, 2),
(3, '30-10-2023', 160, 3),
(4, '27-10-2023', 175, 4),
(5, '13-10-2023', 198, 5),
(6, '20-10-2023', 182, 6),
(7, '27-10-2023', 170, 7),
(8, '22-10-2023', 180, 8),
(9, '9-10-2023', 171, 9),
(10, '15-10-2023', 165, 10);

INSERT INTO ksiegowosc.premie
(id_premii, rodzaj, kwota)
VALUES
(1, 'Regulaminowa', 120),
(2, 'Urodzinowa', 500),
(3, 'Uznaniowa', 300),
(4,'Frekwencja', 280),
(5, 'Frekwencja', 290),
(6, 'Motywacyjna', 200),
(7, 'Zadaniowa', 620),
(8, 'Wynikowa', 220),
(9, 'Zespołowa', 150),
(10, 'Urodzinowa', 500);

INSERT INTO ksiegowosc.pensje
(id_pensji, stanowisko, kwota)
VALUES
(1, 'Dyrektor Generalny', 4350.50),
(2, 'Kierownik Działu IT', 6080),
(3, 'Główna Księgowa', 5000),
(4, 'Asystent', 2350.80),
(5, 'Analityk Finansowy', 4800),
(6, 'Kierownik Projektu', 3790),
(7, 'Dyrektor ds. Produkcji', 4280.70),
(8, 'Specjalista ds. Sprzedaży', 3900),
(9, 'Sekretarka', 5250.25),
(10, 'Dyrektor Naczelny', 6200);

INSERT INTO ksiegowosc.wynagrodzenie
(id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii)
VALUES
(1, '28-10-2023', 1, 1, 1, 1),
(2, '8-10-2023', 2, 2, 2, 2),
(3, '30-10-2023', 3, 3, 3, 3),
(4, '27-10-2023', 4, 4, 4, 4),
(5, '13-10-2023', 5, 5, 5, 5),
(6, '20-10-2023', 6, 6, 6, 6),
(7, '27-10-2023', 7, 7, 7, 7),
(8, '22-10-2023', 8, 8, 8, 8),
(9, '9-10-2023', 9, 9, 9, 9),
(10, '15-10-2023', 10, 10, 10, 10);


--a)
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

--b)
SELECT id_pracownika FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.pensje ON id_pracownika=id_pensji
WHERE kwota>1000::money;

--c)
SELECT id_pracownika FROM ksiegowosc.pracownicy
JOIN ksiegowosc.premie ON id_pracownika=id_premii
JOIN ksiegowosc.pensje ON id_pracownika=id_pensji
WHERE pensje.kwota>2000::money AND premie.kwota IS NULL;

--d)
SELECT * FROM ksiegowosc.pracownicy 
WHERE imie LIKE 'J%';

--e)
SELECT * FROM ksiegowosc.pracownicy
WHERE (cast(imie AS varchar) LIKE '%a') AND (nazwisko LIKE '%n%'); 

--f)
SELECT imie, nazwisko, (liczba_godzin-160) AS liczba_nadgodzin 
FROM ksiegowosc.pracownicy
LEFT JOIN ksiegowosc.godziny ON pracownicy.id_pracownika=godziny.id_godziny;

--g)
SELECT imie, nazwisko FROM ksiegowosc.pracownicy
JOIN ksiegowosc.pensje ON id_pracownika=id_pensji
WHERE pensje.kwota>1500::money AND pensje.kwota<3000::money;

--h)
SELECT imie, nazwisko FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON pracownicy.id_pracownika=godziny.id_pracownika
JOIN ksiegowosc.premie ON pracownicy.id_pracownika=id_premii
WHERE liczba_godzin>160 AND kwota is NULL;

--i)
SELECT * FROM ksiegowosc.pracownicy
JOIN ksiegowosc.pensje ON id_pracownika=id_pensji
ORDER BY pensje.kwota;

--j)
SELECT * FROM ksiegowosc.pracownicy
JOIN ksiegowosc.premie ON id_pracownika=id_premii
JOIN ksiegowosc.pensje ON id_pracownika=id_pensji
ORDER BY premie.kwota DESC;

--k)
SELECT stanowisko, COUNT(stanowisko) AS ilosc_pracownikow FROM ksiegowosc.pensje
GROUP BY stanowisko;

--l)
SELECT stanowisko, MIN(kwota), MAX(kwota), AVG(kwota::numeric) 
FROM ksiegowosc.pensje
WHERE stanowisko LIKE 'Kierownik%'
GROUP BY stanowisko;

--m)
--tylko pensja
SELECT SUM(kwota) AS suma_wynagrodzen FROM ksiegowosc.pensje;

--pensja+premia
SELECT SUM(pensje.kwota + premie.kwota) AS suma_wynagrodzen FROM ksiegowosc.pensje
JOIN ksiegowosc.premie ON id_pensji=id_premii;

--n)
--tylko pensja
SELECT stanowisko, SUM(kwota) AS suma_wynagrodzen FROM ksiegowosc.pensje
GROUP BY stanowisko;

--pensja+premia
SELECT stanowisko, SUM(pensje.kwota + premie.kwota) AS suma_wynagrodzen FROM ksiegowosc.pensje
JOIN ksiegowosc.premie ON id_pensji=id_premii
GROUP BY stanowisko;

--o)
SELECT stanowisko, COUNT(rodzaj) AS liczba_premii FROM ksiegowosc.pensje
JOIN ksiegowosc.premie ON id_pensji=id_premii
GROUP BY stanowisko;

--p)
DELETE FROM ksiegowosc.pracownicy
USING ksiegowosc.pensje 
WHERE pensje.kwota<1200::money;
