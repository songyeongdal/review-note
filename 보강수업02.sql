-- ���� asc 
-- ����: ����������, ����: ����������, ��¥: ������¥����, null���帶������
select * from employees 
order by salary;
-- ���� ���� desc
select * from employees 
order by salary desc; 

-- �μ���ȣ�� - ��������. �μ���ȣ�� ���� ��� ������ �������� ���� 
select department_id, salary from employees
order by department_id, salary desc;

select * from employees 
order by employee_id, hire_date desc; 

-- ���� ���� 
-- length : �÷��� ���ڿ� ���̸� ��ȯ, ������ ������ ���ڿ��� ���� 
-- lengthb : �÷��� ���ڿ� ����Ʈ���� ��ȯ 
--    ������(1����Ʈ) ����(1����Ʈ) �ѱ�(3����Ʈ)
select first_name, length(first_name), lengthb(first_name) from employees;

-- lower -> �ҹ��ڷ� ��ȯ 
select first_name, lower(first_name) from employees;
-- upper -> �빮�ڷ� ��ȯ 
select first_name, upper(first_name) from employees; 

-- substr : ���ڿ��� ���� 
-- substr('jones', 2)���ڿ��� �ι�° ��ġ �� o���� ������ �ڸ���. 
-- substr('jones',2,3) ���ڿ��� �ι�° ��ġ���� 3�ڸ� �� one�� �ڸ��� 
select substr('jones', 2) from dual; 
select substr('jones',2,3) from dual;

select first_name, substr(first_name, 1,6) from employees;
select first_name, substr(first_name, 3) from employees;
select first_name, substr(first_name, -1) from employees;

-- dual�� ����Ŭ ��ü ���� ���̺�� �ѿ��� �̷���� �ӽ����̺��̴�.
-- �ַ� ����ڰ� �Լ�(���)�� �Ҷ� �ӽ÷� ����Ѵ�.
select sysdate from dual;
-- ���� ���� ���ϱ� ���ڴ� �Ұ����ѵ� ����Ŭ���� ���ش�. 
select '1'+'2' from dual;

-- instr Ư�� ���� ��ġ ã�� 

select 'hello.txt', instr('hello.txt','.'), substr('hello.txt',instr('hello.txt','.')+1)
from dual;

-- Q. 'studata.sql'���� sql �����غ���
select 'studata.sql', substr('studata.sql',instr('studata.sql','.')+1)
from dual;

-- control +f7 : �ڵ����� 
CREATE TABLE member (
    id          VARCHAR2(20) PRIMARY KEY,
    pw          VARCHAR2(20),
    name        VARCHAR2(20),
    phone       VARCHAR2(20),
    create_date DATE
);
insert into member(id, pw, name, phone)
values('aaa','         1111', 'ȫ   �浿', '010-1111-111      ');
commit;
select * from member;
select length(pw) from member;

-- replace : ���� ��ü - ������ ������ ���鵵 ���� �� �ִ�. 
select name from member;
select name, replace(name,' ','') from member;

- trim, ltrim, rtrim 
- trim : ���ڿ��� ���� ������ ���� 
- ltrim : ���ڿ� ���� �������� 
- rtrim : ���ڿ� ������ �������� 

select trim('    ����      '), 
    ltrim (rtrim('    ���� ����      ')) from dual;

-- update�� ����ؼ� ������ ���Ž�Ű�� �����ϱ� 
update member set pw = ltrim(pw);
commit;
select length(pw) from member;

select phone, length(phone) from member;
-- Q �� ��ȣ�� ������ �����Ͽ� �����غ����� 
update member set phone = replace(phone,' ','');
-- update member set phone = rtrim(phone);

-- concat : ���ڿ� ��ġ�� 
select concat(id, concat('-',pw)) from member;
select id||'-'||pw from member;

select first_name, last_name from employees;
select (first_name || ' ' || last_name)as �̸� from employees;

-- Ư�� ���� ä��� : lpad, rpad 
select lpad(id, 10, '*') from member;

-- sysdate : ���� �ð� (��¥)
select sysdate, sysdate+1, sysdate-1 from dual;
-- months_between : �� ��¥ ���̰� ������� ��ȯ 
select first_name, sysdate, hire_date, months_between(sysdate, hire_date) from employees;

select sysdate, '23/10/07', months_between(sysdate, to_date('23/10/07')) from dual;

-- add_months(): Ư�� ��¥ �������� ���Ѵ�. 
select sysdate,add_months(sysdate, 6) from dual;

