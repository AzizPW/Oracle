#!/bin/bash
export OUTPUT=/tmp/OS_`whoami`-`hostname`-`date +%Y%m%d`.log
echo hostname: `hostname` > $OUTPUT
echo IP Address: `hostname -i` >> $OUTPUT
echo OS Version: `lsb_release -a` >> $OUTPUT
echo ----------- >> $OUTPUT
cat /etc/os-release >> $OUTPUT
echo Kernel Version: >> $OUTPUT
echo --------------- >> $OUTPUT
uname -a >> $OUTPUT
echo df -h: >> $OUTPUT
echo ------ >> $OUTPUT
df -h >> $OUTPUT
echo Detail Disk: >> $OUTPUT
echo ------------ >> $OUTPUT
lsblk >> $OUTPUT
echo cat /etc/fstab: >> $OUTPUT
echo --------------- >> $OUTPUT
cat /etc/fstab >> $OUTPUT
echo vmstat 2 15: >> $OUTPUT
echo ------------ >> $OUTPUT
vmstat 2 15 >> $OUTPUT
echo free -mt: >> $OUTPUT
echo --------- >> $OUTPUT
free -mt >> $OUTPUT
echo free -gt: >> $OUTPUT
echo --------- >> $OUTPUT
free -gt >> $OUTPUT
echo RAM Capacity: >> $OUTPUT
echo ------------- >> $OUTPUT
grep MemT /proc/meminfo >> $OUTPUT
echo Swap Capacity: >> $OUTPUT
echo -------------- >> $OUTPUT
grep SwapT /proc/meminfo >> $OUTPUT
echo Processor Threads: >> $OUTPUT
echo ------------------ >> $OUTPUT
grep "model name" /proc/cpuinfo >> $OUTPUT
echo Number of Threads: >> $OUTPUT
echo ------------------ >> $OUTPUT
grep "model name" /proc/cpuinfo | wc -l >> $OUTPUT
echo Detail Processor: >> $OUTPUT
echo ----------------- >> $OUTPUT
lscpu >> $OUTPUT
echo cat /etc/hosts: >> $OUTPUT
echo --------------- >> $OUTPUT
cat /etc/hosts >> $OUTPUT
echo Listener Background Process: >> $OUTPUT
echo ---------------------------- >> $OUTPUT
ps -ef|grep tnsl >> $OUTPUT
echo Database Background Process: >> $OUTPUT
echo ---------------------------- >> $OUTPUT
ps -ef|grep lgwr >> $OUTPUT
echo Oracle Environment: >> $OUTPUT
echo ------------------- >> $OUTPUT
env|grep ORA >> $OUTPUT
echo cat /etc/oratab: >> $OUTPUT
echo ---------------- >> $OUTPUT
cat /etc/oratab >> $OUTPUT
echo id: >> $OUTPUT
echo --- >> $OUTPUT
id >> $OUTPUT
echo ulimit -aH: >> $OUTPUT
echo ----------- >> $OUTPUT
ulimit -aH >> $OUTPUT
echo ulimit -aS: >> $OUTPUT
echo ----------- >> $OUTPUT
ulimit -aS >> $OUTPUT
echo crontab -l: >> $OUTPUT
echo ----------- >> $OUTPUT
crontab -l >> $OUTPUT
echo OPatch version: >> $OUTPUT
echo ----------- >> $OUTPUT
$ORACLE_HOME/OPatch/opatch version >> $OUTPUT
echo OPatch lspatches: >> $OUTPUT
echo ----------- >> $OUTPUT
$ORACLE_HOME/OPatch/opatch lspatches >> $OUTPUT
echo OPatch lsinventory: >> $OUTPUT
echo ----------- >> $OUTPUT
$ORACLE_HOME/OPatch/opatch lsinv >> $OUTPUT
echo File output is in:
echo /tmp/OS_`whoami`-`hostname`-`date +%Y%m%d`.log
ls -lh /tmp/OS_`whoami`-`hostname`-`date +%Y%m%d`.log
