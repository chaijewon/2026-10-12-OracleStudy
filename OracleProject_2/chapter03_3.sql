/*CREATE TABLE dept2 ( 
	deptno               NUMBER  NOT NULL,
	dname                varchar2(20)    ,
	loc                  varchar2(20)    ,
	CONSTRAINT pk_dept PRIMARY KEY ( deptno )
 );

CREATE TABLE emp2 ( 
	empno                NUMBER  NOT NULL ,
	ename                varchar2(20)    ,
	job      			 varchar2(20),
	mgr                  NUMBER    ,
	hiredate             date    ,
	sal                  NUMBER(7,2)    ,
	comm                 NUMBER(7,2)    ,
	deptno               NUMBER    ,
	CONSTRAINT pk_emp PRIMARY KEY ( empno )
 );
insert into dept2 values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept2 values(20, 'RESEARCH', 'DALLAS');
insert into dept2 values(30, 'SALES', 'CHICAGO');
insert into dept2 values(40, 'OPERATIONS', 'BOSTON');
  
insert into emp2 values( 7839, 'KING', 'PRESIDENT', null, SYSDATE, 5000, null, 10);
insert into emp2 values( 7698, 'BLAKE', 'MANAGER', 7839, SYSDATE, 2850, null, 30);
insert into emp2 values( 7782, 'CLARK', 'MANAGER', 7839, SYSDATE, 2450, null, 10);
insert into emp2 values( 7566, 'JONES', 'MANAGER', 7839, SYSDATE, 2975, null, 20);
insert into emp2 values( 7788, 'SCOTT', 'ANALYST', 7566, SYSDATE, 3000, null, 20);
insert into emp2 values( 7902, 'FORD', 'ANALYST', 7566, SYSDATE, 3000, null, 20);
insert into emp2 values( 7369, 'SMITH', 'CLERK', 7902, SYSDATE, 800, null, 20);
insert into emp2 values( 7499, 'ALLEN', 'SALESMAN', 7698, SYSDATE, 1600, 300, 30);
insert into emp2 values( 7521, 'WARD', 'SALESMAN', 7698, SYSDATE, 1250, 500, 30);
insert into emp2 values( 7654, 'MARTIN', 'SALESMAN', 7698, SYSDATE, 1250, 1400, 30);
insert into emp2 values( 7844, 'TURNER', 'SALESMAN', 7698, SYSDATE, 1500, 0, 30);
insert into emp2 values( 7876, 'ADAMS', 'CLERK', 7788, SYSDATE, 1100, null, 20);
insert into emp2 values( 7900, 'JAMES', 'CLERK', 7698, SYSDATE, 950, null, 30);
insert into emp2 values( 7934, 'MILLER', 'CLERK', 7782, SYSDATE, 1300, null, 10);
commit;
select * from emp2;
select * from dept2;*/
-- 함수 (내장) => 라이브러리 (오라클에서 지원하는 함수) 
/*
              내장함수 
                 |
    -------------------------------------
    |               |                    |
 집계함수         단일행 함수        사용자 정의 => 5장
 (단위 column)   (단위 row)        CREATE FUNCTION func_name(매개변수)
     |              |
     ----------------
     | 같이 사용이 안된다 
     | 같이 사용이 필요한 경우 => GROUP BY를 이용한다 
     
   단일행 함수 
     1) 문자 함수 
        = *****LENGTH / LENGTHB
                   | 문자의 Byte
          | 문자의 갯수 
        # LENGTH('ABC') ==> 3
        # LENGTHB('ABC')==> 3
        # LENGTH('홍길동')==> 3
        # LENGTHB('홍길동')==> 9 (한글은 한글자당 3byte) 
        # LENGTH(문자열,컬럼명)
        = UPPER / LOWER / INITCAP
                          | 이니셜 (첫자만 대문자)
                            INITCAP(문자열|컬럼명)
                  | 소문자 LOWER(문자열|컬럼명)
          | 대문자 UPPER(문자열|컬럼명) 
        = LPAD / *****RPAD (L(left) , R(right))
          사용처 : ID 찾기 , 비밀번호 찾기 (이메일 전송) => JavaMail
                  hong => ho**
          LPAD(문자열|컬럼명,글자수,변경할 문자) 
          # LPAD('KING',7,'*')
            ***KING
            LPAD('KING',3,'*')
            KIN
          # RPAD('KING',7,'*')
            KING***
            RPAD('KING',3,'*')
            KIN
        = REPLACE : 변경 
          REPLACE(문자열|컬럼명,찾는 문자 , 변경 문자)
          # REPLACE('Hello Java','a','b')
            => Hello Jbvb
          REPLACE('Hello Java','Java','Oracle')
            => Hello Oracle 
          사용처 => 크롤링시 
                이미지 : URL주소 => & , ||
        = TRIM() 지정된 문자 제거 
          LTRIM() / RTRIM() / TRIM()
                              | 좌우 제거
                    | 오른쪽 제거
          | 왼쪽만 제거
          LTRIM(문자열|컬럼명,제거할 문자)  제거문자
          LTRIM(문자열|컬럼명) 공백 
          RTRIM(문자열|컬럼명,제거할 문자)  제거문자
          RTRIM(문자열|컬럼명) 공백 
          TRIM(문자 FROM 문자열) => 좌우 제거
        = ASCII() / CHR()  
                    | 숫자를 문자로 변경
          | => 문자를 숫자 변경 
            ASCII('A') = 65
            CHR(65) => 'A'
         ===> LENGTH / RPAD 
         문자열 제어 
         문자열 자르기 : SUBSTR()
         SUBSTR(문자열|컬럼명,시작위치,갯수)
         Hello Oracle 
         123456789.... 인덱스번호 1번부터
         문자 위치 찾기 : INSTR() => 인덱스 번호를 구하는 경우
         INSTR(문자열|컬럼명,찾는 문자 , 시작번호, 몇번째)
         INSTR('ABCDEDG','D',1,1)
         INSTR('ABCDEDG','D',1,2)
         문자열 결합 : CONCAT() ==> ||
         CONCAT(문자열,문자열)
         CONCAT('Hello ','Oracle')
           Hello Oracle
         => LENGTH , SUBSTR, INSTR , RPAD , REPLACE 
     2) 숫자 함수 
        MOD => % (나머지) 
          MOD(5,2) => 5%2
        ROUND => 반올림 
          ROUND(123.45678,2) => 123.46
                      -   n+1 대상 
        CEIL  => 올림 
          CEIL(123.7777) => 124
        TRUNC() => 버림 
          TRUNC(123.7777,2) => 123.77
     3) 날짜 함수 
        ***SYSDATE : 시스템의 날짜+시간 
        계산 => SYSDATE+1 / STSDATE-1 => 자동 등록 
        ***MONTHS_BETWEEN : 년도 사이의 개월 수 
        MONTHS_BETWEEN(현재, 과거) = 실수형 
        => 시간 분 초 
        ADD_MONTH : 개월 추가 => 적금 , 연금 , 보험 
        NEXT_DAY : 오늘이후 금요일 
        LAST_DAY : 이달의 마지막 날 
     4) 변환 함수 
        ***TO_CHAR : 날짜,숫자 => 문자 변환 
        TO_CHAR(날짜|숫자,'FORMAT형식')
                    날짜 
                         YYYY 년도 
                         MM 월
                         DD 일 
                         HH / HH24
                         MI
                         SS
                    숫자 
                         99,999,999
        TO_NUMBER : 문자 => 숫자 
        ***TO_DATE : 문자 => 날짜 (예약)
     5) 기타 함수 
        ***NVL : NULL을 다른 값 대체 
        ***CASE : swicth ~ case 
        형식)
              CASE
               WHEN 조건 THEN 값
               WHEN 조건 THEN 값
               WHEN 조건 THEN 값
               WHEN 조건 THEN 값
               ELSE 값
              END
        DECODE : 다중 if 
*/
SELECT LENGTH('ABC'),LENGTHB('ABC'),
       LENGTH('홍길동'),LENGTHB('홍길동')
