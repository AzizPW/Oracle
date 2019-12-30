SQL> alter session set nls_date_format='DD-Mon-RR HH24:MI:SS';

Session altered.

SQL> COL USERNAME FOR A25;
SQL> COL PROFILE FOR A20;
SQL> SELECT USERNAME,ACCOUNT_STATUS,EXPIRY_DATE,LOCK_DATE,PROFILE FROM DBA_USERS ORDER BY 1;

USERNAME                  ACCOUNT_STATUS                   EXPIRY_DATE        LOCK_DATE          PROFILE
------------------------- -------------------------------- ------------------ ------------------ ---------------
ANONYMOUS                 EXPIRED & LOCKED                 26-Jan-17 15:27:28 26-Jan-17 15:27:28 DEFAULT
APPQOSSYS                 EXPIRED & LOCKED                 26-Jan-17 14:23:28 26-Jan-17 14:23:28 DEFAULT
AUDSYS                    EXPIRED & LOCKED                 26-Jan-17 13:53:26 26-Jan-17 13:53:26 DEFAULT
CTXSYS                    EXPIRED & LOCKED                 26-Jan-17 14:57:34 26-Jan-17 14:57:34 DEFAULT
DBSFWUSER                 EXPIRED & LOCKED                 26-Jan-17 14:07:52 26-Jan-17 14:07:52 DEFAULT
DBSNMP                    EXPIRED & LOCKED                 26-Jan-17 14:23:26 26-Jan-17 14:23:26 DEFAULT
DCTXMDB                   LOCKED(TIMED)                    15-May-20 18:10:54 17-Nov-19 18:11:15 DEFAULT
DCTXMREPDB                OPEN                             15-May-20 18:11:21                    DEFAULT
DCTXMREPDB2               OPEN                             06-May-20 05:32:17                    DEFAULT
DIP                       EXPIRED & LOCKED                 26-Jan-17 14:05:46 26-Jan-17 14:05:46 DEFAULT
DVF                       EXPIRED & LOCKED                 26-Jan-17 15:27:28 26-Jan-17 15:27:28 DEFAULT
DVSYS                     EXPIRED & LOCKED                 26-Jan-17 15:26:39 26-Jan-17 15:26:39 DEFAULT
GGATE                     OPEN                             05-May-20 19:15:50                    DEFAULT
GGSYS                     EXPIRED & LOCKED                 26-Jan-17 14:24:33 26-Jan-17 14:24:33 DEFAULT
GSMADMIN_INTERNAL         EXPIRED & LOCKED                 26-Jan-17 14:04:59 26-Jan-17 14:04:59 DEFAULT
GSMCATUSER                EXPIRED & LOCKED                 26-Jan-17 14:24:27 26-Jan-17 14:24:27 DEFAULT
GSMUSER                   EXPIRED & LOCKED                 26-Jan-17 14:05:01 26-Jan-17 14:05:01 DEFAULT
HR                        EXPIRED & LOCKED                 07-Nov-19 18:35:11 07-Nov-19 18:35:11 DEFAULT
LBACSYS                   EXPIRED & LOCKED                 26-Jan-17 15:27:28 26-Jan-17 15:27:28 DEFAULT
MDDATA                    EXPIRED & LOCKED                 26-Jan-17 15:27:28 26-Jan-17 15:27:28 DEFAULT
MDSYS                     EXPIRED & LOCKED                 26-Jan-17 14:57:47 26-Jan-17 14:57:47 DEFAULT
OJVMSYS                   EXPIRED & LOCKED                 26-Jan-17 14:51:07 26-Jan-17 14:51:07 DEFAULT
OLAPSYS                   EXPIRED & LOCKED                 26-Jan-17 15:12:32 26-Jan-17 15:12:32 DEFAULT
ORACLE_OCM                EXPIRED & LOCKED                 26-Jan-17 14:09:34 26-Jan-17 14:09:34 DEFAULT
ORDDATA                   EXPIRED & LOCKED                 26-Jan-17 14:57:47 26-Jan-17 14:57:47 DEFAULT
ORDPLUGINS                EXPIRED & LOCKED                 26-Jan-17 14:57:47 26-Jan-17 14:57:47 DEFAULT
ORDSYS                    EXPIRED & LOCKED                 26-Jan-17 14:57:46 26-Jan-17 14:57:46 DEFAULT
OUTLN                     EXPIRED & LOCKED                 26-Jan-17 13:53:40 26-Jan-17 13:53:40 DEFAULT
REMOTE_SCHEDULER_AGENT    EXPIRED & LOCKED                 26-Jan-17 14:07:51 26-Jan-17 14:07:51 DEFAULT
SI_INFORMTN_SCHEMA        EXPIRED & LOCKED                 26-Jan-17 14:57:47 26-Jan-17 14:57:47 DEFAULT
SPATIAL_CSW_ADMIN_USR     EXPIRED & LOCKED                 26-Jan-17 15:15:55 26-Jan-17 15:15:55 DEFAULT
SYS                       OPEN                             05-May-20 18:33:53                    DEFAULT
SYS$UMF                   EXPIRED & LOCKED                 26-Jan-17 14:16:23 26-Jan-17 14:16:23 DEFAULT
SYSBACKUP                 EXPIRED & LOCKED                 26-Jan-17 13:53:27 26-Jan-17 13:53:27 DEFAULT
SYSDG                     EXPIRED & LOCKED                 26-Jan-17 13:53:27 26-Jan-17 13:53:27 DEFAULT
SYSKM                     EXPIRED & LOCKED                 26-Jan-17 13:53:27 26-Jan-17 13:53:27 DEFAULT
SYSRAC                    EXPIRED & LOCKED                 26-Jan-17 13:53:27 26-Jan-17 13:53:27 DEFAULT
SYSTEM                    OPEN                             05-May-20 18:33:55                    DEFAULT
WMSYS                     EXPIRED & LOCKED                 26-Jan-17 14:48:37 26-Jan-17 14:48:37 DEFAULT
XDB                       EXPIRED & LOCKED                 26-Jan-17 14:27:18 26-Jan-17 14:27:18 DEFAULT
XS$NULL                   EXPIRED & LOCKED                 26-Jan-17 14:07:19 26-Jan-17 14:07:19 DEFAULT

