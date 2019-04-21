<<<<<<< HEAD
vi stopDB.sh; chmod +x stopDB.sh;
#################################
#!/bin/bash
source /home/oraprod/PROD/12.1.0/PROD_ebsexa.env; $ORACLE_HOME/bin/lsnrctl stop PROD
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF
SHU IMMEDIATE;
EXIT;
EOF

vi startDB.sh; chmod +x startDB.sh;
###################################
#!/bin/bash
source /home/oraprod/PROD/12.1.0/PROD_ebsexa.env; $ORACLE_HOME/bin/lsnrctl start PROD
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF
STARTUP;
EXIT;
EOF

Atau
####
dbstart $ORACLE_HOME
dbshut $ORACLE_HOME

### Automatic Startup Oracle DB After Reboot ###
### Ensure /etc/oratab (Linux) or /var/opt/oracle/oratab (Solaris) marked as Y
[orekel@jeruk ~]$ vi startDB.sh
[orekel@jeruk ~]$ chmod +x startDB.sh
[orekel@jeruk ~]$ cat startDB.sh
#!/bin/bash
source /home/orekel/.bash_profile; dbstart $ORACLE_HOME
[orekel@jeruk ~]$ su -
Password:
Last login: Wed Jan 30 20:37:55 WIB 2019 on pts/0
[root@jeruk ~]# crontab -l
@reboot sh /root/devshm.sh
[root@jeruk ~]# crontab -l
@reboot sh /root/devshm.sh
@reboot su - orekel -c '/home/orekel/startDB.sh'
[root@jeruk ~]# reboot

Last login: Wed Jan 30 20:49:01 2019
[orekel@jeruk ~]$ ps -ef|grep tnsl
orekel     2036      1  0 20:49 ?        00:00:00 /z01/app/orekel/product/12102/db_1/bin/tnslsnr LISTENER -inherit
orekel     3569   3295  0 20:49 pts/0    00:00:00 grep --color=auto tnsl
[orekel@jeruk ~]$ ps -ef|grep ckpt
orekel     3160      1  1 20:49 ?        00:00:00 ora_ckpt_orange
orekel     3629   3295  0 20:49 pts/0    00:00:00 grep --color=auto ckpt
[orekel@jeruk ~]$ lsnrctl status LISTENER

LSNRCTL for Linux: Version 12.1.0.2.0 - Production on 30-JAN-2019 20:50:09

Copyright (c) 1991, 2014, Oracle.  All rights reserved.

Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=jeruk.buah.net)(PORT=1521)))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 12.1.0.2.0 - Production
Start Date                30-JAN-2019 20:49:06
Uptime                    0 days 0 hr. 1 min. 2 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /z01/app/orekel/product/12102/db_1/network/admin/listener.ora
Listener Log File         /z01/app/orekel/diag/tnslsnr/jeruk/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=jeruk.buah.net)(PORT=1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=jeruk.buah.net)(PORT=5500))(Security=(my_wallet_directory=/z01/app/orekel/admin/orange/xdb_wallet))(Presentation=HTTP)(Session=RAW))
Services Summary...
Service "orange.buah.net" has 1 instance(s).
  Instance "orange", status READY, has 1 handler(s) for this service...
Service "orangeXDB.buah.net" has 1 instance(s).
  Instance "orange", status READY, has 1 handler(s) for this service...
The command completed successfully
[orekel@jeruk ~]$ sqlplus / as sysdba

SQL*Plus: Release 12.1.0.2.0 Production on Wed Jan 30 20:50:14 2019

Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
With the Partitioning, OLAP, Advanced Analytics and Real Application Testing options

SQL> SELECT NAME,OPEN_MODE FROM V$DATABASE;

NAME      OPEN_MODE
--------- --------------------
ORANGE    READ WRITE

Elapsed: 00:00:00.02
SQL> EXIT
Disconnected from Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
With the Partitioning, OLAP, Advanced Analytics and Real Application Testing options
=======
vi stopDB.sh; chmod +x stopDB.sh;
#################################
#!/bin/bash
source /home/oraprod/PROD/12.1.0/PROD_ebsexa.env; $ORACLE_HOME/bin/lsnrctl stop PROD
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF
SHU IMMEDIATE;
EXIT;
EOF

