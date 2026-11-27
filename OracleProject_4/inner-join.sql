/*DROP TABLE salgrade;
CREATE TABLE salgrade (
    grade NUMBER(1) PRIMARY KEY, -- 급여 등급
    losal NUMBER(10,2) NOT NULL,  -- 최소 급여
    hisal NUMBER(10,2) NOT NULL   -- 최대 급여
);
INSERT INTO salgrade VALUES (1, 700000, 1200000);
INSERT INTO salgrade VALUES (2, 1200001, 2500000);
INSERT INTO salgrade VALUES (3, 2500001, 4000000);
INSERT INTO salgrade VALUES (4, 4000001, 6000000);
INSERT INTO salgrade VALUES (5, 6000001, 10000000);
COMMIT;*/
-- 2026-11-27 : JOIN 
/*
     1. JOIN의 목적 / 사용처 
        ----
        테이블의 문제 = 중복된 데이터가 많이 존재 
                      -----------
                      중복 제거 => 테이블을 나눠서 작업 (관련된 데이터)
                      영화 / 회원 
                       |     |
                       -------
                          |
                        예약 => 테이블을 따라 제작 => 정규화 (3정규화)
        여러 테이블로 부터 분리된 데이터를 연결해서 조회할 목적 
        => 공통 컬럼을 기준으로 테이블 결합 
           -------- 컬럼명이 다를 수 있다 (저장된 값이 같은 값을 가지고 있다)
           
        => 사용하는 이유 
           1) 중복 데이터 최소화 (데이터베이스 설계 => 정규화) 
           2) 여러 테이블의 정보를 한번 검색 
           3) 관련된 데이터를 통합 
        => JOIN핵심 
        테이블간의 공통 컬럼이나 같은 데이터를 이용해서 연결하는 기법 
        나눠진 테이블을 한개로 통합 
        => JOIN의 사용처 
           1. 필요한 정보가 여러 테이블로 나우어져 있는 경우 
           2. 다른 테이블의 정보를 통합 해서 출력할 경우 
              사원정보 / 부서정보
           3. 데이터가 없어도 테이블의 전체 목록을 출력 
              ------------- NULL값 = Outer Join
     2. JOIN 종류 
        오라클 JOIN 
        ANSH JOIN (권장) 
        -----------------
        1) INNER JOIN : NULL값이 있는 경우 처리가 안된다 
           등가조인 (EQUI_JOIN) : 같은 값이 있는 경우 
                  연산자 =
           비등가 조인 (NON_EQUI_JOIN) : 범위안에 포함 된 경우 
                  연산자 : 비교연산자 , BETWEEN ~ AND 
        2) OUTER JOIN : NULL값 처리가 가능 (Inner의 단점 보완)
           = LEFT OUTER JOIN : Left에 처리가 안된 데이터가 있는 경우
           = RIGHT OUTER JOIN : Right에 처리가 안된 데이터가 있는 경우
        3) 기타 
           컬럼명이 동일한 경우에 사용 
           자연 조인 : NATURAL JOIN (자연조인)  
           USING : JOIN ~ USING 
           # 두개이상의 테이블을 연결해서 필요한 데이터 추출 
     3. JOIN의 형식 
        = INNER JOIN => SELECT만 사용이 가능 
          오라클 조인 
            SELECT A.column , B.column 
            FROM A,B
            WHERE A.column=B.column 
            => 테이블명이 긴 경우 => 별칭
            SELECT o.column,c.column 
            FROM orders o , customer c
                 --------   ----------
            WHERE o.column=c.column
            => 추출할 컬럼을 가지고 오는 경우 
               컬럼이 동일한 경우 => 반드시 구분 (오류:애매한 정의)
               ---------------- 테이블명.컬럼 , 별칭.컬럼
          ANSH 조인 => 권장 => 표준화된 조인 (모든 데이터베이스에서 사용)
            SELECT A.column,B.column
            FROM A (INNER)JOIN B
            ON A.column=B.column
*/
DESC emp;
DESC dept;
/*
    EMPNO    NOT NULL NUMBER(4)    
    ENAME    NOT NULL VARCHAR2(20) 
    JOB               VARCHAR2(20) 
    HIREDATE          DATE         
    COMM              NUMBER(10,2) 
    SAL               NUMBER(10,2) 
    DEPTNO            NUMBER(2)  FK
      |
    DEPTNO NOT NULL NUMBER(2)    PK 
    DNAME  NOT NULL VARCHAR2(20) 
    LOC             VARCHAR2(20)
    
    테이블 ==> PK, FK 가 선언된 데이터 
*/
/*
SELECT orderid,name,bookname,saleprice , orderdate 
FROM orders o,customer c,book b
WHERE o.custid=c.custid AND o.bookid=b.bookid;
*/
-- INNER JOIN => 연산자 (=) =>  등가 조인 (EQUI-JOIN) => 교집합 
-- 1. EMP에서 DEPT를 연결해서 각사원의 부서명 , 근무지를 가지고 온다 
-- 오라클 조인 ,  WHERE / ANSH 조인  JOIN , ON
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp , dept 
WHERE emp.deptno=dept.deptno;
-- 테이블 별칭
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp e , dept d
WHERE e.deptno=d.deptno;