FROM DUAL;

SELECT ename , UPPER(ename),LOWER(ename),INITCAP(ename)
FROM emp2;

SELECT ename , LPAD(ename,7,'*'),RPAD(ename,7,'*')
FROM emp2;

SELECT ename , LPAD(ename,3,'*'),RPAD(ename,3,'*')
FROM emp2;

SELECT ename , REPLACE(ename,'A','K')
FROM emp2;

SELECT ename,REPLACE(ename,'IN','PP')
FROM emp2;

SELECT ' Hello Oracle ',LTRIM(' Hello Oracle '),
       RTRIM(' Hello Oracle '), TRIM(' Hello Oracle ')
FROM DUAL;
SELECT 'HHHello OracleHHH',LTRIM('HHHello OracleHHH','H'),
       RTRIM('HHHello OracleHHH','H'), TRIM('H' FROM 'HHHello OracleHHH')
FROM DUAL;

SELECT ASCII('1') , CHR(49) 
FROM DUAL;

SELECT hiredate,SUBSTR(hiredate,1,2)
FROM emp;

SELECT hiredate,SUBSTR(hiredate,4,2)
FROM emp;

SELECT hiredate,SUBSTR(hiredate,7,2)
FROM emp;

-- 22년도 입사 
SELECT *
FROM emp 
WHERE SUBSTR(hiredate,1,2)=22;


