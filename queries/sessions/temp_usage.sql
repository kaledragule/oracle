COLUMN kill FORMAT a13
COLUMN osuser FORMAT A15
COLUMN program FORMAT A28
COLUMN segfile# FORMAT 99999
COLUMN segblk# a7
COLUMN size_mb FORMAT 999,999
COLUMN ts_name FORMAT A8
COLUMN username FORMAT A12
SET LINESIZE 160
SET PAGESIZE 66
SET TRIMSPOOL ON

SELECT b.tablespace ts_name, b.segfile#, b.segblk#
       , ROUND(((b.blocks*p.value)/1048576), 2) size_mb
       , a.sid||','||a.serial# kill, a.username, a.osuser
       , a.program, a.status
FROM v$session a, v$sort_usage b, v$process c, v$parameter p
WHERE p.NAME = 'db_block_size'
AND a.saddr = b.session_addr
AND a.paddr = c.addr
ORDER BY size_mb DESC
