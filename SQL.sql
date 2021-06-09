-- INTEROGARI


--1 Sa se afiseze numele complet si destinatia pt utilizatorii a caror rezervare incepe 
--in aceeasi zi a lunii ca aceea in care s-au nascut, in ordine alfabetica 
SELECT last_name, first_name, d.destination_name
FROM users_mhe u JOIN bookings_mhe b
ON u.user_id = b.user_id
JOIN hotels_mhe h ON h.hotel_id = b.hotel_id
JOIN destinations_mhe d ON h.destination_name = d.destination_name
WHERE TO_CHAR(b.start_date, 'DD') = ( SELECT TO_CHAR(u.dob, 'DD')  
    FROM users_mhe
    WHERE user_id = u.user_id)
ORDER BY last_name;

------------------------PREDOIU SET 1

-- 1 Sa se afiseze numele si prenumele actorilor care sunt nascuti in aceeasi luna ca aceea in care 
--s-a infiintat trupa de teatru din care fac parte si numarul de luni care a trecut de la infiintarea trupei

SELECT NUME_ACTOR, PRENUME, MONTHS_BETWEEN( ROUND(MONTHS_BETWEEN(sysdate, DATA_INFIINTARE)
FROM ACTOR_GPR 
JOIN APARTINE_GPR USING (ID_ACTOR) 
JOIN TRUPA_GPR USING(ID_TRUPA)
WHERE TO_CHAR(DATA_NASTERII, 'MON') = (SELECT TO_CHAR(DATA_INFIINTARE, 'MON')
	FROM ACTOR_GPR A
	WHERE ID_ACTOR = A.ID_ACTOR)
	

--2 Sa se afiseze titlul piesei si ratingul pentru toate piesele de teatru care au rating maxim sau care nu se joaca in judetul Timis
--peste 120 de minute

SELECT TITLU, RATING 
FROM PIESA_GPR 
WHERE RATING = (SELECT MAX(RATING) FROM
      PIESA_GPR)
UNION (
SELECT TITLU, RATING 
FROM PIESA_GPR P JOIN TEATRU_GPR T 
ON P.ID_TEATRU = T.ID_TEATRU)
MINUS
(SELECT TITLU, RATING
FROM PIESA_GPR P JOIN TEATRU_GPR T 
ON P.ID_TEATRU = T.ID_TEATRU JOIN
ORAS O ON T.ID_ORAS = O.ID_ORAS
WHERE UPPER(TRIM(O.JUDET)) = 'TIMIS'))

--3 Sa se afiseze pentru fiecare oras capacitatea medie a teatrelor si numarul total de teatre


--4 Sa se afiseze numele si prenumele pentru toti actorii care joaca in cel putin aceleasi piese ca actorul X 


--5 Sa se afiseze numele si anul nasterii pt actorii care sunt nascuti in ziua in care cei mai multi actori au
--fost nascuti 

SELECT NUME_ACTOR || ' ' || TO_CHAR(DATA_NASTERII, 'DD') "Numele si ziua nasterii"
FROM ACTOR_GPR
WHERE TO_CHAR(DATA_NASTERII, 'DD') = (SELECT TO_CHAR(DATA_NASTERII,'DD')
FROM ACTOR_GPR
GROUP BY TO_CHAR(DATA_NASTERII,'DD')
HAVING COUNT(TO_CHAR(DATA_NASTERII,'DD')) = (SELECT MAX(COUNT(*))
    FROM ACTOR_GPR
    GROUP BY TO_CHAR(DATA_NASTERII,'DD')));
    

---------------------------------------------


--2 Sa se afiseze numarul de luni care au trecut de la cea mai veche, respectiv cea mai recenta rezervare pentru 
--hotelul cu codul H2 
SELECT tabel.nr_luni1, tabel.nr_luni2 
FROM ( SELECT ROUND(MONTHS_BETWEEN(sysdate, 
(SELECT MIN(start_date) FROM bookings_mhe 
WHERE UPPER(TRIM(hotel_id)) LIKE 'H2' AND start_date < sysdate)),3) nr_luni1,
ROUND(MONTHS_BETWEEN( sysdate,
(SELECT MAX(start_date) FROM bookings_mhe 
WHERE UPPER(TRIM(hotel_id)) LIKE 'H2' AND start_date <sysdate )),3) nr_luni2 FROM dual) tabel;



--3 Sa se afiseze codul hotelului si lantul hotelier pentru toate hotelurile cu numarul maxim de stele sau pentru
--care nu s-au facut rezervari in luna august 
SELECT hotel_id, chain_name FROM hotels_mhe 
JOIN hotelchains_mhe USING (chain_id)
WHERE stars = (SELECT MAX(stars) FROM
      hotels_mhe)
UNION (
SELECT hotel_id, chain_name FROM hotels_mhe 
JOIN hotelchains_mhe USING (chain_id)
MINUS
    SELECT DISTINCT hotel_id, chain_name FROM bookings_mhe 
JOIN hotels_mhe USING (hotel_id)
JOIN hotelchains_mhe USING (chain_id)
WHERE LOWER(TRIM((TO_CHAR(start_date, 'month')))) = 'august'); 


--4 Sa se afiseze numele, prenumele si destinatia  pentru utilizatorii a caror rezevare se termina inainte de o anumita data  
-- introdusa de la tastatura si care au facut o rezervare pentru un numar de persoane mai mare decat media numarului de persoane 
ACCEPT data_r DATE PROMPT 'data = ';
SELECT last_name, first_name, destination_name, end_date
FROM bookings_mhe JOIN users_mhe USING(user_id)
JOIN hotels_mhe USING(hotel_id)
WHERE TO_DATE('&data_r', 'dd-mon-rr')-end_date > 0 AND guests_no > (
SELECT ROUND(AVG(guests_no),2) FROM bookings_mhe); 


--5 Sa se afiseze pentru fiecare destinatie tara, numarul de rezervari si durata medie a sederii, exprimata in zile

WITH zile AS(
SELECT destination_name, AVG(nr_zile) Nr_mediu_zile FROM(
SELECT destination_name, end_date-start_date AS Nr_zile FROM bookings_mhe JOIN hotels_mhe USING (hotel_id)) 
GROUP BY destination_name)

SELECT d.destination_name,c.country_name, NVL((SELECT COUNT(*) FROM bookings_mhe 
JOIN hotels_mhe USING (hotel_id) WHERE destination_name = d.destination_name GROUP BY destination_name),0) Nr_rezervari,
NVL(z.Nr_mediu_zile,0) || ' zile' Nr_mediu_zile
FROM destinations_mhe d JOIN countries_mhe c ON c.country_id = d.country_id
LEFT JOIN zile z ON z.destination_name = d.destination_name;


--6 Sa se numele lantului hotelier pentru hotelurile care au cel putin o rezervare activa in data de 10.10.2020
--Se vor considera si hotelurile care nu apartin unui lant hotelier 
SELECT chain_name
FROM hotelchains_mhe hc 
FULL JOIN hotels_mhe h ON hc.chain_id = h.chain_id
JOIN bookings_mhe b ON b.hotel_id = h.hotel_id
WHERE EXISTS
( SELECT chain_name
FROM hotelchains_mhe
FULL JOIN hotels_mhe USING(chain_id)
JOIN bookings_mhe USING(hotel_id) WHERE start_date <= TO_DATE('10-10-2020', 'DD-MM-YYYY')
AND end_date  >= TO_DATE('10-10-2020', 'DD-MM-YYYY') AND hotel_id = h.hotel_id);


-----------------------PREDOIU SET 2 


--6 Sa se afiseze titlul si genul piselor care se joaca in acelasi teatru in care se joaca si piesa cu id_ul X 


--7 Sa se afiseze pentru fiecare actor titlul piesei in care joaca si numele trupei de teatru din care face parte. Se vor lua in
-- Pentru actorii care nu fac parte dintr-o trupa de teatru se va afisa "Nu face parte" 


--8 Sa se afiseze strada,numarul si orasul pentru teatrele care se afla in judetul X si in care se joaca cel putin o piesa de comedie


--9 Pentru fiecare teatru, sa se afiseze numele, orasul, capacitatea actuala si capacitatea dupa renovare. Se presupune ca pentru teatrele din judetul
-- Brasov capacitatea se mareste cu 10%, pentru cele din judetul Cluj cu 20%, iar pentru cele din judetul Timis cu 25%. Pentru toate celelalte,
--capacitatea ramane aceeasi. 


--10 Sa se afiseze data de peste 3 luni de la data infiintarii pentru trupele care existau in data de 10.10.2010 si care au cel putin 3 membri



-------------------------------------


--7 Sa se afiseze numele si anul nasterii pt utilizatorii care sunt nascuti in anul in care cei mai multi ultilizatori au
--fost nascuti 
SELECT last_name || ' ' || TO_CHAR(DOB, 'yyyy') "Numele si anul nasterii"
FROM users_mhe
WHERE TO_CHAR(DOB, 'yyyy') = (SELECT TO_CHAR(DOB,'yyyy')
FROM users_mhe
GROUP BY TO_CHAR(DOB,'yyyy')
HAVING COUNT(TO_CHAR(DOB,'yyyy')) = (SELECT MAX(COUNT(*))
    FROM users_mhe
    GROUP BY TO_CHAR(DOB,'yyyy')));
    

--8 Sa se afiseze numarul de rezervari in lant incepand cu data de 13.02.2020
SELECT max(level) Numar_maxim
FROM bookings_mhe
START WITH end_date = TO_DATE('13-09-2020', 'dd-mm-yyyy')
CONNECT BY PRIOR end_date = start_date;


---9 Pentru fiecare hotel, sa se afiseze lantul hotelier,
--cel mai iefin si cel scump tip de camera, precum si capacitatea medie a unei camere 
SELECT hotel_id, NVL((SELECT chain_name FROM hotelchains_mhe RIGHT JOIN hotels_mhe USING(chain_id) 
WHERE hotel_id = tabel.hotel_id),'Nu apartine unui lant') "Lant hotelier",
MIN(tabel.pret) "Pret minim camera" , MAX(tabel.pret)"Pret maxim camera", 
ROUND(AVG(tabel.capacitate),2) "Capacitate medie camera"
FROM(
SELECT hotel_id, type_id, price pret, capacity capacitate
FROM hotelrooms_mhe JOIN roomtypes_mhe USING(type_id)) tabel
GROUP BY hotel_id; 


--10 Sa se afiseze numarul de rezervari pana in prezent pentru fiecare utilizator, sub forma:
-- Utilizatorul X a facut Y rezervari / Utilizatorul X nu a facut nicio rezervare, unde X este numele

SELECT  'Utilizatorul ' || last_name || ' ' || DECODE(
(SELECT user_id from users_mhe where 
user_id = u.user_id and user_id in (select user_id from bookings_mhe))
, NULL, 'nu a facut nicio rezervare', 'a facut ' || 
(SELECT COUNT(*)
FROM bookings_mhe WHERE user_id = u.user_id ) || ' rezervari')  
"Informatii rezervari"
FROM users_mhe u;



--11 Sa se afiseze, luandu-se in considerare doar primul caz indeplinit:
--numarul de telefon si sexul pentru utilizatorii al caror nume se termin in "escu", in cazul in care sunt specificate sau
-- mesajul "telefon/sex nespecificat" 
--data de peste 6 luni de la data nasterii, pentru utiliatorii ale caror nume si prenume au aceeasi lungime
--numarul total de persoane specificate in rezervari, pentru utilizatorii care au facut cel putin o rezervare 
--emailul, unde caracterul @ este inlocuit de caracterul #, pentru utilizatorii care nu verifica niciunul din cazurile precedente

SELECT DISTINCT user_id,
CASE
WHEN SUBSTR(last_name, 4) = 'escu' THEN (SELECT COALESCE(phone, 'Telefon nespecificat') || ' ' || COALESCE(gender, 'Sex nespecificat')
    FROM users_mhe WHERE user_id = u.user_id)
WHEN  NULLIF(LENGTH(last_name),LENGTH(first_name)) IS NULL THEN(SELECT TO_CHAR(ADD_MONTHS(TO_CHAR(DOB, 'DD-MON-YYYY'), 6)) 
    FROM dual)    
WHEN (user_id IN (SELECT user_id FROM bookings_mhe)) THEN (SELECT TO_CHAR(SUM(guests_no)) FROM bookings_mhe
    GROUP BY(user_id) HAVING user_id = u.user_id) 
ELSE (SELECT REPLACE(email, '@', '#') 
    FROM users_mhe WHERE user_id = u.user_id)
END  "Informatii" 

FROM users_mhe u; 
    


--12 Sa se afiseze codul pentru toate hotelurile care au cel putin aceleasi tipuri de camere ca hotelul cu codul H6
SELECT DISTINCT hotel_id
FROM hotelrooms_mhe hr
WHERE NOT EXISTS(( SELECT type_id
FROM hotelrooms_mhe 
WHERE UPPER(TRIM(hotel_id)) like 'H6')
MINUS 
(SELECT type_id 
FROM hotelrooms_mhe 
WHERE hr.hotel_id = hotel_id AND UPPER(TRIM(hotel_id)) <> 'H6' ));



--13 Sa se afiseze numele si prenumele pentru utilizatorii a caror email contine subsirul "gmail" si care au facut rezervare 
-- intr-o destinatie din una din tarile ce incep cu litera "U" 
SELECT last_name, first_name
FROM users_mhe WHERE INSTR(lower(trim(email)), 'gmail') <> 0
INTERSECT
SELECT last_name, first_name
FROM users_mhe JOIN bookings_mhe
USING(user_id) JOIN hotels_mhe USING(hotel_id) JOIN destinations_mhe
USING(destination_name) JOIN countries_mhe 
USING(country_id) WHERE UPPER(TRIM(country_name)) LIKE 'U%';


--14 Sa se afiseze toti utilizatorii si destinatia pentru utilizatorii care au facut rezervari
--in aceleasi destinatii ca utilizatorul cu codul U8
SELECT DISTINCT user_id, destination_name
FROM bookings_mhe bm JOIN hotels_mhe ht  ON bm.hotel_id = ht.hotel_id
WHERE NOT EXISTS(( SELECT destination_name
FROM bookings_mhe JOIN hotels_mhe USING(hotel_id)
WHERE UPPER(TRIM(user_id)) LIKE 'U8')
MINUS 
(SELECT destination_name
FROM bookings_mhe JOIN hotels_mhe USING(hotel_id)
WHERE bm.user_id = user_id AND UPPER(TRIM(user_id)) <> 'U8')) 
AND 
NOT EXISTS(
(SELECT destination_name
FROM bookings_mhe JOIN hotels_mhe USING(hotel_id)
WHERE bm.user_id = user_id AND UPPER(TRIM(user_id)) <> 'U8')
MINUS
(SELECT destination_name
FROM bookings_mhe JOIN hotels_mhe USING(hotel_id)
WHERE UPPER(TRIM(user_id)) LIKE 'U8'));



--15 Sa se afiseze numele utilizatorilor si durata rezervarii pentru utlizatorii care au facut rezervare intr-o anumita tara, citita
--de la tasatatura. Cautarea nu trebuie sa fie case sensitive. 
ACCEPT tara PROMPT 'Tara = ';
SELECT users_mhe.last_name, users_mhe.first_name, end_date - start_date || ' zile ' "Durata" 
FROM bookings_mhe INNER JOIN users_mhe USING(user_id) JOIN hotels_mhe
USING(hotel_id) JOIN destinations_mhe USING(destination_name) JOIN 
countries_mhe USING(country_id)
WHERE lower(trim(country_name)) = lower(trim(&tara));



