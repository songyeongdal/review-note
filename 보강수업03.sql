-- group by, having 
/*
	select �÷���, �׷��Լ�(�÷���)
	from ���̺��
	[where ���ǽ�]
	group by �÷���
	[having ���ǽ�]
	[order by �÷���]; 
*/

select job_id, salary from employees;
select job_id, avg(salary) from employees
group by job_id
having avg(salary) >= 10000;

-- Q. �μ���, ����� ��, ��������, ������ ���(�Ҽ�2�ڸ�), �ִ�޿�, �ּұ޿��� ����ϼ���.
-- �μ���: department_id
select department_id, count(*), sum(salary), 
round(avg(salary),2), max(salary), min(salary)
from employees
group by department_id;

-- Q. ������ 5000 ������ ����� ���� �μ����� ����ϴµ� 
--    ++ �μ��� �縲�� ���� 10���̻��� ��츸 ���
select department_id, count(*) from employees
where salary <= 5000
group by department_id
having count(*) > 10 
;

-- Q. �μ��� �ִ�޿��� ����ϴµ�
-- ++ �ִ�޿��� 4500�� �ʰ��ϴ� ��츸 ���
select department_id, max(salary) 
from employees
group by department_id
having max(salary)>4500
;


--  rank() over([partition by ���̸�a] order by ���̸�b)
-- �� �޿�����
select employee_id, department_id, salary,
    rank() over(order by salary) �ѱ޿�����,
    rank() over(partition by department_id order by salary) ��Ƽ��
from employees
order by department_id;

-- ����Ŭ���� �м��Լ��� ����Ҷ� partition by�� ����� �׷����� ��� ������ �� �ִ�. 

-- group by�� ��� 
select job_id, avg(salary) from employees
where employee_id between 100 and 110
group by job_id
order by job_id;

select job_id, avg(salary) over(partition by job_id) from employees
where employee_id between 100 and 110
order by job_id;


select employee_id, department_id, salary, 
round(avg(salary) over()) ��ü���, 
round(avg(salary) over(order by employee_id)) �������,
round(avg(salary) over(partition by department_id)) �μ������,
round(avg(salary) over(partition by department_id order by employee_id)) �μ����������
from employees
order by employee_id; 


select * from order_info;

-- Q. �����ۺ���. ���Ǹż���, ���Ǹűݾ��� ����غ�����
select item_id, sum(sales) as SALE, sum(quantity) as QTY
from order_info
group by item_id
order by sum(sales) desc ;

-- ���̺� ��ü �����ϱ� 
create table studata2 as select * from studata;
select * from studata2 order by stuid;

-- ���̺� Ÿ�Ը� ���� ���� 
create table studata3 as select * from studata where 1=2;
select * from studata3;
desc studata3;

/*
create sequence test_seq
increment by 1
start with 1
maxvalue 100000
minvalue 1; 
*/

-- ������ �������� �� �� �ִ�.
select stu_seq.currval from dual;
-- ���� �������� �˼� �ִ�
select stu_seq.nextval from dual;

select * from studata3;
desc studata3;
insert into studata3 values (
stu_seq.nextval, 'ȫ�浿', 100,100,100,300,100,0);

insert into studata3 values (
stu_seq.nextval, '������', 100,100,100,300,100,0);

insert into studata3 values (
stu_seq.nextval, '������', 100,100,100,300,100,0);
commit;

-- �ߺ����� �⺻Ű�� ����ϰ��� �Ҷ� ������ ���̺��� ����Ѵ�. 
-- �ߺ����� �ڵ� �����Ǵ� ���̺�� ����� �� �ִ�. 
-- �������� �����Ҷ����� �����ǰ� �ٽ� ���ҽ�ų �� �� ����
-- insert������ �����ϰ� ����� �� �ִ�. 

-- start with�ܿ��� ��� ������ �����ϴ�. 
-- ������ �������� 1->2 �κ��� 
alter sequence stu_seq increment by 2;
-- ������ �ִ밪 ���� 
alter sequence stu_seq maxvalue 999999; 

