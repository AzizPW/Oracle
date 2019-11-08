set echo off
set feedback off
column timecol new_value timestamp
column spool_extension new_value suffix
SELECT TO_CHAR(sysdate,'mmddyyyy_hh24miss') timecol, '.html' spool_extension FROM dual;
column output new_value dbname
SELECT value || '_' output FROM v$parameter WHERE name = 'db_unique_name';
spool dg_psbydiag_&&dbname&&timestamp&&suffix

set linesize 2000
set pagesize 50000
set numformat 999999999999999
set trim on
set trims on
set markup html on
set markup html entmap off
set feedback on

ALTER SESSION SET nls_date_format = 'MON-DD-YYYY HH24:MI:SS';
SELECT TO_CHAR(sysdate) time FROM dual;

set echo on
Rem ===================================
Rem 1) NAME: DB_ENABLED_FEATURES
Rem ===================================

column CHECK_NAME format a40
column force_logging format a15
column supplemental_log_data_pk format a25
column supplemental_log_data_ui format a25
column guard_status format a15
column dataguard_broker format a18
column primary_db_unique_name a18
select 'DB_ENABLED_FEATURES' as CHECK_NAME, dbid, db_unique_name, name, database_role, log_mode, force_logging, supplemental_log_data_pk, supplemental_log_data_ui, flashback_on, guard_status, dataguard_broker, protection_mode, switchover_status, dataguard_broker, platform_id, standby_became_primary_scn, primary_db_unique_name, activation# from v$database;

Rem ===================================
Rem 2) NAME:  REDO_TRANSPORT_CONFIGURED
Rem ===================================

column CHECK_NAME format a40
select 'REDO_TRANSPORT_CONFIGURED' as CHECK_NAME, inst_id, name, value from gv$parameter where name like 'log_archive_dest_%' and upper(value) like '%SERVICE%' order by inst_id;
   
Rem ===================================
Rem 3) NAME: REDO_TRANSPORT_STATE_VALID
Rem ===================================

column CHECK_NAME format a40
col error format a256
select 'REDO_TRANSPORT_STATE_VALID' as CHECK_NAME, inst_id, dest_id, status, error from gv$archive_dest_status where status <> 'INACTIVE' and db_unique_name <> 'NONE' order by dest_id, inst_id;

Rem ===================================
Rem 4) NAME: ADG_STATE
Rem ===================================
	  
column CHECK_NAME format a40	
select 'ADG_STATE' as CHECK_NAME, open_mode from v$database;

Rem ===================================
Rem 5) NAME: STANDBY_SRL_SETUP
Rem ===================================

column CHECK_NAME format a40
select 'STANDBY_SRL_SETUP' as CHECK_NAME, count(*) from v$standby_log;
select 'ORL_SETUP_COUNT' as CHECK_NAME, count(*) from v$log;

Rem ===================================
Rem 6) NAME: SRL_SIZES
Rem ===================================

column CHECK_NAME format a40
select distinct bytes, 'SRL_SIZES_PRIMARY' as CHECK_NAME from v$log group by bytes;
select distinct bytes, 'SRL_SIZES_STANDBY' as CHECK_NAME from v$standby_log group by bytes;

Rem ===================================
Rem 7) NAME: ACTIVE_SRL_USAGE
Rem ===================================

column CHECK_NAME format a40
select 'ACTIVE_SRL_USAGE' as CHECK_NAME, count(*) from v$standby_log where status = 'ACTIVE';

Rem ===================================
Rem 8) NAME: GAP_STATE
Rem ===================================

column CHECK_NAME format a40
select 'GAP_STATE' as CHECK_NAME, thread#, low_sequence#, high_sequence# from v$archive_gap;

Rem =============================
Rem 9) NAME:  LAG_STATE
Rem =============================

column CHECK_NAME format a40
select 'LAG_STATE' as CHECK_NAME, name, value FROM v$dataguard_stats WHERE name LIKE '%lag%';
		
Rem ===================================
Rem 10) NAME: APPLY_INFO_LAST_ARCHIVE
Rem ===================================

column CHECK_NAME format a40
SELECT 'APPLY_INFO_LAST_ARCHIVE' as CHECK_NAME, al.thrd "Thread", almax "Last Seq Received", lhmax "Last Seq Applied" FROM (select thread# thrd, MAX(sequence#) almax FROM v$archived_log WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) GROUP BY thread#) al, (SELECT thread# thrd, MAX(sequence#) lhmax FROM v$log_history WHERE resetlogs_change#=(SELECT resetlogs_change# FROM v$database) GROUP BY thread#) lh WHERE al.thrd = lh.thrd; 
   
Rem ===================================
Rem 11) NAME: DATAFILE_STATE
Rem ===================================	  
	  
column CHECK_NAME format a40	  
select distinct checkpoint_change#, fuzzy, status, 'DATAFILE_STATE' as CHECK_NAME from v$datafile_header;
   
Rem ===================================
Rem 12) NAME: RFS_PERF_STATE
Rem ===================================	  
	  
column CHECK_NAME format a40	
select 'RFS_PERF_STATE' as CHECK_NAME, event, total_waits, total_timeouts, time_waited, average_wait*10 from v$system_event where event like '%RFS%' order by 5 desc;   
	  
Rem ===================================
Rem 13) NAME: DATAFILE_PERF_STATE
Rem ===================================	  
	  
column CHECK_NAME format a40	
select 'DATAFILE_PERF_STATE' as CHECK_NAME, event, total_waits, total_timeouts, time_waited, average_wait*10 from v$system_event where event like '%db file%' order by 5 desc;   
   
Rem ===================================
Rem 14) NAME: DATAGUARD_STATE
Rem ===================================

column CHECK_NAME format a40
column DSTIME format a25
column FACILITY format a30
column MESSAGE format a100
select 'DATAGUARD_STATE' as CHECK_NAME, inst_id, dest_id, to_char(timestamp, 'DD-MON-YYYY HH24:MI:SS') "DSTIME", facility, message from gv$dataguard_status where severity in ('Error', 'Fatal') order by dest_id, inst_id;

spool off
set markup html off entmap on
