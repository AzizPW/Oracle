--EBS Concurrent Query
ALTER SESSION SET NLS_DATE_FORMAT='DD-Mon-RR HH24:MI:SS';
COL OS_PROCESS_ID FOR A10;
SELECT REQUEST_ID,ACTUAL_START_DATE,ACTUAL_COMPLETION_DATE,OS_PROCESS_ID,ORACLE_PROCESS_ID,ORACLE_SESSION_ID,PHASE_CODE,STATUS_CODE FROM APPS.FND_CONCURRENT_REQUESTS WHERE REQUEST_ID IN
(30952200,30952649,30952649,30952611,30952539,30952538,30952535,30952534,30952532,30952498,30952497,30952495,30952485,30952481,30952476,30952465,30952462,30952373) ORDER BY 2;

--
COL USER_CONCURRENT_PROGRAM_NAME FOR A25;
COL CONCURRENT_PROGRAM_NAME FOR A23;
COL REQUEST_DATE FOR A18;
COL STATUS FOR A10;
COL COMPLETION_TEXT FOR A20;
COL LOGFILE_NAME FOR A65;
COL OUTFILE_NAME FOR A65;
COL ARGUMENT_TEXT FOR A30;
SELECT DISTINCT fcp.user_concurrent_program_name,fcp.concurrent_program_name,fcr.request_id,fcr.request_date,flv.meaning status,fcr.status_code,fcr.completion_text,fcr.logfile_name,fcr.outfile_name,fcr.argument_text
FROM apps.fnd_concurrent_programs_vl fcp,apps.fnd_concurrent_requests fcr,apps.fnd_lookup_values flv
WHERE fcr.concurrent_program_id = fcp.concurrent_program_id AND trunc(fcr.last_update_date) = trunc(SYSDATE) AND flv.lookup_code = fcr.status_code AND flv.lookup_type = 'CP_STATUS_CODE' AND flv.language = 'US' AND REQUEST_ID=30952200
ORDER BY fcr.request_date desc;

--
col PHASE heading 'Phase' format A8
col STATUS heading 'Status' format A8
col PROGRAM heading 'Program Name' format A25
col REQUESTOR heading 'Requestor' format A9
col START_TIME heading 'Start Time' format A15
col RUN_TIME justify left heading 'Runtime(m)' format 9999.99
col OSPID heading 'OSPID' format a5
col SID heading 'DBSID' format 99999
--spool crrunning.lst
select fcrv.request_id REQUEST,
decode(fcrv.phase_code,'P','Pending','R','Running','I','Inactive','Completed')PHASE,
decode(fcrv.status_code, 'A','Waiting', 'B','Resuming', 'C','Normal', 'F','Scheduled',
'G','Warning', 'H','On Hold', 'I','Normal', 'M','No Manager',
'Q','Standby', 'R','Normal', 'S','Suspended', 'T','Terminating',
'U','Disabled', 'W','Paused', 'X','Terminated',
'Z','Waiting',fcrv.status_code)STATUS,
substr(fcrv.program,1,25)PROGRAM,
substr(fcrv.requestor,1,9)REQUESTOR,
to_char(fcrv.actual_start_date,'MM/DD/RR HH24:MI')START_TIME,
round(((sysdate - fcrv.actual_start_date)*1440),2)RUN_TIME,
substr(fcr.oracle_process_id,1,7)OSPID,
vs.sid SID
--substr(fcr.os_process_id,1,7)OS_PID
from apps.fnd_conc_req_summary_v fcrv,
apps.fnd_concurrent_requests fcr,
v$session vs,
v$process vp
where fcrv.phase_code = 'R'
and fcrv.request_id = fcr.request_id
and fcr.oracle_process_id = vp.spid
and vs.paddr = vp.addr
AND FCR.REQUEST_ID=30940153
order by PHASE, STATUS, REQUEST desc;

--Get SID and Serial# from Conc. Mgr.
SELECT A.REQUEST_ID, D.SID, D.SERIAL# , C.SPID FROM APPS.FND_CONCURRENT_REQUESTS A, APPS.FND_CONCURRENT_PROCESSES B, V$PROCESS C, V$SESSION D WHERE A.CONTROLLING_MANAGER = B.CONCURRENT_PROCESS_ID AND C.PID = B.ORACLE_PROCESS_ID AND B.SESSION_ID=D.AUDSID AND A.PHASE_CODE = 'R' AND A.REQUEST_ID IN
(30952200,30952649,30952649,30952611,30952539,30952538,30952535,30952534,30952532,30952498,30952497,30952495,30952485,30952481,30952476,30952465,30952462,30952373);

--Generate script kill session locking
SELECT 'ALTER SYSTEM KILL SESSION '''||D.SID||','||D.SERIAL#||''' IMMEDIATE;' SYNTAX FROM APPS.FND_CONCURRENT_REQUESTS A, APPS.FND_CONCURRENT_PROCESSES B, V$PROCESS C, V$SESSION D
WHERE A.CONTROLLING_MANAGER = B.CONCURRENT_PROCESS_ID AND C.PID = B.ORACLE_PROCESS_ID AND B.SESSION_ID=D.AUDSID AND A.PHASE_CODE = 'R' AND A.REQUEST_ID IN
(30952200,30952649,30952649,30952611,30952539,30952538,30952535,30952534,30952532,30952498,30952497,30952495,30952485,30952481,30952476,30952465,30952462,30952373);
