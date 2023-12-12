create database firma;
-----------------------------------
create schema ksiegowosc;
-----------------------------------
create table ksiegowosc.pracownicy(
	id_pracownika SERIAL primary key,
	imie VARCHAR(50),
	nazwisko VARCHAR(50),
	adres VARCHAR(100),
	telefon VARCHAR(9));

   create table ksiegowosc.godziny(
	id_godziny SERIAL primary key,
	data DATE,
	liczba_godzin INTEGER,
	id_pracownika INTEGER,
	foreign key (id_pracownika) references ksiegowosc.pracownicy(id_pracownika));

   create table ksiegowosc.pensja(
	id_pensja SERIAL primary key,
	stanowisko VARCHAR(100),
	kwota DECIMAL(10, 2));

   create table ksiegowosc.premia(
	id_premii SERIAL primary key,
	rodzaj VARCHAR(50),
	kwota DECIMAL(10, 2));

   create table ksiegowosc.wynagrodzenie(
	id_wynagrodzenia SERIAL primary key,
	data DATE,
	id_pracownika INTEGER,
	id_godziny INTEGER,
	id_pensja INTEGER,
	id_premii INTEGER,
	foreign key (id_pracownika) references ksiegowosc.pracownicy(id_pracownika),
	foreign key (id_godziny) references ksiegowosc.godziny(id_godziny),
        foreign key (id_pensja) references ksiegowosc.pensja(id_pensja),
        foreign key (id_premii) references ksiegowosc.premia(id_premii));
-----------------------------------
insert into ksiegowosc.pracownicy (imie, nazwisko, adres, telefon) values
    ('Jan', 'Kowalski', 'ul. Kwiatowa 1', '123456789'),
    ('Anna', 'Nowak', 'ul. Leśna 2', '987654321'),
    ('Piotr', 'Wiśniewski', 'ul. Słoneczna 3', '555555555'),
    ('Ewa', 'Dąbrowska', 'ul. Polna 4', '666666666'),
    ('Krzysztof', 'Lewandowski', 'ul. Rajska 5', '777777777'),
    ('Małgorzata', 'Wójcik', 'ul. Lipowa 6', '888888888'),
    ('Grzegorz', 'Kamiński', 'ul. Ogrodowa 7', '999999999'),
    ('Agnieszka', 'Kowalczyk', 'ul. Kwiatowa 8', '111111111'),
    ('Marek', 'Zieliński', 'ul. Leśna 9', '222222222'),
    ('Magdalena', 'Szymańska', 'ul. Słoneczna 10', '333333333');

insert into ksiegowosc.godziny (data, liczba_godzin, id_pracownika) values
    ('2023-10-01', 8, 1),
    ('2023-10-02', 6, 2),
    ('2023-10-03', 7, 3),
    ('2023-10-04', 8, 4),
    ('2023-10-05', 9, 5),
    ('2023-10-06', 8, 6),
    ('2023-10-07', 6, 7),
    ('2023-10-08', 7, 8),
    ('2023-10-09', 5, 9),
    ('2023-10-10', 9, 10);

insert into ksiegowosc.pensja (stanowisko, kwota) values
    ('Manager', 7000.00),
    ('Księgowy', 5000.00),
    ('Sprzedawca', 3000.00),
    ('Programista', 6000.00),
    ('Recepcjonista', 3500.00),
    ('Analityk', 5500.00),
    ('Inżynier', 6500.00),
    ('Doradca', 4500.00),
    ('Pracownik fizyczny', 2500.00),
    ('Sekretarka', 4000.00);

insert into ksiegowosc.premia (rodzaj, kwota) values 
    ('Za dobre wyniki', 1000.00),
    ('Za staż pracy', 500.00),
    ('Premia świąteczna', 800.00),
    ('Premia uznaniowa', 1200.00),
    ('Za wysiłek dodatkowy', 900.00),
    ('Za sugestie', 600.00),
    ('Premia roczna', 1500.00),
    ('Za projekt specjalny', 1100.00),
    ('Premia za wydajność', 700.00),
    ('Premia za kreatywność', 1300.00);

insert into ksiegowosc.wynagrodzenie (data, id_pracownika, id_godziny, id_pensja, id_premii) values 
    ('2023-10-01', 1, 1, 1, 1),
    ('2023-10-02', 2, 2, 2, 2),
    ('2023-10-03', 3, 3, 3, 3),
    ('2023-10-04', 4, 4, 4, 4),
    ('2023-10-05', 5, 5, 5, 5),
    ('2023-10-06', 6, 6, 6, 6),
    ('2023-10-07', 7, 7, 7, 7),
    ('2023-10-08', 8, 8, 8, 8),
    ('2023-10-09', 9, 9, 9, 9),
    ('2023-10-10', 10, 10, 10, 10);
-----------------------------------
select id_pracownika, nazwisko from ksiegowosc.pracownicy;
-----------------------------------
select prac.id_pracownika, pen.kwota from ksiegowosc.pracownicy as prac
    inner join ksiegowosc.wynagrodzenie as wyn on wyn.id_pracownika = prac.id_pracownika
    inner join ksiegowosc.pensja as pen on wyn.id_pensja = pen.id_pensja
    where pen.kwota > 1000;
