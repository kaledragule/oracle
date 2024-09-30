COLUMN DUMMY NOPRINT;
COLUMN Object FORMAT a40
COLUMN Type FORMAT a17
SET PAGESIZE 55
COMPUTE SUM OF MB ON DUMMY;
BREAK ON DUMMY;
SELECT NULL DUMMY,segment_name Object,segment_type Type,
       SUM(bytes) / (1024*1024) MB
    FROM dba_segments
    WHERE segment_name LIKE UPPER('&Name')
    GROUP BY segment_name,segment_type
    ORDER BY MB
/
