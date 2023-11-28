
-- foreign key -> fk : 참조되는 컬럼값이 존재하면 허용
-- 데이터베이스를 설계할 때 하나의 테이블만으로는 
-- 해당테이블이 대표하는 데이터를 하나로 정리하기 힘들다
-- 이런경우 테이블을 더 생성 후 외래키를 사용해서 데이터 베이스 내 두 테이블을 연결하면 된다.

-- create table 테이블이름 as select * from 테이블이름
-- dept01 테이블을 생성
create table dep01 as select * from departments;
desc dep01;
desc emp01;

-- 공통적으로 department_id가 있기에 fk로 설정해서 연결할 수 있다.
-- 중요 : fk로 설정하고싶으면 부모가되는 테이블에서 primary key 혹은 unique가 되야한다.

-- 부모테이블에서 unique혹은 primary key 먼저 설정이 되어있는지 확인
alter table dep01
add constraint uk_d_id unique(department_id);

-- fk를 설정 :
alter table emp01
add CONSTRAINT fk_d_id foreign key(department_id)
references dep01(department_id);

select * from dep01 order by department_id;
-- 부모키의 있는 department_id 만 추가할 수 있다. 부모엔 department_id 가 7이란 값이 없음
insert into emp01(employee_id, emp_name, salary, department_id)
values (97, "이순신", 500, "");

-- 삭제
-- 외래키로 연결되어 있어서 삭제할 수 없음.
-- 부모테이블을 함부로 삭제할 수 없음 -> 자식테이블과 연결이 되어 있기 때문에
delete from dep01 where department_id = 50;
select * from dep01;
select * from emp01;

-- fk 삭제하기
alter table emp01 drop constraint fk_d_id;


-- on delete cascade
-- 조건에 맞는 모든 행들이 다 지워짐
alter table emp01
add constraint fk_d_id foreign key (department_id)
references dep01(department_id) on delete cascade;

select * from dep01 where department_id = 50;
select * from emp01 where department_id = 50;

-- join : 한개이상의 테이블과 테이블이 서로 연결하여 사용
-- 여러개를 연결할 수 있음 : 
-- 연결하면서 내가 필요한 정보가 현재 테이블에 없어도 마지막에 있는 테이블의
-- 데이터를 가져다 쓸 수 있다.

-- 예) 124번의 부서이름을 알고싶다
select * from employees where employee_id = 124;
-- 부서번호를 직원테이블에서 찾아서 - 50번
select department_id from employees where employee_id = 124;
-- 50번 부서명을 부서테이블에서 찾을 수 있다.
select department_name from departments where department_id = 50;


-- cross join : 조건없이 모두 매칭한 결과
create table stu01 as select * from studata where stuid between 1 and 10;

select * from stu01;
select * from newmem;
insert into newmem values ('aaa', '1111', '홍길동', '010-1111-1111',sysdate);
insert into newmem values ('bbb', '2222', '이순신', '010-1111-1111',sysdate);
commit;

-- cross join
select * from stu01, newmem;

-- 결과를 보면 알듯 의미가 없다.
-- 조인의 결과가 의미를 가지려면 조건이 필요하다.

-- 조인의 종류 : 동등조인, 비동등조인, 외부조인, 자체조인이 있다.

-- 가장 기본은 동등조인이다 equi join, inner join
-- inner join (equi join, 동등조인, 내부조인): 조인 조건이 정확이 일치할때 조회

/*
select 테이블이름1.열이름1 [, 테이블이름2.열이름2....]
from 테이블이름1, 테이블이름2
where 테이블이름1.열이름1 = 테이블이름2.열이름2

두테이블의 열이 갖고 있는 데이터값을 논리적으로 연결, 연결하는 기호로는 등호를 사용
where의 열이름은 내가 조인하고자 하는 기준이 되는 열

*/
select * from employees, departments
where employees.department_id = departments.department_id;

-- 별칭을 사용하면 간단하게 연결할 수 있다.
select A.employee_id, A.last_name, B.department_name from employees A, departments B
where A.department_id = b.department_id ;

