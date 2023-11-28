-- 테이블 생성 
create table member(
id VARCHAR2(20) primary key,
pw VARCHAR2(20),
name VARCHAR2(20),
phone VARCHAR2(20)
);
-- 테이블에 값 넣기 
insert into member(id, pw, name, phone) 
values('aaa','1111','홍길동','010-1111-1111');

select * from member;
commit;

insert into member values ('bbb','1111','이순신','010-2222-2222');
insert into member values ('ccc','1111','이순신','010-2222-2222');
insert into member(id, name) values ('ddd','김구');
insert into member values ('eee','1111','유관순','010-3333-3333');
-- 실행문 되돌리기 .
rollback;
-- 테이블 검색하기 
select * from member;
-- 테이블 안 데이터 삭제 
-- delete from member where id = 'aaa';

-- 데이터 변경 
update member set phone = '010-7777-7777' where id='bbb';
commit;

-- 테이블 삭제 
-- drop table member; 
select * from member;


-- 학생 테이블을 생성해보세요 students
-- id, name, kor, eng, math, total, avg, rank 
-- id, name : varchar2 나머지는 number 
-- avg 경우에는 소숫점 표현을 위해서 NUMBER(4,1)로 생성해보세요 

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

-- 3명의 학생 정보를 입력해보세요 . 
insert into students 
values ('1','홍길동',100,100,100,(100+100+100),(100+100+100)/3,0);

insert into students 
values ('2','이순신',90,100,100,(90+100+100),(90+100+100)/3,0);

insert into students 
values ('3','김구',100,90,90,(100+90+90),(100+90+90)/3,0);

select * from students;
commit;

-- 사용자가 소유한 테이블 정보를 알려준다
select * from tab;
-- 테이블의 구조를 살펴볼 수 있다. 
desc students;

/*
select [distinct] 열 이름 [or Alias]
from 테이블 이름
[where 조건식]
[order by 열 이름 [asc or desc] ];

[]: 선택사항
; : sql이 끝났음을 의미 
distinct : 중복행 제거 
* : 모든열 출력 
alias : 별칭 부여 
where : 조건을 만족하는 행들만 검색
조건식: 열, 표현식, 상수 및 비교 연산자 등 출력을 위한 조건문
order by : 결과 정렬을 위한 옵션 (asc 오름차순 desc 내림차순)

*/
-- 모든 열을 조회
select * from students; 
select * from employees;
-- 특정 컬럼만 출력하고 자 할때는 열이름, 열이름 으로 기술 
select name, total from students;


-- Q. 사원의 급여와 입사 일자만을 출력하는 sql문을 작성해보세요 (employees테이블)
desc employees;
select SALARY, HIRE_DATE from employees;


select EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY from employees;
-- 사칙연산 사용 가능 
-- as로 별칭 선언이 가능 쌍따옴표를 넣을 경우에 대소문자 구분, 한글, 띄어쓰기 가능
select SALARY, SALARY/4 as salary4 , SALARY*12 as " 1 2 달 "  from employees;


select EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY, SALARY*12 as "연봉"  from employees;
-- 커미션 값을 포함하고싶다. 

select EMPLOYEE_ID, HIRE_DATE, SALARY, COMMISSION_PCT, SALARY*12
from employees;

select EMPLOYEE_ID, HIRE_DATE, SALARY, COMMISSION_PCT, SALARY*12+COMMISSION_PCT
from employees;

-- null 있을때는 0으로 입력을해라. nvl()함수 사용 
select EMPLOYEE_ID, HIRE_DATE, SALARY, COMMISSION_PCT, 
SALARY*12+nvl(COMMISSION_PCT,0)
from employees;

-- Q. 사번, 이름 (first_name), 이메일, 전화번호, 입사일을  별칭을 사용해서 출력해보세요 
desc employees;
select EMPLOYEE_ID as "사번", FIRST_NAME as "이름", 
EMAIL as "이메일", PHONE_NUMBER as "전화번호", HIRE_DATE as "입사일" 
from employees; 

--  Q.부서번호, 부서명 별칭을 사용해서 출력하세요 
desc departments;
select DEPARTMENT_ID as "부서번호",DEPARTMENT_NAME  as "부서명"
from departments;

desc employees;
-- concatenation || ' '  || : 컬럼과 컬럼을 하나의 문장처럼 보이게 함 
select FIRST_NAME || '의 직급 : ' || JOB_ID 
from employees; 

-- distinct : 중복제거 
select DEPARTMENT_ID, DEPARTMENT_NAME from departments;
select DEPARTMENT_ID from employees;
select distinct department_id 
from employees
order by department_id;

-- where 절 쿼리 : 조건문
-- 급여가 6000인 경우를 출력을 해라 
select * from employees 
where salary = 6000;
-- 금여가 4000 이상만 출력을 해랴 
select * from employees 
where salary >= 4000;

-- Q. 급여가 4000 이하인 사원의 사원번호, 사원이름, 급여를 출력하는 sql문을 작성하세요
--   ++ 별칭 사용해서 출력 
desc employees;
select EMPLOYEE_ID as "사원번호", FIRST_NAME as "사원이름", SALARY as "급여"
from employees
where salary <=4000;


