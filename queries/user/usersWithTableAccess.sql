select Grantee,'Granted Through Role' as Grant_Type, role, table_name
from role_tab_privs rtp, dba_role_privs drp
where rtp.role = drp.granted_role
and table_name = '&&TABLE_NAME'
union
select Grantee,'Direct Grant' as Grant_type, null as role, table_name
from dba_tab_privs
where table_name = '&TABLE_NAME' ;
