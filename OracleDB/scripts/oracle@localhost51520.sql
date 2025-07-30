create user git identified by xuansong;

alter session set "_ORACLE_SCRIPT"=true;

grant all privileges to git;

commit;

create user git identified by xuansong;

alter session set "_ORACLE_SCRIPT"=true;

grant all privileges to git;

commit;

SELECT * FROM USER_TABLESPACES;