-----------------------------------
select prac.id_pracownika, pen.kwota, pre.kwota from ksiegowosc.pracownicy as prac
    inner join ksiegowosc.wynagrodzenie as wyn on wyn.id_pracownika = prac.id_pracownika
    inner join ksiegowosc.pensja as pen on wyn.id_pensja = pen.id_pensja
    inner join ksiegowosc.premia as pre on wyn.id_premii = pre.id_premii
    where pen.kwota > 2000 and pre.kwota is null;
-----------------------------------
select imie from ksiegowosc.pracownicy
    where imie like 'J%'
  -----------------------------------
select imie, nazwisko from ksiegowosc.pracownicy
    where nazwisko like '%n%' and imie like '%a';
-----------------------------------
select prac.imie, prac.nazwisko, god.liczba_godzin,
    case when god.liczba_godzin > 160 then god.liczba_godzin - 160
    else 0 end as liczba_nadgodzin
    from ksiegowosc.pracownicy as prac
    inner join ksiegowosc.wynagrodzenie as wyn on wyn.id_pracownika = prac.id_pracownika
    inner join ksiegowosc.pensja as pen on wyn.id_pensja = pen.id_pensja
    inner join ksiegowosc.godziny as god on wyn.id_godziny = god.id_godziny
  -----------------------------------
select prac.imie, prac.nazwisko, pen.kwota from ksiegowosc.pracownicy as prac
    inner join ksiegowosc.wynagrodzenie as wyn on wyn.id_pracownika = prac.id_pracownika
    inner join ksiegowosc.pensja as pen on wyn.id_pensja = pen.id_pensja
    where pen.kwota between 1500 and 3000;
-----------------------------------
select prac.imie, prac.nazwisko from ksiegowosc.pracownicy as prac
    inner join ksiegowosc.wynagrodzenie as wyn ON wyn.id_pracownika = prac.id_pracownika
    inner join ksiegowosc.pensja as pen ON wyn.id_pensja = pen.id_pensja
    inner join ksiegowosc.godziny as god ON wyn.id_godziny = god.id_godziny
    left join ksiegowosc.premia as pre ON wyn.id_premii = pre.id_premii
    where god.liczba_godzin > 160 and pre.id_premii is null;
-----------------------------------
select prac.imie, prac.nazwisko, pen.kwota from ksiegowosc.pracownicy as prac
    inner join ksiegowosc.wynagrodzenie as wyn ON wyn.id_pracownika = prac.id_pracownika
    inner join ksiegowosc.pensja as pen ON wyn.id_pensja = pen.id_pensja
    order by pen.kwota 
  -----------------------------------
select prac.imie, prac.nazwisko, pen.kwota from ksiegowosc.pracownicy as prac
    inner join ksiegowosc.wynagrodzenie as wyn ON wyn.id_pracownika = prac.id_pracownika
    inner join ksiegowosc.pensja as pen ON wyn.id_pensja = pen.id_pensja
    order by pen.kwota DESC
  -----------------------------------
select pen.stanowisko, COUNT(pen.stanowisko)from ksiegowosc.pracownicy as prac
    inner join ksiegowosc.wynagrodzenie as wyn ON wyn.id_pracownika = prac.id_pracownika
    inner join ksiegowosc.pensja as pen ON wyn.id_pensja = pen.id_pensja
    group by pen.stanowisko;
-----------------------------------
select pen.stanowisko, AVG(pen.kwota), MIN(pen.kwota), MAX(pen.kwota) from ksiegowosc.pracownicy as prac
    inner join ksiegowosc.wynagrodzenie as wyn ON wyn.id_pracownika = prac.id_pracownika
    inner join ksiegowosc.pensja as pen ON wyn.id_pensja = pen.id_pensja
    where pen.stanowisko = 'Sekretarka'
    group by pen.stanowisko;
-----------------------------------
select SUM(pen.kwota) from ksiegowosc.pracownicy as prac
    inner join ksiegowosc.wynagrodzenie as wyn ON wyn.id_pracownika = prac.id_pracownika
    inner join ksiegowosc.pensja as pen ON wyn.id_pensja = pen.id_pensja
-----------------------------------
select pen.stanowisko, SUM(pen.kwota) from ksiegowosc.pracownicy as prac
    inner join ksiegowosc.wynagrodzenie as wyn ON wyn.id_pracownika = prac.id_pracownika
    inner join ksiegowosc.pensja as pen ON wyn.id_pensja = pen.id_pensja
    group by pen.stanowisko
-----------------------------------
select pen.stanowisko, COUNT(pre.id_premii) as liczba_premii
    from ksiegowosc.pensja as pen
    inner join ksiegowosc.wynagrodzenie as wyn ON pen.id_pensja = wyn.id_pensja
    left join ksiegowosc.premia as pre ON wyn.id_premii = pre.id_premii
    group by pen.stanowisko;
-----------------------------------
delete from ksiegowosc.pracownicy   
    where id_pracownika in (
      select prac.id_pracownika
      from ksiegowosc.pracownicy as prac
      inner join ksiegowosc.wynagrodzenie as wyn on wyn.id_pracownika = prac.id_pracownika
      inner join ksiegowosc.pensja as pen on wyn.id_pensja = pen.id_pensja
      where pen.kwota < 1200);
