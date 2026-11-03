CREATE TABLE counter (id integer PRIMARY KEY CHECK (id = 1), value bigint NOT NULL);
INSERT INTO counter VALUES (1, 0);
