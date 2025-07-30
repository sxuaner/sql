SELECT strftime('%Y', '2018-07-22')  -- supported by sqlite3. It stands for "string format time" or "string from time.

SELECT EXTRACT(WEEK FROM "2017-06-15"); -- supported by postgres,oracle,sqlserver

-- what date format is used in the EXTRACT function?
https://docs.oracle.com/en/database/oracle/oracle-database/18/sqlrf/EXTRACT-datetime.html
