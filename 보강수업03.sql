-- group by, having 
/*
	select 컬럼명, 그룹함수(컬럼명)
	from 테이블명
	[where 조건식]
	group by 컬럼명
	[having 조건식]
	[order by 컬럼명]; 
*/

select job_id, salary from employees;
select job_id, avg(salary) from employees
group by job_id
having avg(salary) >= 10000;

-- Q. 부서별, 사원의 수, 월급총합, 월급의 평균(소수2자리), 최대급여, 최소급여를 출력하세요.
-- 부서별: department_id
select department_id, count(*), sum(salary), 
round(avg(salary),2), max(salary), min(salary)
from employees
group by department_id;

-- Q. 월급이 5000 이하인 사람의 수를 부서별로 출력하는데 
--    ++ 부서별 사림의 수가 10명이상인 경우만 출력
select department_id, count(*) from employees
where salary <= 5000
group by department_id
having count(*) > 10 
;

-- Q. 부서별 최대급여를 출력하는데
-- ++ 최대급여가 4500을 초가하는 경우만 출력
select department_id, max(salary) 
from employees
group by department_id
having max(salary)>4500
;


--  rank() over([partition by 열이름a] order by 열이름b)
-- 총 급여순위
select employee_id, department_id, salary,
    rank() over(order by salary) 총급여순위,
    rank() over(partition by department_id order by salary) 파티션
from employees
order by department_id;

-- 오라클에서 분석함수를 사용할때 partition by를 사용해 그룹으로 묶어서 연산할 수 있다. 

-- group by를 사용 
select job_id, avg(salary) from employees
where employee_id between 100 and 110
group by job_id
order by job_id;

select job_id, avg(salary) over(partition by job_id) from employees
where employee_id between 100 and 110
order by job_id;


select employee_id, department_id, salary, 
round(avg(salary) over()) 전체평균, 
round(avg(salary) over(order by employee_id)) 누적평균,
round(avg(salary) over(partition by department_id)) 부서별평균,
round(avg(salary) over(partition by department_id order by employee_id)) 부서별누적평균
from employees
order by employee_id; 


select * from order_info;

-- Q. 아이템별로. 총판매수량, 총판매금액을 출력해보세요
select item_id, sum(sales) as SALE, sum(quantity) as QTY
from order_info
group by item_id
order by sum(sales) desc ;

-- 테이블 전체 복사하기 
create table studata2 as select * from studata;
select * from studata2 order by stuid;

-- 테이블 타입만 복제 생성 
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

-- 현재의 시퀀스를 알 수 있다.
select stu_seq.currval from dual;
-- 다음 시퀀스를 알수 있다
select stu_seq.nextval from dual;

select * from studata3;
desc studata3;
insert into studata3 values (
stu_seq.nextval, '홍길동', 100,100,100,300,100,0);

insert into studata3 values (
stu_seq.nextval, '유관순', 100,100,100,300,100,0);

insert into studata3 values (
stu_seq.nextval, '강감찬', 100,100,100,300,100,0);
commit;

-- 중복없이 기본키로 사용하고자 할때 시퀀스 테이블을 사용한다. 
-- 중복없이 자동 증가되는 테이블로 사용할 수 있다. 
-- 시퀀스는 실행할때마다 증가되고 다시 감소시킬 수 는 없다
-- insert문에서 유용하게 사용할 수 있다. 

-- start with외에는 모두 변경이 가능하다. 
-- 시퀀스 증가값을 1->2 로변경 
alter sequence stu_seq increment by 2;
-- 시퀀스 최대값 변경 
alter sequence stu_seq maxvalue 999999; 

-- 시퀀스 삭제 
drop sequence stu_seq;

insert into studata3 values (
stu_seq.nextval, '이름', 100,100,100,300,100,0);
commit;
select * from studata3;


create table emp01 as 
select employee_id, first_name, salary from employees
where 1=2;

desc emp01;
select * from emp01;
-- Q. emp_seq를 생성해서 emp01테이블에 사원을 3명 입력해보세요. 
-- ++ 사원번호를 23001 부터시작해 하나씩 증가하는 시퀀스 
insert into emp01 values(emp_seq.nextval, '홍길동','10000');
commit;
insert into emp01 values(emp_seq.nextval, '유관순','5000');
insert into emp01 values(emp_seq.nextval, '이순신','7000');



-- DML: 데이터 조작어. 데이터를 직접 삽입, 갱신, 삭제하는 명령어 
--     select, insert, update, delete 

-- 테이블 생성
create table sample_product(
product_id  number(10),
product_name varchar2(30),
manu_date date
);
/*
insert: 테이블에 새로운 행을 삽입할때 사용

insert into 테이블명 [(컬럼명1, 컬럼명2, .....)]
values(데이터값1, 데이터값2....);

*/

insert into sample_product 
values(1,'television',to_date('140101','YYMMDD'));
insert into sample_product 
values(2,'washer',to_date('150101','YYMMDD'));
insert into sample_product
values(3, 'cleaner', to_date('160101','YYMMDD'));
commit; -- 확정(저장)

select * from sample_product;

/*
update : 기존의 데이터 값을 다른 데이터로 변경할 때 사용 

update 테이블명 
set 열이름1=데이터값1 [,열이름2=데이터값2,...]
[where 조건식];

*/

