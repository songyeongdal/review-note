-- 정렬 asc 
-- 숫자: 작은값부터, 문자: 사전순서로, 날짜: 빠른날짜순서, null가장마지막에
select * from employees 
order by salary;
-- 역순 정렬 desc
select * from employees 
order by salary desc; 

-- 부서번호는 - 순차정렬. 부서번호가 같을 경우 월급을 역순으로 정렬 
select department_id, salary from employees
order by department_id, salary desc;

select * from employees 
order by employee_id, hire_date desc; 

-- 문자 길이 
-- length : 컬럼의 문자열 길이를 반환, 공백을 포함한 문자열의 길이 
-- lengthb : 컬럼의 문자열 바이트수를 반환 
--    영문자(1바이트) 공백(1바이트) 한글(3바이트)
select first_name, length(first_name), lengthb(first_name) from employees;

-- lower -> 소문자로 변환 
select first_name, lower(first_name) from employees;
-- upper -> 대문자로 변환 
select first_name, upper(first_name) from employees; 

-- substr : 문자열을 추출 
-- substr('jones', 2)문자열의 두번째 위치 즉 o부터 끝까지 자른다. 
-- substr('jones',2,3) 문자열의 두번째 위치부터 3자리 즉 one를 자른다 
select substr('jones', 2) from dual; 
select substr('jones',2,3) from dual;

select first_name, substr(first_name, 1,6) from employees;
select first_name, substr(first_name, 3) from employees;
select first_name, substr(first_name, -1) from employees;

-- dual은 오라클 자체 제공 테이블로 한열로 이루어진 임시테이블이다.
-- 주로 사용자가 함수(계산)을 할때 임시로 사용한다.
select sysdate from dual;
-- 원래 숫자 더하기 문자는 불가능한데 오라클에서 해준다. 
select '1'+'2' from dual;

-- instr 특정 문자 위치 찾기 

select 'hello.txt', instr('hello.txt','.'), substr('hello.txt',instr('hello.txt','.')+1)
from dual;

-- Q. 'studata.sql'에서 sql 추출해보기
select 'studata.sql', substr('studata.sql',instr('studata.sql','.')+1)
from dual;

-- control +f7 : 자동정렬 
CREATE TABLE member (
    id          VARCHAR2(20) PRIMARY KEY,
    pw          VARCHAR2(20),
    name        VARCHAR2(20),
    phone       VARCHAR2(20),
    create_date DATE
);
insert into member(id, pw, name, phone)
values('aaa','         1111', '홍   길동', '010-1111-111      ');
commit;
select * from member;
select length(pw) from member;

-- replace : 문자 대체 - 공백이 있으면 공백도 지울 수 있다. 
select name from member;
select name, replace(name,' ','') from member;

- trim, ltrim, rtrim 
- trim : 문자열의 양쪽 공백을 제거 
- ltrim : 문자열 왼쪽 공백제거 
- rtrim : 문자열 오른쪽 공백제거 

select trim('    공백      '), 
    ltrim (rtrim('    공백 있음      ')) from dual;

-- update를 사용해서 공백을 제거시키고 저장하기 
update member set pw = ltrim(pw);
commit;
select length(pw) from member;

select phone, length(phone) from member;
-- Q 폰 번호의 공백을 제거하여 저장해보세요 
update member set phone = replace(phone,' ','');
-- update member set phone = rtrim(phone);

-- concat : 문자열 합치기 
select concat(id, concat('-',pw)) from member;
select id||'-'||pw from member;

select first_name, last_name from employees;
select (first_name || ' ' || last_name)as 이름 from employees;

-- 특정 문자 채우기 : lpad, rpad 
select lpad(id, 10, '*') from member;

-- sysdate : 현재 시간 (날짜)
select sysdate, sysdate+1, sysdate-1 from dual;
-- months_between : 두 날짜 사이가 몇개월인지 반환 
select first_name, sysdate, hire_date, months_between(sysdate, hire_date) from employees;

select sysdate, '23/10/07', months_between(sysdate, to_date('23/10/07')) from dual;

-- add_months(): 특정 날짜 개월수를 더한다. 
select sysdate,add_months(sysdate, 6) from dual;

