-- PL/SQL 
-- PROCEDURY

-- Procedura wypisujaca do konsoli wszystkie transakcje za kwote mniejsza niz podana w parametrze procedury

CREATE OR REPLACE PROCEDURE proc2
(vCena INT)
AS
    CURSOR cur1 IS SELECT imie, nazwisko, nazwa ,ilosc, cena
    FROM Dostawa_miesa_do_klienta dos 
    JOIN Klient ON dos.id_klient = Klient.id_klient 
    JOIN Produkt ON dos.id_produkt = Produkt.id_produkt
    JOIN Osoba ON Klient.id_klient = Osoba.id_osoba;
    vImie VARCHAR(20);
    vNazwisko VARCHAR(20);
    vNazwa VARCHAR(20);
    vIlosc INT;
    vCenaProduktu INT;
BEGIN
    OPEN cur1;
    LOOP
        FETCH cur1 INTO vImie, vNazwisko, vNazwa, vIlosc, vCenaProduktu;
        EXIT WHEN cur1%NOTFOUND;
        IF vCenaProduktu * vIlosc < vCena THEN
            dbms_output.put_line(vImie || ' ' || vNazwisko || ' ' || vNazwa || ' ' || vIlosc * vCenaProduktu);
        END IF;
    END LOOP;
END;

BEGIN
    proc2(50);
END;

-- Procedura zwracajaca ilosc zamowien na podany w parametrze procedury rodzaj miesa

CREATE OR REPLACE PROCEDURE proc1
(vRodzaj VARCHAR, vIlosc OUT INT)
AS
BEGIN
    SELECT COUNT(1) INTO vIlosc
    FROM Dostawa_miesa_do_klienta dos
    JOIN Produkt ON dos.id_produkt = Produkt.id_produkt
    JOIN Rodzaj_miesa ON Produkt.id_rodzaj = Rodzaj_miesa.id_rodzaj WHERE Rodzaj_miesa.nazwa LIKE vRodzaj;
END;

DECLARE 
    vIlosc INT;
BEGIN
    proc1('WOLOWINA', vIlosc);
    dbms_output.put_line(vIlosc);
END;

-- WYZWALACZE

-- Trigger ktory po zatwierdzonej dostawy do klienta doliczy znizke  

CREATE OR REPLACE TRIGGER trigger1
AFTER INSERT ON dostawa_miesa_do_klienta
FOR EACH ROW
DECLARE
    vId INT;
BEGIN
    vId := :new.id_klient;
    UPDATE Klient
    SET Klient.znizka = znizka + 2
    WHERE Klient.id_klient = vId;
END;

-- Trigger ktory uruchamia sie przy nowej dostawej produktu i sprawdza czy danego rodzaju miesa nie jest za duzo jesli tak obniza cene wszystkich produktow z tego rodzaju

CREATE OR REPLACE TRIGGER trigger2
BEFORE INSERT ON dostawa_produktu
FOR EACH ROW 
DECLARE 
    vIdRodzaj INT;
    vSuma INT;
    vCalkowitaSuma INT;
BEGIN
    SELECT id_rodzaj INTO vIdRodzaj
        FROM Produkt
        WHERE id_produkt = :new.id_produkt;
    SELECT SUM(ilosc) INTO vSuma
        FROM Produkt
        WHERE id_rodzaj = vIdRodzaj;
    SELECT SUM(ilosc) INTO vCalkowitaSuma
        FROM Produkt;
    IF vSuma > vCalkowitaSuma/3 THEN
        UPDATE Produkt
        SET cena = cena - 1
        WHERE id_rodzaj = vIdRodzaj;
    END IF;
END;

