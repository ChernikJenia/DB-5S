-- 1 task
select * from dba_tablespaces;

-- 2 task
create tablespace CES_QDATA
  datafile 'c:\app\tablespaces\ts_ces_qdata.dbf'
  size 10m
  autoextend on next 500k
  offline;
  
alter tablespace CES_QDATA online;


alter user u1_ces_pdb quota 2m on CES_QDATA;

--======================== login as u1_ces_pdb =============================
--select * from dba_users;

create table ces_t1 
(
  id int primary key,
  name varchar(50)
) tablespace CES_QDATA;

insert into ces_t1 values(1, 'Vasya Chel');
insert into ces_t1 values(2, 'Meal Day');
insert into ces_t1 values(3, 'Lucky Man');

select * from ces_t1;

-- 3 task
select * from dba_segments where TABLESPACE_NAME = 'CES_QDATA';
-- segment_name = 't1'

-- 4 task
drop table ces_t1;
select * from dba_segments where TABLESPACE_NAME = 'CES_QDATA';
select * from user_recyclebin;

 -- 5 task
 flashback table ces_t1 to before drop;
 
 -- 6 task
 begin
  for i in 1..10000
  loop
    insert into ces_t1 values(i, 'a');
  end loop;
  commit;
 end;
 
-- 7 task
select segment_name, segment_type, tablespace_name, bytes,
  blocks, extents, buffer_pool
  from user_segments
  where tablespace_name = 'CES_QDATA';
  
select * from user_extents where tablespace_name = 'CES_QDATA';

-- 8 task
drop tablespace CES_QDATA
  including contents and datafiles;
  
-- 9 task
select group# from v$logfile;

select group#, status, members from v$log;  


-- 10 task
select member from v$logfile;

-- 11 task
--5:21
alter system switch logfile;

-- 12 task

alter database add logfile group 4 ('c:\app\ora_jenia\oradata\orcl\redo04.log',
                                    'c:\app\ora_jenia\oradata\orcl\redo041.log',
                                    'c:\app\ora_jenia\oradata\orcl\redo042.log')
                                    size 50m blocksize 512;
                                    
  
 select * from v$log; 
                    
-- 13 task           
alter database drop logfile member 'c:\app\ora_jenia\oradata\orcl\redo04.log';
alter database drop logfile member 'c:\app\ora_jenia\oradata\orcl\redo041.log';
alter database drop logfile member 'c:\app\ora_jenia\oradata\orcl\redo042.log';

alter database drop logfile group 4;

-- 14 task
select name, log_mode from v$database;

-- 15 task
select * from v$archived_log;

-- 16 task
--  alter database archivelog; in sql plus

-- 17 task
alter system switch logfile;

select * from v$archived_log;

select * from v$log;

-- 18 task
-- alter database noacrhivelog; in sql plus

select name, log_mode from v$database;

-- 19 task
select name from v$controlfile;

-- 20 task
select * from v$controlfile_record_section;

-- 21 task
-- located in C:\app\ora_jenia\admin\orcl\pfile

-- 22 task
create pfile = 'ces_pfile.ora' from spfile;

-- located in C:\app\ora_jenia\product\12.1.0\dbhome_1\database

-- 23 task
-- password file located in C:\app\ora_jenia\product\12.1.0\dbhome_1\database

-- 24 task
select * from v$diag_info;

-- 25 task
-- log.xml location: C:\APP\ORA_JENIA\diag\rdbms\orcl\orcl\alert