-- ������ ���� 
drop sequence stu_seq;

insert into studata3 values (
stu_seq.nextval, '�̸�', 100,100,100,300,100,0);
commit;
select * from studata3;


create table emp01 as 
select employee_id, first_name, salary from employees
where 1=2;

desc emp01;
select * from emp01;
-- Q. emp_seq�� �����ؼ� emp01���̺� ����� 3�� �Է��غ�����. 
-- ++ �����ȣ�� 23001 ���ͽ����� �ϳ��� �����ϴ� ������ 
insert into emp01 values(emp_seq.nextval, 'ȫ�浿','10000');
commit;
insert into emp01 values(emp_seq.nextval, '������','5000');
insert into emp01 values(emp_seq.nextval, '�̼���','7000');



-- DML: ������ ���۾�. �����͸� ���� ����, ����, �����ϴ� ��ɾ� 
--     select, insert, update, delete 

-- ���̺� ����
create table sample_product(
product_id  number(10),
product_name varchar2(30),
manu_date date
);
/*
insert: ���̺� ���ο� ���� �����Ҷ� ���

insert into ���̺�� [(�÷���1, �÷���2, .....)]
values(�����Ͱ�1, �����Ͱ�2....);

*/

insert into sample_product 
values(1,'television',to_date('140101','YYMMDD'));
insert into sample_product 
values(2,'washer',to_date('150101','YYMMDD'));
insert into sample_product
values(3, 'cleaner', to_date('160101','YYMMDD'));
commit; -- Ȯ��(����)

select * from sample_product;

/*
update : ������ ������ ���� �ٸ� �����ͷ� ������ �� ��� 

update ���̺�� 
set ���̸�1=�����Ͱ�1 [,���̸�2=�����Ͱ�2,...]
[where ���ǽ�];

*/

update sample_product
set product_name='tv1' , manu_date = to_date('170101','YYMMDD')
where product_id = 1;
-- rollback;
select * from sample_product;

/* 
delete [from] ���̺��
[where ���ǽ�]; 

where ���� �����ϸ� �� �����ȴ�. 
*/
delete sample_product where product_id=1;
select * from sample_product;

select * from studata3;
commit;
-- Q. studata3�� �������� ������ 90�� 90�� 95������ �����غ����� (update)
update studata3
set kor = 90, eng=90, math=95
--where stuname='������';
where stuid=2;

-- Q. �̼��� ������ �����غ����� (delete)
delete studata3 
-- where stuname = '�̼���';
-- where stuid=8;
where stuid = (select stuid from studata3 where stuname='�̼���');


-- DDL : ������ ���Ǿ� (���̺�� ���� ���� �����ϰ� �����ϰ� �����ϴ� ��ɾ�)
-- create, alter, drop, rename, truncate
-- ���� Ŀ���� ���� �ʾƵ� ������ ���̽��� �ﰢ �ݿ���. 

-- ���̺� �� �߰��ϱ� 
/*
alter table ���̺��
      add(���̸�1 ������Ÿ��, 
          ���̸�2 ������Ÿ��, 
          ...
);

���̺� �̹� ���� �ִٸ� ���� �߰� ������ ���ο� ���� �����ʹ� null�� �ʱ�ȭ��
*/
-- sample_product���̺� factory �÷� �߰� 
alter table sample_product add (factory varchar2(10));
desc sample_product;
select * from sample_product;

-- ������ �Ӹ� Ű �߰� 
alter table sample_product add primary key (product_id); 
-- ���� 
alter table sample_product drop primary key; 

-- ���̺� �� �����ϱ� 
/*
alter table ���̺��
    modify (���̸�1 ������Ÿ��, 
            ���̸�2 ������Ÿ��,
            .....
);

������ Ÿ�԰� ������, default value �� ���� 
*/
alter table sample_product modify(factory char(10));
alter table sample_product modify(product_id number(20));