-- to_char() 문자형으로 반환하는 함수 
select sysdate, 
       to_char(sysdate, 'YY'),
       to_char(sysdate,'YYYY'),
       to_char(sysdate,'MM'),
       to_char(sysdate,'MON'),
       to_char(sysdate, 'YYYYMMDD'),
       to_char(to_date('20171008'),'YYYYMMDD')
from dual;

-- to_number() :숫자로 변환 
select to_number('123') from dual;

-- to_date() 문자형을 날짜형으로 변환하는 함수 
select to_date('20171007','YYYYMMDD') from dual;

-- 수학적인 함수들 
-- abs: 절대값
select -10, abs(-10) from dual;
-- floor 버림
select floor(10.3245) from dual;
-- round: 반올림 소수점을 3번째자리까지 표시
select round(10.3245, 3) from dual;
-- -1경우에는 정수 첫째자리에서 반올림
select round(19.9876, -1) from dual;

select round(salary/3, 0) from employees;

-- trunc : 특정 자리수에서 버림 
select trunc(34.5678, 2) from dual;

select trunc(round(salary/3,4)) from employees; 

-- mod : 입력받은 수를 나눈 나머지값을 반환 
select mod(27,2) from dual; 

select * from studata;

select * from studata 
where mod(stuid,2)=1
order by stuid
;

-- Q. 사원번호가 짝수만 출력 
desc employees;
Select * from employees
where mod(employee_id, 2) = 0 ;


-- 함수 
-- 순위 함수 
-- rank() : 공통 순위를 출력하되, 공통순위만큼 건너뛰어 다음 순위를 출력
-- dense_rank(): 공통순위를 출력하되 건너뛰지 않고 바로 다음 순위를 출력
-- row_number(): 공통순위 없이 출력 
/*
rank() over([partition by 열이름b] order by 열이름a)
열이름b : 그룹으로 순위를 묶어서 순위를 매겨야 할때 사용
열이름a : 순위를 매길 열 
*/
select employee_id, 
       salary, 
       rank() over(order by salary desc) rank_급여, 
       dense_rank() over(order by salary desc) dense_rank_급여, 
       row_number() over(order by salary desc) row_number_급여
from employees
where employee_id between 100 and 106; 

-- Q. 학생의 성적을 총점순으로 정렬해보세요 

desc studata;
select stuid, stuname, total, 
       row_number() over(order by total desc) 순위
from studata
order by total desc
;

-- nvl(입력값, 대체값) 널값 치환 함수. 
select commission_pct,salary,salary * nvl(commission_pct,1)
from employees
where employee_id between 100 and 106
order by commission_pct;
-- nvl2(입력값, notnull대체값, null대체값)
select employee_id, commission_pct, nvl2(commission_pct,0,1)
from employees
where employee_id between 143 and 148;
-- nullif(값1, 값2) 만약에 값1이 값2면 널로 바꿔줘라. 
select employee_id, commission_pct, salary, nullif(salary, 2600)
from employees
where employee_id between 143 and 148;

desc employees;
-- decode(열이름, 조건값, 치환값, 기본값)
-- 어떤 열 이름에 대해 조건값일때 조건에 해당하는 어떤값을 치환한다. 
select first_name,  last_name, department_id,
salary 원래급여,
decode(department_id, 60, salary*1.1, salary) 조정된급여, 
decode(department_id, 60, '10%인상','미인상') 인상여부
from employees
where employee_id between 100 and 106;

-- Q. department_id가 100 일때 'IT' 그외에는 '다른부서'로 decode를 사용해서 표현해보기
select first_name, last_name, department_id, 
decode(department_id, 100, 'IT', 
                      90, 'HR',
                      '그외' )
from employees;


-- case : 다양한 조건이 주어질 때 
/* 
case 
   when 조건1 then 출력1
   when 조건2 then 출력2
   .....
   else 출력3
end as 별명
*/
select employee_id, first_name, last_name, salary, 
    case
        when salary>=9000 then '상위급여'
        when salary between 6000 and 8999 then '중위급여'
        else '하위급여'
    end as 급여등급
from employees
where job_id = 'IT_PROG';

