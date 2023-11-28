
-- foreign key -> fk : �����Ǵ� �÷����� �����ϸ� ���
-- �����ͺ��̽��� ������ �� �ϳ��� ���̺����δ� 
-- �ش����̺��� ��ǥ�ϴ� �����͸� �ϳ��� �����ϱ� �����
-- �̷���� ���̺��� �� ���� �� �ܷ�Ű�� ����ؼ� ������ ���̽� �� �� ���̺��� �����ϸ� �ȴ�.

-- create table ���̺��̸� as select * from ���̺��̸�
-- dept01 ���̺��� ����
create table dep01 as select * from departments;
desc dep01;
desc emp01;

-- ���������� department_id�� �ֱ⿡ fk�� �����ؼ� ������ �� �ִ�.
-- �߿� : fk�� �����ϰ������ �θ𰡵Ǵ� ���̺��� primary key Ȥ�� unique�� �Ǿ��Ѵ�.

-- �θ����̺��� uniqueȤ�� primary key ���� ������ �Ǿ��ִ��� Ȯ��
alter table dep01
add constraint uk_d_id unique(department_id);

-- fk�� ���� :
alter table emp01
add CONSTRAINT fk_d_id foreign key(department_id)
references dep01(department_id);

select * from dep01 order by department_id;
-- �θ�Ű�� �ִ� department_id �� �߰��� �� �ִ�. �θ� department_id �� 7�̶� ���� ����
insert into emp01(employee_id, emp_name, salary, department_id)
values (97, "�̼���", 500, "");

-- ����
-- �ܷ�Ű�� ����Ǿ� �־ ������ �� ����.
-- �θ����̺��� �Ժη� ������ �� ���� -> �ڽ����̺�� ������ �Ǿ� �ֱ� ������
delete from dep01 where department_id = 50;
select * from dep01;
select * from emp01;

-- fk �����ϱ�
alter table emp01 drop constraint fk_d_id;


-- on delete cascade
-- ���ǿ� �´� ��� ����� �� ������
alter table emp01
add constraint fk_d_id foreign key (department_id)
references dep01(department_id) on delete cascade;

select * from dep01 where department_id = 50;
select * from emp01 where department_id = 50;

-- join : �Ѱ��̻��� ���̺�� ���̺��� ���� �����Ͽ� ���
-- �������� ������ �� ���� : 
-- �����ϸ鼭 ���� �ʿ��� ������ ���� ���̺� ��� �������� �ִ� ���̺���
-- �����͸� ������ �� �� �ִ�.

-- ��) 124���� �μ��̸��� �˰�ʹ�
select * from employees where employee_id = 124;
-- �μ���ȣ�� �������̺��� ã�Ƽ� - 50��
select department_id from employees where employee_id = 124;
-- 50�� �μ����� �μ����̺��� ã�� �� �ִ�.
select department_name from departments where department_id = 50;


-- cross join : ���Ǿ��� ��� ��Ī�� ���
create table stu01 as select * from studata where stuid between 1 and 10;

select * from stu01;
select * from newmem;
insert into newmem values ('aaa', '1111', 'ȫ�浿', '010-1111-1111',sysdate);
insert into newmem values ('bbb', '2222', '�̼���', '010-1111-1111',sysdate);
commit;

-- cross join
select * from stu01, newmem;

-- ����� ���� �˵� �ǹ̰� ����.
-- ������ ����� �ǹ̸� �������� ������ �ʿ��ϴ�.

-- ������ ���� : ��������, �񵿵�����, �ܺ�����, ��ü������ �ִ�.

-- ���� �⺻�� ���������̴� equi join, inner join
-- inner join (equi join, ��������, ��������): ���� ������ ��Ȯ�� ��ġ�Ҷ� ��ȸ

/*
select ���̺��̸�1.���̸�1 [, ���̺��̸�2.���̸�2....]
from ���̺��̸�1, ���̺��̸�2
where ���̺��̸�1.���̸�1 = ���̺��̸�2.���̸�2

�����̺��� ���� ���� �ִ� �����Ͱ��� �������� ����, �����ϴ� ��ȣ�δ� ��ȣ�� ���
where�� ���̸��� ���� �����ϰ��� �ϴ� ������ �Ǵ� ��

*/
select * from employees, departments
where employees.department_id = departments.department_id;

