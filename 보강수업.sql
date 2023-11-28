-- 정렬 기본 : asc
-- 숫자는 작은값부터, 문자는 사전순서로, 날짜는 빠른날짜부터, null은 가장 마지막
select * from employees 
order by salary ;
-- 역순정렬 : desc

select * from employees
order by salary desc;

-- 부서번호는 순차정렬, 분서번호가 같은경우 월급을 역순으로
select department_id, salary from employees
order by department_id, salary desc ;                     -- 순서대로 정렬하는것 같음.

select * from employees
order by employee_id, hire_date desc ;

-- 문자길이를 구하기
-- length : 컬럼의 문자열 길이를 반환, 공백을 포함한 문자열의 길이
-- lengthb : 컬럼의 문자열 바이트수를 반환함
-- 영문자(1바이트) 공백(1바이트) 한글(3바이트)
select first_name, length(first_name), lengthb(first_name) from employees ;

-- lower : 소문자로 변환
select first_name, lower(first_name) from employees ;

-- upper : 대문자로 봔환
select first_name, upper(first_name) from employees;

-- substr : 문자열을 추출
-- substr('jones',2) 문자열의 두번째 위치 즉 o부터 끝까지 자른다
select substr('jones', 2) from dual ;
select substr('jones', 1, 2) from dual;     -- j부터 o까지(1번째부터 2번째까지)

select first_name, substr(first_name, 1, 4) from employees;
select first_name, substr(first_name, 3) from employees;     -- 3번째부터 끝까지 글자를 잘라서 보여줘
select first_name, substr(first_name, -1) from employees ;   -- -1은 제일 마지막꺼

--  dual은 오라클 자체 제공 테이블로 한열이 이루어진 임시테이블이다.
-- 주로 사용자가 함수(계산)을 할때 임시로 사용한다.
--select sysdate from dual (현재날짜)

select '1'+'2' from dual ;
-- 원래 숫자 더하기 문자는 불가능한데 오라클에서 해준다.

-- instr : 특정문자위치찾기. 'hello.txt', '.' -> hello.txt에서 .에 위치를 찾아줘
select 'hello.txt', instr('hello.txt', '.'), substr('hello.txt', instr('hello.txt','.')+1)
from dual;

-- 'studata.sql'에서 sql 추출해보기

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
values('aaa', '       1111', '홍      길동', '010-1111-111      ');
commit;
select * from member;

select length(pw) from member;

-- replace : 문자대체, 뭐를 뭐로 바꿔준다 -> 공백이 있으면 공백을 지울수있다
select name from member;
select name, replace(name, ' ', '') from member; 

-- trim, ltrim, rtrim
-- trim : 문자열의 양쪽 공백을 제거
-- ltrim : 문자열 왼쪽 공백제거
-- rtrim : 문자열 오른쪽 공백제거

select trim('     공백     '),
    ltrim  (rtrim('        공백있음       ')) from dual; 

-- update set를 활용해서 공백을 제거시키고 저장하기
update member set pw = ltrim(pw) ;
commit;

select phone, length(phone) from member;
-- 폰 번호의 공백을 제거하여 저장해보세요

update member set phone = rtrim(phone);
commit;
select * from member;
update member set phone = replace(phone, ' ', '');

--concat : 문자열 합치기
select concat(id, concat('-',pw)) from member;
select id||'-'||pw from member;

select first_name, last_name from employees ;
select first_name || ' ' || last_name as "이름" from employees;

-- 특정 문자 채우기 : lpad, rpad
select rpad(id, 10 , '*') from member ;    -- 총 10자리를 만드는데 뒤에 남은 자리에 *을 채워라

-- sysdate : 현재 시간(날짜)
select sysdate, sysdate+1, sysdate-1 from dual ;
-- months_between : 두 날짜 사이가 몇개월인지 반환
select first_name, sysdate, hire_date, months_between(sysdate, hire_date) from employees;

select sysdate, '23/10/07', months_between(sysdate, to_date('23/10/07')) from dual;  -- to_date : 날짜로 바꿔주는 함수
 
-- ㅁadd months()
select sysdate, add_months(sysdate, 6) from dual ;