-- join시에는 어느 테이블에서 데이터를 가져왔는지 명시해야 한다.
-- 컬럼명이 어느 테이블에 속하는지 알 수 없어서 오류 발생
select e.employee_id, e.last_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

-- select 절에는 출력할 열 이름을 기술
-- from 절에는 접근하려는 테이블 이름을 기술
-- where 절에는 조인조건을 기술
-- * from 절 외의 절에는 조회의 명확성을 위해 열 앞에 테이블 이름을 붙인다.

select e.employee_id, e.first_name, e.last_name, 
d.department_id, d.departmet_name
from employees e, departments d
where e.department_id = d.department_id;

-- 조건절에 and를 추가해서 사용할 수 있다.

select e.employee_id, e.first_name, e.last_name, 
d.department_id, d.departmet_name
from employees e, departments d
where e.department_id = d.department_id
and e.employee_id = 124 ; 

-- shipping 부서에서 일하는 사원의 이름과 입사일을 출력하세요
-- sales 부서에서 일하는 사원의 수
-- location_id가 1800인 사원의 이름과 급여
-- 최고매니저의 이름과 부서명을 출력하세요(manager_id가 없는사람) 

select * from employees;
select * from departments;

select e.first_name, e.last_name, e.hire_date, d.department_name
from employees e, departments d
where e.department_id = d.department_id and d.department_name = 'Shipping';

select count(*) from 
employees e, departments d
where e.department_id = d.department_id and department_name = 'Sales';

select e.first_name|| ' ' || e.last_name 이름, e.salary, d.location_id
from employees e, departments d
where e.department_id = d.department_id and d.location_id = 1800;

select e.first_name, e.last_name, d.department_name, e.job_id
from employees e, departments d
where e.department_id = d.department_id and e.manager_id is null;

-- 비동등조인 non-equal join. 구간이 될 수 있게 between같은걸 사용해서 하게 댐
-- 조인 조건절에 사용되어지는 컬럼의 값이 '같다, 같지않다' 가 아니라
-- 특정 범위에 속할때 사용되어지는 join
-- 맨날 등급을 매기는 case when을 쓸수 없으니 차라리 비동등조인으로 등급을 만들자

-- employees테이블에서 월급을 등급으로 나누어 보자
select employee_id, first_name,
    case when salary >= 10001 then 5
        when salary >= 8001 then 4
        when salary >= 5001 then 3
        when salary >= 3001 then 2
        when salary >= 2001 then 1
    end as 등급
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

-- 비동등 조인을 사용해서 studata 학생성적
-- 평균점수가 95-100 A+, 90-94 A, 85-89 B+, 80-84 B, 0-79 C

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

-- self join : 하나의 테이블 내에서 조인을 해야만 원하는 자료를 얻을 수 있을 때 사용
-- 1개의 테이블(x)을 가상으로 x1, x2라는 별칭을 부여해서 
-- 2개의 테이블인것처럼 간주한 뒤 join


/*
select 별명1.열이름 [, 별명2.열이름2..]
from 테이블이름 별명1, 테이블이름 별명2
where 별명1.열이름 = 별명2.열이름
*/

-- 각 사원을 관리하는 상사의 이름을 검색한다.

select department_id from employees where first_name = 'Adam';

select a.last_name || '의 관리자는' || b.last_name
from employees a, employees b
where a.manager_id = b.employee_id;

select e1.employee_id 사원번호,
        e1.first_name ||' '|| e1.last_name 사원이름,
        e1.manager_id 상사번호,
        e1.employee_id 상사의사원번호,
        e2.first_name ||' '|| e2.last_name 상사이름
from employees e1, employees e2
where e1.manager_id = e2.employee_id(+)
order by e1.employee_id;

-- 상사가 steven 인 사원들의 이름과 직급을 출력
-- adamr(firstname)과 동일한 부서에서 근무하는 사원의 이름 출ㄹ력
select employee_id from employees where employee_id = 100;

select e1.employee_id, e1.last_name || ' ' || e1.first_name 이름, e1.job_id
from employees e1, employees e2
where e1.manager_id = e2.employee_id and  e2.first_name = 'Steven';

