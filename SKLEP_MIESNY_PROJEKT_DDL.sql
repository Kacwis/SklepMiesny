
CREATE TABLE Osoba (
    id_osoba int,
    imie varchar(255),
    nazwisko varchar(255),
    numer_telefonu int,
    CONSTRAINT PK_osoba
    PRIMARY KEY(id_osoba)
);

CREATE TABLE Klient (
    id_klient int NOT NULL,
    data_pierwszego_zamowienia date,
    znizka int, 
    CONSTRAINT PK_klient
    PRIMARY KEY(id_klient),
    CONSTRAINT FK_klient
    FOREIGN KEY (id_klient) REFERENCES Osoba(id_osoba)
);

CREATE TABLE Rzeznik (
    id_rzeznik int,
    data_zatrudnienia date,
    placa int,
    PRIMARY KEY (id_rzeznik),
    FOREIGN KEY (id_rzeznik) REFERENCES Osoba(id_osoba)
);

CREATE TABLE Firma_kurierska (
    id_firma int,
    nazwa varchar(255),
    PRIMARY KEY (id_firma)
);

CREATE TABLE Dostawca (
    id_dostawca int,
    id_firma int,
    PRIMARY KEY (id_dostawca),
    FOREIGN KEY(id_firma) REFERENCES Firma_kurierska(id_firma)
);

CREATE TABLE Status (
    id_status int,
    status varchar(255),
    CONSTRAINT PK_status
    PRIMARY KEY (id_status)
);

CREATE TABLE Rodzaj_miesa (
    id_rodzaj int NOT NULL,
    nazwa varchar(255),
    CONSTRAINT PK_rodzaj
    PRIMARY KEY (id_rodzaj)
);

CREATE TABLE Produkt (
    id_produkt int NOT NULL,
    nazwa varchar(255),
    id_rodzaj int,
    cena int,
    ilosc int,
    CONSTRAINT PK_produkt
    PRIMARY KEY (id_produkt),
    CONSTRAINT FK_rodzaj
    FOREIGN KEY (id_rodzaj) REFERENCES Rodzaj_miesa(id_rodzaj)
);

CREATE TABLE Dostawa_produktu (
    id_dostawa int,
    data_dostawy date,
    ilosc int,
    id_produkt int,
    CONSTRAINT PK_dostawa_produktu
    PRIMARY KEY (id_dostawa),
    CONSTRAINT FK_produkt_dostawa
    FOREIGN KEY (id_produkt) REFERENCES Produkt (id_produkt)
);

CREATE TABLE Dostawa_miesa_do_klienta (
     id_dostawa int NOT NULL,
     id_produkt int,
     ilosc int,
     data_realizacji date NULL,
     id_klient int,
     id_status int,
     id_dostawca int,
     CONSTRAINT PK_dostawa 
     PRIMARY KEY (id_dostawa),
     CONSTRAINT FK_produktDostawa
     FOREIGN KEY (id_produkt) REFERENCES Produkt (id_produkt ),
     CONSTRAINT FK_klientDostawa
     FOREIGN KEY (id_klient) REFERENCES Klient (id_klient),
     CONSTRAINT FK_statusDostawa
     FOREIGN KEY (id_status) REFERENCES Status (id_status),
     CONSTRAINT FK_dostawcaDostawa
     FOREIGN KEY (id_dostawca) REFERENCES Dostawca (id_dostawca)
); 

