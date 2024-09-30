COL CUR_USE_MB FORMAT 999999
COL CUR_SZ_MB  FORMAT 999999
COL CUR_PCT_FULL FORMAT 999
COL FREE_SPACE_MB FORMAT 999999
COL MAX_SZ_MB FORMAT 999999
COL PCT_FULL FORMAT 999

SET LINESIZE 128
SET PAGESIZE 25
SET TRIMSPOOL ON

WITH space_totals AS
      (SELECT tablespace_name, SUM(bytes)/1048576 FREE_MB, 0 TOTAL_MB, 0 MAX_MB
 	FROM dba_free_space
 	GROUP BY tablespace_name
 	UNION
 	SELECT tablespace_name, 0 CURRENT_MB, SUM(bytes)/1048576 TOTAL_MB, SUM(DECODE(maxbytes,0,bytes, maxbytes))/1048576 MAX_MB
 	FROM dba_data_files
 	GROUP BY tablespace_name
 	UNION
 	SELECT tablespace_name, 0 CURRENT_MB, SUM(bytes)/1024/1024 TOTAL_MB, SUM(DECODE(maxbytes,0,bytes, maxbytes))/1048576 MAX_MB
 	FROM dba_temp_files
 	GROUP BY tablespace_name)
/*                                                   */
SELECT tablespace_name,
       SUM(total_mb)-SUM(free_mb) CUR_USE_MB,
       SUM(total_mb) CUR_SZ_MB,
       (SUM(total_mb)-SUM(free_mb))/SUM(total_mb)*100 CUR_PCT_FULL,
       SUM(max_mb) - (SUM(total_mb)-SUM(free_mb)) FREE_SPACE_MB,
       SUM(max_mb) MAX_SZ_MB,
       (SUM(total_mb)-SUM(free_mb))/SUM(max_mb)*100 PCT_FULL
FROM space_totals
GROUP BY tablespace_name;
