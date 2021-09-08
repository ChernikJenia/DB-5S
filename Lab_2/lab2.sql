-- 1 задание
create tablespace TS_CES
    datafile 'c:\app\Tablespaces\TS_CES.dbf'
    size 7M
    autoextend on next 5M
    maxsize 20M
    extent management local;

-- 2 задание
create temporary tablespace TS_CES_TEMP
    tempfile 'c:\app\Tablespaces\TS_CES_TEMP.dbf'
    size 5m
    autoextend on next 3m
    maxsize 30m
    extent management local;

-- 3 задание
select FILE_NAME, TABLESPACE_NAME from DBA_DATA_FILES
union
select FILE_NAME, TABLESPACE_NAME from DBA_TEMP_FILES;

-- 4 задание
create role RL_CESCORE;

grant create session,
    create table,
    create view,
    create procedure to RL_CESCORE;

select * from dba_roles where role like 'RL_%';


select * from dba_roles;
select * from DBA_SYS_PRIVS;


-- 6 задание
create profile PF_CESCORE limit
    password_life_time 180  -- количе�?тво дней жизни парол�?
    sessions_per_user 3     -- количе�?тво �?е�?�?ий дл�? пользовател�?
    failed_login_attempts 7 -- количе�?тво попыток входа
    password_lock_time 1    -- количе�?тво дней блокировани�? по�?ле ошибки
    password_reuse_time 10  -- через �?колько дней можно повторить пароль
    password_grace_time default -- количе�?тво дней предупреждений о �?мене парол�?
    connect_time 180    -- врем�? �?оединени�?
    idle_time 30; -- минут про�?то�?

-- 7 задание
select * from DBA_PROFILES;
select * from DBA_PROFILES where PROFILE = 'PF_CESCORE';
select * from DBA_PROFILES where PROFILE = 'DEFAULT';

-- 8 задание
create user CESCORE identified by 1234
    default tablespace TS_CES quota unlimited on TS_CES
    temporary tablespace TS_CES_TEMP
    profile PF_CESCORE
    account unlock
    password expire;
    
grant RL_CESCORE to CESCORE;

create table CES_TABLE(a int);
create view CES_VIEW
  as select * from CES_TABLE;
  
drop table CES_TABLE;
drop view CES_VIEW;

-- 11 excercise
create tablespace CES_QDATA
  datafile 'c:\app\Tablespaces' 
  size 10m
  offline;
  
alter tablespace CES_QDATA online;



alter user CESCORE quota 2m on CES_QDATA;

create table T(a int)  tablespace CES_QDATA;

insert into T values (1);
insert into T values (2);
insert into T values (3);

select * from T;