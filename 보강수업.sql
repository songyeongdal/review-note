-- ���� �⺻ : asc
-- ���ڴ� ����������, ���ڴ� ����������, ��¥�� ������¥����, null�� ���� ������
select * from employees 
order by salary ;
-- �������� : desc

select * from employees
order by salary desc;

-- �μ���ȣ�� ��������, �м���ȣ�� ������� ������ ��������
select department_id, salary from employees
order by department_id, salary desc ;                     -- ������� �����ϴ°� ����.

select * from employees
order by employee_id, hire_date desc ;

-- ���ڱ��̸� ���ϱ�
-- length : �÷��� ���ڿ� ���̸� ��ȯ, ������ ������ ���ڿ��� ����
-- lengthb : �÷��� ���ڿ� ����Ʈ���� ��ȯ��
-- ������(1����Ʈ) ����(1����Ʈ) �ѱ�(3����Ʈ)
select first_name, length(first_name), lengthb(first_name) from employees ;

-- lower : �ҹ��ڷ� ��ȯ
select first_name, lower(first_name) from employees ;

-- upper : �빮�ڷ� ��ȯ
select first_name, upper(first_name) from employees;

-- substr : ���ڿ��� ����
-- substr('jones',2) ���ڿ��� �ι�° ��ġ �� o���� ������ �ڸ���
select substr('jones', 2) from dual ;
select substr('jones', 1, 2) from dual;     -- j���� o����(1��°���� 2��°����)

select first_name, substr(first_name, 1, 4) from employees;
select first_name, substr(first_name, 3) from employees;     -- 3��°���� ������ ���ڸ� �߶� ������
select first_name, substr(first_name, -1) from employees ;   -- -1�� ���� ��������

--  dual�� ����Ŭ ��ü ���� ���̺�� �ѿ��� �̷���� �ӽ����̺��̴�.
-- �ַ� ����ڰ� �Լ�(���)�� �Ҷ� �ӽ÷� ����Ѵ�.
--select sysdate from dual (���糯¥)

select '1'+'2' from dual ;
-- ���� ���� ���ϱ� ���ڴ� �Ұ����ѵ� ����Ŭ���� ���ش�.

-- instr : Ư��������ġã��. 'hello.txt', '.' -> hello.txt���� .�� ��ġ�� ã����
select 'hello.txt', instr('hello.txt', '.'), substr('hello.txt', instr('hello.txt','.')+1)
from dual;

-- 'studata.sql'���� sql �����غ���

select 'studata.sql', instr('studata.sql', '.'), substr('studata.sql', instr('studata.sql','.')+1)
from dual;
select substr('studata.sql',9) from dual;

create table member(
id varchar2(20) primary key,
pw varchar2(20),
name varchar2(20),
phone VARCHAR2(20),
create_date date
);

insert into member(id, pw, name, phone)
values('aaa', '       1111', 'ȫ      �浿', '010-1111-111      ');
commit;
select * from member;

select length(pw) from member;

-- replace : ���ڴ�ü, ���� ���� �ٲ��ش� -> ������ ������ ������ ������ִ�
select name from member;
select name, replace(name, ' ', '') from member; 

-- trim, ltrim, rtrim
-- trim : ���ڿ��� ���� ������ ����
-- ltrim : ���ڿ� ���� ��������
-- rtrim : ���ڿ� ������ ��������

select trim('     ����     '),
    ltrim  (rtrim('        ��������       ')) from dual; 

-- update set�� Ȱ���ؼ� ������ ���Ž�Ű�� �����ϱ�
update member set pw = ltrim(pw) ;
commit;

select phone, length(phone) from member;
-- �� ��ȣ�� ������ �����Ͽ� �����غ�����

update member set phone = rtrim(phone);
commit;
select * from member;
update member set phone = replace(phone, ' ', '');

--concat : ���ڿ� ��ġ��
select concat(id, concat('-',pw)) from member;
select id||'-'||pw from member;

select first_name, last_name from employees ;
select first_name || ' ' || last_name as "�̸�" from employees;

