# Hardcoded credentials 

# sqlplus user/pass@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=hostname.network)(Port=1521))(CONNECT_DATA=(SID=remote_SID)))

# To log on
# sqlplus sys/mysecurepassword@127.0.0.1:51521/XE

# To execute a command
echo @$1
exit | sqlplus sys/mysecurepassword@127.0.0.1:51521/XE as SYSDBA @$1

