--a)
ALTER TABLE pracownicy
ALTER COLUMN telefon TYPE VARCHAR(15);
UPDATE pracownicy 
SET telefon = 
	CASE
	WHEN id_pracownika = '1' THEN '+48-234-597-890'
	WHEN id_pracownika = '2' THEN '+48-234-567-890'
	WHEN id_pracownika = '3' THEN '+48-345-678-901'
	WHEN id_pracownika = '4' THEN '+48-456-789-012'
	WHEN id_pracownika = '5' THEN '+48-567-890-123'
	WHEN id_pracownika = '6' THEN '+48-678-901-234'
	WHEN id_pracownika = '7' THEN '+48-789-012-345'
	WHEN id_pracownika = '8' THEN '+48-890-123-456'
	WHEN id_pracownika = '9' THEN '+48-901-234-567'
	WHEN id_pracownika = '10' THEN '+48-987-654-321'
END;

--b)
UPDATE pracownicy
SET telefon = SUBSTR(telefon, 1, 3) || '-' || 
SUBSTR(telefon, 4, 3) || '-' || SUBSTR(telefon, 7, 3);

--c)
SELECT *
FROM ksiegowosc.pracownicy
ORDER BY LENGTH(UPPER(nazwisko)) DESC
LIMIT 1;

--d)
SELECT imie, nazwisko, MD5(CONCAT(imie, nazwisko, CAST(pensje.kwota AS TEXT))) AS haslo
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.pensje ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.pensje.id_pensji;

--f)
SELECT pracownicy.imie, pracownicy.nazwisko, pensje.kwota AS pensja, premie.kwota AS premia
FROM ksiegowosc.pracownicy
LEFT JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
LEFT JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensje.id_pensji
LEFT JOIN ksiegowosc.premie ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premie.id_premii;

--g)
SELECT CONCAT('Pracownik ', pracownicy.imie, pracownicy.nazwisko,', w dniu ', wynagrodzenie.data, ' otrzymał pensję całkowitą na kwotę ', 
pensje.kwota + premie.kwota, ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ', pensje.kwota, ' zł, premia: ', premie.kwota, ' zł')
AS raport FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensje ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensje.id_pensji
JOIN ksiegowosc.premie ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premie.id_premii;