-- to_char() 문자형으로 반환하는 함수
select sysdate,
        to_char(sysdate, 'YY'),
        to_char(sysdate, 'YYYY'),
        to_char(sysdate, 'MM'),
        to_char(sysdate, 'MON'),
        to_char(sysdate, 'YYYYMMDD'),
        to_char(to_date('20171008'), 'YYYYMMDD')    -- 오라클에선 문자를 알아서 날짜로 인식하진 못하는듯. to_date를 붙여줘야 날짜로 인식하는듯
        FROM DUAL;
        
-- to_number() : 숫자로 변환
select to_number('123') from dual ;

-- to_date() 문자형을 날짜형으로 반환하는 함수
select to_date('20171007', 'YYYYMMDD') from dual ;

-- 수학적인 함수들
-- abs : 절대값
select -10, abs(-10) from dual ;

select floor(10.3245) from dual ;  -- floor : 버림
-- round : 반올림
select round(10.3245) from dual ;
select round(10.3455, 3) from dual ;
select round(10.9876, -1) from dual ;
select round(19.9876, -1) from dual ;

select round(salary/3, 0) from employees;

-- trunc : 특정 자리수에서 버림
select trunc(34.5678, 2) from dual ;
select trunc(round(salary/3,1)) from employees; 

-- mod : 입력받은 수를 나눈 나머지값을 반환
select mod(27,2) from dual ;

select * from studata;
select * from studata
where mod(stuid,2)=1
order by stuid;

-- 사원번호가 짝수만 출력
select * from employees
where mod(employee_id,2)=0
;

-- 함수
-- 순위함수
-- rank() : 공통순위를 출력하되, 공통순위만큼 건너뛰어 다음 순위를 출력
-- dense_rank() : 공통순위를 출력하되 건너뛰지 않고 바로 다음 순위를 출력
-- row_number() : 공통순위없이 출력

/*
rank() over([partition by 열이름a] order by 열이름a)    대괄호 : 생략가능
열이름 b : 그룹으로 순위를 묶어서 순위를 매겨야 할때 사용
열이름 a : 순위를 매길 열
*/

select employee_id, salary,
rank() over(order by salary desc) as "rank_급여",
dense_rank() over(order by salary desc) as "dense_rank급여",
row_number() over(order by salary desc) as "row_number_급여"               -- row number은 정렬한 다음 순위를 부여한대
from employees
where empployee_id between  100 and 106 ;

-- 학생의 성적을 총점순으로 정렬하세요

 
select total, rank() over(order by total desc) as "총점",
dense_rank() over(order by total desc) as "총점2",
row_number() over(order by total desc) as "총점3"
from studata;