-- ��Ī�� ����ϸ� �����ϰ� ������ �� �ִ�.
select A.employee_id, A.last_name, B.department_name from employees A, departments B
where A.department_id = b.department_id ;

-- join�ÿ��� ��� ���̺��� �����͸� �����Դ��� ����ؾ� �Ѵ�.
-- �÷����� ��� ���̺� ���ϴ��� �� �� ��� ���� �߻�
select e.employee_id, e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

-- select ������ ����� �� �̸��� ���
-- from ������ �����Ϸ��� ���̺� �̸��� ���
-- where ������ ���������� ���
-- * from �� ���� ������ ��ȸ�� ��Ȯ���� ���� �� �տ� ���̺� �̸��� ���δ�.

select e.employee_id, e.first_name, e.last_name, 
d.department_id, d.departmet_name
from employees e, departments d
where e.department_id = d.department_id;

-- �������� and�� �߰��ؼ� ����� �� �ִ�.

select e.employee_id, e.first_name, e.last_name, 
d.department_id, d.departmet_name
from employees e, departments d
where e.department_id = d.department_id
and e.employee_id = 124 ; 

-- shipping �μ����� ���ϴ� ����� �̸��� �Ի����� ����ϼ���
-- sales �μ����� ���ϴ� ����� ��
-- location_id�� 1800�� ����� �̸��� �޿�
-- �ְ�Ŵ����� �̸��� �μ����� ����ϼ���(manager_id�� ���»��) 

select * from employees;
select * from departments;

select e.first_name, e.last_name, e.hire_date, d.department_name
from employees e, departments d
where e.department_id = d.department_id and d.department_name = 'Shipping';

select count(*) from 
employees e, departments d
where e.department_id = d.department_id and department_name = 'Sales';

select e.first_name|| ' ' || e.last_name �̸�, e.salary, d.location_id
from employees e, departments d
where e.department_id = d.department_id and d.location_id = 1800;

select e.first_name, e.last_name, d.department_name, e.job_id
from employees e, departments d
where e.department_id = d.department_id and e.manager_id is null;

-- �񵿵����� non-equal join. ������ �� �� �ְ� between������ ����ؼ� �ϰ� ��
-- ���� �������� ���Ǿ����� �÷��� ���� '����, �����ʴ�' �� �ƴ϶�
-- Ư�� ������ ���Ҷ� ���Ǿ����� join
-- �ǳ� ����� �ű�� case when�� ���� ������ ���� �񵿵��������� ����� ������

-- employees���̺��� ������ ������� ������ ����
select employee_id, first_name,
    case when salary >= 10001 then 5
        when salary >= 8001 then 4
        when salary >= 5001 then 3
        when salary >= 3001 then 2
        when salary >= 2001 then 1
    end as ���
from employees order by employee_id;        

create table salary_grade(
grade number(2),
low_salary number(6),
high_salary number(6)
);

insert into salary_grade values(1, 2000, 3000);
insert into salary_grade values(2, 3001, 5000);
insert into salary_grade values(3, 5001, 8000);
insert into salary_grade values(4, 8001, 10000);
insert into salary_grade values(5, 10001,99999);
commit;

select * from salary_grade;


select a.employee_id, a.first_name, a.salary, b.grade
from employees a, salary_grade b
where a.salary between b.low_salary and b.high_salary
order by a.employee_id;

-- �񵿵� ������ ����ؼ� studata �л�����
-- ��������� 95-100 A+, 90-94 A, 85-89 B+, 80-84 B, 0-79 C

select * from studata;

create table stu_grade(
grade varchar2(4),
low_grade number(6),
high_grade number(6)
);

select * from stu_grade;
insert into stu_grade values('A+', 95, 100);
insert into stu_grade values('A', 90, 94);
insert into stu_grade values('B+', 85, 89);
insert into stu_grade values('B', 80, 84);
insert into stu_grade values('C', 0, 79);



select a.stuname, a.avg, b.grade
from studata a, stu_grade b
where a.avg between b.low_grade and b.high_grade;