select FIRST_NAME || ' ' || Last_NAME as "name"
from employees; 


-- sql에서 문자열이나 날짜는 단일따옴표 안에 표시해야 한다. 
select * from employees where email = 'RLADWIG';
-- 따옴표 안에 문자열은 대소문자를 구분한다. 
select * from employees where email = 'rladwig';

select * from employees where hire_date >='07/06/21';
-- Q. 2000/1/1 이후 입사사원 
--  ++입사일 순으로 정렬 
select * from employees where hire_date >='00/01/01'
order by hire_date;

-- desc는 역순정렬 
select * from employees 
where salary > 4000
order by salary desc;

-- 조건절에 and 
select * from employees
where salary >=2000 and salary <= 3000; 

select * from employees 
where salary = 8000 and job_id='SA_REP';

-- 조건에 or 
select * from employees 
where salary = 8000 or salary = 6000 ;

-- Q. 사원 아이디, 이름, 급여를 출력하는 sql문을 작성하세요 
--  ++ 아이디가 100 이상이며 급여가 4000이상인
--  ++ 급여가 높은 순-> 낮은 순으로 
select EMPLOYEE_ID, FIRST_NAME, SALARY from employees
where EMPLOYEE_ID >=100 and SALARY >= 4000
order by SALARY desc;

-- between a and b : a와 b 사이의 값
select * from employees 
where salary BETWEEN 6000 and 8000
order by salary;

select * from employees 
where salary>= 6000 and salary <= 8000
order by salary;

-- in (list) : list 중 어느 값이라도 일치 할 경우 출력 
select * from employees 
where salary in (6000, 8000, 10000) 
order by salary; 

select * from employees 
where salary = 6000 or salary = 8000
order by salary;

-- Q.  commission_pct 0.1이나 0.3인 경우 출력 
-- or 사용 
SELECT
    *
FROM
    employees
WHERE
    commission_pct = 0.1
    OR commission_pct = 0.3;
-- in 사용 
select * from employees
where commission_pct in (0.1, 0.3);

-- Q. 176, 158, 102 인 사원들의 사원번호와 급여를 검색하는 쿼리문을 출력하세요
-- or
select employee_id, salary from employees 
where employee_id = 176 or employee_id = 158 or employee_id = 102;
-- in
select employee_id, salary from employees
where employee_id in(176, 158, 102);

-- 논리 연산자 not 
select * from employees where not department_id=20;
select * from employees where department_id != 20;
select * from employees where department_id <> 20;
select * from employees where department_id ^= 20;

-- 포함된 글자를 찾을때 like 
-- 이메일에 첫글자가 v로 시작하는 모든데이터를 출력해라 
select * from employees
where email like 'V'||'%';
select * from employees
where email like 'V%';
-- 이메일에 S를 포함하는 데이터 출력 
-- S로 시작
select * from employees
where email like 'S%';
-- S로 끝나는 것 
select * from employees
where email like '%S';
-- S가 중간에 있는것
select * from employees
where email like '%S%';

select * from employees
where lower(email) like '%s%';

-- 언더바는 문자 수를 나타낸다. (언더바 5개)
select * from employees 
where email like 'B'||'_____';
select * from employees 
where email like 'B_____';
select * from employees 
where email like 'B%';

-- 두번째 글자가 a인 사원을 찾기 
select first_name from employees
where first_name like '_a%';

-- 네번째 글자가 a인 사원 찾기 
select first_name from employees
where lower(first_name) like '___a%';

-- a를 포함하지 않는 사람을 찾기 
select first_name from employees 
where lower(first_name) not like '%a%';
-- 두번째 글짜에 a를 포함하지 않는 사람 찾기 
select first_name from employees 
where lower(first_name) not like '_a%';

-- null 값을 갖는 행들만 출력 
select * from employees 
where manager_id is null; 


-- null 이 있는 경우를 제외하고 출력
select * from employees 
where manager_id is not null; 

-- Q id, 이름, 월급을 출력하세요 . 
--   + 월급이 4000 이하이며 department_id가 30인
--   월급순으로 정렬해보세요 
select employee_id, first_name, salary from employees 
where salary <=4000 and department_id =30 
order by salary; 

-- Q last_name에 a 와 e가 모두 포함된 사원을 출력
select last_name from employees 
where lower(last_name) like '%a%' and last_name like '%e%';

-- Q job_id가 'SA_REP' 이거나 'ST_CLERK' 이면서
--  ++ salary가 2500, 3500 또는 7000가 아닌 
--  ++ 모든 사원의 last_name, job_id, salary를 출력하세요 
select last_name, job_id, salary from employees 
where job_id in('SA_REP','ST_CLERK')
and salary not in (2500, 3500, 700);

-- Q employee_id가 130보다 크며 월급이 3000과 5000 사이인 테이블을
-- + 월급 역순으로 출력
select * from employees 
where employee_id >=130 and salary between 3000 and 5000
order by salary desc;


-- 날짜는 정렬과 사이. 다 가능하다.
select * from employees
where hire_date between '95/01/01' and '02/12/31'
order by hire_date;
-- 날짜에서 덧셈과 뺄셈이 가능하다 
select hire_date, hire_date+10 from employees;


-- 테이블 만들기 
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


