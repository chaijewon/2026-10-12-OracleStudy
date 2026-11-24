-- Chapter 03 => SQL 기초 
/*
              SQL : 문자열 형식  143ㅔpage
               |
       ----------------------------------------
       |           |        |        |        |
      DQL        DML       DDL      DCL      TCL
       |          |         |        |        |
                                        정상 저장 / 전체 취소
                                            COMMIT 
                                            ROLLBACK 
                                            SAVEPOINT 
                                   권한부여/취소
                                    GRANT 
                                    REVOKE
    검색 /추출  데이터 조작 생성,수정,삭제
     SELECT     INSERT     CREATE 
                UPDATE     ALTER
                DELETE     DROP
                
     SELECT => 데이터 읽기 
     -------
     1. 테이블의 구조 확인 
        => 데이터형 / 컬럼명 
        DESC table명 
     
*/
-- 테이블 구조 확인 
DESC emp;
/*
   사원 정보 
   EMPNO    NOT NULL NUMBER(4)    사번 => 정수형 
   ENAME    NOT NULL VARCHAR2(20) 이름 => 문자열 
   JOB               VARCHAR2(20) 직위 => 문자열 
   HIREDATE          DATE         입사일 => 날짜형
   COMM              NUMBER(10,2) 성과급 => 정수
   SAL               NUMBER(10,2) 연봉 => 정수
   DEPTNO            NUMBER(2)    부서번호 => 정수
   142page 
   = 데이터 검색 
   = 형식 / 순서 
     ------------------------------------------
     SELECT *(전체) | column 나열 (원하는 데이터만)
     FROM 테이블명 
     -------------------------------- 필수 조건
     [
         WHERE 조건(연산자) === 
         GROUP BY 
         HAVING 
         ORDER BY === 
     ]
   = 주의점 
     1) 데이터베이스는 대소문자 구분이 없다 
        약속) 키워드 대문자로 한다 
        ** 실제로 저장된 데이터는 대소문자 구분 
           KING => king (X)
     2) 문장이 종료되는 ;을 사용 
        => 자바는 ;을 자동으로 추가 
     3) 문자,날짜는 반드시 ' '을 사용한다 
        => 모든 데이터베이스 '' , ""(인용부호,별칭)
     4) 실행 문장 => 문자열 형식으로 되어 있다 
     5) 날짜 형식 => YY/MM/DD
     6) 중복없는 데이터 : 컬럼앞에 DISTINCT => Set
     7) 문자열 결합 => ||
     8) &를 사용하면 => Scanner
     9) 한줄 , 여러줄이 가능 
        SELECT * FROM emp;
        SELECT *
        FROM emp 
        WHERE....
     10) 실행 순서 
         FROM - WHERE -GROUP BY - HAVING - SELECT - ORDER BY
   = 옵션 
   = 연산자 
*/
-- 1. 모든 사원의 정보를 가지고 온다 
SELECT *
FROM emp;
-- 2. 원하는 데이터문 출력 : 사번,이름,직위, 입사일,급여
SELECT empno,ename,job,hiredate,sal
FROM emp;
-- 3. 이름 , 부서번호 출력 
SELECT ename , deptno 
FROM emp;
-- 4. 어떤 부서가 있는지 확인 => 중복 없이
SELECT DISTINCT deptno
FROM emp;
-- 5. 사번 / 이름 / 직위 / 입사일 / 연봉 
-- 
SELECT empno "사번",ename "이름",job "직위" ,
       hiredate "입사일",sal "연봉" 
FROM emp;

SELECT empno as 사번,ename as 이름,job as 직위 ,
       hiredate as 입사일,sal as 연봉 
FROM emp;

-- 6. 문자열 결합 =>  || => OR
-- 이름는 이번 연봉은 00000 입니다 
SELECT ename||'는 이번 연봉은 '||sal||'입니다'
FROM emp;
-- 7. Scanner 입력 받기 
SELECT * 
FROM emp
WHERE empno=&사번; -- 한명의 모든 정보 