select * from employees;
select * from departments;
-- Q. employee_id, first_name, job_id를 출력하는 쿼리
-- department id 가 10일때 'admin',  40일때 HR, 60일때 it 그외는 'N/A'로 출력 해보세요 
-- 컬럼명은 job_title 로 출력
select employee_id, first_name, job_id, department_id, manager_id,
    case 
        when department_id = 10 then 'Admin'
        when department_id = 40 then 'HR'
        else 'N/A'    
    end as job_title
from employees 
where employee_id between 199 and 204
;
-- and or 도 함께 사용할 수 있다 
select employee_id, first_name, job_id, department_id, manager_id,
    case 
        when department_id = 10 and manager_id = 101 then 'Admin'
        when department_id = 40 and manager_id = 101 then 'HR'
        else 'N/A'    
    end as job_title
from employees 
where employee_id between 199 and 204;


-- 그룹 함수 : 열에 대해서 계산 
-- count() 행의 개수를 셈.  count(*) null 값도 센다. 
select count(*) from employees;
select count(*), count(employee_id), count(manager_id) 
from employees;
select count(*), count(manager_id), count(commission_pct)
from employees;

select commission_pct from employees;
select count(*)전체,count(commission_pct)커미션, count(*)-count(commission_pct)노커미션 
from employees;

select count(*) from employees
where commission_pct is null;

-- sum() 합계 
select sum(salary) from employees;
select sum(salary) as 총월급여, 
       sum(salary)*0.1 as 인상분, 
       sum(salary)*1.1 as 변경후_총월급여
from employees;

select sum(salary) as 총월급여, 
       trunc(sum(salary)*0.1,0) as "인상분", 
       round(sum(salary)*1.1,0) as "변경후 총월급여"
from employees;

-- avg() 평균 함수 
select round(avg(salary),2) from employees;
select count(*), avg(salary) from employees;

-- max() 최대값
select max(total) from studata; 
select max(salary) from employees;
-- min() 최소값
desc studata;
select min(kor) from studata;
select min(salary) from employees;

-- where도 select문을 사용 할 수 있다. 
select first_name, salary from employees
where salary < ( select avg(salary) from employees );

-- Q. department_id가 10인 사람들 중에서 커미션을 받는 사원의 수 
select count(commission_pct) from employees
where department_id = 10;

select count(*) from employees 
where commission_pct is not null and department_id=10;

-- Q. department_id가 60인 사람들의 월급의 합 sum()
select sum(salary) from employees 
where department_id = 60 ; 

-- Q. 월급이 평균이상인 사람들의 수 
select avg(salary) from employees;

select count(*) from employees 
where salary > (select avg(salary) from employees);

-- group by : 합계, 평균, 최대값, 최소값 등 어떠한 컬럼을 기준으로 
--           그 컬럼의 값 별로 보고자 할때 group by절 뒤에 해당 컬럼을 기술 
--     *group by  뒤에는 반드시 컬럼명을 기술해야함 (별칭은안됨)
/* 
select 컬럼명, 그룹함수(컬럼명)
from 테이블명
[where 조건식]
group by 컬럼명
[order by 컬럼명]
 예) select A, sum(B) group by A; 
*/
select job_id, salary from employees;
select job_id, avg(salary) from employees
group by job_id;

select job_id 직무, sum(salary) 직무별_총급여, avg(salary) 직무별_평균급여
from employees 
where employee_id >=10
group by job_id
order by 직무별_총급여 desc, 직무별_평균급여;

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


-- Q. 부서별(department_id)로 사원수와 커미션을 받는 사원수 계산 
select department_id, count(*), count(commission_pct) 
from employees
group by department_id;
-- Q. 소속부서별 최대급여와 최소급여 
select department_id, min(salary), max(salary), count(*)
from employees
group by department_id
order by department_id;

-- having 
-- select절 조건을 사용하여 결과를 제한할때는 where절을 사용하지만
-- 그룹의 결과를 제한할때는 having 절을 사용한다. 
-- 즉, 그룹으로 묶여진 결과값에 대해 다시 조건을 주는 경우 
-- group by의 결과가 적용된 절에 having 조건을 주는 것. 
/*
select 컬럼명, 그룹함수(컬럼명)
from 테이블명
[where 조건식]
group by 컬럼명
[having 조건식]
[order by 컬럼명]
*/
-- 예) 부서별로 그룹을 만들 후, 그룹지어진 부서별 평균 급여가 5000 이상인 부서번호와 평균급여 
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




 