SELECT 'ABCDEDG',INSTR('ABCDEDG','D',1,1),
       INSTR('ABCDEDG','D',1,2)
FROM DUAL;

SELECT 'ABCDEDG',INSTR('ABCDEDG','D',1,1),
       INSTR('ABCDEDG','D',-1,1)
FROM DUAL;

/*
       A B C D E D G 
       1 2 3 4 5 6 7  indexOf 
       -7 -6  -5  -4  -3  -2  -1 => lastIndexOf -1
*/
-- CONCAT => MySQL의 LIKE 
SELECT CONCAT('Hello ','Oracle')
FROM DUAL;
SELECT 'Hello '||'Oracle'
FROM DUAL;
/*
    WHERE ename LIKE '%'||값||'%' => 자바 오라클  
    WHERE ename LIKE CONCAT('%',값,'%') => 자바 MySQL 
*/
SELECT *
FROM emp
WHERE MOD(empno,2)<>0;
-- 날짜 계산 
SELECT ROUND(123.5678,2),ROUND(123.5674,3)
FROM DUAL;

SELECT TRUNC(123.5678,2),TRUNC(123.5674,3)
FROM DUAL;
-- 총페이지 계산 
SELECT CEIL(1234.123) 
FROM DUAL;
SELECT COUNT(*) FROM book;
SELECT CEIL(COUNT(*)/10.0) FROM book;

-- ROUND / MOD / CEIL / TRUNC 
SELECT SYSDATE , SYSDATE-1 , SYSDATE+1
FROM DUAL;

SELECT ename,hiredate,ROUND((MONTHS_BETWEEN(SYSDATE,hiredate)/12))
FROM emp;

-- ADD_MONTHS => 개월 => 보험 / 적금 / 연금 
SELECT ADD_MONTHS('26/10/12',7)
FROM DUAL;

-- LAST_DAY => 입력 => 그달의 마지막 
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- NEXT_DAY => 날짜 , 요일 
SELECT NEXT_DAY(SYSDATE,'목') 
FROM DUAL;

-- MONTHS_BETWEEN / SYSDATE 
SELECT ename,hiredate,sal,
       TO_CHAR(hiredate,'YYYY-MM-DD HH24:MI:SS'),
       TO_CHAR(sal,'L999,999,999')
FROM emp;

