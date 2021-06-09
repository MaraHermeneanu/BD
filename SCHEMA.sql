
--DROP 
drop table Bookings_MHE;
drop table HotelRooms_MHE;
drop table Hotels_MHE;
drop table Destinations_MHE;
drop table Countries_MHE;
drop table Users_MHE;
drop table RoomTypes_MHE;
drop table HotelChains_MHE;


--CREATE HOTEL CHAINS 
CREATE TABLE HotelChains_MHE
(
  Chain_id VARCHAR(3),
  Chain_name VARCHAR(30) NOT NULL,
  PRIMARY KEY (Chain_id)
);
--INSERT INTO HOTEL CHAINS 
INSERT INTO HotelChains_MHE VALUES
( 'C1', 'InterContinental');
INSERT INTO HotelChains_MHE VALUES
( 'C2', 'Hyatt Hotels');
INSERT INTO HotelChains_MHE VALUES
( 'C3', 'Hilton');
INSERT INTO HotelChains_MHE VALUES
( 'C4', 'Premier Inn');
INSERT INTO HotelChains_MHE VALUES
( 'C5', 'Mariott International');
INSERT INTO HotelChains_MHE VALUES
( 'C6', 'Radisson');
INSERT INTO HotelChains_MHE VALUES
( 'C7', 'Wyndham');
INSERT INTO HotelChains_MHE VALUES
( 'C8', 'Accor Group');
INSERT INTO HotelChains_MHE VALUES
( 'C9', 'Carlson');
INSERT INTO HotelChains_MHE VALUES
( 'C10', 'Best Western');

--SELECT * 
SELECT * FROM HotelChains_MHE;
COMMIT;

--CREATE ROOMTYPES 
CREATE TABLE RoomTypes_MHE
(
  Type_id VARCHAR(3),
  Type_name VARCHAR(20) NOT NULL,
  Capacity INT NOT NULL,
  Price FLOAT NOT NULL,
  PRIMARY KEY (Type_id),
  CHECK(Price>0),
  CHECK(Capacity>0)
);
--INSERT INTO ROOMTYPES
INSERT INTO RoomTypes_MHE VALUES
( 'T1', 'King', 2, 250);
INSERT INTO RoomTypes_MHE VALUES
( 'T2', 'Twin', 2, 130);
INSERT INTO RoomTypes_MHE VALUES
( 'T3', 'Suite', 4, 450);
INSERT INTO RoomTypes_MHE VALUES
( 'T4', 'Apartament', 6, 700);
INSERT INTO RoomTypes_MHE VALUES
( 'T5', 'Murphy', 2, 180.5);
INSERT INTO RoomTypes_MHE VALUES
( 'T6', 'Accesible', 2, 150);
INSERT INTO RoomTypes_MHE VALUES
( 'T7', 'Cabana', 2, 500);
INSERT INTO RoomTypes_MHE VALUES
( 'T8', 'Villa', 5, 800);
INSERT INTO RoomTypes_MHE VALUES
( 'T9', 'Double', 2, 100);
INSERT INTO RoomTypes_MHE VALUES
( 'T10', 'Queen', 2, 235.5);

--SELECT * FROM ROOMTYPES
SELECT * FROM RoomTypes_MHE;
COMMIT;

--CREATE USERS
CREATE TABLE Users_MHE(
  User_id VARCHAR(15),
  Last_name VARCHAR(30) NOT NULL,
  First_name VARCHAR(30) NOT NULL,
  DOB DATE NOT NULL,
  Email VARCHAR(20) NOT NULL,
  Phone CHAR(10),
  Gender CHAR(1),
  PRIMARY KEY (User_id),
  UNIQUE (Email));
