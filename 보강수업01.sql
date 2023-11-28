-- ���̺� ���� 
create table member(
id VARCHAR2(20) primary key,
pw VARCHAR2(20),
name VARCHAR2(20),
phone VARCHAR2(20)
);
-- ���̺� �� �ֱ� 
insert into member(id, pw, name, phone) 
values('aaa','1111','ȫ�浿','010-1111-1111');

select * from member;
commit;

insert into member values ('bbb','1111','�̼���','010-2222-2222');
insert into member values ('ccc','1111','�̼���','010-2222-2222');
insert into member(id, name) values ('ddd','�豸');
insert into member values ('eee','1111','������','010-3333-3333');
-- ���๮ �ǵ����� .
rollback;
-- ���̺� �˻��ϱ� 
select * from member;
-- ���̺� �� ������ ���� 
-- delete from member where id = 'aaa';

-- ������ ���� 
update member set phone = '010-7777-7777' where id='bbb';
commit;

-- ���̺� ���� 
-- drop table member; 
select * from member;


-- �л� ���̺��� �����غ����� students
-- id, name, kor, eng, math, total, avg, rank 
-- id, name : varchar2 �������� number 
-- avg ��쿡�� �Ҽ��� ǥ���� ���ؼ� NUMBER(4,1)�� �����غ����� 

create table students(
id VARCHAR2(20) primary key, 
name VARCHAR2(20),
kor NUMBER(3),
eng NUMBER(3),
math NUMBER(3),
total NUMBER(3),
avg NUMBER(4,1),
rank number(3)
);

-- 3���� �л� ������ �Է��غ����� . 
insert into students 
values ('1','ȫ�浿',100,100,100,(100+100+100),(100+100+100)/3,0);

insert into students 
values ('2','�̼���',90,100,100,(90+100+100),(90+100+100)/3,0);

insert into students 
values ('3','�豸',100,90,90,(100+90+90),(100+90+90)/3,0);

select * from students;
commit;

-- ����ڰ� ������ ���̺� ������ �˷��ش�
select * from tab;
-- ���̺��� ������ ���캼 �� �ִ�. 
desc students;

/*
select [distinct] �� �̸� [or Alias]
from ���̺� �̸�
[where ���ǽ�]
[order by �� �̸� [asc or desc] ];

[]: ���û���
; : sql�� �������� �ǹ� 
distinct : �ߺ��� ���� 
* : ��翭 ��� 
alias : ��Ī �ο� 
where : ������ �����ϴ� ��鸸 �˻�
���ǽ�: ��, ǥ����, ��� �� �� ������ �� ����� ���� ���ǹ�
order by : ��� ������ ���� �ɼ� (asc �������� desc ��������)

*/
-- ��� ���� ��ȸ
select * from students; 
select * from employees;
-- Ư�� �÷��� ����ϰ� �� �Ҷ��� ���̸�, ���̸� ���� ��� 
select name, total from students;


-- Q. ����� �޿��� �Ի� ���ڸ��� ����ϴ� sql���� �ۼ��غ����� (employees���̺�)
desc employees;
select SALARY, HIRE_DATE from employees;


select EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY from employees;
-- ��Ģ���� ��� ���� 
-- as�� ��Ī ������ ���� �ֵ���ǥ�� ���� ��쿡 ��ҹ��� ����, �ѱ�, ���� ����
select SALARY, SALARY/4 as salary4 , SALARY*12 as " 1 2 �� "  from employees;


select EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY, SALARY*12 as "����"  from employees;
-- Ŀ�̼� ���� �����ϰ�ʹ�. 

select EMPLOYEE_ID, HIRE_DATE, SALARY, COMMISSION_PCT, SALARY*12
from employees;

select EMPLOYEE_ID, HIRE_DATE, SALARY, COMMISSION_PCT, SALARY*12+COMMISSION_PCT
from employees;