-- Ư�� ���� ä��� : lpad, rpad
select rpad(id, 10 , '*') from member ;    -- �� 10�ڸ��� ����µ� �ڿ� ���� �ڸ��� *�� ä����

-- sysdate : ���� �ð�(��¥)
select sysdate, sysdate+1, sysdate-1 from dual ;
-- months_between : �� ��¥ ���̰� ������� ��ȯ
select first_name, sysdate, hire_date, months_between(sysdate, hire_date) from employees;

select sysdate, '23/10/07', months_between(sysdate, to_date('23/10/07')) from dual;  -- to_date : ��¥�� �ٲ��ִ� �Լ�
 
-- ��add months()
select sysdate, add_months(sysdate, 6) from dual ;

-- to_char() ���������� ��ȯ�ϴ� �Լ�
select sysdate,
        to_char(sysdate, 'YY'),
        to_char(sysdate, 'YYYY'),
        to_char(sysdate, 'MM'),
        to_char(sysdate, 'MON'),
        to_char(sysdate, 'YYYYMMDD'),
        to_char(to_date('20171008'), 'YYYYMMDD')    -- ����Ŭ���� ���ڸ� �˾Ƽ� ��¥�� �ν����� ���ϴµ�. to_date�� �ٿ���� ��¥�� �ν��ϴµ�
        FROM DUAL;
        
-- to_number() : ���ڷ� ��ȯ
select to_number('123') from dual ;

-- to_date() �������� ��¥������ ��ȯ�ϴ� �Լ�
select to_date('20171007', 'YYYYMMDD') from dual ;

-- �������� �Լ���
-- abs : ���밪
select -10, abs(-10) from dual ;

select floor(10.3245) from dual ;  -- floor : ����
-- round : �ݿø�
select round(10.3245) from dual ;
select round(10.3455, 3) from dual ;
select round(10.9876, -1) from dual ;
select round(19.9876, -1) from dual ;

select round(salary/3, 0) from employees;

-- trunc : Ư�� �ڸ������� ����
select trunc(34.5678, 2) from dual ;
select trunc(round(salary/3,1)) from employees; 

-- mod : �Է¹��� ���� ���� ���������� ��ȯ
select mod(27,2) from dual ;

select * from studata;
select * from studata
where mod(stuid,2)=1
order by stuid;

-- �����ȣ�� ¦���� ���
select * from employees
where mod(employee_id,2)=0
;

-- �Լ�
-- �����Լ�
-- rank() : ��������� ����ϵ�, ���������ŭ �ǳʶپ� ���� ������ ���
-- dense_rank() : ��������� ����ϵ� �ǳʶ��� �ʰ� �ٷ� ���� ������ ���
-- row_number() : ����������� ���

/*
rank() over([partition by ���̸�a] order by ���̸�a)    ���ȣ : ��������
���̸� b : �׷����� ������ ��� ������ �Űܾ� �Ҷ� ���
���̸� a : ������ �ű� ��
*/

select employee_id, salary,
rank() over(order by salary desc) as "rank_�޿�",
dense_rank() over(order by salary desc) as "dense_rank�޿�",
row_number() over(order by salary desc) as "row_number_�޿�"               -- row number�� ������ ���� ������ �ο��Ѵ�
from employees
where empployee_id between  100 and 106 ;

-- �л��� ������ ���������� �����ϼ���

 
select total, rank() over(order by total desc) as "����",
dense_rank() over(order by total desc) as "����2",
row_number() over(order by total desc) as "����3"
from studata;


