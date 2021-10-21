-- 1 task
--  C:\app\ora_jenia\product\12.1.0\dbhome_1\NETWORK\ADMIN

-- 2 task
-- connect system/Pass1234@localhost:1521/orcl
show parameter instance;

-- 3 task
-- connect system/Pass1234@localhost:1521/ces_pdb
select * from dba_tablespaces;
select * from dba_data_files;
select * from dba_roles;
select * from dba_users;

-- 4 task
-- regedit -> HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE

-- 5 task
-- done (Net manager)

-- 6 task
-- sqlplus system@ces_pdb_ces_pdb

-- 7 task
select * from CES_TABLE;

-- 8 task
-- ====== SQLPLUS =======
set timing on
select * from dba_tablespaces;

-- 9 task
-- == SQLPLUS == 
describe dba_tablespaces;

-- 10 task
select * from dba_segments
  where owner = 'U1_CES_PDB';

-- 11 task
-- login as SYS

create view lab8_task11
as
select count(*) as segment_count,
       sum(extents) as extent_count,
       sum(blocks) as block_count,
       sum(bytes) as byte_count
  from dba_segments;

select * from lab8_task11;
