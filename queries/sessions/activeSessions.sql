SELECT SID, Serial#, UserName, Status, SchemaName, Logon_Time
FROM V$Session
WHERE
Status='ACTIVE' AND
UserName IS NOT NULL;