-- self join : �ϳ��� ���̺� ������ ������ �ؾ߸� ���ϴ� �ڷḦ ���� �� ���� �� ���
-- 1���� ���̺�(x)�� �������� x1, x2��� ��Ī�� �ο��ؼ� 
-- 2���� ���̺��ΰ�ó�� ������ �� join


/*
select ����1.���̸� [, ����2.���̸�2..]
from ���̺��̸� ����1, ���̺��̸� ����2
where ����1.���̸� = ����2.���̸�
*/

-- �� ����� �����ϴ� ����� �̸��� �˻��Ѵ�.

select department_id from employees where first_name = 'Adam';

select a.last_name || '�� �����ڴ�' || b.last_name
from employees a, employees b
where a.manager_id = b.employee_id;

select e1.employee_id �����ȣ,
        e1.first_name ||' '|| e1.last_name ����̸�,
        e1.manager_id ����ȣ,
        e1.employee_id ����ǻ����ȣ,
        e2.first_name ||' '|| e2.last_name ����̸�
from employees e1, employees e2
where e1.manager_id = e2.employee_id(+)
order by e1.employee_id;

-- ��簡 steven �� ������� �̸��� ������ ���
-- adamr(firstname)�� ������ �μ����� �ٹ��ϴ� ����� �̸� �⤩��
select employee_id from employees where employee_id = 100;

select e1.employee_id, e1.last_name || ' ' || e1.first_name �̸�, e1.job_id
from employees e1, employees e2
where e1.manager_id = e2.employee_id and  e2.first_name = 'Steven';

select e1.last_name || ' ' || e1.last_name �̸�
from employees e1, employees e2
where e1.department_id = e2.department_id 
and e2.department_id =(select department_id from employees where first_name = 'Adam');

-- outer join : �����Ͱ� ��ġ���� �ʾƵ� �����͸� ����ؾ� �� �� ���
/*
select ���̺��̸�1.���̸�1 [, ���̺��̸�2.���̸�2,.....]
from ���̺��̸�1, ���̺��̸�2
where ���̺��̸�1.���̸�1 = ���̺��̸�2.���̸�2(+)
(+) : �ܺ�����, �����Ͱ� ������ ���� ���
�̳����� ������ �������� ���� �����Ǵ� ���� ����ϱ� ���ؼ� (+)��ȣ�� ���
(+) ��ȣ�� ������ ���� ����, �� �����Ͱ��� ������ ���̺��� �� �̸� �ڿ� ���
(+) ��ȣ�� ���ʿ��� ����� �� �ִ�.
(+) �� ���̸� ������ ���̺� null ���� ���� ���� ������
(+) ��ȣ�� ���ʿ� ������ left outer join
        �����ʿ� ������ right outer join
*/

-- department_id�� ������ ���.
select * from employees where employee_id = 178;
select * from employees where department_id is null;

-- inner join�� �� ��� ����� ����� ���� �ʴ´�.
select * from employees a, departments b
where a.department_id = b.department_id
and a.employee_id = 178;

-- outer join. null�� ������ �Ǹ鼭 join�� �ȴ�.
select * from employees a, departments b
where a.department_id = b.department_id(+)
and a.employee_id = 178;

select * from employees;
select * from departments;

-- �Ŵ����� ���� ����� outer join�غ�����
-- employee_id�� 100 �λ��
select * from employees a, departments b
where a.department_id = b.department_id(+)
and b.manager_id is null;

select * from employees a, departments b
where a.manager_id = b.manager_id(+)
and a.employee_id = 100 ;


select * from employees;
-- luis �� �μ��̸� - inner join
-- luis �̸��� employees���̺� �μ��� �̸��� departments ���̺�
--�̳�����

select b.department_name 
from employees a, departments b 
where a.department_id = b.department_id
and a.first_name = 'Luis';

-- Luis�� ����̸�
-- 1. ����� ��ȣ�� ã�´�

select manager_id from employees where first_name = 'Luis';  -- ���̽��� ���� 108���̴�
-- ���ܷ� luis 2-1. department_name : Finance
select department_name from departments
where department_id = 100;

-- 2. 108���� �ش��ϴ� �̸��� ã�´�.
select first_name from employees where employee_id = 108;
-- 108���� �ش��ϴ� �̸��� nancy�̴�

select * from employees;

