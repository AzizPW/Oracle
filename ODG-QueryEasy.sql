--Check DB information
<<<<<<< HEAD
SELECT NAME,DB_UNIQUE_NAME,DBID,LOG_MODE,OPEN_MODE,DATABASE_ROLE,TO_CHAR(CURRENT_SCN)CURRENT_SCN FROM V$DATABASE;
=======
SELECT NAME,DB_UNIQUE_NAME,DBID,/*FORCE_LOGGING,*/LOG_MODE,OPEN_MODE,DATABASE_ROLE,SWITCHOVER_STATUS,TO_CHAR(CURRENT_SCN)CURRENT_SCN FROM V$DATABASE;
>>>>>>> 327b5e2c2d7f1e6078f5d0c4cff716a75d749ca2

--Start and stop Media Recovery Process
--Start only once on one of nodes RAC (RAC only)
RECOVER /*Start MRP*/ MANAGED STANDBY DATABASE DISCONNECT FROM SESSION;
RECOVER /*Start MRP realtime*/ MANAGED STANDBY DATABASE USING CURRENT LOGFILE DISCONNECT FROM SESSION;
RECOVER /*Stop MRP*/ MANAGED STANDBY DATABASE CANCEL;

--Check gap on standby DB
SELECT /*Check gap on stby*/ al.thrd "Thread", almax "Last Seq Received", lhmax "Last Seq Applied" FROM (select thread# thrd, MAX(sequence#) almax
FROM v$archived_log WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) GROUP BY thread#) al, (SELECT thread# thrd, MAX(sequence#) lhmax
FROM v$log_history WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) GROUP BY thread#) lh WHERE al.thrd = lh.thrd;

--Check gap on standby DB with gap
SELECT /*Check gap on stby with difference*/ al.thrd "Thread", almax "Last Seq Received", lhmax "Last Seq Applied", almax-lhmax "Gap", decode(almax-lhmax, 0, 'Sync', 'Gap') "Result"
FROM (select thread# thrd, MAX(sequence#) almax FROM v$archived_log WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) GROUP BY thread#) al,
(SELECT thread# thrd, MAX(sequence#) lhmax FROM v$log_history WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) GROUP BY thread#) lh WHERE al.thrd = lh.thrd;

--Check destination error on primary DB
COL DESTINATION FOR A25;
<<<<<<< HEAD
SELECT /*Check destination status on primary*/ THREAD#, DEST_ID, DESTINATION, GVAD.STATUS, ERROR, FAIL_SEQUENCE FROM GV$ARCHIVE_DEST GVAD, GV$INSTANCE GVI WHERE GVAD.INST_ID = GVI.INST_ID AND DESTINATION IS NOT NULL ORDER BY THREAD#, DEST_ID;
=======
SELECT /*Check destination status on primary*/ THREAD#, DEST_ID, DESTINATION, GVAD.STATUS, ERROR, FAIL_SEQUENCE FROM GV$ARCHIVE_DEST GVAD, GV$INSTANCE GVI
WHERE GVAD.INST_ID = GVI.INST_ID AND DESTINATION IS NOT NULL ORDER BY THREAD#, DEST_ID;
>>>>>>> 327b5e2c2d7f1e6078f5d0c4cff716a75d749ca2

--Manual register archivelog
ALTER DATABASE REGISTER LOGFILE '&arc';

--Check proses standby
SELECT SEQUENCE#, APPLIED FROM V$ARCHIVED_LOG;
SELECT PROCESS,STATUS,SEQUENCE# FROM V$MANAGED_STANDBY;
<<<<<<< HEAD
SELECT /*Primary*/ MAX(SEQUENCE#) FROM V$ARCHIVED_LOG;
SELECT /*Standby*/ MAX(SEQUENCE#) FROM V$ARCHIVED_LOG WHERE APPLIED='YES';
=======
SELECT MAX(SEQUENCE#) FROM V$ARCHIVED_LOG/*Primary*/;
SELECT MAX(SEQUENCE#) FROM V$ARCHIVED_LOG WHERE APPLIED='YES'/*Standby*/;
>>>>>>> 327b5e2c2d7f1e6078f5d0c4cff716a75d749ca2