41 rows selected.

SQL> COL LIMIT FOR A30;
SQL> SELECT PROFILE,RESOURCE_NAME,LIMIT FROM DBA_PROFILES ORDER BY 1,2;

PROFILE              RESOURCE_NAME                    LIMIT
-------------------- -------------------------------- ------------------------------
DEFAULT              COMPOSITE_LIMIT                  UNLIMITED
DEFAULT              CONNECT_TIME                     UNLIMITED
DEFAULT              CPU_PER_CALL                     UNLIMITED
DEFAULT              CPU_PER_SESSION                  UNLIMITED
DEFAULT              FAILED_LOGIN_ATTEMPTS            10
DEFAULT              IDLE_TIME                        UNLIMITED
DEFAULT              INACTIVE_ACCOUNT_TIME            UNLIMITED
DEFAULT              LOGICAL_READS_PER_CALL           UNLIMITED
DEFAULT              LOGICAL_READS_PER_SESSION        UNLIMITED
DEFAULT              PASSWORD_GRACE_TIME              7
DEFAULT              PASSWORD_LIFE_TIME               180
DEFAULT              PASSWORD_LOCK_TIME               1
DEFAULT              PASSWORD_REUSE_MAX               UNLIMITED
DEFAULT              PASSWORD_REUSE_TIME              UNLIMITED
DEFAULT              PASSWORD_VERIFY_FUNCTION         NULL
DEFAULT              PRIVATE_SGA                      UNLIMITED
DEFAULT              SESSIONS_PER_USER                UNLIMITED
ORA_STIG_PROFILE     COMPOSITE_LIMIT                  DEFAULT
ORA_STIG_PROFILE     CONNECT_TIME                     DEFAULT
ORA_STIG_PROFILE     CPU_PER_CALL                     DEFAULT
ORA_STIG_PROFILE     CPU_PER_SESSION                  DEFAULT
ORA_STIG_PROFILE     FAILED_LOGIN_ATTEMPTS            3
ORA_STIG_PROFILE     IDLE_TIME                        15
ORA_STIG_PROFILE     INACTIVE_ACCOUNT_TIME            35
ORA_STIG_PROFILE     LOGICAL_READS_PER_CALL           DEFAULT
ORA_STIG_PROFILE     LOGICAL_READS_PER_SESSION        DEFAULT
ORA_STIG_PROFILE     PASSWORD_GRACE_TIME              5
ORA_STIG_PROFILE     PASSWORD_LIFE_TIME               60
ORA_STIG_PROFILE     PASSWORD_LOCK_TIME               UNLIMITED
ORA_STIG_PROFILE     PASSWORD_REUSE_MAX               10
ORA_STIG_PROFILE     PASSWORD_REUSE_TIME              365
ORA_STIG_PROFILE     PASSWORD_VERIFY_FUNCTION         ORA12C_STIG_VERIFY_FUNCTION
ORA_STIG_PROFILE     PRIVATE_SGA                      DEFAULT
ORA_STIG_PROFILE     SESSIONS_PER_USER                DEFAULT

34 rows selected.

