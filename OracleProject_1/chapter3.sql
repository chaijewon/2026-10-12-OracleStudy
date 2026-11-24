-- 데이터 조작어 - 검색 
/*
    WHERE 문장 (조건) 
              ------ 연산자 
    SELECT * | column_list 
    FROM table_name 
    WHERE 조건 
          ----
          column 연산자 값 
                 ------
    오라클 지원하는 연산자  143page 
    -------------------
    1. 산술연산자 : + , - , *  /
                  % => MOD()
       + : 순수하게 덧셈만 가능
       / : 0으로 나누면 오류 발생 
           정수/정수=실수 , 5/2 => 2.5
           => SELECT 뒤에서 통계 
           => 임시 테이블 => 연산 결과 확인 => DUAL
    2. 비교연산자 : = (같다) , != ^= <>(권장) , < , > , <= , >=
                            ---------------
                  => 숫자 , 문자 , 날짜까지 적용 
    3. 논리연산자 : AND , OR 
                   &&(X) ||(X) 
                         --- 문자열 결합 
                   --- 입력 
                   NOT : 부정 => !(X)
             
    4. BETWEEN ~ AND : 기간 , 범위 
                       페이징 기법 
                       >= AND <=
                       BETWEEN 10 AND 100 => 10,100포함 
    5. IN : OR가 여러개인 경우에 => 간단하게 표현 
            deptno=10 OR deptno=20 OR deptno=30 
            deptno IN(10,20,30)
    6. LIKE : 검색 
              유사문자 검색 
              LIKE 'A%' => startsWith A로 시작하는 모든 문자열 
              LIKE '%A' => endsWith A로 끝나는 모든 문자열 
              LIKE '%A%' => contains A가 포함된 문자열 
              LIKE '___A' => _ 한글자 
              => REGEXP_LIKE => 함수 (정규식)
              
              name LIKE '%A%' OR name LIKE '%B%' OR name LIKE '%C%'
              REGEXP_LIKE(name ,'A|B|C')
              검색기 
    7. NULL => 값이 NULL인 경우 연산처리가 안된다 
               IS NULL : NULL값인 경우 
               IS NOT NULL : NULL값이 아닌 경우 
       SELECT * FROM emp;
*/
SELECT 10+3,10-3,10*3,10/3 
FROM DUAL; -- DUAL은 오라클에서 지원하는 테이블 (데이터 없이 연산 결과 함수 결과)
-- 자동으로 문자열을 숫자형 변경이 된다 / 연산 
SELECT TO_NUMBER('10')+'3','10'-3,'10'*'3',10/3 
FROM DUAL; -- 변환하는 시간이 있다 = 속도가 느려진다 
-- 가급적이면 사용하지 않는다 (권장) 
-- TO_NUMBER()를 이용한다 = Integer.parseInt()
SELECT * 
FROM emp
WHERE comm IS NOT NULL;

-- 1. 산술연산자 => select 
-- 각 사원의 총급여를 가지고 온다 => comm+sal
-- 오라클 => ROW단위 통계가 없다 / column단위 통계는 있다 (sum,avg,max,min)
SELECT ename,sal , comm , sal+NVL(comm,0), sal*12 
FROM emp;
-- 2. 비교연산자 => 결과값 true / false => WHERE에서 주로 사용 
-- = , <> , < , > , <= , >=
-- 날짜까지 비교가 가능   3400000
SELECT * FROM emp
WHERE sal=3400000;

-- 권장 (같지 않다)
SELECT * FROM emp
WHERE sal<>3400000;

SELECT * FROM emp
WHERE sal!=3400000;

SELECT * FROM emp
WHERE sal^=3400000;

SELECT * FROM emp
WHERE sal<3400000; -- if , select는 for

SELECT * FROM emp
WHERE sal>3400000;

SELECT * FROM emp
WHERE sal<=3400000;

SELECT * FROM emp
WHERE sal>=3400000;

-- 20/07/22
SELECT * FROM emp
WHERE hiredate='20/07/22';
SELECT * FROM emp
WHERE hiredate<>'20/07/22';
SELECT * FROM emp
WHERE hiredate<'20/07/22';
SELECT * FROM emp
WHERE hiredate>'20/07/22';
SELECT * FROM emp
WHERE hiredate<='20/07/22';
SELECT * FROM emp
WHERE hiredate>='20/07/22';
-- 조하준
SELECT * FROM emp
WHERE ename='조하준';

SELECT * FROM emp
WHERE ename<>'조하준';

SELECT * FROM emp
WHERE ename<'조하준';

SELECT * FROM emp
WHERE ename>'조하준';
-- 날짜 => 'YY/MM/DD'
-- 문자 => '조하준'

/*
    논리 연산자 
    (조건) AND (조건) : 범위안에 포함 (기간) ~부터 ~까지  => BTEWEEN AND 
    -----      ----
    TRUE       TRUE ==> TRUE
    TRUE       FALSE => FALSE
    FALSE      TRUE  => FALSE
    FALSE      FALSE => FALSE
    (조건) OR (조건) : 범위밖에 포함  ==> IN
    TRUE       TRUE ==> TRUE
    TRUE       FALSE => TRUE
    FALSE      TRUE  => TRUE
    FALSE      FALSE => FALSE
*/
-- 20년도에 입사한 사원 목록 
SELECT * 
FROM emp
WHERE hiredate>='20/01/01' AND hiredate<='20/12/31';

SELECT * 
FROM emp
WHERE hiredate BETWEEN '20/01/01' AND '20/12/31';

SELECT * 
FROM emp
WHERE hiredate LIKE '20%';



