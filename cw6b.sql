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
