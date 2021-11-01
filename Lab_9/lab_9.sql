
-- 1 task
grant create sequence,
      create cluster,
      create synonym,
      create public synonym,
      create view,
      create materialized view
      to U1_CES_PDB;
-- 2 task
drop sequence S1;
drop sequence S2;
drop sequence S3;
drop sequence S4;


create sequence S1
  increment by 10
  start with 1000
  nominvalue
  nomaxvalue
  nocycle
  nocache
  noorder;
  
select S1.NEXTVAL from dual;
select S1.NEXTVAL from dual;
select S1.CURRVAL from dual;

-- 3 task
create sequence S2
  increment by 10
  start with 10
  maxvalue 100
  nocycle;
-- TODO: get all secuence's values
select S2.nextval from dual;

-- 4 task

create sequence S3
  increment by -10
  start with 10
  minvalue -100
  maxvalue 10
  nocycle
  order;
 
 -- TODO: get all secuence's values 
select S3.nextval from dual; 
 
 -- 5 task
 create sequence S4
  increment by 1
  start with 1
  maxvalue 10
  cycle
  cache 5
  noorder;
  
-- TODO: show cycleness of sequence
select S4.nextval from dual;
-- 6 task
select * from sys.user_sequences;

-- 7 task
create table T1
(
  N1 number(20),
  N2 number(20),
  N3 number(20),
  N4 number(20)
) cache storage(buffer_pool keep);

begin
  for i in 1..7 loop
      insert into T1(N1, N2, N3, N4) values (S1.nextval,  S2.nextval,   S3.nextval,  S4.nextval);
    end loop;
end;

select * from T1;

-- 8 task
create cluster U1_CES_PDB.ABC
(
  X number(10),
  V varchar2(12)
) hashkeys 200;

-- 9 task
create table U1_CES_PDB.A
(
  XA number(10),
  VA varchar2(12),
  NA number(10)
) cluster ABC(XA, VA);

-- 10 task
create table U1_CES_PDB.B
(
  XB number(10),
  VB varchar2(12),
  CB char(10)
) cluster ABC(XB, VB);

-- 11 task
create table U1_CES_PDB.C
(
  XC number(10),
  VC varchar2(12),
  NC number(10)
) cluster ABC(XC, VC);

-- 12 task
select * from user_tables;
select * from user_clusters;

-- 13 task
create synonym SC for U1_CES_PDB.C;
-- TODO usage demonstrating

describe SC;

-- 14 task
create public synonym SB for CES.B;
-- TODO usage demonstrating
describe SB;

-- 15 task
create table A1
(
  NA1 int primary key,
  SA1 varchar(10)
);

create table A2
(
  NA2 int,
  SA2 varchar(10),
  foreign key(NA2) references A1(NA1)
);

insert into A1 values(1,'aaa');
insert into A1 values(3,'bbb');
insert into A1 values(2,'ccc');

insert into A2 values(1, 'LLL');
insert into A2 values(2, 'DDD');
insert into A2 values(3, 'III');

create view V1
as
  select A1.NA1, A1.SA1, A2.SA2 
    from A1 join A2
    on A1.NA1 = A2.NA2;
    
select * from V1;

-- 16 task
create materialized view MV
build immediate
refresh complete
start with sysdate
next sysdate + Interval '2' minute
as
    select A1.X, A2.Y
    from (select count(*) as X from A1) A1,
         (select count(*) as Y from A2) A2
         
select * from MV;