SELECT TO_NUMBER('10') FROM DUAL; -- Integer.parseInt("10")
-- 묵시적 변환   '10'+'10' => 20
SELECT TO_CHAR(TO_DATE('26/11/25','YY/MM/DD'),'YYYY"년" MM"월" DD"일"')
FROM DUAL;
-- DAY는 요일 
SELECT empno,ename,job,hiredate,sal,TO_CHAR(hiredate,'DAY')
FROM emp;
-- TO_CHAR , TO_DATE 
-- 사원이 받는 급여의 총합 ==> sal+comm
SELECT ename,sal,comm,TO_CHAR(sal+NVL(comm,0),'L9,999,999,999') "총급여"
FROM emp;
-- NULL 값을 다른 값으로 대체 한다 
-- NVL(컬럼명,값) => 값이 반드시 컬럼 데이터형과 일치
SELECT zipcode,sido,gugun,dong,NVL(bunji,' ') FROM zipcode;
SELECT ename,sal,NVL(TO_CHAR(comm),'없음') 
FROM emp;
-- 별점 / 레이팅 => TRIGGER
-- CASE 다중조건문 
SELECT ename,deptno,
       CASE
        WHEN deptno=10 THEN '영업부'
        WHEN deptno=20 THEN '개발부'
        WHEN deptno=30 THEN '자재부'
        WHEN deptno=40 THEN '총무부'
        WHEN deptno=50 THEN '기획부'
        ELSE '신입'
      END as job
FROM emp;

-- DECODE => 선택문
SELECT ename,deptno,DECODE(deptno,10,'영업부',
                                  20,'개발부',
                                  30,'기획부',
                                  40,'비서부',
                                  50,'총무부',
                                  '자제부') as job
FROM emp;
/*
     DECODE / CASE
     | 값한개  |모든 조건 연산이 가능
       가독성(X)  가독성(O)
       단순값 비교 복잡한 조건 
    
     단일행 
       = 문자 함수 
         LEGNTH / SUBSTR / INSTR / RPAD 
       = 숫자 함수 
         CEIL / ROUND / TRUNC / MOD 
       = 날짜 함수 
         SYSDATE / MONTHS_BETWEEN 
       = 변환 
         TO_CHAR / TO_DATE 
       = 기타 
         NVL / CASE
         
      --------------------------------------
      집계 함수 : 도메인 (컬럼단위) => 단일행 함수와 같이 사용이 안된다
                 만약에 필요한 경우는 반드시 GROUP BY 이용 
      COUNT()  => ROW의 갯수 
         COUNT(컬럼) => NULL값을 제외
         COUNT(*) => NULL값을 포함 
         로그인 / 아이디 중복 / 장바구니 / 검색 몇건 ...
      MAX / MIN => 최소값 , 최대값
       |=> 자동 증가번호 
      AVG => 평균 
      SUM => 총합 
      RANK => 순위 
      = DENSE_RANK 
        1 2 2 3
      = RANK
        1 2 2 4
        
    ----------------------------------------
    
*/
-- 1. emp에 저장된 사원은 총 몇명 
SELECT COUNT(*) FROM emp; -- NULL을 포함 
-- 2. 커미션을 받는 사원 수 
SELECT COUNT(COMM) FROM emp; -- NULL 값 제외
-- 3. 중복이 없이 총갯수 
SELECT COUNT(DISTINCT deptno) FROM emp;
-- 3. 사원의 급여의 평균 
SELECT TO_CHAR(AVG(sal),'9,999,999') FROM emp;
-- 4. 월 지출되는 총 급여
SELECT TO_CHAR(SUM(sal),'9,999,999,999') FROM emp;
-- 5. 가장 작은 급여 , 가장 큰 급여 
SELECT MIN(sal) , MAX(sal) FROM emp;
-- 6. 급여 높은 순으로 순위를 출력 
SELECT empno,ename,sal,hiredate,job,
       RANK() OVER(ORDER BY sal DESC) as rank
FROM emp;

SELECT empno,ename,sal,hiredate,job,
       DENSE_RANK() OVER(ORDER BY sal DESC) as rank
FROM emp;