select * from studata;
--select row_number() over(order by

select stuid, stuname, total, 
    row_number() over(order by total desc) 순위
    from studata
    order by total desc;
    
-- nvl () null 값 치환 함수
select commission_pct, salary * nvl(commission_pct,1)
from employees
where employee_id between 100 and 106
order by commission_pct;

--decode(열이름, 조건값, 치환값, 기본값)
-- 어떤 열이름에 대해 조건값일때 조건에 해당하는 어떤값을 치환한다.

-- nvl(입력값, 대체값) 널값 치환 함수select commission_pct, salary * nvl(commission_pct,1)
select commission_pct, salary, salary*commission_pct ,salary*nvl(commission_pct,1)
from employees
where employee_id between 100 and 106
order by commission_pct;

-- nvl2(입력값, notnull대체값, null대체값)
select employee_id , commission_pct, salary, salary*nvl2(commission_pct,0,1)
from employees
where employee_id between 143 and 148
order by commission_pct;

-- nullif(값1,값2) : 만약에 값1이 값2면 null로 바꿔줘라
select employee_id, commission_pct, salary, nullif(salary, 2600)
from employees
where employee_id between 143 and 148
order by commission_pct;

--decode(열이름, 조건값, 치환값, 기본값)
-- 어떤 열 이름에 대해 조건값일때 조건에 해당하는 어떤값을 치환한다.
select first_name,
last_name,
department_id,
salary 원래급여,
decode(department_id, 60, salary*1.1, salary) 조정된급여,
decode(department_id, 60, '10%인상', '미인상') 인상여부
from employees
where employee_id between 100 and 106;

-- 만약에 department_id 가 100일때 'IT'로 표현 그외에는 다른부서
select * from employees;

select first_name, last_name, department_id,
decode(department_id, 100, 'IT', 
                       90, 'HR', '그외') ID      -- 100일땐 IT, 90일땐 HR 나머지는 그외
from employees
order by department_id desc;

-- case : 다양한 조건이 주어질때, 파이썬의 if문 느낌이남

/*
case
    when 조건1 then 출력1
    when 조건2 then 출력2
    ....
    else 출력3
end as 별명
*/
select employee_id, first_name, last_name, salary,
    case
        when salary >= 9000 then '상위급여'
        when salary between 6000 and 8999 then '중위급여'
        else '하위급여'
     end as 급여등급
from employees 
where job_id = 'IT_PROG';

-- employee_id, first_name, job_id를 출력하는 쿼리
-- ++ department_id 가 10일때 'admin', 40일때 HR, 60일때 IT 그외는 'N/A'로 출력

select employee_id, first_name, job_id, department_id, manager_id,
    case
        when department_id = 10 then 'admin'
        when department_id = 40 then 'HR'
        when department_id = 60 then 'IT'
        else 'N/A'
      end as job_title  
from employees
where employee_id between 199 and 204;

-- and or 도 함께 사용할 수 있다.
select employee_id, first_name, job_id, department_id, manager_id,
    case
        when department_id = 10 and manager_id = 101 then 'admin'    -- and라 조건 2개 다 맞족해야 admin이 나옴
        when department_id = 40 and manager_id = 101 then 'HR'
        when department_id = 60 then 'IT'
        else 'N/A'
      end as job_title  
from employees
where employee_id between 199 and 204;

-- 그룹함수 : 열에 대해서 계산.. count, sum, avg 뭐 이런거
-- count() : 행의 개수를 셈. count(*) : null도 센다

select count(*) from employees;
select count(*), count(employee_id), count(manager_id)
from employees;

select count(*), count(manager_id),  count(commission_pct) from employees;

select commission_pct from employees;
select count(commission_pct), count(*)-count(commission_pct) from employees;       -- > 전체-받는사람 = 안받는사람

select count(*) from employees where commission_pct is null;

--sum() 합계
select sum(salary) from employees;
select sum(salary) as 총월급여,
        sum(salary)*0.1 as 인상분,
        sum(salary)*1.1 as 변경후_총월급여
from employees;

select sum(salary) as 총월급여,
        floor(sum(salary)*0.1) as 인상분,
        sum(salary)*1.1 as 변경후_총월급여
from employees;

-- avg() 평균함수
select trunc(avg(salary),2) from employees;
select count(*), avg(salary) from employees;

-- max(최대값)
select max(total) from studata;
select max(salary) from employees;
-- min(최소값)
select min(total) from studata;
select min(salaryfasd) from employees;

-- where절에도 select문을 사용 할 수 있다.
select first_name, salary from employees
where salary<(select avg(salary) from employees);

-- department_id가 10인 사람들 중에서 커미션을 받는 사원의 수
-- department_id가 60인 사람들의 월급의 합
-- 월급이 평균이상인 사람들의 수

select * from employees order by department_id;

select count(commission_pct) from employees             -- count 함수로 null이 아닌 값을 찾는다
where department_id = 10;

select count(*) from employees
where commission_pct is not null and department_id = 10;

select sum(salary) from employees where department_id = 60;
select * from employees where department_id = 60;

select count(*) from employees
where salary >= (select avg(salary) from employees) ;

-- group by : 합계, 평균, 최대값, 최소값 등 어떠한 컬럼을 기준으로 그 컬럼의 값 별로 보고자 할때 group by 절 뒤에 해당 컬럼을 기술
-- group by 뒤에는 반드시 컬럼명을 기술해야 함(별칭은안됨)

-- select 컬렴명, 그룹함수(컬럼명)
-- from 테이블명
-- [where 조건식]
-- group by 컬럼명
-- [order by 컬럼명]
-- 예) select A, sum(B) group by A ;

