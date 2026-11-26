-- 2026-11-26 1,2,3장 정리 
/*
    1. DataBase 
       = 데이터베이스 : 데이터를 체계적으로 저장하고 관리하는 공간 
         : 폴더(윈도우) : 패키지(자바) : 오라클 (XE)
           CREATE DATABASE mydb 
       = 데이터 : 가공이 않된 정보 
         데이터의 종류 
         -----------
           1) 정형화된 데이터 => 오라클 / MySQL..에 저장된 데이터
           2) 반정형화된 데이터 => 구분만 된 데이터
                                 HTML/XML/JSON...
           3) 비정형화된 데이터 => txt / pdf ...
              => 빅데이터 => 가공 => 필요한 데이터를 오라클 
        = 테이블 : 데이터를 행과 열로 저장하는 구조 
        = 행(ROW) : 한개의 모든 정보를 저장 
                    학생/맛집/레시피 ....
                    => 객체
        = 열(Column) :  데이터의 항목 , 속성 
                    => 클래스 멤버변수 
        = 레코드 : 테이블에 저장된 하나의 Row 
                  => 레코드 
        = 기본키 (PK) : 각 ROW를 구분하는 구분자 (번호)
        = 스키마 :   테이블을 제작하기 위한 논리 구조 
    2. DBMS 
        = 데이터베이스를 생성 / 저장 / 
          관리기능을 기능을 가지고 있는 소프트웨어
        = 데이터 저장 / 조회 
            INSERT     SELECT
          수정 / 삭제 / 보안 / 백업 / 동시성 제어 
          UPDATE , DELETE 
    3. RDBMS 
        = 데이터를 테이블 형태로 저장 => 관계를 관리하는 시스템
        = SQL문장을 이용해서 관리 
        = 데이터의 중복을 줄일 수 있다 => 일관성 
        = 데이터의 안정성 보장 
    4. 오라클 
        = 데이터를 저장 관리 => 관계형 데이터베이스 관리 시스템 
        = SQL / SQL Developer
    5. 오라클 동작 
        1) SQL문장 작성 
           --- 오라클에 명령문을 작성 
        2) 파싱 : SQL문법 => 권한 확인 
        3) 실행 
        4) 결과값 반환 
    6. SQL => SELECT문장 형식 / 동작 순서 
       => 데이터 조회(검색)
          SELECT :  조회할 컬럼 지정 (*=>전체)
                            ----------------- IO입출력 많다 
                             속도가 느리다 (필요한 컬럼만)
          FROM : 데이터를 어디서 가지고 올지 (테이블)
          WHERE : 조건 설정 => 연산자 
          GROUP BY : 그룹을 묶어서 
          HAVING : 그룹에 대한 조건 설정 
          ORDER BY : 조회 결과 정렬 
          
          실제 실행 
          FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY
    7. 상세한 검색 => 연산자 => 언제 사용하는지 
       산술 : ROW단위 처리 => 합 / 평균 / 단가 계산 / 수량 계산 
             + , - , * , /
       비교 : = , !=(<>) , < , > , <= , >=
             로그인 / 재고 부족 , 가격 조건 , 급여 
       논리 : 로그인 => id,pwd 
              AND , OR
       BETWEEN ~ AND  : 페이징 , 비등가 조인 
       IN : 검색 필터링 
       NOT : 반대 조건 
       NULL : 연산 처리가 안된다 => IS NULL , IS NOT NULL
       LIKE : 실제 검색기 
       => WHERE 안에 조건 처리 
    8. 내장 함수 
       = 단일행 
         한행씩 데이터를 처리 
         각행마다 하나의 결과을 반환 
         문자 / 날짜 / 숫자 / 변환 / 기타(NULL,다중 조건)
       = 집계 
         여러행의 데이터를 모아서 계산 
         합계,평균 ,갯수 
         그룹별 / 전체 데이터 통계 
       => 단일행 
          문자 함수 
            = LENGTH = 비밀번호 길이 검사 , 지정된 범위 처리 
            = SUBSTR = 전화번호 분리 , 우편번호 분리 
            = INSTR = 문자열 검사 
            = REPLACE = 크롤링시 변경해야되는 문자
                        || , & 
          날짜 함수 
            = SYSDATE : 등록일 / 예약일 / 회원 가입 
                        현재 컴퓨터의의 날짜,시간 
            = MONTHS_BETWEEN : 퇴직 , 근속 기간 => ERP
          숫자 함수
            = CEIL : 총페이지 
            = ROUND : 평균 
            = MOD : 나머지 / TRUNC
          변환 함수 
            = TO_CHAR => 문자 변환 / 댓글 날짜 변환 , 10,000
            = TO_DATE => 예약일 선택 => 문자열 => TO_DATE
          기타 함수 
            = NVL : NULL 값 대체 
            = CASE : 별점 = 다중 조건문 
          집계함수 
            = COUNT : 로그인 / 장바구니 확인 / 아이디 중복 체크 
            = SUM : 장바구니 , 구매 목록 
            = AVG : 등급 
            = MAX : 자동 증가 번호 
          --------------------------
           쇼핑몰 / 인사관리 / 물류관리 / 예약관리 / 게시판 
    9. Group BY / Having 
       
    10. 두개이상의 테이블을 연결 => 데이터 추출 (JOIN)
        = INNER JOIN 
        = OUTER JOIN 
    11. 집합 연산자 
        = UNION
        = UNION ALL
        = INTERSECT
        = MINUS 
    12. SUBQUERY => SQL문장을 합쳐서 제어 
        = 일반 서브쿼리 
        = 스칼라 서브쿼리 
        = 인라인뷰 
    13. DDL => 데이터형 / 어떤 데이터가 필요한지 
    14. DML => INSERT / UPDATE / DELETE 
    15. 고급 과정 
        가상 테이블 : 보안 => View 
        최적화 : 인덱스 
        자동 증가 : 시퀀스 
        테이블명을 공통사용 => 시노님 
        사용자 정의 함수 : PL/SQL 
                         FUNCTION / PROCEDURE 
        자동화 처리 : TRIGGER
        => SQL 튜닝 
    16. 요구사항 분석 
        = ER-MODEL 
        = ERD 
        = 정규화 (1~3정규화) 
    17. 트랜잭션 
    18. 보안 
    ----------- 웹 개발자 : 자바 + 오라클 + HTML
                           ------------------- JSP 
*/
-- GROUP BY : Group별 통계 => 값은 값을 가지고 있는 column을 이용해서 그룹설정 
-- SELECT * FROM emp;
SELECT COUNT(*),SUM(sal),ROUND(AVG(sal))
FROM emp
WHERE deptno=10;
SELECT COUNT(*),SUM(sal),ROUND(AVG(sal))
FROM emp
WHERE deptno=20;
SELECT COUNT(*),SUM(sal),ROUND(AVG(sal))
FROM emp
WHERE deptno=30;
SELECT COUNT(*),SUM(sal),ROUND(AVG(sal))
FROM emp
WHERE deptno=40;
SELECT COUNT(*),SUM(sal),ROUND(AVG(sal))
FROM emp
WHERE deptno=50;
SELECT COUNT(*),SUM(sal),ROUND(AVG(sal))
FROM emp
WHERE deptno=60;
SELECT COUNT(*),SUM(sal),ROUND(AVG(sal))
FROM emp
WHERE deptno=70;
SELECT COUNT(*),SUM(sal),ROUND(AVG(sal))
FROM emp
WHERE deptno=80;