SQL> ALTER PROFILE DEFAULT LIMIT PASSWORD_REUSE_TIME UNLIMITED;

Profile altered.

SQL> ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

Profile altered.

SQL> ALTER PROFILE DEFAULT LIMIT FAILED_LOGIN_ATTEMPTS UNLIMITED;

Profile altered.

SQL> ALTER USER DCTXMDB ACCOUNT UNLOCK;

User altered.

SQL> SELECT USERNAME,ACCOUNT_STATUS,EXPIRY_DATE,LOCK_DATE,PROFILE FROM DBA_USERS ORDER BY 1;

USERNAME                  ACCOUNT_STATUS                   EXPIRY_DATE        LOCK_DATE          PROFILE
------------------------- -------------------------------- ------------------ ------------------ ---------------
ANONYMOUS                 EXPIRED & LOCKED                 26-Jan-17 15:27:28 26-Jan-17 15:27:28 DEFAULT
APPQOSSYS                 EXPIRED & LOCKED                 26-Jan-17 14:23:28 26-Jan-17 14:23:28 DEFAULT
AUDSYS                    EXPIRED & LOCKED                 26-Jan-17 13:53:26 26-Jan-17 13:53:26 DEFAULT
CTXSYS                    EXPIRED & LOCKED                 26-Jan-17 14:57:34 26-Jan-17 14:57:34 DEFAULT
DBSFWUSER                 EXPIRED & LOCKED                 26-Jan-17 14:07:52 26-Jan-17 14:07:52 DEFAULT
DBSNMP                    EXPIRED & LOCKED                 26-Jan-17 14:23:26 26-Jan-17 14:23:26 DEFAULT
DCTXMDB                   OPEN                                                                   DEFAULT
DCTXMREPDB                OPEN                                                                   DEFAULT
DCTXMREPDB2               OPEN                                                                   DEFAULT
DIP                       EXPIRED & LOCKED                 26-Jan-17 14:05:46 26-Jan-17 14:05:46 DEFAULT
DVF                       EXPIRED & LOCKED                 26-Jan-17 15:27:28 26-Jan-17 15:27:28 DEFAULT
DVSYS                     EXPIRED & LOCKED                 26-Jan-17 15:26:39 26-Jan-17 15:26:39 DEFAULT
GGATE                     OPEN                                                                   DEFAULT
GGSYS                     EXPIRED & LOCKED                 26-Jan-17 14:24:33 26-Jan-17 14:24:33 DEFAULT
GSMADMIN_INTERNAL         EXPIRED & LOCKED                 26-Jan-17 14:04:59 26-Jan-17 14:04:59 DEFAULT
GSMCATUSER                EXPIRED & LOCKED                 26-Jan-17 14:24:27 26-Jan-17 14:24:27 DEFAULT
GSMUSER                   EXPIRED & LOCKED                 26-Jan-17 14:05:01 26-Jan-17 14:05:01 DEFAULT
HR                        EXPIRED & LOCKED                 07-Nov-19 18:35:11 07-Nov-19 18:35:11 DEFAULT
LBACSYS                   EXPIRED & LOCKED                 26-Jan-17 15:27:28 26-Jan-17 15:27:28 DEFAULT
MDDATA                    EXPIRED & LOCKED                 26-Jan-17 15:27:28 26-Jan-17 15:27:28 DEFAULT
MDSYS                     EXPIRED & LOCKED                 26-Jan-17 14:57:47 26-Jan-17 14:57:47 DEFAULT
OJVMSYS                   EXPIRED & LOCKED                 26-Jan-17 14:51:07 26-Jan-17 14:51:07 DEFAULT
OLAPSYS                   EXPIRED & LOCKED                 26-Jan-17 15:12:32 26-Jan-17 15:12:32 DEFAULT
ORACLE_OCM                EXPIRED & LOCKED                 26-Jan-17 14:09:34 26-Jan-17 14:09:34 DEFAULT
ORDDATA                   EXPIRED & LOCKED                 26-Jan-17 14:57:47 26-Jan-17 14:57:47 DEFAULT
ORDPLUGINS                EXPIRED & LOCKED                 26-Jan-17 14:57:47 26-Jan-17 14:57:47 DEFAULT
ORDSYS                    EXPIRED & LOCKED                 26-Jan-17 14:57:46 26-Jan-17 14:57:46 DEFAULT
OUTLN                     EXPIRED & LOCKED                 26-Jan-17 13:53:40 26-Jan-17 13:53:40 DEFAULT
REMOTE_SCHEDULER_AGENT    EXPIRED & LOCKED                 26-Jan-17 14:07:51 26-Jan-17 14:07:51 DEFAULT
SI_INFORMTN_SCHEMA        EXPIRED & LOCKED                 26-Jan-17 14:57:47 26-Jan-17 14:57:47 DEFAULT
SPATIAL_CSW_ADMIN_USR     EXPIRED & LOCKED                 26-Jan-17 15:15:55 26-Jan-17 15:15:55 DEFAULT
SYS                       OPEN                                                                   DEFAULT
SYS$UMF                   EXPIRED & LOCKED                 26-Jan-17 14:16:23 26-Jan-17 14:16:23 DEFAULT
SYSBACKUP                 EXPIRED & LOCKED                 26-Jan-17 13:53:27 26-Jan-17 13:53:27 DEFAULT
SYSDG                     EXPIRED & LOCKED                 26-Jan-17 13:53:27 26-Jan-17 13:53:27 DEFAULT
SYSKM                     EXPIRED & LOCKED                 26-Jan-17 13:53:27 26-Jan-17 13:53:27 DEFAULT
SYSRAC                    EXPIRED & LOCKED                 26-Jan-17 13:53:27 26-Jan-17 13:53:27 DEFAULT
SYSTEM                    OPEN                                                                   DEFAULT
WMSYS                     EXPIRED & LOCKED                 26-Jan-17 14:48:37 26-Jan-17 14:48:37 DEFAULT
XDB                       EXPIRED & LOCKED                 26-Jan-17 14:27:18 26-Jan-17 14:27:18 DEFAULT
XS$NULL                   EXPIRED & LOCKED                 26-Jan-17 14:07:19 26-Jan-17 14:07:19 DEFAULT

