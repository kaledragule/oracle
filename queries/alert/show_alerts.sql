SELECT
    TO_CHAR(a.originating_timestamp, 'dd.mm.yyyy hh24:mi:ss') message_time,
    message_text
FROM v$diag_alert_ext a
WHERE a.originating_timestamp > sysdate-1
AND component_id='rdbms'
ORDER BY 1 DESC
/
