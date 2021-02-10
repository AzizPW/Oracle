### INCREMENTAL 0 BACKUP
########################
[oracle@bakso backup]$ vi ~/scripts/RMAN-INCR0.sh; chmod +x ~/scripts/RMAN-INCR0.sh; cat ~/scripts/RMAN-INCR0.sh;
#!/bin/bash
source /home/oracle/.bash_profile; export NLS_DATE_FORMAT='DD-Mon-RR HH24:MI:SS'; export TGL=`date +%Y%m%d`; export DIR=/home/oracle/FRA/CPEMPEK/backup;
$ORACLE_HOME/bin/rman target=/ log=/home/oracle/logs/RMAN-INCR0_`date +%Y%m%d`.log << EOF
run{
  CONFIGURE DEVICE TYPE DISK PARALLELISM 4;
  CROSSCHECK BACKUP;
  DELETE NOPROMPT EXPIRED BACKUP;
  CROSSCHECK ARCHIVELOG ALL;
  DELETE NOPROMPT EXPIRED ARCHIVELOG ALL;
  SQL 'ALTER SYSTEM ARCHIVE LOG CURRENT';
  BACKUP AS COMPRESSED BACKUPSET INCREMENTAL LEVEL 0 DATABASE TAG 'INCR0_$TGL' FORMAT '$DIR/INC0_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET ARCHIVELOG ALL DELETE ALL INPUT TAG 'ARCHIVELOGS_$TGL' FORMAT '$DIR/ARC_%I%d%T_%s_%p.bkp';
  #DELETE NOPROMPT OBSOLETE RECOVERY WINDOW OF 14 DAYS;
  BACKUP AS COMPRESSED BACKUPSET CURRENT CONTROLFILE TAG 'PRIMCTRL_$TGL' FORMAT '$DIR/CTRL_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET CURRENT CONTROLFILE FOR STANDBY TAG 'STBYCTRL_$TGL' FORMAT '$DIR/STBY_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET SPFILE TAG 'SPFile_$TGL' FORMAT '$DIR/SPF_%I%d%T_%s_%p.bkp';
  CONFIGURE DEVICE TYPE DISK CLEAR;}
EOF
[oracle@bakso backup]$

### INCREMENTAL 1 BACKUP
########################
[oracle@bakso backup]$ vi ~/scripts/RMAN-INCR1.sh; chmod +x ~/scripts/RMAN-INCR1.sh; cat ~/scripts/RMAN-INCR1.sh;
#!/bin/bash
source /home/oracle/.bash_profile; export NLS_DATE_FORMAT='DD-Mon-RR HH24:MI:SS'; export TGL=`date +%Y%m%d`; export DIR=/home/oracle/FRA/CPEMPEK/backup;
$ORACLE_HOME/bin/rman target=/ log=/home/oracle/logs/RMAN-INCR1_`date +%Y%m%d`.log << EOF
run{
  CONFIGURE DEVICE TYPE DISK PARALLELISM 4;
  CROSSCHECK BACKUP;
  DELETE NOPROMPT EXPIRED BACKUP;
  CROSSCHECK ARCHIVELOG ALL;
  DELETE NOPROMPT EXPIRED ARCHIVELOG ALL;
  SQL 'ALTER SYSTEM ARCHIVE LOG CURRENT';
  BACKUP AS COMPRESSED BACKUPSET INCREMENTAL LEVEL 1 DATABASE TAG 'INCR1_$TGL' FORMAT '$DIR/INC1_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET ARCHIVELOG ALL DELETE ALL INPUT TAG 'ARCHIVELOGS_$TGL' FORMAT '$DIR/ARC_%I%d%T_%s_%p.bkp';
  #DELETE NOPROMPT OBSOLETE RECOVERY WINDOW OF 14 DAYS;
  BACKUP AS COMPRESSED BACKUPSET CURRENT CONTROLFILE TAG 'PRIMCTRL_$TGL' FORMAT '$DIR/CTRL_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET CURRENT CONTROLFILE FOR STANDBY TAG 'STBYCTRL_$TGL' FORMAT '$DIR/STBY_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET SPFILE TAG 'SPFile_$TGL' FORMAT '$DIR/SPF_%I%d%T_%s_%p.bkp';
  CONFIGURE DEVICE TYPE DISK CLEAR;}