select * from studata;
--select row_number() over(order by

select stuid, stuname, total, 
    row_number() over(order by total desc) ����
    from studata
    order by total desc;
    
-- nvl () null �� ġȯ �Լ�
select commission_pct, salary * nvl(commission_pct,1)
from employees
where employee_id between 100 and 106
order by commission_pct;

--decode(���̸�, ���ǰ�, ġȯ��, �⺻��)
-- � ���̸��� ���� ���ǰ��϶� ���ǿ� �ش��ϴ� ����� ġȯ�Ѵ�.

-- nvl(�Է°�, ��ü��) �ΰ� ġȯ �Լ�select commission_pct, salary * nvl(commission_pct,1)
select commission_pct, salary, salary*commission_pct ,salary*nvl(commission_pct,1)
from employees
where employee_id between 100 and 106
order by commission_pct;

-- nvl2(�Է°�, notnull��ü��, null��ü��)
select employee_id , commission_pct, salary, salary*nvl2(commission_pct,0,1)
from employees
where employee_id between 143 and 148
order by commission_pct;

-- nullif(��1,��2) : ���࿡ ��1�� ��2�� null�� �ٲ����
select employee_id, commission_pct, salary, nullif(salary, 2600)
from employees
where employee_id between 143 and 148
order by commission_pct;

--decode(���̸�, ���ǰ�, ġȯ��, �⺻��)
-- � �� �̸��� ���� ���ǰ��϶� ���ǿ� �ش��ϴ� ����� ġȯ�Ѵ�.
select first_name,
last_name,
department_id,
salary �����޿�,
decode(department_id, 60, salary*1.1, salary) �����ȱ޿�,
decode(department_id, 60, '10%�λ�', '���λ�') �λ󿩺�
from employees
where employee_id between 100 and 106;

-- ���࿡ department_id �� 100�϶� 'IT'�� ǥ�� �׿ܿ��� �ٸ��μ�
select * from employees;

select first_name, last_name, department_id,
decode(department_id, 100, 'IT', 
                       90, 'HR', '�׿�') ID      -- 100�϶� IT, 90�϶� HR �������� �׿�
from employees
order by department_id desc;

-- case : �پ��� ������ �־�����, ���̽��� if�� �����̳�

/*
case
    when ����1 then ���1
    when ����2 then ���2
    ....
    else ���3
end as ����
*/
select employee_id, first_name, last_name, salary,
    case
        when salary >= 9000 then '�����޿�'
        when salary between 6000 and 8999 then '�����޿�'
        else '�����޿�'
     end as �޿����
from employees 
where job_id = 'IT_PROG';

-- employee_id, first_name, job_id�� ����ϴ� ����
-- ++ department_id �� 10�϶� 'admin', 40�϶� HR, 60�϶� IT �׿ܴ� 'N/A'�� ���

select employee_id, first_name, job_id, department_id, manager_id,
    case
        when department_id = 10 then 'admin'
        when department_id = 40 then 'HR'
        when department_id = 60 then 'IT'
        else 'N/A'
      end as job_title  
from employees
where employee_id between 199 and 204;

-- and or �� �Բ� ����� �� �ִ�.
select employee_id, first_name, job_id, department_id, manager_id,
    case
        when department_id = 10 and manager_id = 101 then 'admin'    -- and�� ���� 2�� �� �����ؾ� admin�� ����
        when department_id = 40 and manager_id = 101 then 'HR'
        when department_id = 60 then 'IT'
        else 'N/A'
      end as job_title  
from employees
where employee_id between 199 and 204;

-- �׷��Լ� : ���� ���ؼ� ���.. count, sum, avg �� �̷���
-- count() : ���� ������ ��. count(*) : null�� ����

select count(*) from employees;
select count(*), count(employee_id), count(manager_id)
from employees;

select count(*), count(manager_id),  count(commission_pct) from employees;

select commission_pct from employees;
select count(commission_pct), count(*)-count(commission_pct) from employees;       -- > ��ü-�޴»�� = �ȹ޴»��

select count(*) from employees where commission_pct is null;

--sum() �հ�
select sum(salary) from employees;
select sum(salary) as �ѿ��޿�,
        sum(salary)*0.1 as �λ��,
        sum(salary)*1.1 as ������_�ѿ��޿�
from employees;

select sum(salary) as �ѿ��޿�,
        floor(sum(salary)*0.1) as �λ��,
        sum(salary)*1.1 as ������_�ѿ��޿�
from employees;

-- avg() ����Լ�
select trunc(avg(salary),2) from employees;
select count(*), avg(salary) from employees;

-- max(�ִ밪)
select max(total) from studata;
select max(salary) from employees;
-- min(�ּҰ�)
select min(total) from studata;
select min(salaryfasd) from employees;

-- where������ select���� ��� �� �� �ִ�.
select first_name, salary from employees
where salary<(select avg(salary) from employees);

-- department_id�� 10�� ����� �߿��� Ŀ�̼��� �޴� ����� ��
-- department_id�� 60�� ������� ������ ��
-- ������ ����̻��� ������� ��

select * from employees order by department_id;

select count(commission_pct) from employees             -- count �Լ��� null�� �ƴ� ���� ã�´�
where department_id = 10;

select count(*) from employees
where commission_pct is not null and department_id = 10;

select sum(salary) from employees where department_id = 60;
select * from employees where department_id = 60;

select count(*) from employees
where salary >= (select avg(salary) from employees) ;

-- group by : �հ�, ���, �ִ밪, �ּҰ� �� ��� �÷��� �������� �� �÷��� �� ���� ������ �Ҷ� group by �� �ڿ� �ش� �÷��� ���
-- group by �ڿ��� �ݵ�� �÷����� ����ؾ� ��(��Ī���ȵ�)

-- select �÷Ÿ�, �׷��Լ�(�÷���)
-- from ���̺��
-- [where ���ǽ�]
-- group by �÷���
-- [order by �÷���]
-- ��) select A, sum(B) group by A ;