41 rows selected.

SQL> COL LIMIT FOR A30;
SQL> SELECT PROFILE,RESOURCE_NAME,LIMIT FROM DBA_PROFILES ORDER BY 1,2;

PROFILE                   RESOURCE_NAME                    LIMIT
------------------------- -------------------------------- --------------------------------------------------------------------------------------------------------------------------------
DEFAULT                   COMPOSITE_LIMIT                  UNLIMITED
DEFAULT                   CONNECT_TIME                     UNLIMITED
DEFAULT                   CPU_PER_CALL                     UNLIMITED
DEFAULT                   CPU_PER_SESSION                  UNLIMITED
DEFAULT                   FAILED_LOGIN_ATTEMPTS            UNLIMITED
DEFAULT                   IDLE_TIME                        UNLIMITED
DEFAULT                   INACTIVE_ACCOUNT_TIME            UNLIMITED
DEFAULT                   LOGICAL_READS_PER_CALL           UNLIMITED
DEFAULT                   LOGICAL_READS_PER_SESSION        UNLIMITED
DEFAULT                   PASSWORD_GRACE_TIME              7
DEFAULT                   PASSWORD_LIFE_TIME               UNLIMITED
DEFAULT                   PASSWORD_LOCK_TIME               1
DEFAULT                   PASSWORD_REUSE_MAX               UNLIMITED
DEFAULT                   PASSWORD_REUSE_TIME              UNLIMITED
DEFAULT                   PASSWORD_VERIFY_FUNCTION         NULL
DEFAULT                   PRIVATE_SGA                      UNLIMITED
DEFAULT                   SESSIONS_PER_USER                UNLIMITED
ORA_STIG_PROFILE          COMPOSITE_LIMIT                  DEFAULT
ORA_STIG_PROFILE          CONNECT_TIME                     DEFAULT
ORA_STIG_PROFILE          CPU_PER_CALL                     DEFAULT
ORA_STIG_PROFILE          CPU_PER_SESSION                  DEFAULT
ORA_STIG_PROFILE          FAILED_LOGIN_ATTEMPTS            3
ORA_STIG_PROFILE          IDLE_TIME                        15
ORA_STIG_PROFILE          INACTIVE_ACCOUNT_TIME            35
ORA_STIG_PROFILE          LOGICAL_READS_PER_CALL           DEFAULT
ORA_STIG_PROFILE          LOGICAL_READS_PER_SESSION        DEFAULT
ORA_STIG_PROFILE          PASSWORD_GRACE_TIME              5
ORA_STIG_PROFILE          PASSWORD_LIFE_TIME               60
ORA_STIG_PROFILE          PASSWORD_LOCK_TIME               UNLIMITED
ORA_STIG_PROFILE          PASSWORD_REUSE_MAX               10
ORA_STIG_PROFILE          PASSWORD_REUSE_TIME              365
ORA_STIG_PROFILE          PASSWORD_VERIFY_FUNCTION         ORA12C_STIG_VERIFY_FUNCTION
ORA_STIG_PROFILE          PRIVATE_SGA                      DEFAULT
ORA_STIG_PROFILE          SESSIONS_PER_USER                DEFAULT

34 rows selected.

SQL>