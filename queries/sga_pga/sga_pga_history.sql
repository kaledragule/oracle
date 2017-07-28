select sn.INSTANCE_NUMBER, sga.allo sga, pga.allo pga,(sga.allo+pga.allo) tot,trunc(SN.END_INTERVAL_TIME,'mi') time
  from
(select snap_id,INSTANCE_NUMBER,round(sum(bytes)/1024/1024/1024,3) allo 
   from DBA_HIST_SGASTAT 
  group by snap_id,INSTANCE_NUMBER) sga
,(select snap_id,INSTANCE_NUMBER,round(sum(value)/1024/1024/1024,3) allo 
    from DBA_HIST_PGASTAT where name = 'total PGA allocated' 
   group by snap_id,INSTANCE_NUMBER) pga
, dba_hist_snapshot sn 
where sn.snap_id=sga.snap_id
  and sn.INSTANCE_NUMBER=sga.INSTANCE_NUMBER
  and sn.snap_id=pga.snap_id
  and sn.INSTANCE_NUMBER=pga.INSTANCE_NUMBER
order by sn.snap_id desc, sn.INSTANCE_NUMBER
\