select job_id, salary from employees;
select job_id, avg(salary) from employees
group by job_id;

select job_id ����, sum(salary) ������_�ѱ޿�, avg(salary) ������_��ձ޿�
from employees 
where employee_id>=10
group by job_id
order by ������_�ѱ޿� desc, ������_��ձ޿�;

select department_id, sum(salary), count(*)
from employees
group by department_id
order by department_id;

select * from employees;
-- �μ����� ������� Ŀ�̼��� �޴� ����� ���
-- �ҼӺμ��� �ִ�޿��� �ּұ޿�

select department_id ,count(department_id), count(commission_pct) 
from employees 
group by department_id
order by department_id;

select department_id, max(salary), min(salary) 
from employees
group by department_id
order by department_id;

select job_id, avg(salary), max(salary), min(salary)
from employees
group by job_id;

-- having
-- select �� ������ ����Ͽ� ����� �����Ҷ��� where���� ���������
-- �׷��� ����� �����Ҷ��� having���� ����Ѵ�.
-- ��, �׷����� ������ ������� ���� �ٽ� ������ �ִ� ���
-- group by�� ����� ����� ���� having ������ �ִ� ��
/*
select �÷���, �׷��Լ�(�÷���)
from ���̺��
[where ���ǽ�]
group by �÷���
[having ���ǽ�]
[order by �÷���]
*/

-- ��) �μ����� �׷��� ���� �� �׷������� �μ��� ��� �޿��� 5000 �̻��� �μ���ȣ�� ��ձ޿�
select department_id, round(avg(salary),2) 
from employees 
group by department_id 
having avg(salary) >= 5000;

select job_id ����, sum(salary) ������_�ѱ޿�, avg(salary) ������_��ձ޿�
from employees
where employee_id > 100
group by job_id
having sum(salary) > 50000
order by ������_�ѱ޿� desc;

select job_id, salary from employees;
select job_id, avg(salary) from employees group by job_id
having avg(salary) >= 10000;

-- �μ���, ����� ��, ��������, ������ ���(�Ҽ�2�ڸ�), �ִ�޿�, �ּұ޿��� ����ϼ���
select department_id, count(*), sum(salary), round(avg(salary),2), max(salary), min(salary) 
from employees
group by department_id
order by department_id;

-- ������ 5000������ ����� ���� �μ����� ����ϴµ� �μ��� ����� ���� 10�� �̻��� ��츸 ���
select department_id, count(*) 
from employees
where salary <= 5000
group by department_id
having count(department_id)>= 10;

select department_id, count(*) 
from employees
where salary <= 5000
group by department_id
having count(*)>= 10;




