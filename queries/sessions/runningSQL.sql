select x.sid
      ,x.serial#
      ,x.username
      ,x.sql_id
      ,x.sql_child_number
      ,optimizer_mode
      ,hash_value
      ,address
      ,sql_text
from   v$sqlarea sqlarea
      ,v$session x
where  x.sql_hash_value = sqlarea.hash_value
and    x.sql_address    = sqlarea.address
and    x.username       is not null;
