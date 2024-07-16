### Oracle DB
#############
SET LINESIZE 200 PAGESIZE 5000;
SELECT USERNAME, SID, SERIAL#, PROGRAM FROM V$SESSION WHERE USERNAME IS NOT NULL ORDER BY LOGON_TIME;

EXPLAIN PLAN FOR query_statement;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(SQL_ID=>'gr8j48fxfddkt', FORMAT=>'+ALLSTATS'));

SELECT t.*
FROM v$sql s, table(DBMS_XPLAN.DISPLAY_CURSOR(s.sql_id, s.child_number)) t WHERE 
sql_text LIKE '%TOTO%';

OWNER
INDEX_NAME
INDEX_TYPE
TABLE_OWNER
TABLE_NAME
TABLE_TYPE
UNIQUENESS
COMPRESSION

SELECT /*+PARALLEL(4)*/ OWNER||'.'||INDEX_NAME IDX, TABLE_OWNER||'.'||TABLE_NAME TBL, LOGGING, STATUS FROM DBA_INDEXES
WHERE TABLE_OWNER||'.'||TABLE_NAME='MANDIRIMAIN.CS_CASE_DETAILS';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(SQL_ID=>'&sql_id'));

### PostgreSQL
##############
-bash-4.2$ psql -U postgres -d dvdrental
psql (12.2)
Type "help" for help.

dvdrental=# SELECT address_id, address, district, phone FROM address WHERE phone = '223664661973';
 address_id |      address       | district  |    phone
------------+--------------------+-----------+--------------
         85 | 320 Baiyin Parkway | Mahajanga | 223664661973
(1 row)

dvdrental=# explain SELECT address_id, address, district, phone FROM address WHERE phone = '223664661973';
                       QUERY PLAN
---------------------------------------------------------
 Seq Scan on address  (cost=0.00..15.54 rows=1 width=45)
   Filter: ((phone)::text = '223664661973'::text)
(2 rows)

dvdrental=# explain analyze SELECT address_id, address, district, phone FROM address WHERE phone = '223664661973';
                                            QUERY PLAN
---------------------------------------------------------------------------------------------------
 Seq Scan on address  (cost=0.00..15.54 rows=1 width=45) (actual time=0.019..0.081 rows=1 loops=1)
   Filter: ((phone)::text = '223664661973'::text)
   Rows Removed by Filter: 602
 Planning Time: 0.046 ms
 Execution Time: 0.092 ms
(5 rows)

dvdrental=# create index ix_phone_film on address (phone);
CREATE INDEX
dvdrental=# SELECT address_id, address, district, phone FROM address WHERE phone = '223664661973';
 address_id |      address       | district  |    phone
------------+--------------------+-----------+--------------
         85 | 320 Baiyin Parkway | Mahajanga | 223664661973
(1 row)

dvdrental=# explain SELECT address_id, address, district, phone FROM address WHERE phone = '223664661973';
                                  QUERY PLAN
------------------------------------------------------------------------------
 Index Scan using ix_phone_film on address  (cost=0.28..8.29 rows=1 width=45)
   Index Cond: ((phone)::text = '223664661973'::text)
(2 rows)

dvdrental=# explain analyze SELECT address_id, address, district, phone FROM address WHERE phone = '223664661973';
                                                       QUERY PLAN
------------------------------------------------------------------------------------------------------------------------
 Index Scan using ix_phone_film on address  (cost=0.28..8.29 rows=1 width=45) (actual time=0.020..0.021 rows=1 loops=1)
   Index Cond: ((phone)::text = '223664661973'::text)
 Planning Time: 0.059 ms
 Execution Time: 0.033 ms
(4 rows)

dvdrental=# SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'address';
   indexname    |                                  indexdef
----------------+-----------------------------------------------------------------------------
 address_pkey   | CREATE UNIQUE INDEX address_pkey ON public.address USING btree (address_id)
 idx_fk_city_id | CREATE INDEX idx_fk_city_id ON public.address USING btree (city_id)
 ix_phone_film  | CREATE INDEX ix_phone_film ON public.address USING btree (phone)
(3 rows)

dvdrental=#