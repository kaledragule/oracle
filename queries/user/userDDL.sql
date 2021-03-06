COLUMN DDL FORMAT A300
SET HEAD OFF
SET PAGES 0
SET FEEDBACK OFF
SET LONG 9999999
SET LINES 300
SET TRIMSPOOL ON
SET VERIFY OFF
EXEC DBMS_METADATA.SET_TRANSFORM_PARAM (DBMS_METADATA.SESSION_TRANSFORM,'SQLTERMINATOR', true);
WITH objusers AS
    ( SELECT USERNAME
      FROM DBA_USERS
      WHERE USERNAME  IN ( '&1'))
SELECT DBMS_METADATA.GET_DDL('USER', USERNAME) DDL
FROM objusers
UNION ALL
SELECT DBMS_METADATA.GET_GRANTED_DDL('TABLESPACE_QUOTA', USERNAME) DDL
FROM objusers WHERE username in (SELECT username FROM dba_ts_quotas)
UNION ALL
SELECT DBMS_METADATA.GET_GRANTED_DDL('ROLE_GRANT', USERNAME) DDL
FROM objusers WHERE username in (SELECT grantee FROM dba_role_privs)
UNION ALL
SELECT DBMS_METADATA.GET_GRANTED_DDL('SYSTEM_GRANT', USERNAME) DDL
FROM objusers WHERE username in (SELECT grantee FROM dba_sys_privs)
UNION ALL
SELECT DBMS_METADATA.GET_GRANTED_DDL('OBJECT_GRANT', USERNAME) DDL
FROM objusers WHERE username in (SELECT grantee FROM dba_tab_privs);
