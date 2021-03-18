-- T/SQL
-- PROCEDURY

-- Procedura wypisujace wszystkie osoby zapisane w bazie i wypisujaca obok nich ich czy sa klientami, dostawcami czy rzeznikami

CREATE PROCEDURE proc1 
AS
  BEGIN
  DECLARE @imie AS VARCHAR(20), @nazwisko AS VARCHAR(20), @currentLine AS VARCHAR(40)
  DECLARE @vId AS INT
  DECLARE eachPerson CURSOR FOR 
  SELECT id_osoba, imie, nazwisko 
  FROM Osoba
  OPEN eachPerson
  FETCH NEXT FROM eachPerson INTO @vId , @imie, @nazwisko
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @currentLine = @imie + ' ' + @nazwisko
    IF EXISTS(SELECT id_rzeznik FROM Rzeznik WHERE id_rzeznik = @vId)
    BEGIN
      PRINT @currentLine + ' ' + 'RZEZNIK'
    END
    IF EXISTS(SELECT id_klient FROM Klient WHERE id_klient = @vId)
    BEGIN
      PRINT @currentLine + ' ' + 'KLIENT'
    END
    IF EXISTS(SELECT id_dostawca FROM Dostawca WHERE id_dostawca = @vId)
    BEGIN
      PRINT @currentLine + ' ' + 'DOSTAWCA'
    END
    FETCH NEXT FROM eachPerson INTO @vId , @imie, @nazwisko
  END
END

-- Procedura zwracajaca ilosc dostaw ktore dostarczyla podana w parametrze procedury firma kurierska

CREATE PROCEDURE proc2 @nazwaFirmy VARCHAR(20), 
@ilosc INT OUTPUT
AS
  BEGIN
  SELECT @ilosc = COUNT(*)
  FROM Dostawa_miesa_do_klienta dos
  JOIN Dostawca ON dos.id_dostawca = Dostawca.id_dostawca
  WHERE id_firma = (SELECT id_firma FROM Firma_kurierska WHERE nazwa = @nazwaFirmy)
END

-- Procedura wypisujaca imie i nazwisko klientow oraz ich koszt zakupu na podawny w parametrze procedury rodzaj miesa

CREATE PROCEDURE proc3 @rodzajMiesa VARCHAR(20)
AS 
  BEGIN
  DECLARE eachTransaction CURSOR FOR
  SELECT imie, nazwisko, dos.ilosc * Produkt.cena FROM Dostawa_miesa_do_klienta dos
  JOIN Produkt ON Produkt.id_produkt = dos.id_produkt
  JOIN Rodzaj_miesa ON Produkt.id_rodzaj = Rodzaj_miesa.id_rodzaj
  JOIN Klient ON dos.id_klient = Klient.id_klient
  JOIN Osoba ON Klient.id_klient = Osoba.id_osoba
  WHERE Rodzaj_miesa.nazwa = @rodzajMiesa
  DECLARE @imie VARCHAR(20), @nazwisko VARCHAR(20);
  DECLARE @ilosc INT
  OPEN eachTransaction;
  FETCH NEXT FROM eachTransaction INTO @imie , @nazwisko, @ilosc
  PRINT @rodzajMiesa
  WHILE @@FETCH_STATUS = 0
  BEGIN
    PRINT @imie + ' ' + @nazwisko + ' ' + CONVERT(varchar(10), @ilosc)
    FETCH NEXT FROM eachTransaction INTO @imie , @nazwisko, @ilosc
  END
END

-- WYZWALACZE

-- Trigger nie pozwalajacy dodac nowej firmy kurierskiej poniewaz sa zawsze stali dostawcy 

CREATE TRIGGER trigger1
ON Firma_kurierska
FOR INSERT, UPDATE , DELETE
AS
BEGIN
  RAISERROR (15600,-1,-1, 'ONLY CONTRACTED COMPANIES');  
  ROLLBACK
END

-- Trigger zmieniajacy place jesli nowy pracownik otrzyma wynagrodzenie za duze w porwnaniu do reszty

CREATE TRIGGER trigger2
ON Rzeznik
AFTER INSERT
AS
BEGIN
  DECLARE @vId INT, @minPlaca INT , @placa INT, @insertedPlaca INT
  SELECT @insertedPlaca = placa FROM inserted 
  SELECT @minPlaca = MIN(placa) FROM Rzeznik
  DECLARE eachRzeznik CURSOR FOR
  SELECT id_rzeznik, placa FROM Rzeznik
  WHERE placa < @insertedPlaca/2
  IF @insertedPlaca > @minPlaca * 2 - 100       
  BEGIN
    OPEN eachRzeznik
    FETCH NEXT FROM eachRzeznik INTO @vId, @placa
    WHILE @@FETCH_STATUS = 0
    BEGIN
      UPDATE Rzeznik
      SET placa = @placa + 200
      WHERE id_rzeznik = @vId
      FETCH NEXT FROM eachRzeznik INTO @vId, @placa
    END
  END 
END