-- -----------------------------------------------------------------------------------
-- File Name    : https://oracle-base.com/dba/monitoring/session_io.sql
-- Author       : Tim Hall, Aziz Prastyo Wibowo
-- Description  : Displays I/O information on all database sessions.
-- Requirements : Access to the V$ views.
-- Call Syntax  : @session_io
-- Last Modified: 21-FEB-2005, 29-Jan-2020
-- -----------------------------------------------------------------------------------
SET LINESIZE 250 PAGES 5000;
COL username FOR A15
COL SIDSERIAL FOR A12;
COL OSUSER FOR A25;
SELECT NVL(s.username, '(oracle)') AS username, s.osuser, s.sid||','||s.serial# SIDSERIAL, si.block_gets, si.consistent_gets, si.physical_reads, si.block_changes, si.consistent_changes
FROM v$session s, v$sess_io si
WHERE s.sid = si.sid
ORDER BY s.username, s.osuser;
