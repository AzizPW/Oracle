SET LINES 200 PAGES 5000;
SELECT A.INSTANCE_NUMBER,A.SNAP_ID,TO_CHAR(BEGIN_INTERVAL_TIME,'YYYY-MM-DD HH24:MI:SS') TIME, AVG(VALUE) "PGA CACHE RATIO" FROM WRH$_PGASTAT A
JOIN DBA_HIST_SNAPSHOT B ON A.SNAP_ID=B.SNAP_ID AND A.INSTANCE_NUMBER=B.INSTANCE_NUMBER WHERE EXISTS(SELECT DISTINCT SNAP_ID FROM DBA_HIST_SNAPSHOT
WHERE(TO_CHAR(BEGIN_INTERVAL_TIME,'YYYY-MM-DD HH24:MI:SS') BETWEEN '2014-10-14 08:00' AND '2014-10-21 18:00') AND A.SNAP_ID=SNAP_ID) AND NAME='CACHE HIT PERCENTAGE'
AND A.INSTANCE_NUMBER=1 GROUP BY A.INSTANCE_NUMBER,A.SNAP_ID ,TO_CHAR(BEGIN_INTERVAL_TIME,'YYYY-MM-DD HH24:MI:SS') ORDER BY A.SNAP_ID;