EOF
[oracle@bakso backup]$

### FULL BACKUP PRIMARY DB
##########################
BACKUP AS COMPRESSED BACKUPSET DATABASE TAG 'FULLDB' FORMAT '/backup/DB_%I%d%T_%s_%p.bkp';

### FULL BACKUP STANDBY DB
##########################
run{
  CONFIGURE DEVICE TYPE DISK PARALLELISM 4;
  CROSSCHECK BACKUP;
  DELETE NOPROMPT EXPIRED BACKUP;
  CROSSCHECK ARCHIVELOG ALL;
  DELETE NOPROMPT EXPIRED ARCHIVELOG ALL;
  SQL 'ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL';
  BACKUP AS COMPRESSED BACKUPSET SPFILE TAG 'SPFile' FORMAT '/home/orekel/backup/SPF_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET DATABASE PLUS ARCHIVELOG DELETE ALL INPUT TAG 'DBPlusArchive' FORMAT '/home/orekel/backup/DB_%I%d%T_%s_%p.bkp';
  #DELETE NOPROMPT OBSOLETE RECOVERY WINDOW OF 14 DAYS;
  BACKUP AS COMPRESSED BACKUPSET CURRENT CONTROLFILE TAG 'Controlfile' FORMAT '/home/orekel/backup/CTRL_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET CURRENT CONTROLFILE FOR STANDBY TAG 'StbyControl' FORMAT '/home/orekel/backup/STBY_%I%d%T_%s_%p.bkp';
  CONFIGURE DEVICE TYPE DISK CLEAR;
  SQL 'ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT FROM SESSION';}

### CROSSCHECK
##############
run{ALLOCATE CHANNEL CH01 TYPE DISK;
    ALLOCATE CHANNEL CH02 TYPE DISK;
    CROSSCHECK BACKUP;
    CROSSCHECK ARCHIVELOG ALL;
    DELETE NOPROMPT EXPIRED BACKUP;
    DELETE NOPROMPT EXPIRED ARCHIVELOG ALL;
    RELEASE CHANNEL CH01;
    RELEASE CHANNEL CH02;}

### Example Connect with TNS
############################
rlwrap rman target "'sys/oracle789@CPEMPEK as sysdba'"

### Example Backup Summary
##########################
[oracle@bakso backup]$ rlwrap rman target=/

Recovery Manager: Release 19.0.0.0.0 - Production on Wed Feb 10 15:57:58 2021
Version 19.10.0.0.0

Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

connected to target database: CPEMPEK (DBID=1075316347)

RMAN> list backup summary;

using target database control file instead of recovery catalog

List of Backups
===============
Key     TY LV S Device Type Completion Time    #Pieces #Copies Compressed Tag
------- -- -- - ----------- ------------------ ------- ------- ---------- ---
19      B  0  A DISK        10-Feb-21 15:55:41 1       1       YES        INCR0_20210210
20      B  0  A DISK        10-Feb-21 15:55:47 1       1       YES        INCR0_20210210
21      B  0  A DISK        10-Feb-21 15:55:58 1       1       YES        INCR0_20210210
22      B  0  A DISK        10-Feb-21 15:56:38 1       1       YES        INCR0_20210210
23      B  0  A DISK        10-Feb-21 15:56:52 1       1       YES        INCR0_20210210
24      B  0  A DISK        10-Feb-21 15:57:05 1       1       YES        INCR0_20210210
25      B  0  A DISK        10-Feb-21 15:57:18 1       1       YES        INCR0_20210210
26      B  0  A DISK        10-Feb-21 15:57:22 1       1       YES        INCR0_20210210
27      B  0  A DISK        10-Feb-21 15:57:27 1       1       YES        INCR0_20210210
28      B  0  A DISK        10-Feb-21 15:57:27 1       1       YES        INCR0_20210210
29      B  0  A DISK        10-Feb-21 15:57:28 1       1       YES        INCR0_20210210
30      B  A  A DISK        10-Feb-21 15:57:30 1       1       YES        ARCHIVELOGS_20210210
31      B  A  A DISK        10-Feb-21 15:57:30 1       1       YES        ARCHIVELOGS_20210210
32      B  F  A DISK        10-Feb-21 15:57:33 1       1       YES        PRIMCTRL_20210210
33      B  F  A DISK        10-Feb-21 15:57:35 1       1       YES        STBYCTRL_20210210
34      B  F  A DISK        10-Feb-21 15:57:37 1       1       YES        SPFILE_20210210
35      B  F  A DISK        10-Feb-21 15:57:38 1       1       NO         TAG20210210T155738

