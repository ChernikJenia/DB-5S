-- 1 task
begin
  
end;

-- 2 task
begin
  DBMS_OUTPUT.put_line ('Hello World!');
end;

-- 3 task
declare 
  x number(3) := 3;
  y number(3) := 0;
  z number(3, 2);
begin
  z := x / y;
  
  exception
    when ZERO_DIVIDE
    then dbms_output.put_line('error = ' || sqlcode || ', ' || sqlerrm );
end;

-- 4 task
declare 
  x number(3) := 3;
  y number(3) := 0;
  z number(3, 2);
begin
  dbms_output.put_line('x=' || x || ', y=' || y);
  begin
  z := x / y;
  exception
    when others
    then dbms_output.put_line('inner block: error = ' || sqlcode || ', ' || sqlerrm );
    end;
exception
    when others
    then dbms_output.put_line('outer block: error = ' || sqlcode || ', ' || sqlerrm );
    end;


-- 5 task
-- connect as system
show parameter plsql_warnings;

select * from v$parameter 
  where name = 'plsql_warnings';
  
-- 6 task
select keyword from v$reserved_words
  where regexp_like(keyword, '^[^a-zA-Z]{1,2}$');
  
-- 7 task
select keyword from v$reserved_words
  minus 
select keyword from v$reserved_words
  where regexp_like(keyword, '^[^a-zA-Z]{1,2}$'); 
  
  
-- 8 task
select * from v$parameter 
  where name like 'plsql%';

show parameter plsql;

-- 9 task
declare
        c1 number(3)        := 25;
        c2 number(3)        := 10;
        div number(10,2);
        fix number(10,2)    := 3.12;
        otr number(4, -5)   := 32.12345;
        en number(32,10)    := 12345E-10;
        bf binary_float     := 123456789.12345678911;
        bd binary_double    := 123456789.12345678911;
        b1 boolean          := true;
    
    begin
        div := mod(c1,c2);
        dbms_output.put_line('c1 = '||c1);
        dbms_output.put_line('c2 = '||c2);
        dbms_output.put_line('c1%c2 = '||div);
        
        dbms_output.put_line('fix = '||fix);
        dbms_output.put_line('otr = '||otr);
        dbms_output.put_line('en = '||en);
        dbms_output.put_line('bf = '||bf);
        dbms_output.put_line('bd = '||bd);
        if b1 then dbms_output.put_line('b1 = '||'true'); end if;
    end;
    
    
-- 18 task (10)
declare
  v1 constant varchar(2) := 'AA';
  c1 constant char := 'A';
  n1 constant number(5) := 5;
begin
  dbms_output.put_line('v1=' || v1);
  dbms_output.put_line('c1=' || c1);
  dbms_output.put_line('n1=' || to_char(n1 + 4));
end; 

-- 19 task
declare 
  pulpit ces.pulpit.pulpit%type;
  faculty pulpit%type;
begin
  pulpit := 'ISIT';
  faculty := 'IDIP';
  
  dbms_output.put_line('pulpit=' || pulpit);
  dbms_output.put_line('faculty=' || faculty);
end;
  
-- 20 task
declare
  faculty_rec ces.faculty%rowtype;
begin
  faculty_rec.faculty := 'IDIP';
  faculty_rec.faculty_name := 'aaaaaaaaaaaaaa';
  
  dbms_output.put_line(trim(faculty_rec.faculty) || ': ' ||  faculty_rec.faculty_name);
end;

-- 21 task
declare
  a number(3) := 10;
begin
  if a = 2 then
    dbms_output.put_line('a=2');
  elsif a > 3 then
    dbms_output.put_line('a>3');
  else
    dbms_output.put_line('a=' || a);
  end if;
end;

-- 22 task
 declare
    x pls_integer := 17;
begin
    case x
        when 17 then dbms_output.put_line('17');
    end case;
    
    case
        when 8 > x then dbms_output.put_line('8>'||x);
        when x between 13 and 20 then dbms_output.put_line('[13;20]');
        else dbms_output.put_line('else');
    end case;
end;

-- 23 task
declare 
  i number(3) := 0;
begin
  loop
    dbms_output.put_line(i);
    i := i + 1;
  exit when i > 5;
  end loop;
end;

-- 24 task
declare 
  i number(3) := 0;
begin
  while(i <= 5)
  loop
    dbms_output.put_line(i);
    i := i + 1;
  end loop;
end;

-- 25 task
begin
  for i in 0..5
  loop
    dbms_output.put_line(I);
  end loop;
end;

