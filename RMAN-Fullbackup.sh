### FULL BACKUP PRIMARY DB ###
vi /home/orekel/scripts/RMAN-Fullbackup.sh; chmod +x /home/orekel/scripts/RMAN-Fullbackup.sh;
#############################################################################################
#!/bin/bash
source /home/orekel/.bash_profile; export NLS_DATE_FORMAT='DD-Mon-RR HH24:MI:SS';
$ORACLE_HOME/bin/rman target=/ log=/home/orekel/backup/RMAN-Fullbackup_`date +%Y%m%d`.log << EOF
run{
  CONFIGURE DEVICE TYPE DISK PARALLELISM 2;
  CROSSCHECK BACKUP;
  DELETE NOPROMPT EXPIRED BACKUP;
  CROSSCHECK ARCHIVELOG ALL;
  DELETE NOPROMPT EXPIRED ARCHIVELOG ALL;
  BACKUP AS COMPRESSED BACKUPSET SPFILE TAG 'SPFile' FORMAT '/home/orekel/backup/SPF_%I%d%T_%s_%p.bkp';
  SQL 'ALTER SYSTEM ARCHIVE LOG CURRENT';
  BACKUP AS COMPRESSED BACKUPSET DATABASE TAG 'FULLDB' FORMAT '/home/orekel/backup/DB_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET ARCHIVELOG ALL DELETE ALL INPUT TAG 'ARCHIVELOGS' FORMAT '/home/orekel/backup/ARC_%I%d%T_%s_%p.bkp';
  DELETE NOPROMPT OBSOLETE RECOVERY WINDOW OF 14 DAYS;
  BACKUP AS COMPRESSED BACKUPSET CURRENT CONTROLFILE TAG 'PRIMCTRL' FORMAT '/home/orekel/backup/CTRL_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET CURRENT CONTROLFILE FOR STANDBY TAG 'STBYCTRL' FORMAT '/home/orekel/backup/STBY_%I%d%T_%s_%p.bkp';
  CONFIGURE DEVICE TYPE DISK CLEAR;}
EOF

nohup /home/orekel/scripts/RMAN-Fullbackup.sh >> /home/orekel/backup/nohupRMAN-Fullbackup_`date +%Y%m%d`.log 2>&1 &
tail -100f /home/orekel/backup/RMAN-Fullbackup_`date +%Y%m%d`.log

### FULL BACKUP STANDBY DB ###
vi /home/orekel/scripts/RMAN-Fullbackup.sh; chmod +x /home/orekel/scripts/RMAN-Fullbackup.sh;
#############################################################################################
#!/bin/bash
source /home/orekel/.bash_profile; export NLS_DATE_FORMAT='DD-Mon-RR HH24:MI:SS';
$ORACLE_HOME/bin/rman target=/ log=/home/orekel/backup/RMAN-Fullbackup_`date +%Y%m%d`.log << EOF
run{
  CONFIGURE DEVICE TYPE DISK PARALLELISM 2;
  CROSSCHECK BACKUP;
  DELETE NOPROMPT EXPIRED BACKUP;
  CROSSCHECK ARCHIVELOG ALL;
  DELETE NOPROMPT EXPIRED ARCHIVELOG ALL;
  SQL 'ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL';
  BACKUP AS COMPRESSED BACKUPSET SPFILE TAG 'SPFile' FORMAT '/home/orekel/backup/SPF_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET DATABASE PLUS ARCHIVELOG DELETE ALL INPUT TAG 'DBPlusArchive' FORMAT '/home/orekel/backup/DB_%I%d%T_%s_%p.bkp';
  DELETE NOPROMPT OBSOLETE RECOVERY WINDOW OF 14 DAYS;
  BACKUP AS COMPRESSED BACKUPSET CURRENT CONTROLFILE TAG 'Controlfile' FORMAT '/home/orekel/backup/CTRL_%I%d%T_%s_%p.bkp';
  BACKUP AS COMPRESSED BACKUPSET CURRENT CONTROLFILE FOR STANDBY TAG 'StbyControl' FORMAT '/home/orekel/backup/STBY_%I%d%T_%s_%p.bkp';
  CONFIGURE DEVICE TYPE DISK CLEAR;
  SQL 'ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT FROM SESSION';}
EOF

nohup /home/orekel/scripts/RMAN-Fullbackup.sh >> /home/orekel/backup/nohupRMAN-Fullbackup_`date +%Y%m%d`.log 2>&1 &
tail -100f /home/orekel/backup/RMAN-Fullbackup_`date +%Y%m%d`.log