select * from emp
order by deptno;

-- 부서별 
SELECT deptno , COUNT(*) "인원수",
                SUM(sal) "급여총합",ROUND(AVG(sal)) "부서평균"
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

-- 입사년도별 
SELECT hiredate, COUNT(*) "인원수",
                SUM(sal) "급여총합",ROUND(AVG(sal)) "부서평균"
FROM emp
GROUP BY hiredate
ORDER BY hiredate ASC;

SELECT TO_CHAR(hiredate,'YYYY'), COUNT(*) "인원수",
                SUM(sal) "급여총합",ROUND(AVG(sal)) "부서평균"
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')
ORDER BY TO_CHAR(hiredate,'YYYY') ASC;

-- 성씨 
SELECT SUBSTR(ename,1,1),COUNT(*) "인원수",
             SUM(sal) "급여총합",ROUND(AVG(sal)) "부서평균"
FROM emp
GROUP BY SUBSTR(ename,1,1)
ORDER BY SUBSTR(ename,1,1) ASC;

-- 입사 요일별  DAY : 요일포함 , DY
SELECT TO_CHAR(hiredate,'DY'),COUNT(*) "인원수",
             SUM(sal) "급여총합",ROUND(AVG(sal)) "부서평균"
FROM emp
GROUP BY TO_CHAR(hiredate,'DY')
ORDER BY TO_CHAR(hiredate,'DY');

-- 직위별 
SELECT job , COUNT(*) "인원수",
             SUM(sal) "급여총합",ROUND(AVG(sal)) "부서평균"
FROM emp
GROUP BY job
ORDER BY job;

-- 부서별로 성과급을 받는 사원수 , 총 성과급 
SELECT deptno,COUNT(*),SUM(sal) --4
FROM emp  -- 1
WHERE comm IS NOT NULL -- 2
GROUP BY deptno  --3
ORDER BY deptno; --5

-- 부서별 = 직위별 인원수 , 합 , 평균 
SELECT deptno,job,COUNT(*) "인원수",
             SUM(sal) "급여총합",ROUND(AVG(sal)) "부서평균"
FROM emp 
GROUP BY deptno,job
ORDER BY deptno ASC , job DESC;

/*
   GROUP BY : 같은 값을 가진 데이터끼리 그룹으로 묶어서 처리 
              쇼핑몰 : 등급 , 은행 
              학교 = 학년 / 반 
   HAVING : 그룹을 묶은 결과에 조건을 적용 
   WHERE : 그룹을 묶기전에 조건이 적용 
*/
-- HAVING 사용법 
-- 부서별 평균 급여가 4061538보다 큰 부서만 출력 
SELECT deptno,COUNT(*),ROUND(AVG(sal)) 
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal))>4061538;
-- WHERE (X) HAVING (집계함수 사용이 가능) 
/*
     FROM emp
     EMP에서 데이터 가져오기
     GROUP BY deptno
     부서번호별로 그룹화 하기 
     HAVING ROUND(AVG(sal))>4061538;
     그룹 평균이 4061538 크거를 찾아라
     SELECT deptno,COUNT(*),ROUND(AVG(sal))
     부서번호, 인원수 , 급여 평균 
     
     ==> 실무에서 GROUP BY 사용법 => 관리자 모드 
*/