-- null �������� 0���� �Է����ض�. nvl()�Լ� ��� 
select EMPLOYEE_ID, HIRE_DATE, SALARY, COMMISSION_PCT, 
SALARY*12+nvl(COMMISSION_PCT,0)
from employees;

-- Q. ���, �̸� (first_name), �̸���, ��ȭ��ȣ, �Ի�����  ��Ī�� ����ؼ� ����غ����� 
desc employees;
select EMPLOYEE_ID as "���", FIRST_NAME as "�̸�", 
EMAIL as "�̸���", PHONE_NUMBER as "��ȭ��ȣ", HIRE_DATE as "�Ի���" 
from employees; 

--  Q.�μ���ȣ, �μ��� ��Ī�� ����ؼ� ����ϼ��� 
desc departments;
select DEPARTMENT_ID as "�μ���ȣ",DEPARTMENT_NAME  as "�μ���"
from departments;

desc employees;
-- concatenation || ' '  || : �÷��� �÷��� �ϳ��� ����ó�� ���̰� �� 
select FIRST_NAME || '�� ���� : ' || JOB_ID 
from employees; 

-- distinct : �ߺ����� 
select DEPARTMENT_ID, DEPARTMENT_NAME from departments;
select DEPARTMENT_ID from employees;
select distinct department_id 
from employees
order by department_id;

-- where �� ���� : ���ǹ�
-- �޿��� 6000�� ��츦 ����� �ض� 
select * from employees 
where salary = 6000;
-- �ݿ��� 4000 �̻� ����� �ط� 
select * from employees 
where salary >= 4000;

-- Q. �޿��� 4000 ������ ����� �����ȣ, ����̸�, �޿��� ����ϴ� sql���� �ۼ��ϼ���
--   ++ ��Ī ����ؼ� ��� 
desc employees;
select EMPLOYEE_ID as "�����ȣ", FIRST_NAME as "����̸�", SALARY as "�޿�"
from employees
where salary <=4000;


select FIRST_NAME || ' ' || Last_NAME as "name"
from employees; 


-- sql���� ���ڿ��̳� ��¥�� ���ϵ���ǥ �ȿ� ǥ���ؾ� �Ѵ�. 
select * from employees where email = 'RLADWIG';
-- ����ǥ �ȿ� ���ڿ��� ��ҹ��ڸ� �����Ѵ�. 
select * from employees where email = 'rladwig';

select * from employees where hire_date >='07/06/21';
-- Q. 2000/1/1 ���� �Ի��� 
--  ++�Ի��� ������ ���� 
select * from employees where hire_date >='00/01/01'
order by hire_date;

-- desc�� �������� 
select * from employees 
where salary > 4000
order by salary desc;

-- �������� and 
select * from employees
where salary >=2000 and salary <= 3000; 

select * from employees 
where salary = 8000 and job_id='SA_REP';

-- ���ǿ� or 
select * from employees 
where salary = 8000 or salary = 6000 ;

-- Q. ��� ���̵�, �̸�, �޿��� ����ϴ� sql���� �ۼ��ϼ��� 
--  ++ ���̵� 100 �̻��̸� �޿��� 4000�̻���
--  ++ �޿��� ���� ��-> ���� ������ 
select EMPLOYEE_ID, FIRST_NAME, SALARY from employees
where EMPLOYEE_ID >=100 and SALARY >= 4000
order by SALARY desc;

-- between a and b : a�� b ������ ��
select * from employees 
where salary BETWEEN 6000 and 8000
order by salary;

select * from employees 
where salary>= 6000 and salary <= 8000
order by salary;

-- in (list) : list �� ��� ���̶� ��ġ �� ��� ��� 
select * from employees 
where salary in (6000, 8000, 10000) 
order by salary; 

select * from employees 
where salary = 6000 or salary = 8000
order by salary;

-- Q.  commission_pct 0.1�̳� 0.3�� ��� ��� 
-- or ��� 
SELECT
    *
FROM
    employees
