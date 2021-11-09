-- 1 task
declare
  f faculty%rowtype;
begin
  select * into f
    from faculty
    where faculty = 'IDIP';
  dbms_output.put_line(f.faculty || ' : ' || f.faculty_name);
exception
  when others then
    dbms_output.put_line(sqlerrm);
end;

-- 2 task
declare
  f faculty%rowtype;
begin
  select * into f
    from faculty;
  dbms_output.put_line(f.faculty || ' : ' || f.faculty_name);
exception
  when others then
    dbms_output.put_line(sqlcode || ', ' || sqlerrm);
end;

-- 3 task
declare
  f faculty%rowtype;
begin
  select * into f
    from faculty;
  dbms_output.put_line(f.faculty || ' : ' || f.faculty_name);
exception
  when too_many_rows then
    dbms_output.put_line('==== too many rows: ' || sqlerrm);
  when others then
    dbms_output.put_line('other exception');
end;

-- 4 task
declare
  p pulpit%rowtype;
  f faculty%rowtype;
begin
  select * into f
    from faculty
    where faculty = 'FIT';
  dbms_output.put_line(f.faculty || ' : ' || f.faculty_name);
exception
  when no_data_found then
    dbms_output.put_line('==== no_data_found: ' || sqlerrm);
  when others then
    dbms_output.put_line('other exception');
end;

declare
  p pulpit%rowtype;
  
  b1 boolean;
  b2 boolean;
  b3 boolean;
begin
  select * into p
    from pulpit
    where pulpit = 'OH';
  
  b1 := sql%found;
  b2 := sql%notfound;
  b3 := sql%isopen;
  
  if b1 then
    dbms_output.put_line('found: TRUE');
  else
     dbms_output.put_line('found: FALSE');
  end if;
   
  if b2 then
    dbms_output.put_line('notfound: TRUE');
  else
     dbms_output.put_line('notfound: FALSE');  
   end if;
   
  if b3 then
    dbms_output.put_line('isOpen: TRUE');
  else
     dbms_output.put_line('isOpen: FALSE');  
  end if;
end;
select * from auditorium;


-- 5 task
declare
  a auditorium%rowtype;
  
  b1 boolean;
  b2 boolean;
  b3 boolean;
begin
  update auditorium 
    set auditorium = '206-2'
    where auditorium = '206-1';
  
  rollback;  
    
  b1 := sql%found;
  b2 := sql%notfound;
  b3 := sql%isopen;
  
  if b1 then
    dbms_output.put_line('found: TRUE');
  else
     dbms_output.put_line('found: FALSE');
  end if;
   
  if b2 then
    dbms_output.put_line('notfound: TRUE');
  else
     dbms_output.put_line('notfound: FALSE');  
   end if;
   
  if b3 then
    dbms_output.put_line('isOpen: TRUE');
  else
     dbms_output.put_line('isOpen: FALSE');  
  end if;
    
  exception 
    when others then
    dbms_output.put_line(sqlerrm);
end;

-- 6 task
begin
  update faculty 
    set faculty = 'TEST'
    where faculty = 'IDIP';
    
  exception 
    when others then
    begin
      dbms_output.put_line(sqlerrm);
      rollback;
    end;
end;

-- 7 task
declare
  b1 boolean;
  b2 boolean;
  b3 boolean;
begin
  insert into faculty values('TEST', 'Test faculty'); 
    
  b1 := sql%found;
  b2 := sql%notfound;
  b3 := sql%isopen;  
        
  if b1 then
    dbms_output.put_line('found: TRUE');
  else
     dbms_output.put_line('found: FALSE');
  end if;
   
  if b2 then
    dbms_output.put_line('notfound: TRUE');
  else
     dbms_output.put_line('notfound: FALSE');  
   end if;
   
  if b3 then
    dbms_output.put_line('isOpen: TRUE');
  else
     dbms_output.put_line('isOpen: FALSE');  
  end if;  
   
  rollback;
  
  exception 
    when others then
      dbms_output.put_line(sqlerrm);
end;

-- 8 task
begin
  insert into pulpit values(null, 123, 'IDIP');
exception
  when others then
    dbms_output.put_line(sqlerrm);