-- �μ��� �ִ�޿��� ����ϴµ� �ִ�޿��� 4500�� �ʰ��ϴ� ��츸 ���
select department_id, max(salary) from employees
group by department_id
having max(salary) > 4500
order by department_id;

-- rank() over([partition by ���̸�a] order by ���̸�b)
select employee_id, department_id, salary, 
    rank() over(order by salary) �ѱ޿�����,
    rank() over(partition by department_id order by salary) ��Ƽ��
from employees
order by department_id, salary;

-- ����Ŭ���� �м��Լ��� ����� �� partition by �� ����� �׷����� ��� ������ �� �ִ�.

-- group by�� ���
select job_id, avg(salary) from employees
where employee_id between 100 and 110
group by job_id
order by job_id;

select job_id, avg(salary) over (partition by job_id) from employees
where employee_id between 100 and 110
order by job_id;

select employee_id, department_id, salary,
round(avg(salary) over() ) ��ü���,
round(avg(salary) over(order by employee_id)) �������,
round(avg(salary) over(partition by department_id)) �μ������,
round(avg(salary) over(partition by department_id order by employee_id)) �μ����������
from employees
order by employee_id;

select * from tab;

select * from order_info;

-- item���� ���Ǹž�, ���Ǹűݾ��� ����غ�����
select item_id, sum(quantity), sum(sales)
from order_info
group by item_id
order by sum(sales) desc;

-- ���̺� ��ü �����ϱ�
create table studata2 as select * from studata;
select * from studata2 order by stuid;

-- ���̺� Ÿ�Ը� ��������
create table studata3 as select * from studata where 1=2;
select * from studata3;
desc studata3;

/*
create sequence test_seq
increment by
start with
maxvalue 100000
minvalue 1;
*/

--������ �������� �� �� �ִ�.
select stu_seq.currval from dual;  --  �ٵ� ���� ���� ���Ÿ� �θ����� �ؾ���
-- ���� �������� �� �� �ִ�.
select stu_seq.nextval from dual;  --�ѹ� nextval�� ����ϰ� �Ǹ� �������� ���� �ǵ����� ����.

select * from studata3;

insert into studata3 values(
stu_seq.nextval, 'ȫ�浿', 100,100,100,300,100,0);            -- nextval : netxvalue.

select * from studata3;

insert into studata3 values(
stu_seq.nextval, '������', 100,100,100,300,100,0); 


-- �ߺ����� �⺻Ű�� ����ϰ��� �Ҷ� ������ ���̺��� ����Ѵ�.
-- �ߺ����� �ڵ� �����Ǵ� ���̺�� ����� �� �ִ�.
-- �������� �����Ҷ����� �����ǰ� �ٽ� ���ҽ�ų���� ����
-- insert������ �����ϰ� ����� �� �ִ�

-- start with �ܿ��� ��� ������ �����ϴ�
-- ������ �������� 1->2�� �����Ҽ� �ִ�.
alter sequence stu_seq increment by 2 ;

-- ������ �ִ밪 ����
alter sequence stu_seq maxvalue 999999;

-- ������ ����
drop sequence ste_seq;

create table emp01 as select employee_id, first_name, salary from employees
where 1=2;

desc emp01;

-- emp_seq�� �����ؼ� emp01���̺� ����� 3�� �Է��غ�����.
-- �����ȣ�� 2023001 ���� ������ �ϳ��� �����ϴ� ������

select emp_seq.currval from dual;

insert into emp01 values
(emp_seq.nextval, '�̸�1', 1000);

select * from emp01;

insert into emp01 values
(emp_seq.nextval, '�̸�2', 2000);

select emp_seq.currval from dual;

select emp_seq.nextval from dual;

insert into emp01 values
(emp_seq.nextval, '�̸�3', 2000);

select * from emp01;das

-- DML : ������ ���۾�. �����͸� ���� ����, ����, �����ϴ� ��ɾ�
-- select, insert, update, delete

