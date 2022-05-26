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
    category VARCHAR(30),
    Languages VARCHAR(15),
    Subtitle VARCHAR(15),
    Length INT,
    Rating INT,
    PRIMARY KEY (movie_id)
);
CREATE TABLE Theatre_Hall (
    Theatre_Hall_id TINYINT,
    Hall_Category VARCHAR(30),
    Number_of_Seats INT,
    Rows_of_Seats INT,
    PRIMARY KEY (Theatre_Hall_id)
);
CREATE TABLE Movie_Showtime (
    Movie_Showtime_id TINYINT,
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
CREATE TABLE Seats (
    Seat_id TINYINT UNIQUE NOT NULL AUTO_INCREMENT,
    Seats_Category ENUM('Εξώστης', 'Πλατεία'),
    Theatre_Hall_id TINYINT,
    PRIMARY KEY (Seat_id),
    FOREIGN KEY (Theatre_Hall_id)
        REFERENCES Theatre_Hall (Theatre_Hall_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
)
