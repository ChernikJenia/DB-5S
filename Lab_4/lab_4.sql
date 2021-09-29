-- 1 task
select name, open_mode, total_size from v$pdbs;

-- 2 task
select * from v$instance;

-- 3 task
select comp_name, version, status from dba_registry;
select * from product_component_version;

-- 4 task
--         done


-- 5 task
select name, open_mode, total_size from v$pdbs;

-- 6 task
create tablespace ts_ces_pdb
  datafile 'c:\app\tablespaces\pdb\ts_ces_pdb.dbf'
  size 10m
  autoextend on next 500k
  maxsize 100m
  extent management local;
  
create temporary tablespace ts_temp_ces_pdb
  tempfile 'c:\app\tablespaces\pdb\ts_temp_ces_pdb.dbf'
  size 10m
  autoextend on next 500k
  maxsize 100m
  extent management local;
  
drop tablespace ts_ces_pdb;
drop tablespace ts_temp_ces_pdb;

create role RL_CES_PDB;
grant create session,
      create table,
      create view,
      create procedure to RL_CES_PDB;

create profile PF_CES_PDB limit
  password_life_time 180
  sessions_per_user 3
  failed_login_attempts 7
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 30;
  
create user U1_CES_PDB identified by 1234
  default tablespace ts_ces_pdb quota unlimited on ts_ces_pdb
  temporary tablespace ts_temp_ces_pdb
  profile PF_CES_PDB
  account unlock;
  
grant RL_CES_PDB to U1_CES_PDB;

-- 7 task
------------------LOG IN AS U1_CES_PDB------------
create table CES_table
(
  a int primary key,
  b varchar(10)
)

insert into CES_table values (1, 'hello');
insert into CES_table values (2, 'lab_4');
insert into CES_table values (3, 'aboba');

select * from CES_table;

-- 8 task
select * from dba_tablespaces;
select * from dba_data_files;
select * from dba_temp_files;
select * from dba_roles;
select * from dba_tab_privs;
select * from dba_profiles;
select * from dba_role_privs;

-- 9 task
----------LOG IN TO CDB----------------
create user C##CES identified by 1234;

----------LOG IN TO PDB----------------
grant create session to C##CES;




  