RMAN> exit


Recovery Manager complete.
[oracle@bakso backup]$

### Example of Logfile
######################
[oracle@bakso backup]$ cat ~/logs/RMAN-INCR0_20210210.log

Recovery Manager: Release 19.0.0.0.0 - Production on Wed Feb 10 15:54:26 2021
Version 19.10.0.0.0

Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

connected to target database: CPEMPEK (DBID=1075316347)

RMAN> 2> 3> 4> 5> 6> 7> 8> 9> 10> 11> 12> 13> 14>
using target database control file instead of recovery catalog
new RMAN configuration parameters:
CONFIGURE DEVICE TYPE DISK PARALLELISM 4 BACKUP TYPE TO BACKUPSET;
new RMAN configuration parameters are successfully stored

allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=2095 device type=DISK
allocated channel: ORA_DISK_2
channel ORA_DISK_2: SID=30 device type=DISK
allocated channel: ORA_DISK_3
channel ORA_DISK_3: SID=1058 device type=DISK
allocated channel: ORA_DISK_4
channel ORA_DISK_4: SID=2096 device type=DISK
specification does not match any backup in the repository

using channel ORA_DISK_1
using channel ORA_DISK_2
using channel ORA_DISK_3
using channel ORA_DISK_4
specification does not match any backup in the repository

released channel: ORA_DISK_1
released channel: ORA_DISK_2
released channel: ORA_DISK_3
released channel: ORA_DISK_4
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=2095 device type=DISK
allocated channel: ORA_DISK_2
channel ORA_DISK_2: SID=30 device type=DISK
allocated channel: ORA_DISK_3
channel ORA_DISK_3: SID=1058 device type=DISK
allocated channel: ORA_DISK_4
channel ORA_DISK_4: SID=2096 device type=DISK
specification does not match any archived log in the repository

released channel: ORA_DISK_1
released channel: ORA_DISK_2
released channel: ORA_DISK_3
released channel: ORA_DISK_4
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=2095 device type=DISK
allocated channel: ORA_DISK_2
channel ORA_DISK_2: SID=30 device type=DISK
allocated channel: ORA_DISK_3
channel ORA_DISK_3: SID=1058 device type=DISK
allocated channel: ORA_DISK_4
channel ORA_DISK_4: SID=2096 device type=DISK
specification does not match any archived log in the repository

sql statement: ALTER SYSTEM ARCHIVE LOG CURRENT