--INSERT INTO USERS
INSERT INTO USERS_MHE VALUES
('U1', 'Alexandrescu' , 'Vlad', TO_DATE('07-07-1999', 'DD-MM-YYYY')
, 'vlad@gmail.com', '0712345678', 'M');
INSERT INTO USERS_MHE VALUES
('U2', 'Muresan' , 'Oana', TO_DATE('23-03-1998', 'DD-MM-YYYY')
, 'oana@gmail.com', '0721345678', 'F');
INSERT INTO USERS_MHE VALUES
('U3', 'Mihaila' , 'Gabriel', TO_DATE('28-04-2000', 'DD-MM-YYYY')
, 'mihai@yahoo.com', '0713245678', 'M');
INSERT INTO USERS_MHE VALUES
('U4', 'Dumitrescu' , 'Alexandra', TO_DATE('07-08-1987', 'DD-MM-YYYY')
, 'alexa@gmail.com',NULL,NULL);
INSERT INTO USERS_MHE VALUES
('U5', 'Iordache' , 'Patricia', TO_DATE('13-09-1989', 'DD-MM-YYYY')
,  'patricia@yahoo.com',NULL, 'F');
INSERT INTO USERS_MHE VALUES
('U6', 'Rotaru' , 'Ada', TO_DATE('01-07-1993', 'DD-MM-YYYY')
, 'ada@gmail.com', '0712435678', 'F');
INSERT INTO USERS_MHE VALUES
('U7', 'Cristea' , 'Matei', TO_DATE('12-05-1985', 'DD-MM-YYYY')
, 'matei@yahoo.com', '0712346578',NULL);
INSERT INTO USERS_MHE VALUES
('U8', 'Radu' , 'Stefania', TO_DATE('07-06-1991', 'DD-MM-YYYY')
, 'stef@gmail.com', '0712345768', 'F');
INSERT INTO USERS_MHE VALUES
('U9', 'Popescu' , 'Ioan', TO_DATE('28-07-1996', 'DD-MM-YYYY')
, 'ioan@gmail.com', NULL,NULL);
INSERT INTO USERS_MHE VALUES
('U10', 'Ionescu' , 'Marius', TO_DATE('14-02-1987', 'DD-MM-YYYY')
, 'maria@gmail.com',NULL, 'M');
INSERT INTO USERS_MHE VALUES
('U11', 'Petrescu' , 'George', TO_DATE('10-03-1988', 'DD-MM-YYYY')
, 'george@yahoo.ro', NULL, 'M');


--SELECT * FROM USERS

SELECT * FROM USERS_MHE;
COMMIT;

-- CREATE COUNTRIES 
CREATE TABLE Countries_MHE(
  Country_id INT,
  Country_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (Country_id));
--INSERT INTO COUNTRIES
INSERT INTO Countries_MHE VALUES
(1, 'Netherlands');
INSERT INTO Countries_MHE VALUES
(2, 'Poland');
INSERT INTO Countries_MHE VALUES
(3, 'Portugal');
INSERT INTO Countries_MHE VALUES
(4, 'Malaysia');
INSERT INTO Countries_MHE VALUES
(5, 'United Arab Emirates');
INSERT INTO Countries_MHE VALUES
(6, 'Greece');
INSERT INTO Countries_MHE VALUES
(7, 'Italy');
INSERT INTO Countries_MHE VALUES
(8, 'Japan');
INSERT INTO Countries_MHE VALUES
(9, 'United Kingdom');
INSERT INTO Countries_MHE VALUES
(10, 'Thailand');
INSERT INTO Countries_MHE VALUES
(11, 'Turkey');
INSERT INTO Countries_MHE VALUES
(12, 'China');
INSERT INTO Countries_MHE VALUES
(13, 'United States');
INSERT INTO Countries_MHE VALUES
(14, 'France');
INSERT INTO Countries_MHE VALUES
(15, 'Malta');

--SELECT * FROM COUNTRIES
SELECT * FROM Countries_MHE;
COMMIT;


----CREATE HOLIDAYVOUCHERS
--
--CREATE TABLE HolidayVouchers_MHE
--(
--  Voucher_id INT,
--  Discount INT NOT NULL,
--  PRIMARY KEY (Voucher_id),
--  CHECK(Discount>0)
--);
--
----INSERT INTO HOLIDAYVOUCHERS
--INSERT INTO HolidayVouchers_MHE VALUES
--(1,20);
--INSERT INTO HolidayVouchers_MHE VALUES
--(2,25);
--INSERT INTO HolidayVouchers_MHE VALUES
--(3,30);
--INSERT INTO HolidayVouchers_MHE VALUES
--(4,35);
--INSERT INTO HolidayVouchers_MHE VALUES
--(5,50);
--
--
----SELECT * FROM HOLIDAYVOUCHERS
--
--SELECT * FROM HolidayVouchers_MHE;
--COMMIT;

--CREATE DESTINAIONS
CREATE TABLE Destinations_MHE(
  Destination_name VARCHAR(40),
  Country_id INT NOT NULL,
  PRIMARY KEY (Destination_name),
  FOREIGN KEY (Country_id) REFERENCES Countries_MHE(Country_id)
);
--INSERT INTO DESTINATIONS 
INSERT INTO Destinations_MHE VALUES
('Rome', 7);
INSERT INTO Destinations_MHE VALUES
('Santorini',6);
INSERT INTO Destinations_MHE VALUES
('Milan', 7);
INSERT INTO Destinations_MHE VALUES
('New York', 13);
INSERT INTO Destinations_MHE VALUES
('Paris', 14);
INSERT INTO Destinations_MHE VALUES
('Venice', 7);
INSERT INTO Destinations_MHE VALUES
('Mykonos', 6);
INSERT INTO Destinations_MHE VALUES
('Phuket', 10);
INSERT INTO Destinations_MHE VALUES
('Dubai', 5);
INSERT INTO Destinations_MHE VALUES
('Istanbul', 11);
INSERT INTO Destinations_MHE VALUES
('Hong Kong', 12);
INSERT INTO Destinations_MHE VALUES
('Miami', 13);
INSERT INTO Destinations_MHE VALUES
('Antalya', 11);
INSERT INTO Destinations_MHE VALUES
('Porto', 3);
INSERT INTO Destinations_MHE VALUES
('Las Vegas', 13);