select e1.manager_id, e2.first_name
from employees e1, employees e2
where e1.manager_id = e2.employee_id and e1.first_name = 'Luis';

-- ansi join - ����ǥ�� ���� �ӹ��
-- ��������(����Ŭ)
select a.employee_id, b.department_name
from employees a, departments b
where a.department_id = b.department_id;
-- ansi join�� from �� ������ inner join�̶� �ܾ ����� ������ ���̺� �̸��� ���
-- on���� ����ؼ� ���� ������ ���
-- ansi����
select a.employee_id, b.department_name
from employees a inner join departments b
on a.department_id = b.department_id;

-- �ٸ����ǿ� ���ؼ��� where �������� ����

select a.employee_id, b.department_name
from employees a inner join departments b
on a.department_id = b.department_id
where a.employee_id = 100;

-- using�� �̿��� �������� ����
-- using�ȿ� ���� �÷��� ������ �ȴ�.

select a.employee_id, b.department_name
from employees a inner join departments b
using(department_id);

-- natural join
-- �� ���̺��� ���� ���� �÷��� ���ؼ� inner join�� ������ �÷����� ��Ÿ������
-- natural join�� �ϳ��� �÷����� ��Ÿ����.

-- ���� : ǥ�� ���� ������ department_id Į���� 2�� Ȯ�� �� �� �ִ�.
select * from employees a, departments b
where a.department_id = b.department_id;    -- ���� Į���� 2�� ��Ÿ��

-- natural join : ������ department_id �÷��� 1���� ��Ÿ����.
select * from employees natural join departments;

-- outer join - [left | right | full]
-- full = left+right

-- ����
select * from employees a, departments b
where a.department_id = b.department_id(+)
and a.employee_id = 178 ; 

--
select *
from employees a right outer join departments b
using (department_id);

select *
from employees a left outer join departments b
using (department_id)
where a.employee_id = 178;

-- ���տ����� (set operator)
-- select ���� �����ؼ� �ۼ��ϸ� �� select���� ��ȸ����� �ϳ��� ��ġ�ų� �и�
-- ���տ����ڴ� ������, ������, �������� ���� ����

/*
select ���̸�1, ���̸�2, ���̸�3.......
from ���̺��̸�
���տ�����
select ���̸�1, ���̸�2, ���̸�3.......
from ���̺��̸�
[order by ���̸� [asc or desc]]
*/

select department_id from employees order by department_id;
select department_id from departments order by department_id ;

-- union ������ : �ߺ��Ǵ� ���� �ѹ��� ���
select department_id from employees
union
select department_id from departments ; 
-- null (employees���̺� ����) �� ���ԵǾ� �������� �Ǿ��ٴ� ���� �� �� �ִ�.

-- union all : ������, �ߺ��Ǵ� �൵ �״�� ���
select department_id from employees
union all
select department_id from departments ; 

-- intersect(������) : �ߺ��Ǵ� �ุ ���
select department_id from employees
intersect
select department_id from departments ; 

-- minus : ������, ù��° select�� ������� �ι�° select�� ����� ����
select department_id from employees
minus
select department_id from departments ; 

-- ���� ���� ���� �м�
select * from reservation;
-- reserv_no, reserv_date, reserv_time, customer_id, branch, visitor_cnt, cancel
select * from order_info;
-- order_no, item_id, reserv_no, quantity, sales

-- ���� �÷��� ã�Ƽ� ����ѹ�, ������, �����۾��̵�, �ǸŰ��� ����غ�����

select r.reserv_no, r.reserv_date, o.item_id, o.sales
from reservation r, order_info o
where r.reserv_no = o.reserv_no 
order by r.reserv_no;

-- �� �߿��� ������ ��ҵ��� ���� �� (ĵ���� n)
select r.reserv_no, r.reserv_date, o.item_id, o.sales
from reservation r, order_info o
where r.reserv_no = o.reserv_no and r.cancel = 'N'
order by r.reserv_no;

-- �׸��� ���೯¥�� 20170101 - 20171231 �����ΰ� 
select r.reserv_no, r.reserv_date, o.item_id, o.sales
from reservation r, order_info o
where r.reserv_no = o.reserv_no and r.cancel = 'N' 
and r.reserv_date between '20170101' and '20171231'
order by r.reserv_no;

