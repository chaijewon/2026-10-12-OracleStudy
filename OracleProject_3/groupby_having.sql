/*
------------------------------------
Group BY / Having 
실제 웹사이트 
매출관리 프로그램 
  = 연도별 매출 현황
  = 월별 매출 통계 
  = 분기별 매출 분석 
인사관리 프로그램 
  = 연도별 입사자 수 
  = 월별 퇴사자 수 
  = 직원 근속기간 분석 
쇼핑몰 주문관리 
  = 월별 주문 건수 
  = 날짜별 결제 현황 
  = 시간대별 주문 분석 
----------------------- 관리자 페이지 
EXTRACT / TO_CHAR
          => 문자
=> 실제 숫자 
=> YEAR / MONTH / DAY / HOUR / MINUTE / SECOND
EXTRACT(추출할 데이터 FROM DATE) => 정수형으로 추출이 가능 
Oracle에서 별칭 
AS 별칭/ ""
SELECT 별칭 
WHERE 불가능 
GROUP BY 불가능 
ORDER BY 가능 
SELECT EXTRACT(year from hiredate) "hire_date"
                                   as hire_date
FROM emp e
GROUP BY EXTRACT(year from hiredate)
ORDER BY "hire_date" => hire_date
------------------------------------
1.	부서별 사원 수를 구하시오.
    ----- ------ COUNT => row의 갯수 
    SELECT deptno,COUNT(*) "인원수"
    FROM emp 
    GROUP BY deptno;
2.	부서별 급여 합계를 구하시오. => sum
    SELECT deptno,TO_CHAR(SUM(sal),'L999,999,999') "급여합계"
    FROM emp 
    GROUP BY deptno;
3.	부서별 평균 급여를 구하시오. => avg
    SELECT deptno,TO_CHAR(ROUND(AVG(sal)),'L999,999,999') "평균 급여"
    FROM emp 
    GROUP BY deptno;
4.	부서별 최고 급여를 구하시오. => max
    SELECT deptno,MAX(sal) "최고 급여"
    FROM emp 
    GROUP BY deptno;
5.	부서별 최저 급여를 구하시오. ==> min
    SELECT deptno,MIN(sal) "최저 급여"
    FROM emp 
    GROUP BY deptno;
    
    SELECT deptno,MAX(sal) "최고 급여",MIN(sal) "최저급여"
    FROM emp 
    GROUP BY deptno;
6.	직급별 사원 수를 구하시오.
    SELECT job,COUNT(*) "사원 수"
    FROM emp 
    GROUP BY job;
7.	직급별 평균 급여를 구하시오.
    SELECT job,ROUND(AVG(sal)) "평균 급여"
    FROM emp 
    GROUP BY job;
8.	직급별 급여 합계를 구하시오.
    SELECT job,SUM(sal) "급여 합계"
    FROM emp 
    GROUP BY job;
9.	직급별 최고 급여와 최저 급여를 구하시오.
    SELECT job,MAX(sal) "최고 급여",MIN(sal) "최저급여"
    FROM emp 
    GROUP BY job;
10.	입사 연도별 사원 수를 구하시오.
    SELECT EXTRACT(year FROM hiredate) as hire_date,
           COUNT(*) "인원수"
    FROM emp
    GROUP BY EXTRACT(year FROM hiredate)
    ORDER BY 1;
11.	입사 연도별 평균 급여를 구하시오.
    SELECT EXTRACT(year FROM hiredate) as hire_date,
            ROUND(AVG(sal)) "평균 급여"
    FROM emp
    GROUP BY EXTRACT(year FROM hiredate)
    ORDER BY 1;
12.	입사 월별 사원 수를 구하시오.
    SELECT EXTRACT(month FROM hiredate) as hire_date,
           COUNT(*) "사원수"
    FROM emp
    GROUP BY EXTRACT(month FROM hiredate);
13.	부서별 커미션 지급 대상자 수를 구하시오.
     SELECT deptno,COUNT(comm) as comm
     FROM emp
     GROUP BY deptno;
     
     SELECT deptno,COUNT(*) as comm
     FROM emp
     WHERE comm IS NOT NULL
     GROUP BY deptno;
14.	부서별 커미션 평균을 구하시오.
    -- COUNT(*) , SUM , AVG => NULL 제외 
    SELECT deptno , ROUND(AVG(comm)) as comm
    FROM emp
    GROUP BY deptno 
    ORDER BY deptno;
15.	부서별 급여와 커미션을 합산한 평균 보수를 구하시오. (NULL은 0)
    SELECT deptno, ROUND(AVG(sal+NVL(comm,0))) as avg
    FROM emp
    GROUP BY deptno
    ORDER BY deptno;
16.	부서별 사원 수와 평균 급여를 동시에 출력하시오.
     SELECT deptno,COUNT(*),ROUND(AVG(sal))
     FROM emp
     GROUP BY deptno
     ORDER BY deptno;
17.	부서별, 직급별 사원 수를 구하시오. => 이중 그룹    
    SELECT deptno,job,COUNT(*) as count
    FROM emp
    GROUP BY deptno,job
    ORDER BY deptno , job DESC;
18.	부서별, 직급별 평균 급여를 구하시오.
    SELECT deptno,job,ROUND(AVG(sal)) as avg
    FROM emp
    GROUP BY deptno,job
    ORDER BY deptno , job DESC;
입사 연도별
=> TO_CHAR(hiredate,'YYYY')
=> EXTRACT(YEAR FROM hiredate) => 실무 
19.	입사 연도별, 직급별 사원 수를 구하시오.
SELECT EXTRACT(year from hiredate) "hire_date",job,
       COUNT(*) "사원수"
FROM emp
GROUP BY EXTRACT(year from hiredate), job
ORDER BY "hire_date";
       
20.	부서별 급여 총액과 사원 수, 평균 급여를 한 번에 출력하시오.
    SELECT deptno,SUM(sal) as total,
           COUNT(*) as count,
           ROUND(AVG(sal)) as avg
    FROM emp
    GROUP BY deptno
    ORDER BY deptno;
    
    GROUP BY : 무엇을 기준으로 묶을 것인가 
               ---------- column : 같은 값을 가지고 있어야 된다
    HAVING : 묶은 결과중 어떤 그룹을 조회 여부 확인 
    WHERE : 그룹전에 제외할 것이 어떤 것이 있는지 
    
    159page GROUP BY => 161 page 주의점 
    GROUP BY => 집계함수 사용이 가능 
                SELECT 순서 , 일반 속성이 가능 
                ** column과 집계함수는 사용이 불가능 
                   GROUP BY가 있는 경우에만 가능 
    => 제외하는 그룹 => HAVING 
    HAVING => GROUP BY가 있는 경우에만 사용이 가능 
    
    WHERE : 데이터행을 걸러낸다 
    HAVING : 그룹별 통계 결과를 걸러낸다 
    ========= 실제 구축의 관리자 페이지 => 통계 
              은행 / 증권 => 금융권 프로그램 
              ---------- 공기업 , 학교 
                         국민연금 , 국세청 , 한전 
              AI => startup
              
    => TO_CHAR : 날짜,숫자의 형식을 변경 => 문자열 
         => 브라우저에 날짜 출력 , 댓글 , 게시판 
       YYYY / MM / DD HH24:MI:SS
       DAY => 요일 
    => 년도 / 월 / 일 / 시간 / 분/ 초 
       EXTRACT(day from hiredate) => 일
       
    => COUNT : ROW 갯수 
    => SUM/AVG : 통계 
    => RANK : 순위 결정 
    
    ----------------------------
    함수(단일행) 
      => 문자 : LENGTH / SUBSTR / INSTR 
      => 숫자 : CEIL / ROUND 
      => 날짜 : SYSDATE , MONTHS_BETWEEN 
      => 변환 : TO_CHAR 
      => 기타 : NVL
    
    연산자 
      비교연산자 : = , <> , < , >
      ==> 산술 , 논리 => 대부분이 자바에서 처리 
      오라클에서만 존재 
      BETWEEN ~ AND 
      IN 
      NULL 
      LIKE 
    ----------------------------------------
    SELECT 
    FROM 
    WHERE 
    GROUP BY 
    HAVING
    ORDER BY 
       
Having : 그룹을 제외 => 조건 

1.	사원이 10명 이상인 부서만 출력하시오.
    1) group by deptno  
    2) 함수 count 
    3) having  count 
    SELECT deptno,COUNT(*) "인원수"
    FROM emp
    GROUP BY deptno
    HAVING COUNT(*)>=10;
2.	평균 급여가 400만원 이상인 부서를 출력하시오.
    1) group by  deptno 
    2) 함수 avg()
    3) having avg()
    SELECT deptno,ROUND(AVG(sal)) "평균급여"
    FROM emp
    GROUP BY deptno 
    HAVING AVG(sal)>=4000000;
    # GROUP BY가 없는 경우에는 HAVING은 사용이 불가능 
3.	급여 총액이 3000만원 이상인 부서를 출력하시오.
    1) Group : deptno 
    2) SUM() => 구하기 
    3) SUM>=3000000 Having 
    SELECT deptno,SUM(sal) "급여 총액"
    FROM emp
    GROUP BY deptno
    HAVING SUM(sal)>3000000;
    => 실무 => 부서별 인건비 
4.	최고 급여가 600만원 이상인 부서를 출력하시오.
    1) Group : deptno 
    2) 함수 => MAX
    3) MAX()>=6000000
    SELECT deptno,MAX(sal) "최고급여"
    FROM emp 
    GROUP BY deptno
    HAVING MAX(sal)>=6000000;
5.	최저 급여가 300만원 이상인 부서를 출력하시오.
    SELECT deptno,MIN(sal) "최저급여"
    FROM emp 
    GROUP BY deptno
    HAVING MIN(sal)>=3000000;
6.	사원 수가 5명 이상인 직급만 출력하시오. => job
    SELECT job , COUNT(*) "사원수"
    FROM emp
    GROUP BY job
    HAVING COUNT(*)>=5;
7.	평균 급여가 450만원 이상인 직급만 출력하시오.
    SELECT job,ROUND(AVG(sal)) "평균급여"
    FROM emp
    GROUP BY job 
    HAVING AVG(sal)>=4500000;
8.	급여 합계가 1억원 이상인 직급만 출력하시오.
    SELECT job,SUM(sal) "급여합계"
    FROM emp
    GROUP BY job
    HAVING SUM(sal)>=90000000;
9.	커미션 지급 대상자가 3명 이상인 부서를 출력하시오.
    -- COUNT(*) : 모든 사원
    -- COUNT(comm) : comm에 값이 있는 사원
    SELECT deptno,COUNT(comm) "지급 대상자"
    FROM emp
    GROUP BY deptno
    HAVING COUNT(comm)>=3;
    
    SELECT COUNT(*),COUNT(comm) 
    FROM emp;
    
    SELECT COUNT(*) 
    FROM emp
    WHERE comm IS NULL;
    
    COUNT(*) : NULL을 포함한 전체 갯수
    COUNT(comm) : COMM이 NULL이 아닌 행의 갯수 
          컬럼  => NULL 값 제외 
10.	커미션 평균이 30만원 이상인 부서를 출력하시오.
    SELECT deptno,ROUND(AVG(comm)) "커미션 평균"
    FROM emp 
    GROUP BY deptno
    HAVING AVG(comm)>=300000; 
    -- AVG / SUM => NULL 값을 제외 
# 복합 조건 => OR(또는 , 이거나) , AND(이면서 ,이고) 
11.	사원 수가 10명 이상이면서 평균 급여가 400만원 이상인 부서를 출력하시오.
    SELECT deptno,COUNT(*) "인원수",ROUND(AVG(sal)) "평균급여"
    FROM emp
    GROUP BY deptno
    HAVING COUNT(*)>=10 AND AVG(sal)>=4000000;
12.	최고 급여와 최저 급여의 차이가 300만원 이상인 부서를 출력하시오.
    SELECT deptno,MAX(sal)-MIN(sal) "차이"
    FROM emp
    GROUP BY deptno 
    HAVING MAX(sal)-MIN(sal)>=3000000;
13.	직급별 평균 급여가 전체 평균 급여보다 높은 직급을 출력하시오.
    --------------  -------------
    SELECT ROUND(AVG(sal)) FROM emp; 4514000 전체 평균 
    SELECT job, ROUND(AVG(sal)) "평균급여"
    FROM emp
    GROUP BY job
    HAVING AVG(sal)>4514000;
    
14.	입사 연도별 사원 수가 15명 이상인 연도를 출력하시오.
    SELECT EXTRACT(year FROM hiredate) "hiredate",
           COUNT(*) "인원수"
    FROM emp
    GROUP BY EXTRACT(year FROM hiredate)
    HAVING COUNT(*)>=15;
15.	입사 월별 사원 수가 5명 이상인 월을 출력하시오.
    SELECT EXTRACT(month FROM hiredate) "hiredate",
           COUNT(*) "사원 수"
    FROM emp
    GROUP BY EXTRACT(month FROM hiredate)
    HAVING COUNT(*)>=5;
16.	부서별 급여 총액이 5000만원 이상인 부서를 출력하시오.
    SELECT deptno,SUM(sal) "부서별 급여 총액"
    FROM emp
    GROUP BY deptno
    HAVING SUM(sal)>=50000000;
17.	부서별 평균 급여가 350만원 이상 500만원 이하인 부서를 출력하시오.
    SELECT deptno,ROUND(AVG(sal)) "부서별 평균 급여"
    FROM emp
    GROUP BY deptno
    HAVING AVG(sal) BETWEEN 3500000 AND 5000000;
    -- AVG(sal)>=3500000 AND AVG(sal)<=5000000
18.	부서별 커미션 지급 대상자가 존재하면서 사원 수가 5명 이상인 부서를 출력하시오.
    SELECT deptno,
           COUNT(*) "사원수",COUNT(comm) "커미션 지급 대상자"
    FROM emp
    GROUP BY deptno
    HAVING COUNT(comm)>0 AND COUNT(*)>=5;
19.	부서별, 직급별 사원 수가 2명 이상인 그룹을 출력하시오.
    SELECT deptno,job,COUNT(*) "사원 수"
    FROM emp
    GROUP BY deptno,job
    HAVING COUNT(*)>=2;
20.	부서별 사원 수가 10명 이상이고 최고 급여가 600만원 이상인 부서를 출력하시오.
    SELECT deptno,COUNT(*) "사원 수" , MAX(sal) "최고 급여"
    FROM emp 
    GROUP BY deptno
    HAVING COUNT(*)>=10 AND MAX(sal)>=6000000;
*/