--SELECT * FROM DESTINATIONS
SELECT * FROM Destinations_MHE;
COMMIT;


--CREATE HOTELS
CREATE TABLE Hotels_MHE(
  Hotel_id VARCHAR(3),
  Stars INT,
  Chain_id VARCHAR(3),
  Destination_name VARCHAR(40),
  PRIMARY KEY (Hotel_id),
  FOREIGN KEY (Chain_id) REFERENCES HotelChains_MHE(Chain_id),
  FOREIGN KEY (Destination_name) REFERENCES Destinations_MHE(Destination_name),
  CHECK((Stars>=1 AND Stars<=5) OR Stars IS NULL)
);
--INSERT INTO HOTELS
INSERT INTO Hotels_MHE VALUES
('H1', 5, 'C3', 'Miami'); 
INSERT INTO Hotels_MHE VALUES
('H2', 3, 'C5', 'Paris'); 
INSERT INTO Hotels_MHE VALUES
('H3', NULL, NULL, 'Rome'); 
INSERT INTO Hotels_MHE VALUES
('H4', 2, 'C9', 'Antalya'); 
INSERT INTO Hotels_MHE VALUES
('H5', 5, 'C7', 'New York'); 
INSERT INTO Hotels_MHE VALUES
('H6', 5, 'C1', 'Dubai'); 
INSERT INTO Hotels_MHE VALUES
('H7', 3, 'C2', 'Santorini'); 
INSERT INTO Hotels_MHE VALUES
('H8', 2, 'C10', 'Istanbul'); 
INSERT INTO Hotels_MHE VALUES
('H9', NULL, NULL, 'Phuket'); 
INSERT INTO Hotels_MHE VALUES
('H10', 5, 'C3', 'Las Vegas'); 
INSERT INTO Hotels_MHE VALUES
('H11', 4, 'C7', 'Venice');
INSERT INTO Hotels_MHE VALUES
('H12', 5, 'C6', 'Porto');
INSERT INTO Hotels_MHE VALUES
('H13', 3, 'C1', 'Rome');
INSERT INTO Hotels_MHE VALUES
('H14', 4, 'C3', 'Mykonos');
INSERT INTO Hotels_MHE VALUES
('H15', 5, 'C5', 'Dubai');
INSERT INTO Hotels_MHE VALUES
('H16', 5, 'C4', 'Dubai');
INSERT INTO Hotels_MHE VALUES
('H17', 4, 'C6', 'Mykonos');
INSERT INTO Hotels_MHE VALUES
('H18', 3, 'C8', 'Venice');
INSERT INTO Hotels_MHE VALUES
('H19', 5, 'C9', 'Santorini');



--SELECT * FROM HOTELS
SELECT * FROM Hotels_MHE;
COMMIT;

--CREATE HOTELROOMS
CREATE TABLE HotelRooms_MHE
(
  Hotel_id VARCHAR(3),
  Type_id VARCHAR(3),
  PRIMARY KEY (Hotel_id, Type_id),
  FOREIGN KEY (Hotel_id) REFERENCES Hotels_MHE(Hotel_id),
  FOREIGN KEY (Type_id) REFERENCES RoomTypes_MHE(Type_id)
);

--INSERT INTO HOTELROOMS
INSERT INTO HotelRooms_MHE VALUES
('H1', 'T3');
INSERT INTO HotelRooms_MHE VALUES
('H3', 'T2');
INSERT INTO HotelRooms_MHE VALUES
('H2', 'T1');
INSERT INTO HotelRooms_MHE VALUES
('H6', 'T2');
INSERT INTO HotelRooms_MHE VALUES
('H5', 'T5');
INSERT INTO HotelRooms_MHE VALUES
('H11', 'T9');
INSERT INTO HotelRooms_MHE VALUES
('H5', 'T7');
INSERT INTO HotelRooms_MHE VALUES
('H3', 'T8');
INSERT INTO HotelRooms_MHE VALUES
('H9', 'T6');
INSERT INTO HotelRooms_MHE VALUES
('H14', 'T2');
INSERT INTO HotelRooms_MHE VALUES
('H11', 'T3');
INSERT INTO HotelRooms_MHE VALUES
('H2', 'T3');
INSERT INTO HotelRooms_MHE VALUES
('H1', 'T7');
INSERT INTO HotelRooms_MHE VALUES
('H4', 'T10');
INSERT INTO HotelRooms_MHE VALUES
('H13', 'T10');
INSERT INTO HotelRooms_MHE VALUES
('H7', 'T1');
INSERT INTO HotelRooms_MHE VALUES
('H8', 'T4');
INSERT INTO HotelRooms_MHE VALUES
('H10', 'T10');
INSERT INTO HotelRooms_MHE VALUES
('H11', 'T8');
INSERT INTO HotelRooms_MHE VALUES
('H7', 'T5');
INSERT INTO HotelRooms_MHE VALUES
('H12', 'T1');
INSERT INTO HotelRooms_MHE VALUES
('H12', 'T2');
INSERT INTO HotelRooms_MHE VALUES
('H15', 'T5');