-- ���� ���̸� ��������Ƿ� ��¥�� ����� �ڸ�����
select r.reserv_no, substr(r.reserv_date,1,6), o.item_id, o.sales
from reservation r, order_info o
where r.reserv_no = o.reserv_no and r.cancel = 'N' 
and r.reserv_date between '20170101' and '20171231'
order by r.reserv_no;

-- ������ �׷��ؼ� ���� �� �ǸŰ��� ���
select substr(r.reserv_date,1,6), sum(o.sales)
from reservation r, order_info o
where r.reserv_no = o.reserv_no and r.cancel = 'N' 
and r.reserv_date between '20170101' and '20171231'
group by substr(r.reserv_date,1,6)
order by substr(r.reserv_date,1,6);

-- �߰������� item_id�� M005�ΰ��� �հ踦 ������ũ Į������ ���
-- decode�Լ���� -=> m0005�̸� sales �ƴϸ� 0���� ������ �ȴ�.
select substr(r.reserv_date,1,6), sum(o.sales) ���ǸŰ�,
sum(decode(o.item_id, 'M0005', o.sales, 0)) ������ũ
from reservation r, order_info o
where r.reserv_no = o.reserv_no and r.cancel = 'N' 
and r.reserv_date between '20170101' and '20171231' 
group by substr(r.reserv_date,1,6)
order by substr(r.reserv_date,1,6);



select * from reservation;
select * from order_info;
select * from item;


select substr(r.reserv_date,1,6), sum(o.sales),
sum(decode(o.item_id, 'M0005', o.sales, 0))
from reservation r, order_info o, item i
where r.reserv_no = o.reserv_no and o.item_id = i.item_id
and r.cancel = 'N' 
and r.reserv_date between '20170101' and '20171231' 
group by substr(r.reserv_date,1,6)
order by substr(r.reserv_date,1,6);

select * from order_info;

-- ��ǰ�� ���� �м�
-- ����, m0005 �����, m0002 �Ľ�Ÿ, m0003����, m0004��Ǫ��, m0005 ������ũ
select substr(r.reserv_date,1,6)���� ,
sum(decode(o.item_id, 'M0001+', o.sales, 0)) �����,
sum(decode(o.item_id, 'M0002', o.sales, 0)) �Ľ�Ÿ,
sum(decode(o.item_id, 'M0003', o.sales, 0)) ����,
sum(decode(o.item_id, 'M0004', o.sales, 0)) ��Ǫ��,
sum(decode(o.item_id, 'M0005', o.sales, 0)) ������ũ

from reservation r, order_info o, item i
where r.reserv_no = o.reserv_no and o.item_id = i.item_id
and r.cancel = 'N' 
and r.reserv_date between '20170101' and '20171231' 
group by substr(r.reserv_date,1,6)
order by substr(r.reserv_date,1,6);


-- ��������
-- select ���ȿ� �ٽ� select ���� ����� ����
-- ���������� ����� ���������� �������� ���
-- ���� select������ ���ǽ��� ����� �����Ҷ� 
-- ������ �ٸ����̺��� �����Ͱ��� ��ȸ�ؼ� ���������� �������� ����Ҷ� ������
-- ���������� ()�� ��� ���
-- �������� �����ڴ� ����, �������� �����ڴ� �����ʿ� ���
-- ���������� �������� ���·� ��ø�ؼ� ����� �� �ִ�
--
/*
select ���̸�1, ���̸�2......
from ���̺��̸�
where ���ǽ� ������
                ( select ���̸�1, ���̸�2.....
                    from ���̺��̸�
                    where ���ǽ�);
                    
���������� ���������� �����ڷ� ����ȴ�                    

*/

-- ������ �������� : �ϳ��� ���� �˻��ϴ� ��������
/* =, !=, >, >=, <, <=
*/
-- �������� select������ ���� �Ѱ��� ���� ����� ���������� ����
-- ���ǽ��� where���� ����Ǵ� ���� ������ ������ Ÿ���� ���������� ���������� ���ƾ� �Ѵ�.

-- DE Hann (last_name) �̶�»���� ���� �޿��� �޴� ������� ����غ�����
-- �̻���� �޿��� �˻�
select salary from employees where last_name = 'De Haan';
-- 17000�� ����ؼ� �ٸ� ������ �˻�
select * from employees where salary = 17000;