select e1.last_name || ' ' || e1.last_name 이름
from employees e1, employees e2
where e1.department_id = e2.department_id 
and e2.department_id =(select department_id from employees where first_name = 'Adam');

-- outer join : 데이터가 일치하지 않아도 데이터를 출력해야 할 때 사용
/*
select 테이블이름1.열이름1 [, 테이블이름2.열이름2,.....]
from 테이블이름1, 테이블이름2
where 테이블이름1.열이름1 = 테이블이름2.열이름2(+)
(+) : 외부조인, 데이터가 부족한 끝에 기술
이너조인 조건을 만족하지 못해 누락되는 행을 출력하기 위해서 (+)기호를 사용
(+) 기호는 조인할 행이 없는, 즉 데이터값이 부족한 테이블의 열 이름 뒤에 기술
(+) 기호는 한쪽에만 기술할 수 있다.
(+) 를 붙이면 부족한 테이블에 null 값을 갖는 행이 생성됨
(+) 기호가 왼쪽에 있으면 left outer join
        오른쪽에 있으면 right outer join
*/

-- department_id가 누락된 사람.
select * from employees where employee_id = 178;
select * from employees where department_id is null;

-- inner join을 할 경우 결과가 출력이 되지 않는다.
select * from employees a, departments b
where a.department_id = b.department_id
and a.employee_id = 178;

-- outer join. null이 생성이 되면서 join이 된다.
select * from employees a, departments b
where a.department_id = b.department_id(+)
and a.employee_id = 178;

select * from employees;
select * from departments;

-- 매니저가 없는 사람을 outer join해보세요
-- employee_id가 100 인사람
select * from employees a, departments b
where a.department_id = b.department_id(+)
and b.manager_id is null;

select * from employees a, departments b
where a.manager_id = b.manager_id(+)
and a.employee_id = 100 ;


select * from employees;
-- luis 의 부서이름 - inner join
-- luis 이름은 employees테이블 부서의 이름은 departments 테이블
--이너조인

select b.department_name 
from employees a, departments b 
where a.department_id = b.department_id
and a.first_name = 'Luis';

-- Luis의 상사이름
-- 1. 상사의 번호를 찾는다

select manager_id from employees where first_name = 'Luis';  -- 루이스의 상사는 108번이다
-- 번외로 luis 2-1. department_name : Finance
select department_name from departments
where department_id = 100;

-- 2. 108번에 해당하는 이름을 찾는다.
select first_name from employees where employee_id = 108;
-- 108번에 해당하는 이름은 nancy이다

select * from employees;

select e1.manager_id, e2.first_name
from employees e1, employees e2
where e1.manager_id = e2.employee_id and e1.first_name = 'Luis';

-- ansi join - 국제표준 조인 ㅣ방법
-- 기존조인(오라클)
select a.employee_id, b.department_name
from employees a, departments b
where a.department_id = b.department_id;
-- ansi join은 from 절 다음에 inner join이란 단어를 사용해 조인할 테이블 이름을 명시
-- on절을 사용해서 조인 조건을 명시
-- ansi조인
select a.employee_id, b.department_name
from employees a inner join departments b
on a.department_id = b.department_id;

-- 다른조건에 대해서는 where 구문에서 지정

select a.employee_id, b.department_name
from employees a inner join departments b
on a.department_id = b.department_id
where a.employee_id = 100;

-- using을 이용해 조인조건 지정
-- using안에 공통 컬럼을 넣으면 된다.

select a.employee_id, b.department_name
from employees a inner join departments b
using(department_id);

-- natural join
-- 두 테이블이 갖는 공통 컬럼에 대해서 inner join은 별개의 컬럼으로 나타나지만
-- natural join은 하나의 컬럼으로 나타난다.

-- 기존 : 표를 보면 공통의 department_id 칼럼을 2개 확인 할 수 있다.
select * from employees a, departments b
where a.department_id = b.department_id;    -- 같은 칼럼이 2개 나타남

-- natural join : 공통인 department_id 컬럼이 1개만 나타난다.
select * from employees natural join departments;

-- outer join - [left | right | full]
-- full = left+right

-- 기존
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

