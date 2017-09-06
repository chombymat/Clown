drop database if exists clown;

CREATE DATABASE clown
    WITH
    OWNER = clown
    ENCODING = 'UTF8'
    LC_COLLATE = 'french_France'
    LC_CTYPE = 'french_France'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