-- ���̺� ��(�÷���) �̸� �ٲٱ� 
/*
alter table ���̺��
rename column (���̸�1 to �ٲٷ��¿��̸�1);
*/
alter table sample_product rename column factory to factory_name;
select * from sample_product;

-- ���̺� �� ���� 
/*
rename ���̺��  to ���ο����̺��;
*/
rename sample_product to sproduct;
desc sproduct;

-- ���̺� �� �����ϱ� 
/*
alter table ���̺��̸�
drop column ���̸�;
*/
alter table sproduct drop column factory_name;

-- ���̺� ���� �����ϱ� 
/*
truncate table ���̺��

���̺��� ��絥���Ͱ� ���������� ������ �������� �ʴ´�. 
*/
desc sproduct;
select * from sproduct;
truncate table sproduct;

-- ���̺� �����ϱ� 
/*
drop table ���̺��;
*/
drop table sproduct;

/* CREATE TABLE member (
    id          VARCHAR2(20) PRIMARY KEY,
    pw          VARCHAR2(20),
    name        VARCHAR2(20),
    phone       VARCHAR2(20),
    create_date DATE
); */
-- Q1. email Number(30) �÷� �߰��ϱ� - alter table add 
alter table member add (email number(30));
-- Q2. email�� varchar2(50)���� �����ϱ� - alter table modify 
alter table member modify (email varchar2(50));
-- Q3. pw�� not null�� �����ϱ� (modify)
alter table member modify (pw not null);
-- Q4. phone �÷����� cell�� �����ϱ� - alter table rename column 
alter table member rename column phone to cell;
-- Q5. email�÷� ����� - alter table drop column
alter table member drop column email;
-- Q6. ��� ���̺� ���� �����ϱ� - truncate table 
truncate table member;
-- Q7. member ���̺��� newmem���� �����ϱ�  rename 
rename member to newmem;
-- Q8. emp01 ���̺� �����ϱ�
drop table emp01;
select * from emp01;

create table emp01(
employee_id number(6) primary key,
emp_name varchar2(20) unique,
salary number(8,2) not null, 
manager_id number(6),
department_id number(6)
);

insert into emp01(employee_id, emp_name, salary, manager_id, department_id)
select employee_id, first_name||' '|| last_name, salary, manager_id, 
department_id from employees;
commit;
select * from emp01;

-- primary key : �� �ȵǰ� �ߺ��� �ȵ�
-- employee_id 100�� �̹� �����ϱ⶧���� ���� 
insert into emp01(employee_id, emp_name, salary) values(100,'ȫ�浿' ,5000);
-- emp_name�� �����ϱ⶧���� unique ����
insert into emp01(employee_id, emp_name, salary) values(99, 'Steven King',1000);
-- salary - not null  ��Ģ�� ������ �Ǿ ����
insert into emp01(employee_id, emp_name) values(99,'ȫ�浿');

insert into emp01(employee_id, emp_name, salary) values(99,'ȫ�浿',10000);
commit;
select * from emp01 order by employee_id;

-- check 
alter table emp01
    add gender varchar2(10)
    constraint ck_gender
    check(gender in ('M','m','F','f'))
;

insert into emp01(employee_id, emp_name, salary, gender)
values(98,'������',5000,'f');
commit;
select * from emp01 order by employee_id;

/*
create table emp02(
employee_id number(6) primary key,
emp_name varchar2(20) unique,
salary number(8,2) not null, 
manager_id number(6),
department_id number(6),
gender varchar2(10),
CONSTRAINT ck_gender check(gender in ('M','m','F','f'))
);
*/
-- �������� ���� 
alter table emp01 drop constraint ck_gender;

-- null notnull 
alter table emp01 modify salary null;
alter table emp01 modify salary not null; 

-- unique ���� 
-- constratint �̸�Ȯ��
select constraint_name, constraint_type, table_name from user_constraints
where table_name = 'EMP01';
-- ����ũ ���� 
alter table emp01 drop constraint SYS_C007029;

-- unique�߰� 
alter table emp01 add constraint uk_name unique(emp_name);





