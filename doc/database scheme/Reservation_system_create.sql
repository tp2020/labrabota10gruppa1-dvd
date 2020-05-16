-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-05-16 07:12:41.226

-- tables
-- Table: hotel
CREATE TABLE hotel (
    id integer NOT NULL CONSTRAINT hotel_pk PRIMARY KEY,
    name text NOT NULL,
    country text NOT NULL,
    description text NOT NULL,
    standardPrice integer NOT NULL,
    luxPrice integer NOT NULL,
    NumbOfLuxRooms integer NOT NULL,
    city text NOT NULL,
    NumbOfStRooms integer NOT NULL
);

-- Table: reservation
CREATE TABLE reservation (
    id integer NOT NULL CONSTRAINT reservation_pk PRIMARY KEY,
    time text NOT NULL,
    route_id integer NOT NULL,
    hotel_id integer NOT NULL,
    user text NOT NULL,
    totalPrice integer NOT NULL,
    typeOfRoom text NOT NULL,
    CONSTRAINT reservation_route FOREIGN KEY (route_id)
    REFERENCES route (id),
    CONSTRAINT reservation_hotel FOREIGN KEY (hotel_id)
    REFERENCES hotel (id)
);

-- Table: route
CREATE TABLE route (
    id integer NOT NULL CONSTRAINT route_pk PRIMARY KEY,
    cityFrom text NOT NULL,
    cityTo text NOT NULL,
    price integer NOT NULL,
    company text NOT NULL,
    transport_id integer NOT NULL,
    time text NOT NULL,
    timeOfArrival text NOT NULL,
    CONSTRAINT route_transport FOREIGN KEY (transport_id)
    REFERENCES transport (id)
);

-- Table: transport
CREATE TABLE transport (
    id integer NOT NULL CONSTRAINT transport_pk PRIMARY KEY,
    type text NOT NULL
);

-- End of file.