-- ANSH 조인  INNER는 생략이 가능  
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp  JOIN dept 
ON emp.deptno=dept.deptno;

--  별칭 
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp e JOIN dept d
ON e.deptno=d.deptno;

-- 극히 드물게 사용 
-- 자연 조인 : 반드시 같은 컬럼명이 존재
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp NATURAL JOIN dept;

-- JOIN ~ USING : 반드시 같은 컬럼명이 존재
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp JOIN dept USING(deptno);

-- 비등가 조인 (=외에 다른 연산자를 사용시에) => 비교연산자 / BETWEEN ~ AND 
-- SELECT * FROM emp;
-- SELECT * FROM salgrade;
/*
    for(int i=0;i<emp.length;i++)
    {
       for(int j=0;j<dept.length;j++)
       {
           if(emp[i]==dept[j])
           {
              dept[i] 출력 
           }
       }
    }
*/
-- 각 사원의 사번 , 이름 , 직위 , 입사일 , 급여 , 급여 등급 
SELECT empno,ename,job,hiredate,sal,grade
FROM emp,salgrade 
WHERE sal BETWEEN losal AND hisal; -- 범위에 포함 
-- 같은 값을 찾은 경우 => 모든 컬럼을 읽어 올 수 있다 

-- ANSH 조인 
SELECT empno,ename,job,hiredate,sal,grade
FROM emp JOIN salgrade 
ON sal BETWEEN losal AND hisal;

-- 2중 조인 
-- 사번 , 이름 , 직위 , 입사일 , 급여 (emp), 부서명,근무지 (dept), 급여 등급(salgrade)
-- 오라클 조인 
SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;
-- ANSH 조인 
SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp JOIN dept
ON emp.deptno=dept.deptno
JOIN salgrade
ON sal BETWEEN losal AND hisal;

-- 조인은 1) 조건 : 조인 조건 / AND => 다른 조건 
-- empno,ename,job,hiredate,sal,dname,loc ==> 안수빈
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp,dept 
WHERE emp.deptno=dept.deptno 
AND ename='안수빈';

SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp JOIN dept 
ON emp.deptno=dept.deptno 
AND ename='안수빈';

-- empno,ename,job,hiredate,sal,dname,loc  : JOIN
-- job이 과장인 사원만 추출 
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp JOIN dept 
ON emp.deptno=dept.deptno 
AND job='과장'
ORDER BY hiredate;

SELECT emp.*,dname,loc 
FROM emp JOIN dept 
ON emp.deptno=dept.deptno; 

/*
   JOIN : 여러개 테이블 연결 => 필요 데이터 추출 기술 
   사용 => 회원 + 주문정보 
          직원 + 부서정보 
*/
-- 1. 사원 이름(emp) + 부서명(dept) 
SELECT ename,dname 
FROM emp,dept
WHERE emp.deptno=dept.deptno;