select job_id, salary from employees;
select job_id, avg(salary) from employees
group by job_id;

select job_id 직무, sum(salary) 직무별_총급여, avg(salary) 직무별_평균급여
from employees 
where employee_id>=10
group by job_id
order by 직무별_총급여 desc, 직무별_평균급여;

select department_id, sum(salary), count(*)
from employees
group by department_id
order by department_id;

select * from employees;
-- 부서별로 사원수와 커미션을 받는 사원수 계산
-- 소속부서별 최대급여와 최소급여

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
-- select 절 조건을 사용하여 결과를 제한할때는 where절을 사용하지만
-- 그룹의 결과를 제한할때는 having절을 사용한다.
-- 즉, 그룹으로 묶여진 결과값에 대해 다시 조건을 주는 경우
-- group by의 결과가 적용된 절에 having 조건을 주는 것
/*
select 컬럼명, 그룹함수(컬럼명)
from 테이블명
[where 조건식]
group by 컬럼명
[having 조건식]
[order by 컬럼명]
*/

-- 예) 부서별로 그룹을 만든 후 그룹지어진 부서별 평균 급여가 5000 이상인 부서번호와 평균급여
select department_id, round(avg(salary),2) 
from employees 
group by department_id 
having avg(salary) >= 5000;

select job_id 직무, sum(salary) 직무별_총급여, avg(salary) 직무별_평균급여
from employees
where employee_id > 100
group by job_id
having sum(salary) > 50000
order by 직무별_총급여 desc;

select job_id, salary from employees;
select job_id, avg(salary) from employees group by job_id
having avg(salary) >= 10000;

-- 부서별, 사원의 수, 월급총합, 월급의 평균(소수2자리), 최대급여, 최소급여를 출력하세요
select department_id, count(*), sum(salary), round(avg(salary),2), max(salary), min(salary) 
from employees
group by department_id
order by department_id;

-- 월급이 5000이하인 사람의 수를 부서별로 출력하는데 부서별 사람의 수가 10명 이상인 경우만 출력
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




-- 부서별 최대급여를 출력하는데 최대급여가 4500을 초과하는 경우만 출력
select department_id, max(salary) from employees
group by department_id
having max(salary) > 4500
order by department_id;

-- rank() over([partition by 열이름a] order by 열이름b)
select employee_id, department_id, salary, 
    rank() over(order by salary) 총급여순위,
    rank() over(partition by department_id order by salary) 파티션
from employees
order by department_id, salary;

-- 오라클에서 분석함수를 사용할 때 partition by 를 사용해 그룹으로 묶어서 연산할 수 있다.

-- group by를 사용
select job_id, avg(salary) from employees
where employee_id between 100 and 110
group by job_id
order by job_id;

select job_id, avg(salary) over (partition by job_id) from employees
where employee_id between 100 and 110
order by job_id;

select employee_id, department_id, salary,
round(avg(salary) over() ) 전체평균,
round(avg(salary) over(order by employee_id)) 누적평균,
round(avg(salary) over(partition by department_id)) 부서별평균,
round(avg(salary) over(partition by department_id order by employee_id)) 부서별누적평균
from employees
order by employee_id;

select * from tab;

select * from order_info;

-- item별로 총판매양, 총판매금액을 출력해보세요
select item_id, sum(quantity), sum(sales)
from order_info
group by item_id
order by sum(sales) desc;

-- 테이블 전체 복사하기
create table studata2 as select * from studata;
select * from studata2 order by stuid;

-- 테이블 타입만 복제생성
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

--현재의 시퀀스를 알 수 있다.
select stu_seq.currval from dual;  --  근데 먼저 내가 쓸거를 부르고나서 해야함
-- 다음 시퀀스를 알 수 있다.
select stu_seq.nextval from dual;  --한번 nextval을 사용하게 되면 시퀀스의 값을 되돌릴수 없음.

select * from studata3;

insert into studata3 values(
stu_seq.nextval, '홍길동', 100,100,100,300,100,0);            -- nextval : netxvalue.

select * from studata3;

