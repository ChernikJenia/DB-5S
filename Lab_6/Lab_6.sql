-- 1 task
select sum(value) as Total_Size from v$sga;

-- 2 task
--select pool, sum(bytes) from v$sgastat group by POOL;
select component, current_size 
  from v$sga_dynamic_components 
  where lower(COMPONENT) like '%pool';

-- 3 task
select component, granule_size 
  from v$sga_dynamic_components
  where lower(COMPONENT) like '%pool';
  
-- 4 task
select * from v$sga_dynamic_free_memory;

-- 5 task
select component, current_size 
  from v$sga_dynamic_components
  where component like '%cache';
      
-- 6 task
create table T1_KEEP( t_id int primary key)
  storage(buffer_pool keep);
  
--drop table T1_KEEP;

select segment_name, segment_type, tablespace_name, buffer_pool
  from user_segments
  where segment_name = 'T1_KEEP';
  
select * from dba_segments 
  where segment_name = 'T1_KEEP';
  
-- 7 task
create table T2_DEFAULT( t_id int primary key) cache; 
  
--drop table T2_DEFAULT;

select segment_name, segment_type, tablespace_name, buffer_pool
  from user_segments
  where segment_name = 'T2_DEFAULT';
  
select * from dba_segments 
  where segment_name = 'T2_DEFAULT';
  
-- 8 task
show parameter log_buffer;

-- 9 task
select * from v$sgastat
  where pool = 'shared pool'
  order by bytes desc
  fetch first 10 rows only;
  
-- 10 task
select component, (MAX_SIZE - CURRENT_SIZE) as FREE_SIZE
  from v$sga_dynamic_components 
  where component = 'large pool';
  
-- 11 task
select username, service_name, server
  from v$session
  where username is not null;
  
-- 12 task
select server
  from v$session
  where username is not null;
  
-- 13 task
select name, type, executions 
  from v$db_object_cache
  order by executions desc
  fetch first 10 rows only;