-- 집합연산자 (set operator)
-- select 문을 연결해서 작성하며 각 select문의 조회결과가 하나로 합치거나 분리
-- 집합연산자는 합집합, 교집합, 차집합의 논리와 같음

/*
select 열이름1, 열이름2, 열이름3.......
from 테이블이름
집합연산자
select 열이름1, 열이름2, 열이름3.......
from 테이블이름
[order by 열이름 [asc or desc]]
*/

select department_id from employees order by department_id;
select department_id from departments order by department_id ;

-- union 합집합 : 중복되는 행은 한번만 출력
select department_id from employees
union
select department_id from departments ; 
-- null (employees테이블에 있음) 이 포함되어 합집합이 되었다는 것을 알 수 있다.

-- union all : 합집합, 중복되는 행도 그대로 출력
select department_id from employees
union all
select department_id from departments ; 

-- intersect(교집합) : 중복되는 행만 출력
select department_id from employees
intersect
select department_id from departments ; 

-- minus : 차집합, 첫번째 select문 결과에서 두번째 select문 결과를 뺀다
select department_id from employees
minus
select department_id from departments ; 

-- 월별 매출 추이 분석
select * from reservation;
-- reserv_no, reserv_date, reserv_time, customer_id, branch, visitor_cnt, cancel
select * from order_info;
-- order_no, item_id, reserv_no, quantity, sales

-- 공통 컬럼을 찾아서 예약넘버, 예약일, 아이템아이디, 판매가를 출력해보세요

select r.reserv_no, r.reserv_date, o.item_id, o.sales
from reservation r, order_info o
where r.reserv_no = o.reserv_no 
order by r.reserv_no;

-- 그 중에서 예약이 취소되지 않은 것 (캔슬이 n)
select r.reserv_no, r.reserv_date, o.item_id, o.sales
from reservation r, order_info o
where r.reserv_no = o.reserv_no and r.cancel = 'N'
order by r.reserv_no;

-- 그리고 예약날짜가 20170101 - 20171231 사이인것 
select r.reserv_no, r.reserv_date, o.item_id, o.sales
from reservation r, order_info o
where r.reserv_no = o.reserv_no and r.cancel = 'N' 
and r.reserv_date between '20170101' and '20171231'
order by r.reserv_no;

-- 월별 추이를 보고싶으므로 날짜를 년월로 자르세요
select r.reserv_no, substr(r.reserv_date,1,6), o.item_id, o.sales
from reservation r, order_info o
where r.reserv_no = o.reserv_no and r.cancel = 'N' 
and r.reserv_date between '20170101' and '20171231'
order by r.reserv_no;

-- 월별로 그룹해서 월별 총 판매가를 출력
select substr(r.reserv_date,1,6), sum(o.sales)
from reservation r, order_info o
where r.reserv_no = o.reserv_no and r.cancel = 'N' 
and r.reserv_date between '20170101' and '20171231'
group by substr(r.reserv_date,1,6)
order by substr(r.reserv_date,1,6);

-- 추가적으로 item_id가 M005인것의 합계를 스테이크 칼럼으로 출력
-- decode함수사용 -=> m0005이면 sales 아니면 0값을 넣으면 된다.
select substr(r.reserv_date,1,6), sum(o.sales) 총판매가,
sum(decode(o.item_id, 'M0005', o.sales, 0)) 스테이크
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

-- 상품별 매출 분석
-- 월별, m0005 스페셜, m0002 파스타, m0003피자, m0004시푸드, m0005 스테이크
select substr(r.reserv_date,1,6)월별 ,
sum(decode(o.item_id, 'M0001+', o.sales, 0)) 스페셜,
sum(decode(o.item_id, 'M0002', o.sales, 0)) 파스타,
sum(decode(o.item_id, 'M0003', o.sales, 0)) 피자,
sum(decode(o.item_id, 'M0004', o.sales, 0)) 시푸드,
sum(decode(o.item_id, 'M0005', o.sales, 0)) 스테이크

from reservation r, order_info o, item i
where r.reserv_no = o.reserv_no and o.item_id = i.item_id
and r.cancel = 'N' 
and r.reserv_date between '20170101' and '20171231' 
group by substr(r.reserv_date,1,6)
order by substr(r.reserv_date,1,6);


