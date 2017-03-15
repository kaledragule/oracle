begin
dbms_stats.gather_database_stats(
options=>'gather auto',
estimate_percent=>100,
degree=>16) ;
end;
/
