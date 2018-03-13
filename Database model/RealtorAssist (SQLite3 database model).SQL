/*
Created: 13.03.2018
Modified: 13.03.2018
Model: RealtorAssist (SQLite3 database model)
Database: SQLite 3.7
*/


-- Create tables section -------------------------------------------------

-- Table Client

CREATE TABLE Client
(
  Client_id INTEGER NOT NULL
        CONSTRAINT Client_key PRIMARY KEY AUTOINCREMENT,
  Full_name TEXT NOT NULL,
  Phone TEXT NOT NULL,
  Email TEXT NOT NULL
);

-- Table Deal_members

CREATE TABLE Deal_members
(
  Deal_members_id INTEGER NOT NULL
        CONSTRAINT Deal_members_key PRIMARY KEY AUTOINCREMENT,
  Client_id INTEGER NOT NULL,
  Client_role_id INTEGER NOT NULL,
  Deal_id INTEGER NOT NULL,
  CONSTRAINT Memberhips FOREIGN KEY (Client_id) REFERENCES Client (Client_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT Defines_client_role FOREIGN KEY (Client_role_id) REFERENCES Client_role (Client_role_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT Create FOREIGN KEY (Deal_id) REFERENCES Deal (Deal_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX IX_Create ON Deal_members (Deal_id);

CREATE INDEX IX_Defines_client_role ON Deal_members (Client_role_id);

CREATE INDEX IX_Memberhips ON Deal_members (Client_id);

-- Table Client_role

CREATE TABLE Client_role
(
  Client_role_id INTEGER NOT NULL
        CONSTRAINT Client_role_key PRIMARY KEY AUTOINCREMENT,
  Name TEXT NOT NULL
);

-- Table Deal

CREATE TABLE Deal
(
  Deal_id INTEGER NOT NULL
        CONSTRAINT Deal_key PRIMARY KEY AUTOINCREMENT,
  Cost_of_sale REAL NOT NULL,
  Reward_type boolean NOT NULL,
  Reward REAL NOT NULL,
  Start_datetime datetime NOT NULL,
  Object_id INTEGER NOT NULL,
  CONSTRAINT For_sale FOREIGN KEY (Object_id) REFERENCES Object (Object_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX IX_For_sale ON Deal (Object_id);

-- Table Object

CREATE TABLE Object
(
  Object_id INTEGER NOT NULL
        CONSTRAINT Object_key PRIMARY KEY AUTOINCREMENT,
  Street TEXT NOT NULL,
  House TEXT NOT NULL,
  Flat TEXT NOT NULL,
  Rooms INTEGER NOT NULL,
  Area REAL NOT NULL,
  Desired_price REAL NOT NULL,
  Minimum_price REAL NOT NULL
);

-- Table Event

CREATE TABLE Event
(
  Event_id INTEGER NOT NULL
        CONSTRAINT Event_key PRIMARY KEY AUTOINCREMENT,
  Data TEXT NOT NULL,
  Start_datetime datetime NOT NULL,
  Importance boolean NOT NULL,
  Progress boolean NOT NULL,
  Deal_id INTEGER NOT NULL,
  CONSTRAINT Contains_in FOREIGN KEY (Deal_id) REFERENCES Deal (Deal_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX IX_Contains_in ON Event (Deal_id);

-- Table Step

CREATE TABLE Step
(
  Step_id INTEGER NOT NULL
        CONSTRAINT Step_key PRIMARY KEY AUTOINCREMENT,
  End_datetime datetime NOT NULL,
  Deal_id INTEGER NOT NULL,
  Stage_id INTEGER NOT NULL,
  CONSTRAINT Names FOREIGN KEY (Stage_id) REFERENCES Stage (Stage_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT Passes FOREIGN KEY (Deal_id) REFERENCES Deal (Deal_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE INDEX IX_Names ON Step (Stage_id);

CREATE INDEX IX_Passes ON Step (Deal_id);

-- Table Stage

CREATE TABLE Stage
(
  Stage_id INTEGER NOT NULL
        CONSTRAINT Stage_key PRIMARY KEY AUTOINCREMENT,
  Name TEXT NOT NULL
);

-- Table Note

CREATE TABLE Note
(
  Note_id INTEGER NOT NULL
        CONSTRAINT Note_key PRIMARY KEY AUTOINCREMENT,
  Data TEXT NOT NULL,
  Datetime datetime NOT NULL
);

