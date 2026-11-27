-- Outer JOIN 
/*
    => 관리자 페이지 
    Outer JOIN : 두개 이상의 테이블을 연결 
                 조건이 일치하지 않는 데이터를 조회가 가능 
                 ** INNER JOIN => 조건 맞는 경우만 추출 
                 ** NULL이 있는 경우 => 추출이 불가능 
    = LEFT OUTER JOIN 
      INTERSECT + MINUS(emp-dept)
    = RIGHT OUTER JOIN
      INSERSECT + MINUS(dept-emp)
    = FULL OUTER JOIN
      INSERSECT + UNION 
      
    오라클 조인 ==> 
    형식) 
          SELECT A.column,B.column
          FROM A,B
          WHERE A.column=B.column(+)
          
          SELECT A.column,B.column
          FROM A,B
          WHERE A.column(+)=B.column
          
    ANSI JOIN(권장)
          SELECT A.column,B.column
          FROM A LEFT OUTER JOIN B
          ON A.column=B.column
          
          SELECT A.column,B.column
          FROM A RIGHT OUTER JOIN B
          ON A.column=B.column
          
          SELECT A.column,B.column ==> ANSI만 존재 
          FROM A FULL OUTER JOIN B
          ON A.column=B.column
*/
-- Left Outer JOIN
-- 1. 모든 부서와 해당 부서의 사원 이름 출력 
SELECT dept.deptno,dname,ename
FROM dept 
LEFT OUTER JOIN emp
ON dept.deptno=emp.deptno;

SELECT dept.deptno,dname,ename
FROM emp 
RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno;

-- 90 => 사원 이름이 없다 (null)

-- 모든 부서를 출력하고 사원이 없는 부서를 표시 
SELECT d.deptno,dname,empno,ename
FROM emp e
RIGHT OUTER JOIN dept d
ON d.deptno=e.deptno;

-- 부서별 평균 급여 => 사원이 없는 부서도 출력 
/*
    emp : left
    dept : right => RIGHT
    
    dept : left
    emp : right => LETF
*/
SELECT dname,ROUND(AVG(sal)) "평균 급여"
FROM dept 
LEFT OUTER JOIN emp
ON dept.deptno=emp.deptno 
GROUP BY dname;

SELECT dname,ROUND(AVG(sal)) "평균 급여"
FROM dept,emp
WHERE dept.deptno=emp.deptno(+) 
GROUP BY dname;


SELECT dname,ROUND(AVG(sal)) "평균 급여"
FROM emp 
RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno 
GROUP BY dname;

SELECT dname,ROUND(AVG(sal)) "평균 급여"
FROM emp,dept
WHERE emp.deptno(+)=dept.deptno
GROUP BY dname;

-- 사원이 없는 부서의 갯수 
SELECT COUNT(*) "부서수"
FROM dept 
LEFT OUTER JOIN emp
ON dept.deptno=emp.deptno
WHERE empno IS NULL;

CREATE TABLE aaa(no NUMBER);
CREATE TABLE bbb(no NUMBER);

INSERT INTO aaa VALUES(1);
INSERT INTO aaa VALUES(2);
INSERT INTO aaa VALUES(3);
INSERT INTO aaa VALUES(4);
INSERT INTO aaa VALUES(5);

INSERT INTO bbb VALUES(4);
INSERT INTO bbb VALUES(5);
INSERT INTO bbb VALUES(6);
INSERT INTO bbb VALUES(7);
INSERT INTO bbb VALUES(8);

COMMIT;
-- UNION 
SELECT no FROM aaa
UNION
SELECT no FROM bbb;

-- UNION ALL
SELECT no FROM aaa
UNION ALL
SELECT no FROM bbb;

-- INTERSECT 
SELECT no FROM aaa
INTERSECT
SELECT no FROM bbb;

SELECT no FROM bbb
MINUS
SELECT no FROM aaa;
/*
    INNER JOIN 
      SELECT A.column,B.cloumn
      FROM A 
      JOIN B
      ON A.column=B.cloumn
    OUTER JOIN
      SELECT A.column,B.cloumn
      FROM A 
      LEFT OUTER JOIN B
      ON A.column=B.cloumn
      
      SELECT A.column,B.cloumn
      FROM A 
      RIGHT OUTER JOIN B
      ON A.column=B.cloumn
      
      
      INNER JOIN은 두개 테이블 연결 
      WHERE => 필요한 데이터 검색 
      GROUP BY => 지정된 그룹별 통계 
      LEFT JOIN 데이터가 없는 컬럼 조회 
*/