Starting backup at 10-Feb-21 15:54:31
using channel ORA_DISK_1
using channel ORA_DISK_2
using channel ORA_DISK_3
using channel ORA_DISK_4
channel ORA_DISK_1: starting compressed incremental level 0 datafile backup set
channel ORA_DISK_1: specifying datafile(s) in backup set
input datafile file number=00001 name=/z01/oradata/CPEMPEK/system01.dbf
channel ORA_DISK_1: starting piece 1 at 10-Feb-21 15:54:31
channel ORA_DISK_2: starting compressed incremental level 0 datafile backup set
channel ORA_DISK_2: specifying datafile(s) in backup set
input datafile file number=00003 name=/z01/oradata/CPEMPEK/sysaux01.dbf
channel ORA_DISK_2: starting piece 1 at 10-Feb-21 15:54:32
channel ORA_DISK_3: starting compressed incremental level 0 datafile backup set
channel ORA_DISK_3: specifying datafile(s) in backup set
input datafile file number=00010 name=/z01/oradata/CPEMPEK/plenjer/sysaux01.dbf
channel ORA_DISK_3: starting piece 1 at 10-Feb-21 15:54:32
channel ORA_DISK_4: starting compressed incremental level 0 datafile backup set
channel ORA_DISK_4: specifying datafile(s) in backup set
input datafile file number=00006 name=/z01/oradata/CPEMPEK/pdbseed/sysaux01.dbf
channel ORA_DISK_4: starting piece 1 at 10-Feb-21 15:54:33
channel ORA_DISK_2: finished piece 1 at 10-Feb-21 15:56:00
piece handle=/home/oracle/FRA/CPEMPEK/backup/INC0_1075316347CPEMPEK20210210_20_1.bkp tag=INCR0_20210210 comment=NONE
channel ORA_DISK_2: backup set complete, elapsed time: 00:01:29
channel ORA_DISK_2: starting compressed incremental level 0 datafile backup set
channel ORA_DISK_2: specifying datafile(s) in backup set
input datafile file number=00005 name=/z01/oradata/CPEMPEK/pdbseed/system01.dbf
channel ORA_DISK_2: starting piece 1 at 10-Feb-21 15:56:03
channel ORA_DISK_3: finished piece 1 at 10-Feb-21 15:56:03
piece handle=/home/oracle/FRA/CPEMPEK/backup/INC0_1075316347CPEMPEK20210210_21_1.bkp tag=INCR0_20210210 comment=NONE
channel ORA_DISK_3: backup set complete, elapsed time: 00:01:31
channel ORA_DISK_3: starting compressed incremental level 0 datafile backup set
channel ORA_DISK_3: specifying datafile(s) in backup set
input datafile file number=00009 name=/z01/oradata/CPEMPEK/plenjer/system01.dbf
channel ORA_DISK_3: starting piece 1 at 10-Feb-21 15:56:08
channel ORA_DISK_4: finished piece 1 at 10-Feb-21 15:56:08
piece handle=/home/oracle/FRA/CPEMPEK/backup/INC0_1075316347CPEMPEK20210210_22_1.bkp tag=INCR0_20210210 comment=NONE
channel ORA_DISK_4: backup set complete, elapsed time: 00:01:36
channel ORA_DISK_4: starting compressed incremental level 0 datafile backup set
channel ORA_DISK_4: specifying datafile(s) in backup set
input datafile file number=00004 name=/z01/oradata/CPEMPEK/undotbs01.dbf
channel ORA_DISK_4: starting piece 1 at 10-Feb-21 15:56:29
channel ORA_DISK_1: finished piece 1 at 10-Feb-21 15:56:54
piece handle=/home/oracle/FRA/CPEMPEK/backup/INC0_1075316347CPEMPEK20210210_19_1.bkp tag=INCR0_20210210 comment=NONE
channel ORA_DISK_1: backup set complete, elapsed time: 00:02:23
channel ORA_DISK_1: starting compressed incremental level 0 datafile backup set
channel ORA_DISK_1: specifying datafile(s) in backup set
input datafile file number=00008 name=/z01/oradata/CPEMPEK/pdbseed/undotbs01.dbf
channel ORA_DISK_1: starting piece 1 at 10-Feb-21 15:56:58
channel ORA_DISK_2: finished piece 1 at 10-Feb-21 15:56:58
piece handle=/home/oracle/FRA/CPEMPEK/backup/INC0_1075316347CPEMPEK20210210_23_1.bkp tag=INCR0_20210210 comment=NONE
channel ORA_DISK_2: backup set complete, elapsed time: 00:00:55
channel ORA_DISK_2: starting compressed incremental level 0 datafile backup set
channel ORA_DISK_2: specifying datafile(s) in backup set
input datafile file number=00011 name=/z01/oradata/CPEMPEK/plenjer/undotbs01.dbf
channel ORA_DISK_2: starting piece 1 at 10-Feb-21 15:57:05
channel ORA_DISK_3: finished piece 1 at 10-Feb-21 15:57:20
piece handle=/home/oracle/FRA/CPEMPEK/backup/INC0_1075316347CPEMPEK20210210_24_1.bkp tag=INCR0_20210210 comment=NONE
channel ORA_DISK_3: backup set complete, elapsed time: 00:01:13
channel ORA_DISK_3: starting compressed incremental level 0 datafile backup set
channel ORA_DISK_3: specifying datafile(s) in backup set
input datafile file number=00007 name=/z01/oradata/CPEMPEK/users01.dbf
channel ORA_DISK_3: starting piece 1 at 10-Feb-21 15:57:26
channel ORA_DISK_1: finished piece 1 at 10-Feb-21 15:57:26
piece handle=/home/oracle/FRA/CPEMPEK/backup/INC0_1075316347CPEMPEK20210210_26_1.bkp tag=INCR0_20210210 comment=NONE
channel ORA_DISK_1: backup set complete, elapsed time: 00:00:28
channel ORA_DISK_1: starting compressed incremental level 0 datafile backup set
channel ORA_DISK_1: specifying datafile(s) in backup set
input datafile file number=00012 name=/z01/oradata/CPEMPEK/plenjer/users01.dbf
channel ORA_DISK_1: starting piece 1 at 10-Feb-21 15:57:27
channel ORA_DISK_4: finished piece 1 at 10-Feb-21 15:57:27
piece handle=/home/oracle/FRA/CPEMPEK/backup/INC0_1075316347CPEMPEK20210210_25_1.bkp tag=INCR0_20210210 comment=NONE
channel ORA_DISK_4: backup set complete, elapsed time: 00:00:58
channel ORA_DISK_1: finished piece 1 at 10-Feb-21 15:57:28
piece handle=/home/oracle/FRA/CPEMPEK/backup/INC0_1075316347CPEMPEK20210210_29_1.bkp tag=INCR0_20210210 comment=NONE
channel ORA_DISK_1: backup set complete, elapsed time: 00:00:01
channel ORA_DISK_2: finished piece 1 at 10-Feb-21 15:57:28
piece handle=/home/oracle/FRA/CPEMPEK/backup/INC0_1075316347CPEMPEK20210210_27_1.bkp tag=INCR0_20210210 comment=NONE
channel ORA_DISK_2: backup set complete, elapsed time: 00:00:23
channel ORA_DISK_3: finished piece 1 at 10-Feb-21 15:57:28
piece handle=/home/oracle/FRA/CPEMPEK/backup/INC0_1075316347CPEMPEK20210210_28_1.bkp tag=INCR0_20210210 comment=NONE
channel ORA_DISK_3: backup set complete, elapsed time: 00:00:02
Finished backup at 10-Feb-21 15:57:28