--SELECT * FROM HOTELROOMS
SELECT * FROM HotelRooms_MHE
ORDER BY Hotel_id;
COMMIT;


--CREATE BOOKINGS
CREATE TABLE Bookings_MHE(
  User_id VARCHAR(15),
  Hotel_id VARCHAR(3),
  Start_date DATE,
  End_date DATE,
  Guests_no INT NOT NULL,
  PRIMARY KEY (Start_date, End_date, User_id, Hotel_id),
  FOREIGN KEY (User_id) REFERENCES Users_MHE(User_id),
  FOREIGN KEY (Hotel_id) REFERENCES Hotels_MHE(Hotel_id));
--INSERT INTO BOOKINGS
INSERT INTO Bookings_MHE VALUES
('U11', 'H2', TO_DATE('10-06-2020', 'DD-MM-YYYY'),
TO_DATE('17-06-2020', 'DD-MM-YYYY'), 2);
INSERT INTO Bookings_MHE VALUES
('U1', 'H7', TO_DATE('03-08-2020', 'DD-MM-YYYY'),
TO_DATE('07-08-2020', 'DD-MM-YYYY'), 4);
INSERT INTO Bookings_MHE VALUES
('U5', 'H3', TO_DATE('20-07-2020', 'DD-MM-YYYY'),
TO_DATE('25-07-2020', 'DD-MM-YYYY'), 1);
INSERT INTO Bookings_MHE VALUES
('U7', 'H1', TO_DATE('05-08-2020', 'DD-MM-YYYY'),
TO_DATE('17-08-2020', 'DD-MM-YYYY'), 6);
INSERT INTO Bookings_MHE VALUES
('U3', 'H3', TO_DATE('06-09-2020', 'DD-MM-YYYY'),
TO_DATE('13-09-2020', 'DD-MM-YYYY'), 2);
INSERT INTO Bookings_MHE VALUES
('U2', 'H5', TO_DATE('30-06-2020', 'DD-MM-YYYY'),
TO_DATE('07-07-2020', 'DD-MM-YYYY'), 4);
INSERT INTO Bookings_MHE VALUES
('U6', 'H3', TO_DATE('24-06-2020', 'DD-MM-YYYY'),
TO_DATE('28-06-2020', 'DD-MM-YYYY'), 1);
INSERT INTO Bookings_MHE VALUES
('U1', 'H3', TO_DATE('13-09-2020', 'DD-MM-YYYY'),
TO_DATE('19-09-2020', 'DD-MM-YYYY'), 3);
INSERT INTO Bookings_MHE VALUES
('U3', 'H8', TO_DATE('08-10-2020', 'DD-MM-YYYY'),
TO_DATE('14-10-2020', 'DD-MM-YYYY'), 5);
INSERT INTO Bookings_MHE VALUES
('U2', 'H1', TO_DATE('17-08-2020', 'DD-MM-YYYY'),
TO_DATE('24-08-2020', 'DD-MM-YYYY'), 2);
INSERT INTO Bookings_MHE VALUES
('U4', 'H4', TO_DATE('19-09-2020', 'DD-MM-YYYY'),
TO_DATE('25-09-2020', 'DD-MM-YYYY'), 2);
INSERT INTO Bookings_MHE VALUES
('U8', 'H2', TO_DATE('21-12-2020', 'DD-MM-YYYY'),
TO_DATE('27-12-2020', 'DD-MM-YYYY'), 1);
INSERT INTO Bookings_MHE VALUES
('U10', 'H2', TO_DATE('10-12-2020', 'DD-MM-YYYY'),
TO_DATE('13-12-2020', 'DD-MM-YYYY'), 3);
INSERT INTO Bookings_MHE VALUES
('U6', 'H2', TO_DATE('12-05-2020', 'DD-MM-YYYY'),
TO_DATE('15-05-2020', 'DD-MM-YYYY'), 2);

--SELECT * FROM BOOKINGS
SELECT * FROM Bookings_MHE;
COMMIT;