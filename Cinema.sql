create schema cinema;
use cinema;

CREATE TABLE Staff (
    Staff_id TINYINT UNIQUE NOT NULL AUTO_INCREMENT,
    Staff_Name VARCHAR(30),
    Gender ENUM('Male', 'Female', 'Non-Binary'),
    IC VARCHAR(30),
    Mobile_Number VARCHAR(13),
    PRIMARY KEY (Staff_id)
);
CREATE TABLE Movie (
    Movie_id TINYINT UNIQUE NOT NULL AUTO_INCREMENT,
    Movie_Name VARCHAR(30),
    category VARCHAR(30),
    Languages VARCHAR(15),
    Subtitle VARCHAR(15),
    Length INT,
    Rating INT,
    PRIMARY KEY (movie_id)
);
CREATE TABLE Theatre_Hall (
    Theatre_Hall_id TINYINT UNIQUE NOT NULL AUTO_INCREMENT,
    Hall_Category VARCHAR(30),
    Number_of_Seats INT,
    Rows_of_Seats INT,
    PRIMARY KEY (Theatre_Hall_id)
);
CREATE TABLE Movie_Showtime (
    Movie_Showtime_id TINYINT UNIQUE NOT NULL AUTO_INCREMENT,
    Date_of_showtime DATETIME,
    Movie_id TINYINT,
    Theatre_Hall_id TINYINT,
    PRIMARY KEY (Movie_Showtime_id),
    FOREIGN KEY (Movie_id)
        REFERENCES Movie (Movie_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (Theatre_Hall_id)
        REFERENCES Theatre_Hall (Theatre_Hall_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE Ticket (
    Ticket_id TINYINT UNIQUE NOT NULL AUTO_INCREMENT,
    Payment_Method ENUM('Αντικαταβολή', 'Paypal', 'Χρεωστική Καρτα'),
    Price VARCHAR(5),
    Price_Category ENUM('Κανονικό', 'Φοιτητικό', 'Ηλικίες 0-12', 'Ανέργους'),
    Staff_id TINYINT,
    Movie_showtime_id TINYINT,
    PRIMARY KEY (Ticket_id),
    FOREIGN KEY (Staff_id)
        REFERENCES Staff (Staff_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (Movie_Showtime_id)
        REFERENCES Movie_Showtime (Movie_Showtime_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
)
CREATE TABLE Seats (
    Seat_id TINYINT UNIQUE NOT NULL AUTO_INCREMENT,
    Seats_Category ENUM('Εξώστης', 'Πλατεία'),
    Theatre_Hall_id TINYINT,
    PRIMARY KEY (Seat_id),
    FOREIGN KEY (Theatre_Hall_id)
        REFERENCES Theatre_Hall (Theatre_Hall_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
)
insert into Staff values (1, "Christos", "Male","Canteen","+306978521412");
insert into Staff values (null, "Anastasia", "Female","ticket office","+306941589632");
insert into Staff values (null, "Maria", "Non-Binary","ticket office","+306936987875");

insert into Movie values (1,"Shadow","Drama","Mandarin","Greek",120,7);
insert into Movie values (null,"Pirates of the Caribbean","Action","English","Greek",143,8);
insert into Movie values (null,"Sonic","Comedy","English","Greek",122,6);

insert into Theatre_Hall values (1,"Black box theater",300,7);
insert into Theatre_Hall values (null,"Proscenium",576,18);
insert into Theatre_Hall values (null,"Thrust stage",400,10);

insert into Seats values (1,"Εξώστης",1);
insert into Seats values (null,"Πλατεία",3);
insert into Seats values (null,"Πλατεία",2);

insert into Movie_Showtime values (1,"2022-02-07 20:00:00",2,1);
insert into Movie_Showtime values (null,"2022-04-20 22:30:00",1,3);
insert into Movie_Showtime values (null,"2021-12-30 19:00:00",3,2);

insert into Ticket values (1,'Χρεωστική Καρτα',10,'Κανονικό',2,1);
insert into Ticket values (null,'Αντικαταβολή',4,'Ανέργους',3,2);
insert into Ticket values (null,'Paypal',6,'Φοιτητικό',1,3);

CREATE VIEW All_Seats AS
    SELECT 
        SUM(Theatre_Hall.Number_of_Seats)
    FROM
        Theatre_Hall;
        
delimiter $$
create procedure Program_Theatre(in Code_of_Theatre_Hall tinyint)
begin
SELECT 
    Movie.Movie_Name,
    Movie_Showtime.Date_of_showtime,
    Movie.category
FROM
    Movie,
    Movie_Showtime,
    Theatre_Hall
WHERE
    Movie.Movie_id = Movie_Showtime.Movie_id
        AND Movie_Showtime.Theatre_Hall_id = Theatre_Hall.Theatre_Hall_id
        AND Theatre_Hall.Theatre_Hall_id = Code_of_Theatre_Hall;
end$$
delimiter ;

Create User 'Employee1'@'localhost' IDENTIFIED BY 'Employee.1';
GRANT SELECT ON cinema.* 
TO 'Employee1'@'localhost' 
IDENTIFIED BY 'Employee.1';
GRANT INSERT,UPDATE ON cinema.Movie_Showtime 
TO 'Employee1'@'localhost' 
IDENTIFIED BY 'Employee.1';


CREATE TABLE ExEmployees (
    Staff_id TINYINT UNIQUE NOT NULL AUTO_INCREMENT,
    Staff_Name VARCHAR(30),
    Gender ENUM('Male', 'Female', 'Non-Binary'),
    IC VARCHAR(30),
    Mobile_Number VARCHAR(13),
    PRIMARY KEY (Staff_id)
);
delimiter %%
create trigger MyExEmployees before delete on Staff for each row
BEGIN  
    INSERT INTO ExEmployees (Staff_id, Staff_Name, Gender,IC,Mobile_Number)  VALUES(OLD. Staff_id, OLD.Staff_Name, OLD.Gender,OLD.IC,OLD.Mobile_Number);    
END%%
delimiter ;