-- ���̺� ����
create table sample_product(
product_id number(10),
product_name varchar2(30),
manu_date date
);
desc sample_product;
-- dml ���۾ �Ẹ��
/*
insert : ���̺� ���ο� ���� �����Ҷ� ���
insert into ���̺�� [(�÷���1, �÷���2, ....)]
values(�����Ͱ�1, �����Ͱ�2.....);
*/
--DATE��� ������ �������� ������ �� ����Ŭ�� TO_DATE�� �������




insert into sample_product
values(1, 'television', to_date('140101', 'YYMMDD'));
insert into sample_product
values(2, 'wahser', to_date('150101', 'YYMMDD'));
insert into sample_product
values(3, 'cleaner', to_date('160101','YYMMDD'));

select * from sample_product;
commit;   -- Ȯ�� (����)

/* update : ������ ������ ���� �ٸ� �����ͷ� �����Ҷ� ���. Ŀ���ϰ��� ������ �߸����� �˸� update�� �ٲܼ� ����

update ���̺��
set ���̸�1=�����Ͱ�1 [,���̸�2=�����Ͱ�2,...]
[where ���ǽ�];
*/

update sample_product
set product_name='tv', manu_date = to_date('170101', 'YYMMDD')
where product_id = 1 ;           -- where�� �Ⱦ��� ���� �ٲ����� �Ƚ�⿡ ��ü ���� ������ �� �ٲ�
commit;
select * from sample_product;

/* 
delete [from] ���̺��
[where ���ǽ�];  where �Ⱦ��� ������ �� �����

*/

delete sample_product where product_id=1;
select * from sample_product;
rollback;

delete sample_product;
rollback;

-- studata3�� �������� ������ 90�� 90�� 95������ �����غ�����
select * from studata3;
desc studata3;
update studata3 
set kor=90, eng=90, math=95
where stuid=2;

select * from studata3;

-- �̼��� ������ ������ ������
insert into studata3 
values(3,'�̼���', 50, 90, 50, 70, 30,0);

select * from studata3;
commit;

delete from studata3 where stuid=3;
rollback;

update studata3 
set kor = 60, avg = 90
where stuname = '�̼���';


-- DDL : ������ ���Ǿ�(���̺�� ���� ���� �����ϰ� �����ϰ� �����ϴ� ��ɾ�)
-- create, alter, drop, rename, truncate
-- ���� Ŀ���� ���� �ʾƵ� ������ ���̽��� �ﰢ �ݿ���

-- ���̺� �� �߰��ϱ�
/*
alter table ���̺��
    add(���̸�1 ������Ÿ��,
        ���̸�2 ������Ÿ��,
        ....
        );
���̺� �̹� ���� �ִٸ� ���� �߰� ���� �� ���ο� ���� �����ʹ� null�� �ʱ�ȭ��
*/
-- sample_product���̺� factory �÷� �߰�
alter table sample_product add(factory varchar2(10));
desc sample_product;
select * from sample_product; 

-- ������ �Ӹ� Ű �߰�
alter table sample_product add primary key(product_id);
-- ������ �Ӹ� Ű ����
alter table sample_product drop primary key;

-- ���̺� �� �����ϱ�
/*
alter table ���̺��
    modify(���̸�1 ������Ÿ��,
            ���̸�2 ������Ÿ��,
            ....
);
������ Ÿ�԰� �ڸ��� defalut value �� ����
*/
alter table sample_product modify(factory char(10));
desc sample_product;
alter table sample_product modify(product_id number(20));

-- dml : ������ ������ ����
-- ddl : ��ü���� ���̺��� ���� ����. null, ������Ÿ�� ���

-- ���̺� �� �̸� �ٲٱ�
/*
alter table ���̺��
rename column(���̸�1 to �ٲٷ��� ���̸�1);
*/
alter table sample_product rename column factory to factory_name;
select * from sample_product;

-- ���̺� �� ����
/*
rename ���̺�� to ���ο� ���̺��;
*/
rename sample_product to sproduct;
desc sproduct;

