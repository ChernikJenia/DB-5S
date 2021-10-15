-- 1 task
select name, description from v$bgprocess;

-- 2 task 
select name, description 
  from v$bgprocess
  where paddr != hextoraw('00');

-- 3 task
select name, description
  from v$bgprocess 
  where name like 'DBW%';
  
-- 4 task
select serial#, username, status, server 
  from v$session;
  
-- 5 task
select serial#, username, type
  from v$session;
  
-- 6 task
select name, network_name, pdb
  from v$services;
  
-- 7 task
show parameter dispatcher;


-- 8 task 
-- OracleOraDB12Home1TNSListener	

-- 9 task
select serial#, username, status, server 
  from v$session;
  
-- 10 task
-- C:\app\ora_jenia\product\12.1.0\dbhome_1\NETWORK\ADMIN\listener.ora

-- 11 task
-- doneeeeeeeeeeeeeeeeeeeeeeee
-- 12 task
select name, network_name, pdb
  from v$services;
--  lsnrctl -> services