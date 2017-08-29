set lines 300 pages 200 head off
select 'alter database datafile '''
|| file_name 
|| ''' autoextend on maxsize 5G;'
from dba_data_files where regexp_like(file_name, 'system|sysaux|undotbs1|users')
Union
select 'alter database tempfile '''
|| file_name 
|| ''' autoextend on maxsize 10G;'
from dba_temp_files where regexp_like(file_name, 'temp');