end;

-- 9 task
declare
  b1 boolean;
  b2 boolean;
  b3 boolean;
begin
  delete from auditorium where auditorium = '132-4'; 
    
  b1 := sql%found;
  b2 := sql%notfound;
  b3 := sql%isopen;        
  
  if b1 then
    dbms_output.put_line('found: TRUE');
  else
     dbms_output.put_line('found: FALSE');
  end if;
   
  if b2 then
    dbms_output.put_line('notfound: TRUE');
  else
     dbms_output.put_line('notfound: FALSE');  
   end if;
   
  if b3 then
    dbms_output.put_line('isOpen: TRUE');
  else
     dbms_output.put_line('isOpen: FALSE');  
  end if;  
   
  rollback;
  
  exception 
    when others then
      dbms_output.put_line(sqlerrm);
end;

-- 10 task
select * from auditorium_type;
begin
  delete from auditorium_type
    where auditorium_type = 'LK';
exception
  when others then
    rollback;
    dbms_output.put_line(sqlerrm);
end;

-- 11 task
declare
  cursor t_curs is select teacher, teacher_name, pulpit
    from teacher;
    
  c_t teacher.teacher%type;
  c_name teacher.teacher_name%type;
  c_pulp teacher.pulpit%type;
begin
  open t_curs;
  
  loop
    fetch t_curs into c_t, c_name, c_pulp;
    dbms_output.put_line(t_curs%rowcount || ' ' || c_t || ' ' || c_name || ' ' || c_pulp);
  exit when t_curs%notfound;  
  end loop;
  
  close t_curs;
  
  exception
  when others then
    dbms_output.put_line(sqlerrm);
end;

-- 12 task
declare
  cursor s_curs is select *
    from subject;
    
  s_record subject%rowtype;
begin
  open s_curs;
  
  fetch s_curs into s_record;
  
  while (s_curs%found)
  loop
    dbms_output.put_line(s_curs%rowcount || ' ' || s_record.subject || ' ' || s_record.subject_name || ' ' || s_record.pulpit);  
    fetch s_curs into s_record;
  end loop;
  
  close s_curs;
  
  exception
  when others then
    dbms_output.put_line(sqlerrm);
end;

-- 13 task
declare
  cursor t_curs is select teacher, teacher_name, pulpit_name 
    from teacher
    join pulpit
    on pulpit.pulpit = teacher.pulpit;
  
begin

  for t in t_curs
  loop
    dbms_output.put_line(t_curs%rowcount ||  ' ' || t.teacher || ' ' || t.teacher_name || ', PULPIT =  ' || t.pulpit_name );
  end loop;
  
  exception
  when others then
    dbms_output.put_line(sqlerrm);
end;

-- 14 task
declare
  cursor a_curs(c1 auditorium.auditorium_capacity%type, c2 auditorium.auditorium_capacity%type)
    is select auditorium, auditorium_capacity
      from auditorium
      where auditorium_capacity >= c1 and auditorium_capacity <= c2;
      
begin
  dbms_output.put_line('<20:');
  for a1 in a_curs(0, 19)
  loop
    dbms_output.put_line(a1.auditorium || ' ' || a1.auditorium_capacity);
  end loop;
  
  dbms_output.put_line('21-30:');
  for a1 in a_curs(21, 30)
  loop
    dbms_output.put_line(a1.auditorium || ' ' || a1.auditorium_capacity);
  end loop;

  dbms_output.put_line('31-60:');
  for a1 in a_curs(31, 60)
  loop
    dbms_output.put_line(a1.auditorium || ' ' || a1.auditorium_capacity);
  end loop;

  dbms_output.put_line('61-80:');
  for a1 in a_curs(61, 80)
  loop
    dbms_output.put_line(a1.auditorium || ' ' || a1.auditorium_capacity);
  end loop;

  dbms_output.put_line('>81:');
  for a1 in a_curs(82, 1000)
  loop
    dbms_output.put_line(a1.auditorium || ' ' || a1.auditorium_capacity);
  end loop;

  exception
  when others then
    dbms_output.put_line(sqlerrm);
end;