insert into studata3 values(
stu_seq.nextval, '유관순', 100,100,100,300,100,0); 


-- 중복없이 기본키로 사용하고자 할때 시퀀스 테이블을 사용한다.
-- 중복없이 자동 증가되는 테이블로 사용할 수 있다.
-- 시퀀스는 실행할때마다 증가되고 다시 감소시킬수는 없다
-- insert문에서 유용하게 사용할 수 있다

-- start with 외에는 모두 변경이 가능하다
-- 시퀀스 증가값을 1->2로 변경할수 있다.
alter sequence stu_seq increment by 2 ;

-- 시퀀스 최대값 변경
alter sequence stu_seq maxvalue 999999;

-- 시퀀스 삭제
drop sequence ste_seq;

create table emp01 as select employee_id, first_name, salary from employees
where 1=2;

desc emp01;

-- emp_seq를 생성해서 emp01테이블에 사원을 3명 입력해보세요.
-- 사원번호를 2023001 부터 시작해 하나씩 증가하는 시퀀스

select emp_seq.currval from dual;

insert into emp01 values
(emp_seq.nextval, '이름1', 1000);

select * from emp01;

insert into emp01 values
(emp_seq.nextval, '이름2', 2000);

select emp_seq.currval from dual;

select emp_seq.nextval from dual;

insert into emp01 values
(emp_seq.nextval, '이름3', 2000);

select * from emp01;das

-- DML : 데이터 조작어. 데이터를 직접 삽입, 갱신, 삭제하는 명령어
-- select, insert, update, delete

-- 테이블 생성
create table sample_product(
product_id number(10),
product_name varchar2(30),
manu_date date
);
desc sample_product;
-- dml 조작어를 써보자
/*
insert : 테이블에 새로운 행을 삽입할때 사용
insert into 테이블명 [(컬럼명1, 컬럼명2, ....)]
values(데이터값1, 데이터값2.....);
*/
--DATE라는 형식이 있을때는 무조건 꼭 오라클에 TO_DATE를 써줘야함




insert into sample_product
values(1, 'television', to_date('140101', 'YYMMDD'));
insert into sample_product
values(2, 'wahser', to_date('150101', 'YYMMDD'));
insert into sample_product
values(3, 'cleaner', to_date('160101','YYMMDD'));

select * from sample_product;
commit;   -- 확정 (저장)

/* update : 기존의 데이터 값을 다른 데이터로 변경할때 사용. 커밋하고나서 데이터 잘못들어간걸 알면 update로 바꿀수 있음

update 테이블명
set 열이름1=데이터값1 [,열이름2=데이터값2,...]
[where 조건식];
*/

update sample_product
set product_name='tv', manu_date = to_date('170101', 'YYMMDD')
where product_id = 1 ;           -- where을 안쓰면 뭐를 바꿀지를 안썼기에 전체 열의 내용이 다 바뀜
commit;
select * from sample_product;

/* 
delete [from] 테이블명
[where 조건식];  where 안쓰면 내용이 다 사라짐

*/

delete sample_product where product_id=1;
select * from sample_product;
rollback;

delete sample_product;
rollback;

-- studata3의 유관순의 성적을 90점 90점 95점으로 수정해보세요
select * from studata3;
desc studata3;
update studata3 
set kor=90, eng=90, math=95
where stuid=2;

select * from studata3;

-- 이순신 성적을 삭제해 보세요
insert into studata3 
values(3,'이순신', 50, 90, 50, 70, 30,0);

select * from studata3;
commit;

delete from studata3 where stuid=3;
rollback;

update studata3 
set kor = 60, avg = 90
where stuname = '이순신';


-- DDL : 데이터 정의어(테이블과 관련 열을 생성하고 변경하고 삭제하는 명령어)
-- create, alter, drop, rename, truncate
-- 따로 커밋을 하지 않아도 데이터 베이스에 즉각 반영됨

-- 테이블에 열 추가하기
/*
alter table 테이블명
    add(열이름1 데이터타입,
        열이름2 데이터타입,
        ....
        );
테이블에 이미 행이 있다면 열을 추가 했을 때 새로운 열의 데이터는 null로 초기화됨
*/
-- sample_product테이블에 factory 컬럼 추가
alter table sample_product add(factory varchar2(10));
desc sample_product;
select * from sample_product; 