Starting backup at 10-Feb-21 15:57:29
current log archived
using channel ORA_DISK_1
using channel ORA_DISK_2
using channel ORA_DISK_3
using channel ORA_DISK_4
channel ORA_DISK_1: starting compressed archived log backup set
channel ORA_DISK_1: specifying archived log(s) in backup set
input archived log thread=1 sequence=18 RECID=4 STAMP=1064159671
channel ORA_DISK_1: starting piece 1 at 10-Feb-21 15:57:30
channel ORA_DISK_2: starting compressed archived log backup set
channel ORA_DISK_2: specifying archived log(s) in backup set
input archived log thread=1 sequence=19 RECID=5 STAMP=1064159850
channel ORA_DISK_2: starting piece 1 at 10-Feb-21 15:57:30
channel ORA_DISK_1: finished piece 1 at 10-Feb-21 15:57:31
piece handle=/home/oracle/FRA/CPEMPEK/backup/ARC_1075316347CPEMPEK20210210_30_1.bkp tag=ARCHIVELOGS_20210210 comment=NONE
channel ORA_DISK_1: backup set complete, elapsed time: 00:00:01
channel ORA_DISK_1: deleting archived log(s)
archived log file name=/home/oracle/FRA/CPEMPEK/archivelog/2021_02_10/o1_mf_1_18_j277t79l_.arc RECID=4 STAMP=1064159671
channel ORA_DISK_2: finished piece 1 at 10-Feb-21 15:57:31
piece handle=/home/oracle/FRA/CPEMPEK/backup/ARC_1075316347CPEMPEK20210210_31_1.bkp tag=ARCHIVELOGS_20210210 comment=NONE
channel ORA_DISK_2: backup set complete, elapsed time: 00:00:01
channel ORA_DISK_1: deleting archived log(s)
archived log file name=/home/oracle/FRA/CPEMPEK/archivelog/2021_02_10/o1_mf_1_19_j277zt37_.arc RECID=5 STAMP=1064159850
Finished backup at 10-Feb-21 15:57:31