update sample_product
set product_name='tv1' , manu_date = to_date('170101','YYMMDD')
where product_id = 1;
-- rollback;
select * from sample_product;

/* 
delete [from] 테이블명
[where 조건식]; 

where 절을 생략하면 다 삭제된다. 
*/
delete sample_product where product_id=1;
select * from sample_product;

select * from studata3;
commit;
-- Q. studata3의 유관순의 성적을 90점 90점 95점으로 수정해보세요 (update)
update studata3
set kor = 90, eng=90, math=95
--where stuname='유관순';
where stuid=2;

-- Q. 이순신 성적을 삭제해보세요 (delete)
delete studata3 
-- where stuname = '이순신';
-- where stuid=8;
where stuid = (select stuid from studata3 where stuname='이순신');


-- DDL : 데이터 정의어 (테이블과 관련 열을 생성하고 변경하고 삭제하는 명령어)
-- create, alter, drop, rename, truncate
-- 따로 커밋을 하지 않아도 데이터 베이스에 즉각 반영됨. 

-- 테이블에 열 추가하기 
/*
alter table 테이블명
      add(열이름1 데이터타입, 
          열이름2 데이터타입, 
          ...
);

테이블에 이미 행이 있다면 열을 추가 했을때 새로운 열의 데이터는 null로 초기화됨
*/
-- sample_product테이블에 factory 컬럼 추가 
alter table sample_product add (factory varchar2(10));
desc sample_product;
select * from sample_product;

-- 프라이 머리 키 추가 
alter table sample_product add primary key (product_id); 
-- 삭제 
alter table sample_product drop primary key; 

-- 테이블 열 수정하기 
/*
alter table 테이블명
    modify (열이름1 데이터타입, 
            열이름2 데이터타입,
            .....
);

데이터 타입과 지릿수, default value 값 수정 
*/
alter table sample_product modify(factory char(10));
alter table sample_product modify(product_id number(20));

-- 테이블 열(컬럼명) 이름 바꾸기 
/*
alter table 테이블명
rename column (열이름1 to 바꾸려는열이름1);
*/
alter table sample_product rename column factory to factory_name;
select * from sample_product;

-- 테이블 명 변경 
/*
rename 테이블명  to 새로운테이블명;
*/
rename sample_product to sproduct;
desc sproduct;

-- 테이블 열 삭제하기 
/*
alter table 테이블이름
drop column 열이름;
*/
alter table sproduct drop column factory_name;

-- 테이블 내용 삭제하기 
/*
truncate table 테이블명

테이블의 모든데이터가 삭제되지만 구조는 삭제되지 않는다. 
*/
desc sproduct;
select * from sproduct;
truncate table sproduct;

-- 테이블 삭제하기 
/*
drop table 테이블명;
*/
drop table sproduct;

/* CREATE TABLE member (
    id          VARCHAR2(20) PRIMARY KEY,
    pw          VARCHAR2(20),
    name        VARCHAR2(20),
    phone       VARCHAR2(20),
    create_date DATE
); */
-- Q1. email Number(30) 컬럼 추가하기 - alter table add 
alter table member add (email number(30));
-- Q2. email를 varchar2(50)으로 변경하기 - alter table modify 
alter table member modify (email varchar2(50));
-- Q3. pw를 not null로 변경하기 (modify)
alter table member modify (pw not null);
-- Q4. phone 컬럼명을 cell로 변경하기 - alter table rename column 
alter table member rename column phone to cell;
-- Q5. email컬럼 지우기 - alter table drop column
alter table member drop column email;
-- Q6. 모든 테이블 내용 삭제하기 - truncate table 
truncate table member;
-- Q7. member 테이블을 newmem으로 변경하기  rename 
rename member to newmem;
-- Q8. emp01 테이블 삭제하기
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

-- primary key : 널 안되고 중복도 안됨
-- employee_id 100이 이미 존재하기때문에 오류 
insert into emp01(employee_id, emp_name, salary) values(100,'홍길동' ,5000);
-- emp_name이 존재하기때문에 unique 오류
insert into emp01(employee_id, emp_name, salary) values(99, 'Steven King',1000);
-- salary - not null  규칙에 위반이 되어서 오류
insert into emp01(employee_id, emp_name) values(99,'홍길동');

insert into emp01(employee_id, emp_name, salary) values(99,'홍길동',10000);
commit;
select * from emp01 order by employee_id;

-- check 
alter table emp01
    add gender varchar2(10)
    constraint ck_gender
    check(gender in ('M','m','F','f'))
;

insert into emp01(employee_id, emp_name, salary, gender)
values(98,'유관순',5000,'f');
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
-- 제약조건 삭제 
alter table emp01 drop constraint ck_gender;

-- null notnull 
alter table emp01 modify salary null;
alter table emp01 modify salary not null; 

-- unique 삭제 
-- constratint 이름확인
select constraint_name, constraint_type, table_name from user_constraints
where table_name = 'EMP01';
-- 유니크 삭제 
alter table emp01 drop constraint SYS_C007029;

-- unique추가 
alter table emp01 add constraint uk_name unique(emp_name);





