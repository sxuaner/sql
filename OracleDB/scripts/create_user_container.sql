CREATE TABLESPACE logtypets datafile '/tmp/db.dat' size 10M;

CREATE USER C##aurora identified by xuansong CONTAINER=ALL;
grant all privileges to C##aurora;

show con_name;

-- to drop a table.
drop table logtype;