-- 서브쿼리
-- select 문안에 다시 select 문이 기술된 쿼리
-- 서브쿼리의 결과는 메인쿼리의 조건으로 사용
-- 단일 select문으로 조건식을 만들기 복잡할때 
-- 완전히 다른테이블에서 데이터값을 조회해서 메인쿼리의 조건으로 사용할때 유용함
-- 서브쿼리는 ()로 묶어서 사용
-- 메인쿼리 연산자는 왼쪽, 서브쿼리 연산자는 오른쪽에 기술
-- 서브쿼리의 서브쿼리 형태로 중첩해서 사용할 수 있다
--
/*
select 열이름1, 열이름2......
from 테이블이름
where 조건식 연산자
                ( select 열이름1, 열이름2.....
                    from 테이블이름
                    where 조건식);
                    
서브쿼리랑 메인쿼리는 연산자로 연결된다                    

*/

-- 단일행 서브쿼리 : 하나의 행을 검색하는 서브쿼리
/* =, !=, >, >=, <, <=
*/
-- 서브쿼리 select문에서 얻은 한개의 행의 결과로 메인쿼리로 전달
-- 조건식이 where절에 기술되는 열의 개수와 데이터 타입은 메인쿼리와 서브쿼리가 같아야 한다.

-- DE Hann (last_name) 이라는사람과 같은 급여를 받는 사람들을 출력해보세요
-- 이사람의 급여를 검색
select salary from employees where last_name = 'De Haan';
-- 17000을 사용해서 다른 직원을 검색
select * from employees where salary = 17000;

-- 서브쿼리를 사용

select * from employees A
where a.salary = (select salary from employees where last_name = 'De Haan');

-- email이 AERRAZUR과 같은 연봉을 받는 사람을 출력

select * from employees where salary = (select salary from employees where email = 'AERRAZUR');

-- eamil이 LOZER인 사람의 연봉보다 높은 연봉을 받는 사람의 정보를 출력

select * from employees where salary > (select salary from employees where email = 'LOZER');

-- 다중행 서브쿼리 : 하나 이상의 행을 검색하는 서브쿼리
-- 구조 : 단일행 서브쿼리와 같음. 하나이상의 결과행을 메인쿼리에 전달하는 경우 사용.
-- 연산자로 in(같은값), not in(같은값이아님), exists(값이 있으면 반환),
-- any(최소한 하나라도 만족하면 됨. or라고 생각), all(모두만족 and라고 생각) 
/*
in : 같은 값을 찾음
any : 검색한 조건중 하나 이상을 만족하면 된다. 찾아진 값에 대해 하나라도 크만 true
all : 검색된 조건이 모두 만족해야한다.
> any(), < any(), < all(), > all()
*/

-- 부서별 최저 급여
select department_id, min(salary) 최저급여 from employees
group by department_id;

select * from employees
where salary in (2100, 6500)
order by salary desc;

-- 다중행 서브쿼리
select * from employees 
where salary in 
(select min(salary) from employees group by department_id)

order by salary;

select * from employees;

-- last_name이 h로 시작하는 직원과 같은 부서의 직원들을 출력
-- 부서번호 110사원중 급여를 가장 많이 받는 사원보다 더 많은 급여를 받는 사람의 이름과 급여 출력
-- 직원 중, department_id가 존재하지 않는 사원의 수

select * from employees where department_id in (select department_id from employees where last_name like upper('h%'));

select * from employees where department_id in (select department_id from employees where lower(last_name) like 'h%');

select first_name, last_name,salary from employees where salary > (select max(salary) from employees where department_id = 110);

select first_name, last_name,salary from employees where salary > all(select salary from employees where department_id = 110);   -- 서브쿼리 조건보다 전부다 커야함

select first_name, last_name,salary from employees where salary > any(select salary from employees where department_id = 110);  -- 서브쿼리 조건 2개중 하나보다만 크면 되

select count(*) from employees where department_id = (select department_id from employees where department_id is null);

select count(*) from employees  a where not exists (select * from departments b where a.department_id = b.department_id);   --???