-- 15 task (sqlplus)
variable x refcursor;
    declare 
      type teacher_name is ref cursor return teacher%rowtype;
      xcurs teacher_name;
    begin
      open xcurs for select * from teacher;
      :x :=xcurs;
    end;
    
    print x;
    
-- 16 task ($#@$@U#$@#()$@)
 declare 
        cursor curs_aut is select auditorium_type,
              cursor (select auditorium from auditorium aum
                      where aut.auditorium_type = aum.auditorium_type)
                      from auditorium_type aut;
        curs_aum sys_refcursor;
        aut auditorium_type.auditorium_type%type;
        txt varchar2(1000);
        aum auditorium.auditorium%type;
    begin
      open curs_aut;
      fetch curs_aut into aut, curs_aum;
      while(curs_aut%found)
      loop
        txt := rtrim(aut) || ':';
        loop
          fetch curs_aum into aum;
          exit when curs_aum%notfound;
            txt := txt || ', ' || rtrim(aum);
        end loop;
        dbms_output.put_line(aum);
        fetch curs_aut into aut, curs_aum;
      end loop;
      close curs_aut;
    end;
    
-- 17 task
  declare 
      cursor cur(cap1 auditorium.auditorium%type, cap2 auditorium.auditorium%type)
            is select auditorium, auditorium_capacity from auditorium
            where auditorium_capacity between cap1 and cap2 for update;
      aum auditorium.auditorium%type;
      cap auditorium.auditorium_capacity%type;
    begin
      open cur(40, 80);
      fetch cur into aum, cap;
      while(cur%found)
      loop
          cap := cap * 0.9;
          update auditorium set auditorium_capacity = cap
            where current of cur;
          dbms_output.put_line(' '||aum||' '||cap);
          fetch cur into aum, cap;
      end loop;
      close cur; rollback;
   end;
   
-- 18 task
declare 
  cursor cur(c1 auditorium.auditorium_capacity%type, c2 auditorium.auditorium_capacity%type)
    is select auditorium, auditorium_capacity from auditorium
      where auditorium_capacity between c1 and c2 for update;
      
  aum auditorium.auditorium%type;
  cap auditorium.auditorium_capacity%type;
begin
  open cur(0, 20);
  fetch cur into aum, cap;
  while(cur%found)
  loop
    delete from auditorium where current of cur;
    fetch cur into aum, cap;
  end loop;
  close cur;
  
  for pp in cur(0,120) loop
        dbms_output.put_line(pp.auditorium||' '||pp.auditorium_capacity);
      end loop;
  
  rollback;
end;

-- 19 task
declare
    cursor cur(capacity auditorium.auditorium%type)
            is select auditorium, auditorium_capacity, rowid
            from auditorium
            where auditorium_capacity >=capacity for update;
      aum auditorium.auditorium%type;
      cap auditorium.auditorium_capacity%type;
    begin
      for xxx in cur(80)
      loop
        if xxx.auditorium_capacity >=80
          then update auditorium
          set auditorium_capacity = auditorium_capacity+3
          where rowid = xxx.rowid;
        end if;
      end loop;
      for yyy in cur(80)
      loop
        dbms_output.put_line(yyy.auditorium||' '||yyy.auditorium_capacity);
      end loop; rollback;
   end;

-- 20 task
  declare 
      cursor curs_teacher is select teacher, teacher_name, pulpit
          from teacher;
      m_teacher teacher.teacher%type;
      m_teacher_name teacher.teacher_name%type;
      m_pulpit teacher.pulpit%type;
      k integer :=1;
    begin
      open curs_teacher;
      loop
        fetch curs_teacher into m_teacher, m_teacher_name, m_pulpit;
        exit when curs_teacher%notfound;
        DBMS_OUTPUT.PUT_LINE(' '||curs_teacher%rowcount||' '
                            ||m_teacher||' '
                            ||m_teacher_name||' '
                            ||m_pulpit);
          if (k mod 3 = 0) then 
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------'); 
          end if;
          k:= k + 1;
        end loop;
        DBMS_OUTPUT.PUT_LINE('rowcount = '|| curs_teacher%rowcount);
        close curs_teacher;
        exception
          when others then
            DBMS_OUTPUT.PUT_LINE(sqlerrm);
      end;