-- to_char() ���������� ��ȯ�ϴ� �Լ� 
select sysdate, 
       to_char(sysdate, 'YY'),
       to_char(sysdate,'YYYY'),
       to_char(sysdate,'MM'),
       to_char(sysdate,'MON'),
       to_char(sysdate, 'YYYYMMDD'),
       to_char(to_date('20171008'),'YYYYMMDD')
from dual;

-- to_number() :���ڷ� ��ȯ 
select to_number('123') from dual;

-- to_date() �������� ��¥������ ��ȯ�ϴ� �Լ� 
select to_date('20171007','YYYYMMDD') from dual;

-- �������� �Լ��� 
-- abs: ���밪
select -10, abs(-10) from dual;
-- floor ����
select floor(10.3245) from dual;
-- round: �ݿø� �Ҽ����� 3��°�ڸ����� ǥ��
select round(10.3245, 3) from dual;
-- -1��쿡�� ���� ù°�ڸ����� �ݿø�
select round(19.9876, -1) from dual;

select round(salary/3, 0) from employees;

-- trunc : Ư�� �ڸ������� ���� 
select trunc(34.5678, 2) from dual;

select trunc(round(salary/3,4)) from employees; 

-- mod : �Է¹��� ���� ���� ���������� ��ȯ 
select mod(27,2) from dual; 

select * from studata;

select * from studata 
where mod(stuid,2)=1
order by stuid
;

-- Q. �����ȣ�� ¦���� ��� 
desc employees;
Select * from employees
where mod(employee_id, 2) = 0 ;


-- �Լ� 
-- ���� �Լ� 
-- rank() : ���� ������ ����ϵ�, ���������ŭ �ǳʶپ� ���� ������ ���
-- dense_rank(): ��������� ����ϵ� �ǳʶ��� �ʰ� �ٷ� ���� ������ ���
-- row_number(): ������� ���� ��� 
/*
rank() over([partition by ���̸�b] order by ���̸�a)
���̸�b : �׷����� ������ ��� ������ �Űܾ� �Ҷ� ���
���̸�a : ������ �ű� �� 
*/
select employee_id, 
       salary, 
       rank() over(order by salary desc) rank_�޿�, 
       dense_rank() over(order by salary desc) dense_rank_�޿�, 
       row_number() over(order by salary desc) row_number_�޿�
from employees
where employee_id between 100 and 106; 

-- Q. �л��� ������ ���������� �����غ����� 

desc studata;
select stuid, stuname, total, 
       row_number() over(order by total desc) ����
from studata
order by total desc
;

-- nvl(�Է°�, ��ü��) �ΰ� ġȯ �Լ�. 
select commission_pct,salary,salary * nvl(commission_pct,1)
from employees
where employee_id between 100 and 106
order by commission_pct;
-- nvl2(�Է°�, notnull��ü��, null��ü��)
select employee_id, commission_pct, nvl2(commission_pct,0,1)
from employees
where employee_id between 143 and 148;
-- nullif(��1, ��2) ���࿡ ��1�� ��2�� �η� �ٲ����. 
select employee_id, commission_pct, salary, nullif(salary, 2600)
from employees
where employee_id between 143 and 148;

desc employees;
-- decode(���̸�, ���ǰ�, ġȯ��, �⺻��)
-- � �� �̸��� ���� ���ǰ��϶� ���ǿ� �ش��ϴ� ����� ġȯ�Ѵ�. 
select first_name,  last_name, department_id,
salary �����޿�,
decode(department_id, 60, salary*1.1, salary) �����ȱ޿�, 
decode(department_id, 60, '10%�λ�','���λ�') �λ󿩺�
from employees
where employee_id between 100 and 106;

-- Q. department_id�� 100 �϶� 'IT' �׿ܿ��� '�ٸ��μ�'�� decode�� ����ؼ� ǥ���غ���
select first_name, last_name, department_id, 
decode(department_id, 100, 'IT', 
                      90, 'HR',
                      '�׿�' )
from employees;


-- case : �پ��� ������ �־��� �� 
/* 
case 
   when ����1 then ���1
   when ����2 then ���2
   .....
   else ���3
end as ����
*/
select employee_id, first_name, last_name, salary, 
    case
        when salary>=9000 then '�����޿�'
        when salary between 6000 and 8999 then '�����޿�'
        else '�����޿�'
    end as �޿����
from employees
where job_id = 'IT_PROG';

select * from employees;
select * from departments;
-- Q. employee_id, first_name, job_id�� ����ϴ� ����
-- department id �� 10�϶� 'admin',  40�϶� HR, 60�϶� it �׿ܴ� 'N/A'�� ��� �غ����� 
-- �÷����� job_title �� ���
select employee_id, first_name, job_id, department_id, manager_id,
    case 
        when department_id = 10 then 'Admin'
        when department_id = 40 then 'HR'
        else 'N/A'    
    end as job_title
