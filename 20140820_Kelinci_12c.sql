select /*+parallel64*/owner, table_name from dba_tables@db11204 where owner='HR' order by 1,2;

SELECT 'CREATE TABLE C##AZIZPW.'||TABLE_NAME||' AS SELECT * FROM '||OWNER||'.'||TABLE_NAME||'@DB11204;'SCRIPT FROM DBA_TABLES@DB11204 WHERE OWNER='HR' ORDER BY 1;

CREATE TABLE C##AZIZPW.COUNTRIES AS SELECT * FROM HR.COUNTRIES@DB11204;
CREATE TABLE C##AZIZPW.DEPARTMENTS AS SELECT * FROM HR.DEPARTMENTS@DB11204;
CREATE TABLE C##AZIZPW.EMPLOYEES AS SELECT * FROM HR.EMPLOYEES@DB11204;
CREATE TABLE C##AZIZPW.JOBS AS SELECT * FROM HR.JOBS@DB11204;
CREATE TABLE C##AZIZPW.JOB_HISTORY AS SELECT * FROM HR.JOB_HISTORY@DB11204;
CREATE TABLE C##AZIZPW.LOCATIONS AS SELECT * FROM HR.LOCATIONS@DB11204;
CREATE TABLE C##AZIZPW.REGIONS AS SELECT * FROM HR.REGIONS@DB11204;

SELECT * FROM USER_TABLES;

SQL> CREATE USER c##SCOTT IDENTIFIED BY scott temporary tablespace temp;

User created.

SQL> grant select any table, resource, connect to C##SCOTT;

Grant succeeded.

SQL> ALTER USER C##SCOTT QUOTA UNLIMITED ON USERS;

User altered.

SQL>

SELECT /*+parallel64*/oWNER, TABLE_NAME FROM DBA_TABLES@DB11204 WHERE OWNER='HR' ORDER BY 1,2;

SELECT 'CREATE TABLE C##scott.'||TABLE_NAME||' AS SELECT * FROM '||OWNER||'.'||TABLE_NAME||'@DB11204;'SCRIPT FROM DBA_TABLES@DB11204 WHERE OWNER='SCOTT' ORDER BY 1;

CREATE TABLE C##scott.BONUS AS SELECT * FROM SCOTT.BONUS@DB11204;
CREATE TABLE C##scott.DEPT AS SELECT * FROM SCOTT.DEPT@DB11204;
CREATE TABLE C##scott.EMP AS SELECT * FROM SCOTT.EMP@DB11204;
CREATE TABLE C##scott.SALGRADE AS SELECT * FROM SCOTT.SALGRADE@DB11204;
