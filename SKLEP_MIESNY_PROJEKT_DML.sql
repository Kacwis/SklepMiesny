INSERT INTO Rodzaj_miesa  VALUES (1,'WIEPRZOWINA');
INSERT INTO Rodzaj_miesa  VALUES (2,'BARANINA');
INSERT INTO Rodzaj_miesa   VALUES (3,'WOLOWINA');
INSERT INTO Rodzaj_miesa  VALUES (4,'DROB');

INSERT INTO Produkt VALUES (1,'KARKOWKA',(SELECT id_rodzaj FROM rodzaj_miesa WHERE nazwa = 'WIEPRZOWINA'),5,10);
INSERT INTO Produkt VALUES (2,'SCHAB',(SELECT id_rodzaj FROM rodzaj_miesa WHERE nazwa = 'WIEPRZOWINA'),3, 10);
INSERT INTO Produkt VALUES (3,'WEDLINA', (SELECT id_rodzaj FROM rodzaj_miesa WHERE nazwa = 'DROB'),2, 10);
INSERT INTO Produkt VALUES (4,'NOZKA' ,(SELECT id_rodzaj FROM rodzaj_miesa WHERE nazwa = 'DROB'),4, 10);
INSERT INTO Produkt VALUES (5,'KEBAB' ,(SELECT id_rodzaj FROM rodzaj_miesa WHERE nazwa = 'BARANINA'),8, 10);
INSERT INTO Produkt VALUES (6,'STEK' ,(SELECT id_rodzaj FROM rodzaj_miesa WHERE nazwa = 'WOLOWINA'),10, 10);
INSERT INTO Produkt VALUES (7,'ANTRYKOT', (SELECT id_rodzaj FROM rodzaj_miesa WHERE nazwa = 'WOLOWINA'),12, 10);

INSERT INTO Firma_kurierska VALUES (1,'UPS');
INSERT INTO Firma_kurierska VALUES (2,'INPOST');
INSERT INTO Firma_kurierska VALUES (3,'FEDEX');

INSERT INTO Dostawa_produktu VALUES (1, '2019-06-08',10,(SELECT id_produkt FROM Produkt WHERE nazwa = 'KEBAB'));
INSERT INTO Dostawa_produktu VALUES (2, '2020-01-03',5, (SELECT id_produkt FROM Produkt WHERE nazwa = 'NOZKA'));
INSERT INTO Dostawa_produktu VALUES (3, '2020-02-03',7, (SELECT id_produkt FROM Produkt WHERE nazwa = 'STEK'));
INSERT INTO Dostawa_produktu VALUES (4, '2019-11-03', 10, (SELECT id_produkt FROM Produkt WHERE nazwa = 'KARKOWKA'));

INSERT INTO Osoba VALUES (1,'KAROL','NOWAK', 693283213);
INSERT INTO Osoba VALUES (2,'MICHAL','KOWAL', 887653178);
INSERT INTO Osoba VALUES (3,'KACPER','PIECHOWIAK', 664302003);
INSERT INTO OSOBA VALUES (4,'MAREK','MOSTOWIAK', 652324242);
INSERT INTO Osoba VALUES (5,'KUBA', 'KOWALCZYK', 54623472);
INSERT INTO Osoba VALUES (6,'KAROLINA', 'KOWALSKA', 654987323);
INSERT INTO Osoba VALUES (7,'JULIA', 'JABLKO',546235231);
INSERT INTO Osoba VALUES (8,'PATRYK', 'SMOLAREK', 654244235);
INSERT INTO Osoba VALUES (9,'KARINA', 'GRUSZKOWSKA',234532098);
INSERT INTO Osoba VALUES (10,'MARCEL', 'PACZEK',253985345);

INSERT INTO Rzeznik VALUES(2,'2017-06-05', 1000);
INSERT INTO Rzeznik VALUES(5,'2018-03-05', 700);
INSERT INTO Rzeznik VALUES(7, '2019-04-02', 700);

INSERT INTO Dostawca VALUES(1,(SELECT id_firma FROM Firma_kurierska WHERE nazwa = 'UPS'));
INSERT INTO Dostawca VALUES(3,(SELECT id_firma FROM Firma_kurierska WHERE nazwa = 'FEDEX'));
INSERT INTO Dostawca VALUES(4,(SELECT id_firma FROM Firma_kurierska WHERE nazwa = 'INPOST'));

INSERT INTO Status VALUES (1,'ZREALIZOWANE');
INSERT INTO Status VALUES (2,'W TRAKCIE');
INSERT INTO Status VALUES (3,'NIE WYSLANE');
INSERT INTO Status VALUES (4,'NIE GOTOWE');

INSERT INTO Klient VALUES (6, '2018-03-01', 0);
INSERT INTO Klient VALUES(8,'2019-07-02', 0);
INSERT INTO Klient VALUES(9,'2016-03-01', 0);
INSERT INTO Klient VALUES(10,'2011-08-03', 0);


INSERT INTO Dostawa_miesa_do_klienta VALUES ( 1, 
    (SELECT id_produkt FROM Produkt WHERE nazwa = 'KARKOWKA'),
    3,
    '2018-03-05',
    6,
    (SELECT id_status FROM Status WHERE status = 'ZREALIZOWANE'),
    1
);
INSERT INTO Dostawa_miesa_do_klienta VALUES (2,
    (SELECT id_produkt FROM Produkt WHERE nazwa = 'NOZKA'),
    5,
    '2019-07-07',
    8,
    (SELECT id_status FROM Status WHERE status = 'ZREALIZOWANE'),
    3
);
INSERT INTO Dostawa_miesa_do_klienta VALUES (3,
    (SELECT id_produkt FROM Produkt WHERE nazwa = 'STEK'),
    6,
    '2020-06-20',
    10,
    (SELECT id_status FROM Status WHERE status = 'W TRAKCIE'),
    3
);
INSERT INTO Dostawa_miesa_do_klienta VALUES (4,
    (SELECT id_produkt FROM Produkt WHERE nazwa = 'ANTRYKOT'),
    3,
    '2020-01-02',
    10,
    (SELECT id_status FROM Status WHERE status = 'ZREALIZOWANE'),
    4
);
INSERT INTO Dostawa_miesa_do_klienta VALUES (5,
    (SELECT id_produkt FROM Produkt WHERE nazwa = 'KEBAB'),
    5,
    NULL,
    9,
    (SELECT id_status FROM Status WHERE status = 'NIE GOTOWE'),
    1
);
INSERT INTO Dostawa_miesa_do_klienta VALUES (6,
    (SELECT id_produkt FROM Produkt WHERE nazwa = 'WEDLINA'),
    10,
    '2019-06-30',
    6,
    (SELECT id_status FROM Status WHERE status = 'NIE WYSLANE'),
    3
);