from employees 
where employee_id between 199 and 204
;
-- and or �� �Բ� ����� �� �ִ� 
select employee_id, first_name, job_id, department_id, manager_id,
    case 
        when department_id = 10 and manager_id = 101 then 'Admin'
        when department_id = 40 and manager_id = 101 then 'HR'
        else 'N/A'    
    end as job_title
from employees 
where employee_id between 199 and 204;


-- �׷� �Լ� : ���� ���ؼ� ��� 
-- count() ���� ������ ��.  count(*) null ���� ����. 
select count(*) from employees;
select count(*), count(employee_id), count(manager_id) 
from employees;
select count(*), count(manager_id), count(commission_pct)
from employees;

select commission_pct from employees;
select count(*)��ü,count(commission_pct)Ŀ�̼�, count(*)-count(commission_pct)��Ŀ�̼� 
from employees;

select count(*) from employees
where commission_pct is null;

-- sum() �հ� 
select sum(salary) from employees;
select sum(salary) as �ѿ��޿�, 
       sum(salary)*0.1 as �λ��, 
       sum(salary)*1.1 as ������_�ѿ��޿�
from employees;

select sum(salary) as �ѿ��޿�, 
       trunc(sum(salary)*0.1,0) as "�λ��", 
       round(sum(salary)*1.1,0) as "������ �ѿ��޿�"
from employees;

-- avg() ��� �Լ� 
select round(avg(salary),2) from employees;
select count(*), avg(salary) from employees;

-- max() �ִ밪
select max(total) from studata; 
select max(salary) from employees;
-- min() �ּҰ�
desc studata;
select min(kor) from studata;
select min(salary) from employees;

-- where�� select���� ��� �� �� �ִ�. 
select first_name, salary from employees
where salary < ( select avg(salary) from employees );

-- Q. department_id�� 10�� ����� �߿��� Ŀ�̼��� �޴� ����� �� 
select count(commission_pct) from employees
where department_id = 10;

select count(*) from employees 
where commission_pct is not null and department_id=10;

-- Q. department_id�� 60�� ������� ������ �� sum()
select sum(salary) from employees 
where department_id = 60 ; 

-- Q. ������ ����̻��� ������� �� 
select avg(salary) from employees;

select count(*) from employees 
where salary > (select avg(salary) from employees);

-- group by : �հ�, ���, �ִ밪, �ּҰ� �� ��� �÷��� �������� 
--           �� �÷��� �� ���� ������ �Ҷ� group by�� �ڿ� �ش� �÷��� ��� 
--     *group by  �ڿ��� �ݵ�� �÷����� ����ؾ��� (��Ī���ȵ�)
/* 
select �÷���, �׷��Լ�(�÷���)
from ���̺��
[where ���ǽ�]
group by �÷���
[order by �÷���]
 ��) select A, sum(B) group by A; 
*/
select job_id, salary from employees;
select job_id, avg(salary) from employees
group by job_id;

select job_id ����, sum(salary) ������_�ѱ޿�, avg(salary) ������_��ձ޿�
from employees 
where employee_id >=10
group by job_id
order by ������_�ѱ޿� desc, ������_��ձ޿�;

SELECT
    department_id,
    SUM(salary),
    COUNT(*)
FROM
    employees
GROUP BY
    department_id
ORDER BY
    department_id;


-- Q. �μ���(department_id)�� ������� Ŀ�̼��� �޴� ����� ��� 
select department_id, count(*), count(commission_pct) 
from employees
group by department_id;
-- Q. �ҼӺμ��� �ִ�޿��� �ּұ޿� 
select department_id, min(salary), max(salary), count(*)
from employees
group by department_id
order by department_id;

-- having 
-- select�� ������ ����Ͽ� ����� �����Ҷ��� where���� ���������
-- �׷��� ����� �����Ҷ��� having ���� ����Ѵ�. 
-- ��, �׷����� ������ ������� ���� �ٽ� ������ �ִ� ��� 
-- group by�� ����� ����� ���� having ������ �ִ� ��. 
/*
select �÷���, �׷��Լ�(�÷���)
from ���̺��
[where ���ǽ�]
group by �÷���
[having ���ǽ�]
[order by �÷���]
*/
-- ��) �μ����� �׷��� ���� ��, �׷������� �μ��� ��� �޿��� 5000 �̻��� �μ���ȣ�� ��ձ޿� 
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




 