Starting backup at 10-Feb-21 15:57:32
using channel ORA_DISK_1
using channel ORA_DISK_2
using channel ORA_DISK_3
using channel ORA_DISK_4
channel ORA_DISK_1: starting compressed full datafile backup set
channel ORA_DISK_1: specifying datafile(s) in backup set
including current control file in backup set
channel ORA_DISK_1: starting piece 1 at 10-Feb-21 15:57:33
channel ORA_DISK_1: finished piece 1 at 10-Feb-21 15:57:34
piece handle=/home/oracle/FRA/CPEMPEK/backup/CTRL_1075316347CPEMPEK20210210_32_1.bkp tag=PRIMCTRL_20210210 comment=NONE
channel ORA_DISK_1: backup set complete, elapsed time: 00:00:01
Finished backup at 10-Feb-21 15:57:34

Starting backup at 10-Feb-21 15:57:34
using channel ORA_DISK_1
using channel ORA_DISK_2
using channel ORA_DISK_3
using channel ORA_DISK_4
channel ORA_DISK_1: starting compressed full datafile backup set
channel ORA_DISK_1: specifying datafile(s) in backup set
including standby control file in backup set
channel ORA_DISK_1: starting piece 1 at 10-Feb-21 15:57:35
channel ORA_DISK_1: finished piece 1 at 10-Feb-21 15:57:36
piece handle=/home/oracle/FRA/CPEMPEK/backup/STBY_1075316347CPEMPEK20210210_33_1.bkp tag=STBYCTRL_20210210 comment=NONE
channel ORA_DISK_1: backup set complete, elapsed time: 00:00:01
Finished backup at 10-Feb-21 15:57:36

Starting backup at 10-Feb-21 15:57:36
using channel ORA_DISK_1
using channel ORA_DISK_2
using channel ORA_DISK_3
using channel ORA_DISK_4
channel ORA_DISK_1: starting compressed full datafile backup set
channel ORA_DISK_1: specifying datafile(s) in backup set
including current SPFILE in backup set
channel ORA_DISK_1: starting piece 1 at 10-Feb-21 15:57:37
channel ORA_DISK_1: finished piece 1 at 10-Feb-21 15:57:38
piece handle=/home/oracle/FRA/CPEMPEK/backup/SPF_1075316347CPEMPEK20210210_34_1.bkp tag=SPFILE_20210210 comment=NONE
channel ORA_DISK_1: backup set complete, elapsed time: 00:00:01
Finished backup at 10-Feb-21 15:57:38

Starting Control File and SPFILE Autobackup at 10-Feb-21 15:57:38
piece handle=/home/oracle/FRA/CPEMPEK/autobackup/2021_02_10/o1_mf_s_1064159858_j27802lm_.bkp comment=NONE
Finished Control File and SPFILE Autobackup at 10-Feb-21 15:57:39

old RMAN configuration parameters:
CONFIGURE DEVICE TYPE DISK PARALLELISM 4 BACKUP TYPE TO BACKUPSET;
RMAN configuration parameters are successfully reset to default value
released channel: ORA_DISK_1
released channel: ORA_DISK_2
released channel: ORA_DISK_3
released channel: ORA_DISK_4

RMAN>

Recovery Manager complete.
[oracle@bakso backup]$