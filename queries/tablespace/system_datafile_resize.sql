set lines 1000 pages 1000 head off
select 'alter database datafile '''
|| file_name 
|| ''' autoextend on maxsize 5G;'
from dba_data_files where regexp_like(file_name, 'system|sysaux|undotbs1|users');