-- ���������� ���

select * from employees A
where a.salary = (select salary from employees where last_name = 'De Haan');

-- email�� AERRAZUR�� ���� ������ �޴� ����� ���

select * from employees where salary = (select salary from employees where email = 'AERRAZUR');

-- eamil�� LOZER�� ����� �������� ���� ������ �޴� ����� ������ ���

select * from employees where salary > (select salary from employees where email = 'LOZER');

-- ������ �������� : �ϳ� �̻��� ���� �˻��ϴ� ��������
-- ���� : ������ ���������� ����. �ϳ��̻��� ������� ���������� �����ϴ� ��� ���.
-- �����ڷ� in(������), not in(�������̾ƴ�), exists(���� ������ ��ȯ),
-- any(�ּ��� �ϳ��� �����ϸ� ��. or��� ����), all(��θ��� and��� ����) 
/*
in : ���� ���� ã��
any : �˻��� ������ �ϳ� �̻��� �����ϸ� �ȴ�. ã���� ���� ���� �ϳ��� ũ�� true
all : �˻��� ������ ��� �����ؾ��Ѵ�.
> any(), < any(), < all(), > all()
*/

-- �μ��� ���� �޿�
select department_id, min(salary) �����޿� from employees
group by department_id;

select * from employees
where salary in (2100, 6500)
order by salary desc;

-- ������ ��������
select * from employees 
where salary in 
(select min(salary) from employees group by department_id)

order by salary;

select * from employees;

-- last_name�� h�� �����ϴ� ������ ���� �μ��� �������� ���
-- �μ���ȣ 110����� �޿��� ���� ���� �޴� ������� �� ���� �޿��� �޴� ����� �̸��� �޿� ���
-- ���� ��, department_id�� �������� �ʴ� ����� ��

select * from employees where department_id in (select department_id from employees where last_name like upper('h%'));

select * from employees where department_id in (select department_id from employees where lower(last_name) like 'h%');

select first_name, last_name,salary from employees where salary > (select max(salary) from employees where department_id = 110);

select first_name, last_name,salary from employees where salary > all(select salary from employees where department_id = 110);   -- �������� ���Ǻ��� ���δ� Ŀ����

select first_name, last_name,salary from employees where salary > any(select salary from employees where department_id = 110);  -- �������� ���� 2���� �ϳ����ٸ� ũ�� ��

select count(*) from employees where department_id = (select department_id from employees where department_id is null);

select count(*) from employees  a where not exists (select * from departments b where a.department_id = b.department_id);   --???

-- ���߿� �������� : �ϳ��̻��� ���� �˻��ϴ� ��������(�������� �÷�)
-- ���������� ���������� ���ϴ� where���ǽĿ��� �񱳵Ǵ� ���� ������ �϶� ���
-- ���̸��� ������ ������ Ÿ���� �����ؾ��Ѵ�.

-- job_id�� ���� �ñ��� �޴� ����� ����
select job_id, min(salary) �׷캰�޿� from employees group by job_id;

select * from employees a 
where (a.job_id, a.salary) in
(select job_id, min(salary) from employees group by job_id) order by a.salary desc;

-- �μ��� �ִ�޿��� �޴� ������� ����ϼ���
select * from employees where (department_id, salary) in 
(select department_id, max(salary) from employees group by department_id) 
order by employee_id;

select department_id, max(salary) from employees group by department_id;


-- �ζ��� �� : from ���� ���̺� �� �ƴ϶� ���������� ����� �� �ִ�.
-- �� ���������� from �� �ȿ��� ���Ǵ� ���
-- �ش� ���������� '�ζ��κ�'��� �Ѵ�.
-- from ������ ���� ���������� ����� �ϳ��� ���̺� ���� �� ó�� ���ȴ�.
-- ��ġ ������ ���̺�, ��� ���� ������ �Ѵٰ� �ؼ� �ζ��� ���� �Ѵ�.

/*
select ���̸�1, ..
from ���̺� �̸� as ��Ī1, 
    (select ���̸�2 from ���̺��̸� where ���ǽ�) as ��Ī
where ��Ī1.���̸�1 = ��Ī2.���̸�2
*/