vi startDB.sh; chmod +x startDB.sh;
###################################
#!/bin/bash
source /home/oraprod/PROD/12.1.0/PROD_ebsexa.env; $ORACLE_HOME/bin/lsnrctl start PROD
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF
STARTUP;
EXIT;
EOF

Atau
####
dbstart $ORACLE_HOME
dbshut $ORACLE_HOME

### Automatic Startup Oracle DB After Reboot ###
### Ensure /etc/oratab (Linux) or /var/opt/oracle/oratab (Solaris) marked as Y
[orekel@jeruk ~]$ vi startDB.sh
[orekel@jeruk ~]$ chmod +x startDB.sh
[orekel@jeruk ~]$ cat startDB.sh
#!/bin/bash
source /home/orekel/.bash_profile; dbstart $ORACLE_HOME
[orekel@jeruk ~]$ su -
Password:
Last login: Wed Jan 30 20:37:55 WIB 2019 on pts/0
[root@jeruk ~]# crontab -l
@reboot sh /root/devshm.sh
[root@jeruk ~]# crontab -l
@reboot sh /root/devshm.sh
@reboot su - orekel -c '/home/orekel/startDB.sh'
[root@jeruk ~]# reboot

Last login: Wed Jan 30 20:49:01 2019
[orekel@jeruk ~]$ ps -ef|grep tnsl
orekel     2036      1  0 20:49 ?        00:00:00 /z01/app/orekel/product/12102/db_1/bin/tnslsnr LISTENER -inherit
orekel     3569   3295  0 20:49 pts/0    00:00:00 grep --color=auto tnsl
[orekel@jeruk ~]$ ps -ef|grep ckpt
orekel     3160      1  1 20:49 ?        00:00:00 ora_ckpt_orange
orekel     3629   3295  0 20:49 pts/0    00:00:00 grep --color=auto ckpt
[orekel@jeruk ~]$ lsnrctl status LISTENER

LSNRCTL for Linux: Version 12.1.0.2.0 - Production on 30-JAN-2019 20:50:09

Copyright (c) 1991, 2014, Oracle.  All rights reserved.

Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=jeruk.buah.net)(PORT=1521)))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 12.1.0.2.0 - Production
Start Date                30-JAN-2019 20:49:06
Uptime                    0 days 0 hr. 1 min. 2 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /z01/app/orekel/product/12102/db_1/network/admin/listener.ora
Listener Log File         /z01/app/orekel/diag/tnslsnr/jeruk/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=jeruk.buah.net)(PORT=1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=jeruk.buah.net)(PORT=5500))(Security=(my_wallet_directory=/z01/app/orekel/admin/orange/xdb_wallet))(Presentation=HTTP)(Session=RAW))
Services Summary...
Service "orange.buah.net" has 1 instance(s).
  Instance "orange", status READY, has 1 handler(s) for this service...
Service "orangeXDB.buah.net" has 1 instance(s).
  Instance "orange", status READY, has 1 handler(s) for this service...
The command completed successfully
[orekel@jeruk ~]$ sqlplus / as sysdba

SQL*Plus: Release 12.1.0.2.0 Production on Wed Jan 30 20:50:14 2019

Copyright (c) 1982, 2014, Oracle.  All rights reserved.


Connected to:
Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
With the Partitioning, OLAP, Advanced Analytics and Real Application Testing options

SQL> SELECT NAME,OPEN_MODE FROM V$DATABASE;

NAME      OPEN_MODE
--------- --------------------
ORANGE    READ WRITE

Elapsed: 00:00:00.02
SQL> EXIT
Disconnected from Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
With the Partitioning, OLAP, Advanced Analytics and Real Application Testing options
>>>>>>> 327b5e2c2d7f1e6078f5d0c4cff716a75d749ca2
[orekel@jeruk ~]$