-- -----------------------------------------------------------------------------------
-- File Name    : https://oracle-base.com/dba/monitoring/active_user_sessions.sql
-- Author       : Tim Hall, Aziz Prastyo Wibowo
-- Description  : Displays information on all active database sessions.
-- Requirements : Access to the V$ views.
-- Call Syntax  : @active_user_sessions
-- Last Modified: 16-MAY-2019, 29-Jan-2020
-- -----------------------------------------------------------------------------------
SET LINESIZE 250 PAGES 5000;
COL SIDSERIAL FOR A12;
COL username FORMAT A20
COL osuser FORMAT A20
COL spid FORMAT A10
COL service_name FORMAT A15
COL module FORMAT A45
COL machine FORMAT A35
COL logon_time FORMAT A20
SELECT NVL(s.username, '(oracle)') AS username,
       s.osuser,
       s.sid||','||s.serial# SIDSERIAL,
       p.spid,
       s.lockwait,
       s.status,
       s.machine,
       s.program,
       TO_CHAR(s.logon_Time,'DD-MON-YYYY HH24:MI:SS') AS logon_time,
       s.last_call_et AS last_call_et_secs,
       s.module,
       s.action,
       s.client_info,
       s.client_identifier
FROM   v$session s,
       v$process p
WHERE  s.paddr  = p.addr
AND    s.status = 'ACTIVE'
AND    s.username IS NOT NULL
ORDER BY s.username, s.osuser;