select * from employees a, 
(select department_id from departments where department_name = 'IT') b -- ��Ī�� �༭ ��ġ ���̺�ó�� ����Ѵ�.
where a.department_id = b.department_id;

-- �ζ��� ���������� ����ؼ� sales�μ����� ���ϴ� ����� ������ ����ϼ���
-- �ζ��� ���������� ����ؼ� 110�� �μ����� ���ϴ� ����� ������ ����ϼ���

-- group by�� ������ join�� ������
-- �����Լ��� ������ ���������� ����Ѵ�

select * from employees;
select * from departments;

select b.department_name, a.first_name  from employees a, 
(select * from departments where department_name ='Sales') b
where a.department_id = b.department_id;

select a.department_id, a.first_name from employees a,
(select * from departments where department_id = 110) b
where a.department_id = b.department_id;

select  *
from employees a, (select employee_id from employees where department_id = 110) b
where a.employee_id = b.employee_id;

-- �������� �ȿ��� �� ���������� ����� �� �ִ�.
-- �μ���ȣ�� 110�� ��� �޿����� �޿��� ���� �ް�,
-- ��ǥ�� �ƴϸ� 110 �μ��� ������ ���� ������� ��ȸ

-- 110�� �μ��� ��� �޿����� ���� �޴� ���� ���̵� ���
select employee_id from employees 
where salary > (select avg(salary) from employees where department_id = 110);

select * from employees a,
(select employee_id 
from employees 
where salary > 
(select avg(salary) from employees where department_id = 110)) b
where a.employee_id = b.employee_id
and a.manager_id is not null
and a.department_id != 110;

-- studata
select * from studata order by stuid;

-- �л������ ����ϼ���
select stuid, stuname, avg, rank () over(order by total desc) as ��� from studata;

update studata a set rank = 
((select rank () over(order by total desc) as ��� from studata) b
where a.stuid=b.stuid) ;

-- sql �����Լ�

select * from employees;
select * from departments;
-- group by�� ����ؼ� department_id �� ������ ����� ����ϼ���
-- group by�� ����ؼ� job_id�� ������ ����� ����ϼ���

select d.department_id, avg(e.salary) from departments d, employees e 
where d.department_id = e.department_id group by d.department_id;

select e.job_id, avg(e.salary) from departments d, employees e
where d.department_id = e.department_id group by e.job_id;

-- department_id, job_id �� ��� ���� ���
select department_id, job_id, avg(salary)
from employees
group by department_id, job_id
order by department_id;

-- rollup : �ұ׷찣�� �հ踦 ����ϴ� �Լ�
-- rollup�� ����ϸ� group by�� ���� ������ �ұ׷� ��ü ��� ��� ���� �� �ִ�.

select department_id, job_id, avg(salary) from employees
group by rollup(department_id, job_id)
order by department_id;

-- �� ó���� ����� �÷��� ���ؼ� �ұ׷� ���踦 ���ش�.

-- cube : �׸�� �� ���������� �Ұ踦 ���
-- rollup���� �޸� group by���� ����� ��� �÷��� ���ؼ� �ұ׷����踦 ���ش�.

select department_id, job_id, avg(salary) from employees
group by cube(department_id, job_id)
order by department_id;

select job_id, department_id, avg(salary) from employees
group by rollup(job_id, department_id)
order by job_id;

-- grouping set : Ư�� �׸� ���� �Ұ踦 ���
select job_id, department_id, avg(salary) from employees
group by grouping sets(job_id, department_id)
order by job_id;

-- grouping sets�� union all�� ���� ���
select avg(salary) from employees group by department_id
union all
select avg(salary) from employees group by job_id;

-- grouping �� ���������� �׷캰 ���踦 ���ϴ� �Լ��� �ƴ�����
-- �����÷��� ���谡 �Ǿ������� �� 0, �׿ܴ� 1

select case grouping(department_id) when 1 then '���μ�' else to_char(department_id)
    end as �μ�,
    decode(grouping(job_id), 1, '�����å', job_id) as ��å,
    avg(salary) as ��ձ޿�
from employees
group by rollup(job_id, department_id)
order by job_id desc;

