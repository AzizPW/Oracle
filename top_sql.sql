-- -----------------------------------------------------------------------------------
-- File Name    : https://oracle-base.com/dba/monitoring/top_sql.sql
-- Author       : Tim Hall, Aziz Prastyo Wibowo
-- Description  : Displays a list of SQL statements that are using the most resources.
-- Comments     : The address column can be use as a parameter with SQL_Text.sql to display the full statement.
-- Requirements : Access to the V$ views.
-- Call Syntax  : @top_sql (number)
-- Last Modified: 15/07/2000, 29-Jan-2020
-- -----------------------------------------------------------------------------------
SET LINESIZE 250 PAGES 5000;
SET VERIFY OFF
COL SQL_Text FOR A100;
SELECT * FROM
(SELECT INST_ID, Substr(a.sql_text,1,100) sql_text, a.sql_id,Trunc(a.disk_reads/Decode(a.executions,0,1,a.executions)) reads_per_execution, a.buffer_gets, a.disk_reads, a.executions, a.sorts, a.address FROM gv$sqlarea a ORDER BY 2 DESC)
WHERE  rownum <= 25;