-- 다중열 서브쿼리 : 하나이상의 열을 검색하는 서브쿼리(여러개의 컬럼)
-- 메인쿼리와 서브쿼리를 비교하는 where조건식에서 비교되는 열이 여러개 일때 사용
-- 열이름의 개수와 데이터 타입은 동일해야한다.

-- job_id별 최저 시급을 받는 사원의 정보
select job_id, min(salary) 그룹별급여 from employees group by job_id;

select * from employees a 
where (a.job_id, a.salary) in
(select job_id, min(salary) from employees group by job_id) order by a.salary desc;

-- 부서별 최대급여를 받는 사람들을 출력하세요
select * from employees where (department_id, salary) in 
(select department_id, max(salary) from employees group by department_id) 
order by employee_id;

select department_id, max(salary) from employees group by department_id;


-- 인라인 뷰 : from 절에 테이블 뿐 아니라 서브쿼리를 사용할 수 있다.
-- 즉 서브쿼리가 from 절 안에서 사용되는 경우
-- 해당 서브쿼리를 '인라인뷰'라고 한다.
-- from 절에서 사용된 서브쿼리의 결과가 하나의 테이블에 대한 뷰 처럼 사용된다.
-- 마치 가상의 테이블, 뷰와 같은 역할을 한다고 해서 인라인 뷰라고 한다.

/*
select 열이름1, ..
from 테이블 이름 as 별칭1, 
    (select 열이름2 from 테이블이름 where 조건식) as 별칭
where 별칭1.열이름1 = 별칭2.열이름2
*/

select * from employees a, 
(select department_id from departments where department_name = 'IT') b -- 별칭을 줘서 마치 테이블처럼 사용한다.
where a.department_id = b.department_id;

-- 인라인 서브쿼리를 사용해서 sales부서에서 일하는 사원의 정보를 출력하세요
-- 인라인 서브쿼리를 사용해서 110번 부서에서 일하는 사원의 정보를 출력하세요

-- group by를 쓸때를 join을 못쓰고
-- 집계함수를 쓸때는 서브쿼리를 써야한다

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

-- 서브쿼리 안에도 또 서브쿼리를 사용할 수 있다.
-- 부서번호가 110의 평균 급여보다 급여를 많이 받고,
-- 대표가 아니며 110 부서에 속하지 않은 사람들을 조회

-- 110번 부서의 평균 급여보다 많이 받는 직원 아이디를 출력
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

-- 학생등수를 출력하세요
select stuid, stuname, avg, rank () over(order by total desc) as 등수 from studata;

update studata a set rank = 
((select rank () over(order by total desc) as 등수 from studata) b
where a.stuid=b.stuid) ;

-- sql 집계함수

select * from employees;
select * from departments;
-- group by를 사용해서 department_id 별 월급의 평균을 출력하세요
-- group by를 사용해서 job_id별 월급의 평균을 출력하세요

select d.department_id, avg(e.salary) from departments d, employees e 
where d.department_id = e.department_id group by d.department_id;

select e.job_id, avg(e.salary) from departments d, employees e
where d.department_id = e.department_id group by e.job_id;

-- department_id, job_id 별 평균 월급 출력
select department_id, job_id, avg(salary)
from employees
group by department_id, job_id
order by department_id;

-- rollup : 소그룹간의 합계를 계산하는 함수
-- rollup를 사용하면 group by로 묶은 각각의 소그룹 전체 평균 모두 구할 수 있다.

select department_id, job_id, avg(salary) from employees
group by rollup(department_id, job_id)
order by department_id;

-- 맨 처음에 명시한 컬럼에 대해서 소그룹 집계를 해준다.

-- cube : 항목들 간 다차원적인 소계를 계산
-- rollup과는 달리 group by절에 명시한 모든 컬럼에 대해서 소그룹집계를 해준다.

select department_id, job_id, avg(salary) from employees
group by cube(department_id, job_id)
order by department_id;

select job_id, department_id, avg(salary) from employees
group by rollup(job_id, department_id)
order by job_id;

-- grouping set : 특정 항목에 대한 소계를 계산
select job_id, department_id, avg(salary) from employees
group by grouping sets(job_id, department_id)
order by job_id;