-- order_info ���̺��� �����ۺ�, �����(reserv_no) �� �Ǹž��� �հ踦 ���Ͻÿ�
-- ���� �̿���, rollup, cube, grouping sets�� �̿��� ������ ���弼��
-- ��¥ ������ �߰�(cube��)
-- grouping �� ����ؼ� cube ������ ���弼��.


-- grouping :
-- �׷��Լ� (rollup, cube, grouping sets)�� ���� �÷��� ���� ������� ���θ� ��ȯ���ִ� �Լ�
-- ���� �÷��� ����� ���� 0, �׿ܴ� 1 ��ȯ

select * from order_info;
select item_id, substr(reserv_no,1,6), sum(sales) from order_info group by item_id, substr(reserv_no,1,6) order by item_id;

select item_id,  substr(reserv_no,1,6) sum(sales) from order_info  where item_id in ('M0001', 'M0002') group by rollup(item_id, substr(reserv_no,1,6));

select item_id, substr(reserv_no,1,6), sum(sales) from order_info where reserv_no between '201701' and '201707'  group by cube(item_id, reserv_no);


select item_id, substr(reserv_no,1,6), sum(sales) from order_info where reserv_no between '201701' and '201707'  group by grouping sets(item_id, reserv_no);

select 
    case grouping(item_id) when 1 then '����' else item_id end as item_id,
    case grouping(reserv_no) when 1 then '�����' else reserv_no end as reserv_no,
    sum(sales) ����
    from order_info
    group by cube(item_id, reserv_no);

select  
    decode(grouping(item_id),1,'��������',item_id) as ������,
    decode(grouping(substr(reserv_no,1,6),1,'����',substr(reserv_no,1,6)) as ��,
    sum(sales)
     from order_info
     where substr(reserv_no,1,6) between '201701' and '201708'
    group by grouping sets(item_id, substr(reserv_no,1,6));
    
    
create table sb(
sb_id number(2),
sb_name varchar2(10)
);

insert into sb values(1, '����1');
insert into sb values(2, '����2');
insert into sb values(3, '����3');
commit;

create table energy(
    sb_id number(2),
    e_code varchar2(10),
    e_amount number(3)
    );
    
insert into energy values(1, '����', 100);    
insert into energy values(1, '���', 200);
insert into energy values(1, '�ٶ�', 300);
insert into energy values(2, '����', 200);
insert into energy values(2, '���', 300);
insert into energy values(3, '����', 300);
commit;

select * from sb;
select * from energy;

-- 1. inner join
select * from sb s inner join energy e 
on s.sb_id = e.sb_id;

select s.sb_id, e.e_code, sum(e.e_amount)
from sb s inner join energy e
on s.sb_id = e.sb_id
group by rollup(s.sb_id, e.e_code)
order by s.sb_id, sum(e.e_amount)desc;

select s.sb_id, e.e_code, sum(e.e_amount)
from sb s inner join energy e
on s.sb_id = e.sb_id
group by cube(s.sb_id, e.e_code)
order by s.sb_id;

select s.sb_id, e.e_code, sum(e.e_amount)
from sb s inner join energy e
on s.sb_id = e.sb_id
group by grouping sets(s.sb_id, e.e_code, (s.sb_id, e.e_code), ())
order by s.sb_id;

/*
 ���̺� ����Ŭ, ���� �˻�. sql workeheek
http:
*/

-- �μ���, �μ��� ����� �����հ�, �μ��� �����հ� ������ ��Ÿ���� ������ ���弼��

select * from departments;
select * from employees;
-- �μ����̵�, �μ��������հ�, �μ����� ����ϴ� ���̺��� ���弼��.
select d.department_id, sum(e.salary), max(d.department_name)
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id;

-- �μ���, �μ��� ����� �����հ�, �μ��� �����հ� ������ ��Ÿ���� ������ ���弼��
select �μ���, �հ�, rank() over(order by �հ� desc) ����
from(
    select b.department_id, sum(a.salary) as �հ�,
    max(b.department_name) as �μ���
    from employees a, departments b
    where a.department_id = b.department_id
    group by b.department_id);

--�׷���� �� ���������� �����ִ�
-- �÷��� ��ſ� ������ �����ִ�.

select d.department_id, sum(e.salary), max(d.department_name),
rank() over(order by sum(e.salary) desc) as ���޼���
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id;
