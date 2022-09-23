OS :
cat /etc/redhat-release; free -g; df -h; hostname;  lscpu | grep -E '^Thread|^Core|^Socket|^CPU\(';



Database :
-- version db :
mysql> status;


-- user
mysql> select user,host from mysql.user;


-- size db
SELECT table_schema "database", sum(data_length + index_length)/1024/1024/1024 "size in GB" FROM information_schema.TABLES GROUP BY table_schema; select now();



-- Jumlah other
mysql> select ROUTINE_NAME,ROUTINE_SCHEMA,ROUTINE_TYPE from information_schema.routines where ROUTINE_SCHEMA='imoney';

mySQL.789

116.206.198.65:3306