-- ���̺� �� �����ϱ�
/*
alter table ���̺��̸�
drop column ���̸� ;
*/
alter table sproduct drop column factory_name;
desc sproduct;

-- ���̺� ���� �����ϱ�
/*
truncate table ���̺��
���̺��� ��� �����Ͱ� ���������� ������ �������� �ʴ´�
*/
select * from sproduct;
truncate table sproduct;
desc sproduct;

-- ���̺� �����ϱ�
/* 
drop table ���̺��;
*/
drop table sproduct;

select * from member;
desc member;
/* CREATE TABLE member(
ID          NOT NULL VARCHAR2(20) 
PW                   VARCHAR2(20) 
NAME                 VARCHAR2(20) 
PHONE                VARCHAR2(20) 
CREATE_DATE          DATE 
);
*/

-- email Number(30) �÷� �߰��ϱ�
-- email�� varchar2(50)���� �����ϱ�
-- pw�� not null�� �����ϱ� (modify)
-- phone �÷����� cell�� �����ϱ�
-- email �÷� �����
-- ��� ���̺� ���� �����ϱ�
-- member ���̺��� newmem���� �����ϱ�

select * from member;

alter table member add (email Number(30)) ;
desc member;

alter table member modify (email varchar2(50));
desc member;

alter table member modify(pw not null);
desc member;

alter table member rename column phone to cell;
desc member;

alter table member drop column email;
select * from member;

truncate table member ;

rename member to newmem;
desc newmem;

drop table emp01;


-- unique : �ߺ��ȵ�
create table emp01(
employee_id number(6) primary key,
emp_name varchar2(20) unique,
salary number(8,2) not null,
manager_id number(6),
department_id number(6)
);

insert into emp01(employee_id, emp_name, salary, manager_id, department_id)
select employee_id, first_name||' '||last_name, salary, manager_id,
department_id from employees;    -- ���� �ִ� �����͸� ���̺� �÷� ����� �׾ȿ� ����ֱ�
commit;
select * from emp01;

-- primary key : null�ȵǰ� �ߺ��� �ȵ�.
-- employee_id 100�� �̹� �����ϱ� ������ ����
insert into emp01(employee_id, emp_name, salary) values(100, 'ȫ�浿', 5000);

insert into emp01(employee_id, emp_name, salary) values(99, 'Steven King', 1000);
-- emp_name�� �����ϱ� ������ unique ����

insert into emp01(employee_id, emp_name) values(99, 'ȫ�浿');
--salary -> not null ��Ģ�� ������ �Ǿ ����

insert into emp01(employee_id, emp_name, salary) values(99, 'ȫ�浿', 10000);
commit;
select * from emp01 order by employee_id;

-- check
-- gender�̶�� �÷��� not null ���� ���������� �ִ°ž�
-- ��ҹ��� m, f �� ���� �� �־�
alter table emp01
    add gender varchar2(10)
    constraint ck_gender
    check(gender in ('M', 'm', 'F', 'f'));
    
insert into emp01(employee_id, emp_name, salary, gender)
values(98, '������', 5000, 'f');
select * from emp01 order by employee_id;

/*
create table emp01(
employee_id number(6) primary key,
emp_name varchar2(20) unique,
salary number(8,2) not null,
manager_id number(6),
department_id number(6),
gender varchar2(10),
CONSTRAINT ck_gender check(gender in ('M', 'm', 'F', 'f'))
);
*/
-- �������� ����
alter table emp01 drop constraint ck_gender;       -- ck_gender�� constraint�� �̸�. ���� �Ƚ��ָ� �ڵ������� ����

alter table emp01 modify salary null ;
alter table emp01 modify salary not null;

-- unique ����
-- constraint �̸�Ȯ��
select constraint_name, constraint_type, table_name from user_constraints
where table_name = 'EMP01';
--emp01�� ���������� �˼� �־� c:check, p:primary, u:unique

--����ũ����
alter table emp01 drop constraint SYS_C007072;

-- unique �߰�
alter table emp01 add constraint uk_name unique(emp_name);
desc emp01;
select * from emp01;
