SET LINESIZE 140
SET PAGESIZE 9999
COL OWNER FORMAT a10
COL OBJECT_NAME FORMAT a30
COL TYPE FORMAT a8
COL OSUSER FORMAT a10
COL USERNAME FORMAT a15
COL ORAKILL FORMAT a10
COL PROC FORMAT a9
COL DB_OSKILL FORMAT a9
SELECT d.owner, d.object_name OBJECT_NAME, d.object_type type,
    s.sid||','||s.serial# ORAKILL, s.status, s.username, s.osuser, s.process PROC,
    p.spid DB_OSKILL
FROM v$locked_object l , v$session s, dba_objects d,v$process p
WHERE s.sid = l.session_id
AND l.object_id = d.object_id
AND p.addr = s.paddr
ORDER BY 2
/