WHERE
    commission_pct = 0.1
    OR commission_pct = 0.3;
-- in ��� 
select * from employees
where commission_pct in (0.1, 0.3);

-- Q. 176, 158, 102 �� ������� �����ȣ�� �޿��� �˻��ϴ� �������� ����ϼ���
-- or
select employee_id, salary from employees 
where employee_id = 176 or employee_id = 158 or employee_id = 102;
-- in
select employee_id, salary from employees
where employee_id in(176, 158, 102);

-- �� ������ not 
select * from employees where not department_id=20;
select * from employees where department_id != 20;
select * from employees where department_id <> 20;
select * from employees where department_id ^= 20;

-- ���Ե� ���ڸ� ã���� like 
-- �̸��Ͽ� ù���ڰ� v�� �����ϴ� ��絥���͸� ����ض� 
select * from employees
where email like 'V'||'%';
select * from employees
where email like 'V%';
-- �̸��Ͽ� S�� �����ϴ� ������ ��� 
-- S�� ����
select * from employees
where email like 'S%';
-- S�� ������ �� 
select * from employees
where email like '%S';
-- S�� �߰��� �ִ°�
select * from employees
where email like '%S%';

select * from employees
where lower(email) like '%s%';

-- ����ٴ� ���� ���� ��Ÿ����. (����� 5��)
select * from employees 
where email like 'B'||'_____';
select * from employees 
where email like 'B_____';
select * from employees 
where email like 'B%';

-- �ι�° ���ڰ� a�� ����� ã�� 
select first_name from employees
where first_name like '_a%';

-- �׹�° ���ڰ� a�� ��� ã�� 
select first_name from employees
where lower(first_name) like '___a%';

-- a�� �������� �ʴ� ����� ã�� 
select first_name from employees 
where lower(first_name) not like '%a%';
-- �ι�° ��¥�� a�� �������� �ʴ� ��� ã�� 
select first_name from employees 
where lower(first_name) not like '_a%';

-- null ���� ���� ��鸸 ��� 
select * from employees 
where manager_id is null; 


-- null �� �ִ� ��츦 �����ϰ� ���
select * from employees 
where manager_id is not null; 

-- Q id, �̸�, ������ ����ϼ��� . 
--   + ������ 4000 �����̸� department_id�� 30��
--   ���޼����� �����غ����� 
select employee_id, first_name, salary from employees 
where salary <=4000 and department_id =30 
order by salary; 

-- Q last_name�� a �� e�� ��� ���Ե� ����� ���
select last_name from employees 
where lower(last_name) like '%a%' and last_name like '%e%';

-- Q job_id�� 'SA_REP' �̰ų� 'ST_CLERK' �̸鼭
--  ++ salary�� 2500, 3500 �Ǵ� 7000�� �ƴ� 
--  ++ ��� ����� last_name, job_id, salary�� ����ϼ��� 
select last_name, job_id, salary from employees 
where job_id in('SA_REP','ST_CLERK')
and salary not in (2500, 3500, 700);

-- Q employee_id�� 130���� ũ�� ������ 3000�� 5000 ������ ���̺���
-- + ���� �������� ���
select * from employees 
where employee_id >=130 and salary between 3000 and 5000
order by salary desc;


-- ��¥�� ���İ� ����. �� �����ϴ�.
select * from employees
where hire_date between '95/01/01' and '02/12/31'
order by hire_date;
-- ��¥���� ������ ������ �����ϴ� 
select hire_date, hire_date+10 from employees;


-- ���̺� ����� 
CREATE TABLE studata (
    stuid   NUMBER(4),
    stuname VARCHAR2(20),
    kor     NUMBER(3),
    eng     NUMBER(3),
    math    NUMBER(3),
    total   NUMBER(5),
    avg     NUMBER(5, 2),
    rank    NUMBER(3)
);


select * from studata;
select * from studata where kor between 90 and 98;
select * from studata where total in(290, 300);
select * from studata where lower(stuname) like '%li%';


