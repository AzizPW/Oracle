--Auto Extend Table Space Scripts (Doc ID 1908578.1)

SELECT a.tablespace_name, SUM(a.bytes)/1024/1024 "CurMB",
SUM(decode(b.maxextend, null, A.BYTES/1024/1024, b.maxextend*8192/1024/1024)) "MaxMB",
(SUM(a.bytes)/1024/1024 - round(c."Free"/1024/1024)) "TotalUsed",
(SUM(decode(b.maxextend, null, A.BYTES/1024/1024, b.maxextend*8192/1024/1024)) - (SUM(a.bytes)/1024/1024 - round(c."Free"/1024/1024))) "TotalFree",
round(100*(SUM(a.bytes)/1024/1024 - round(c."Free"/1024/1024))/(SUM(decode(b.maxextend, null, A.BYTES/1024/1024, b.maxextend*8192/1024/1024)))) "UPercent"
from
dba_data_files a, sys.filext$ b,
(SELECT d.tablespace_name , sum(nvl(c.bytes,0)) "Free" FROM dba_tablespaces d,DBA_FREE_SPACE c where d.tablespace_name = c.tablespace_name(+) group by d.tablespace_name) c
where a.file_id = b.file#(+)
and a.tablespace_name = c.tablespace_name
GROUP by a.tablespace_name, c."Free"/1024
order by round(100*(SUM(a.bytes)/1024/1024 - round(c."Free"/1024/1024))/(SUM(decode(b.maxextend, null, A.BYTES/1024/1024, b.maxextend*8192/1024/1024)))) desc;

select substr(tablespace_name,1,15) "tbs",substr(file_name,1,65) "auto extend data file",(MAXBYTES/1024)/1024 "MAXMEGA",
case when b.block_size=2048 then increment_by*2/1024
when b.block_size=4096 then increment_by*4/1024
when b.block_size=8192 then increment_by*8/1024
when b.block_size=16384 then increment_by*16/1024
when b.block_size=32768 then increment_by*32/1024 end "incr. /MB",
(b.CREATE_BYTES/1024)/1024 "CREATED MEGA",(a.BYTES/1024)/1024 "MB REACHED",b.block_size
from dba_data_files a,V$DATAFILE b where AUTOEXTENSIBLE='YES'AND b.FILE#=a.FILE_ID
union
select substr(tablespace_name,1,15) "tbs",substr(file_name,1,65) "auto extend data file",(MAXBYTES/1024)/1024 "MAXMEGA",
case when b.block_size=2048 then increment_by*2/1024
when b.block_size=4096 then increment_by*4/1024
when b.block_size=8192 then increment_by*8/1024
when b.block_size=16384 then increment_by*16/1024
when b.block_size=32768 then increment_by*32/1024 end "incr. /MB",
(b.CREATE_BYTES/1024)/1024 "CREATED MEGA",(a.BYTES/1024)/1024 "MB REACHED",b.block_size
from dba_temp_files a,V$tempfile b where AUTOEXTENSIBLE='YES'AND b.FILE#=a.FILE_ID;