SELECT ename,dname 
FROM emp JOIN dept
ON emp.deptno=dept.deptno;
/*
   EMP에서는 사원 이름 
   DEPT에서는 부서명 
   ------------------ 부서번호로 연결 
   서로 다른 테이블에서 데이터를 조회
*/
--2. 사원이름(ename):emp + 근무 지역(loc): dept 추출 
SELECT ename,loc 
FROM emp JOIN dept
ON emp.deptno=dept.deptno;

-- 3. 김씨 성을 가진 사원의 이름 , 근무지 , 부서명 
SELECT ename,loc,dname
FROM emp JOIN dept
ON emp.deptno=dept.deptno
AND ename LIKE '김%';

-- 4. 사원 => 사번(empno),이름(ename),직위(job),부서번호(deptno),부서명(dname),근무지(loc)
-- 조건 : ANSI => 별칭 이용 
SELECT empno,ename,job,e.deptno,dname,loc
FROM emp e JOIN dept d
ON e.deptno=d.deptno;

-- 5. 이름 , 부서 , 근무지 
-- 조건 : 사원이 서울이 아닌 근무지인 경우
SELECT ename,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno 
AND loc<>'서울';
-- 문자열 / 날짜 => ''
-- 6. 복합 연산자 
-- ename,dname,loc 
-- 조건 : 수원에서 근무 => 황씨 성을 가진 모든 사원을 추출 
SELECT ename,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno 
AND loc='수원' 
AND ename LIKE '황%';

-- 2023년 입사한 사원의 이름 , 직위 , 입사일 , 근무지 , 부서명 , 급여 등급 
SELECT ename,job,hiredate,loc,dname,grade,TO_CHAR(hiredate,'DAY')
FROM emp JOIN dept
ON emp.deptno=dept.deptno
JOIN salgrade
ON sal BETWEEN losal AND hisal 
--AND EXTRACT(year FROM hiredate)=2023;
AND TO_CHAR(hiredate,'DAY')='금요일';

/*
    EXTRACT(year FROM hiredate)
            ---- month , day , hour , second ...
    요일 : TO_CHAR 
          DY / DAY
               |= 월요일
          |= 월
*/
-- 부서명과 해당 부서의 사원 수를 출력 
/* 
    count() => row의 갯수 
    집계함수 => GROUP을 사용하지 않는 경우 
               컬럼,단일행 함수를 같이 사용이 불가능 
*/
SELECT dname,COUNT(*)
FROM emp 
JOIN dept 
ON emp.deptno=dept.deptno 
GROUP BY dname;

-- 부서명별 평균 급여 => GROUP BY => AVG
SELECT dname,ROUND(AVG(sal))
FROM emp 
JOIN dept 
ON emp.deptno=dept.deptno 
GROUP BY dname;

-- 부서명과 직급별 사원 수를 추출
SELECT dname,job,COUNT(*)
FROM emp
JOIN dept 
ON emp.deptno=dept.deptno
GROUP BY dname,job;

-- 서울,부산에서 근무하는 사원 모든 정보 , 부서명 , 근무지 출력
SELECT emp.*,dname,loc
FROM emp
JOIN dept 
ON emp.deptno=dept.deptno
AND loc IN('서울','부산');

-- 이름 , 부서명 => 성과급을 받는 사원만 출력 
SELECT ename,dname
FROM emp
JOIN dept 
ON emp.deptno=dept.deptno
AND comm IS NOT NULL;

SELECT ename,dname,loc
FROM emp
RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno;

-- desc emp;
/*
EMPNO    NOT NULL NUMBER(4)    
ENAME    NOT NULL VARCHAR2(20) 
JOB               VARCHAR2(20) 
HIREDATE          DATE         
COMM              NUMBER(10,2) 
SAL               NUMBER(10,2) 
DEPTNO            NUMBER(2)  
*/
select MAX(empno) FROM  emp;