-- 프라이 머리 키 추가
alter table sample_product add primary key(product_id);
-- 프라이 머리 키 삭제
alter table sample_product drop primary key;

-- 테이블 열 수정하기
/*
alter table 테이블명
    modify(열이름1 데이터타입,
            열이름2 데이터타입,
            ....
);
데이터 타입과 자릿수 defalut value 값 수정
*/
alter table sample_product modify(factory char(10));
desc sample_product;
alter table sample_product modify(product_id number(20));

-- dml : 각각의 데이터 변경
-- ddl : 전체적인 테이블의 값을 변경. null, 데이터타입 등등

-- 테이블 열 이름 바꾸기
/*
alter table 테이블명
rename column(열이름1 to 바꾸려는 열이름1);
*/
alter table sample_product rename column factory to factory_name;
select * from sample_product;

-- 테이블 명 변경
/*
rename 테이블명 to 새로운 테이블명;
*/
rename sample_product to sproduct;
desc sproduct;

-- 테이블 열 삭제하기
/*
alter table 테이블이름
drop column 열이름 ;
*/
alter table sproduct drop column factory_name;
desc sproduct;

-- 테이블 내용 삭제하기
/*
truncate table 테이블명
테이블의 모든 데이터가 삭제되지만 구조는 삭제되지 않는다
*/
select * from sproduct;
truncate table sproduct;
desc sproduct;

-- 테이블 삭제하기
/* 
drop table 테이블명;
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

-- email Number(30) 컬럼 추가하기
-- email를 varchar2(50)으로 변경하기
-- pw를 not null로 변경하기 (modify)
-- phone 컬럼명을 cell로 변경하기
-- email 컬럼 지우기
-- 모든 테이블 내용 삭제하기
-- member 테이블을 newmem으로 변경하기

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


-- unique : 중복안됨
create table emp01(
employee_id number(6) primary key,
emp_name varchar2(20) unique,
salary number(8,2) not null,
manager_id number(6),
department_id number(6)
);

insert into emp01(employee_id, emp_name, salary, manager_id, department_id)
select employee_id, first_name||' '||last_name, salary, manager_id,
department_id from employees;    -- 원래 있던 데이터를 테이블 컬럼 만들고 그안에 집어넣기
commit;
select * from emp01;

-- primary key : null안되고 중복도 안됨.
-- employee_id 100이 이미 존재하기 때문에 오류
insert into emp01(employee_id, emp_name, salary) values(100, '홍길동', 5000);

insert into emp01(employee_id, emp_name, salary) values(99, 'Steven King', 1000);
-- emp_name이 존재하기 때문에 unique 오류

insert into emp01(employee_id, emp_name) values(99, '홍길동');
--salary -> not null 규칙에 위반이 되어서 오류

insert into emp01(employee_id, emp_name, salary) values(99, '홍길동', 10000);
commit;
select * from emp01 order by employee_id;

-- check
-- gender이라는 컬럼에 not null 같은 제약조건을 주는거야
-- 대소문자 m, f 만 넣을 수 있어
alter table emp01
    add gender varchar2(10)
    constraint ck_gender
    check(gender in ('M', 'm', 'F', 'f'));
    
insert into emp01(employee_id, emp_name, salary, gender)
values(98, '유관순', 5000, 'f');
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
-- 제약조건 삭제
alter table emp01 drop constraint ck_gender;       -- ck_gender은 constraint의 이름. 직접 안써주면 자동적으로 나옴

alter table emp01 modify salary null ;
alter table emp01 modify salary not null;

-- unique 삭제
-- constraint 이름확인
select constraint_name, constraint_type, table_name from user_constraints
where table_name = 'EMP01';
--emp01의 제약조건을 알수 있어 c:check, p:primary, u:unique

--유니크삭제
alter table emp01 drop constraint SYS_C007072;

-- unique 추가
alter table emp01 add constraint uk_name unique(emp_name);
desc emp01;
select * from emp01;