-- grouping sets는 union all과 같은 결과
select avg(salary) from employees group by department_id
union all
select avg(salary) from employees group by job_id;

-- grouping 은 직접적으로 그룹별 집계를 구하는 함수는 아니지만
-- 기준컬럼이 집계가 되어있으면 행 0, 그외는 1

select case grouping(department_id) when 1 then '모든부서' else to_char(department_id)
    end as 부서,
    decode(grouping(job_id), 1, '모든직책', job_id) as 직책,
    avg(salary) as 평균급여
from employees
group by rollup(job_id, department_id)
order by job_id desc;

-- order_info 테이블에서 아이템별, 예약월(reserv_no) 별 판매액의 합계를 구하시오
-- 쟤를 이용해, rollup, cube, grouping sets를 이용해 쿼리를 만드세요
-- 날짜 조건을 추가(cube만)
-- grouping 을 사용해서 cube 쿼리를 만드세요.


-- grouping :
-- 그룹함수 (rollup, cube, grouping sets)에 쓰인 컬럼에 대해 집계생성 여부를 반환해주는 함수
-- 기준 컬럼이 집계된 행은 0, 그외는 1 반환

select * from order_info;
select item_id, substr(reserv_no,1,6), sum(sales) from order_info group by item_id, substr(reserv_no,1,6) order by item_id;

select item_id,  substr(reserv_no,1,6) sum(sales) from order_info  where item_id in ('M0001', 'M0002') group by rollup(item_id, substr(reserv_no,1,6));

select item_id, substr(reserv_no,1,6), sum(sales) from order_info where reserv_no between '201701' and '201707'  group by cube(item_id, reserv_no);


select item_id, substr(reserv_no,1,6), sum(sales) from order_info where reserv_no between '201701' and '201707'  group by grouping sets(item_id, reserv_no);

select 
    case grouping(item_id) when 1 then '집계' else item_id end as item_id,
    case grouping(reserv_no) when 1 then '예약월' else reserv_no end as reserv_no,
    sum(sales) 매출
    from order_info
    group by cube(item_id, reserv_no);

select  
    decode(grouping(item_id),1,'모든아이템',item_id) as 아이템,
    decode(grouping(substr(reserv_no,1,6),1,'모든월',substr(reserv_no,1,6)) as 월,
    sum(sales)
     from order_info
     where substr(reserv_no,1,6) between '201701' and '201708'
    group by grouping sets(item_id, substr(reserv_no,1,6));
    
    
create table sb(
sb_id number(2),
sb_name varchar2(10)
);

insert into sb values(1, '설비1');
insert into sb values(2, '설비2');
insert into sb values(3, '설비3');
commit;

create table energy(
    sb_id number(2),
    e_code varchar2(10),
    e_amount number(3)
    );
    
insert into energy values(1, '전기', 100);    
insert into energy values(1, '용수', 200);
insert into energy values(1, '바람', 300);
insert into energy values(2, '전기', 200);
insert into energy values(2, '용수', 300);
insert into energy values(3, '전기', 300);
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
 라이브 오라클, 구글 검색. sql workeheek
http:
*/

-- 부서명, 부서별 사원의 월급합계, 부서별 월급합계 순위를 나타내는 쿼리를 만드세요

select * from departments;
select * from employees;
-- 부서아이디, 부서별월급합계, 부서명을 출력하는 테이블을 만드세요.
select d.department_id, sum(e.salary), max(d.department_name)
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id;

-- 부서명, 부서별 사원의 월급합계, 부서별 월급합계 순위를 나타내는 쿼리를 만드세요
select 부서명, 합계, rank() over(order by 합계 desc) 순위
from(
    select b.department_id, sum(a.salary) as 합계,
    max(b.department_name) as 부서명
    from employees a, departments b
    where a.department_id = b.department_id
    group by b.department_id);

--그룹바이 는 서브쿼리를 쓸수있다
-- 컬럼명 대신에 별명을 쓸수있다.

select d.department_id, sum(e.salary), max(d.department_name),
rank() over(order by sum(e.salary) desc) as 월급순위
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id;
