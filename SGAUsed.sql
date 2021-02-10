--SGA Used
SELECT ROUND(used.bytes/1024/1024/1024,2) used_gb, ROUND(free.bytes/1024/1024/1024,2) free_gb, ROUND(total.bytes/1024/1024/1024,2) total_gb
FROM (SELECT SUM(bytes) bytes FROM v$sgastat WHERE name != 'free memory') used, (SELECT SUM(bytes) bytes FROM v$sgastat WHERE name = 'free memory') free, (SELECT SUM(bytes) bytes FROM v$sgastat) total;