-- 2026-11-25 3장 / 4장 => 연산자 정리 , 내장함수 , GROUP BY / HAVING 
/*
     SELECT * | column_list 
     FROM table_name
     [
        WHERE 연산자 (조건) 
        GROUP BY 그룹컬럼 
        HAVING 그룹 조건 => 집합 함수 
        ORDER BY 정렬 컬럼 
     ]
     
     FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY
     
     1) SELECT 
        => 테이블에 어떤 컬럼이 있는 지 , 컬럼에 저장된 데이터형 
           DESC table_name
        => 문자열 / 날짜 => 반드시 ''를 사용한다 
        => SQL문장이 종료 반드시 ;을 사용 
           (자바는 자동으로 ;을 만들어 준다)
        => 키워드는 대문자로 사용 => 대소문자 구분이 없다 
        => 중복없이 데이터 추출 :   DISTINCT 컬럼
                                ----------  Set
        => 별칭 => 컬럼명 "별칭" , 컬럼명 as 별칭 
        => 문자열 결합 => ||
        => 한줄에 코딩 / 여러줄로도 가능 
        SELECT * FROM emp;
        ------------------
        SELECT *
        FROM emp;
        ------------------ 띄어쓰기 => 자바에서 오류 (문자열)
        
        연산자 
        ------ WHERE에서 사용되는 조건 
        산술연산자 (+ , - , * , /) => 순수하게 산술만 사용이 가능
                  3+5 => 8
                  '3'+'5' => 8
                  ------- 자동으로 숫자 변환 (묵시적 형변환)
                  TO_NUMBER('3') 
                  ------- 단점은 속도가 느려진다 
                  / => 정수/정수=실수 
                        5/2=2.5
        비교연산자 : = (같다) 
                   = : WHERE에서 사용 => 같다 
                     : WHERE외에 다른 곳에서 사용 => 대입
                     UPDATE emp SET
                     ename='Hong' ======> 대입 
                     WHERE ename='Hong' ===> 비교
                   != , <>(권장) , ^=
                   < , > , <= , >=
        논리연산자 : AND , OR 
                         | 범위 밖에 있는 경우
                   | 범위안에 있는 경우
                   && => 입력받는 경우 
                   || => 문자열 결합 
        BETWEEN ~ AND : 기간 , 범위 
                  WHERE 컬럼 BETWEEN 값 AND 값 
                                    --     -- 포함 
                  # 숫자 , 날짜 , 문자 
                  >= AND <=
        IN : 여러개를 동시에 수행 
             WHERE 컬럼 IN(값,값,값...) 
        NOT : 부정  => NOT IN , NOT BETWEEN , NOT LIKE 
        NULL : 데이터가 저장이 안된 상태 
               # 연산 처리가 안된다 
               IS NULL  => NULL인 경우 
               IS NOT NULL => NULL이 아닌 경우
        LIKE : 검색 => 포함 여부 
               % : 여러개 문자 (갯수가 없다)
               _ : 한글자 
               
               WHERE 컬럼명 LIKE 'A%'
               WHERE 컬럼명 LIKE '%A'
               WHERE 컬럼명 LIKE '%A%'
               WHERE 컬럼명 LIKE '__A%'
       데이터베이스의 단점 
       ----------------
         경우의 수가 많다 (같은 데이터를 추출 => sql문장이 여러개 있다)
                                            --------------------
                                            | 가장 빠른 속도 => 튜닝
         SQL => 문장 형식으로 만든다 : 순서,형식 
             => 자신의 스타일을 찾는다 
             => 컬럼명으로 구분이 가능 / 명령어 = 읽기,쓰기 편리 
             
         => 전체 데이터 읽기 => * (오라클에서 테이블에 저장된 순서) 
            필요한 내용만 출력 => column1,column2...
            문법 사항 
              1) 대소문 구분이 없다 
                 (실제 저장된 데이터는 대소문자 구분) 
              2) 오라클에서는 문장 종료 ; , 자바는 자동으로 ;
              3) 키워드 : 대문자로 사용 
              4) 일반 연산 , 함수 확인 => dual(임시 테이블 이용) 
         => 테이블 구조 
            DESC emp     dept => JOIN,SUBQUERY
            DESC book
            DESC customer
                 orders  JOIN , SUBQUERY => 정규화 
                 
         emp
          EMPNO    NOT NULL NUMBER(4)    사번 => 구분자 (정수)
          ENAME    NOT NULL VARCHAR2(20) 이름 
          JOB               VARCHAR2(20) 직위
          HIREDATE          DATE         입사일 
          COMM              NUMBER(10,2) 성과급 
          SAL               NUMBER(10,2) 급여 
          DEPTNO            NUMBER(2)    부서번호 
          
          book 
          BOOKID    NOT NULL NUMBER(3)     책번호 => 구분자 
          BOOKNAME           VARCHAR2(40)  책이름 
          PUBLISHER          VARCHAR2(40)  출판사 
          PRICE              NUMBER(8)     금액 
          
          customer
          CUSTID  NOT NULL NUMBER(3)       회원번호
          NAME             VARCHAR2(40)    이름 
          ADDRESS          VARCHAR2(50)    주소 
          PHONE            VARCHAR2(20)    전화 

*/
-- 1. emp => 급여가 3000000 이상인 사원 모든 정보 
SELECT *
FROM emp
WHERE sal>=3000000;
-- 2. 급여가 3000000이상인 사원의 이름 , 입사일 ,직위 , 급여
SELECT ename,hiredate,job,sal
FROM emp
WHERE sal>=3000000;

-- 3. 직위가 사원이 아닌 사원의 모든 정보 
SELECT *
FROM emp
WHERE job<>'사원';  

SELECT *
FROM emp
WHERE job!='사원'; 

SELECT *
FROM emp
WHERE job^='사원'; 

-- 4. 21이전에 입사한 사원의 모든 정보 
SELECT *
FROM emp
WHERE hiredate<'21/01/01'; -- 비교연산자 => 날짜 , 문자 

-- 5. 21년에 입사한 모든 사원 
SELECT *
FROM emp
WHERE hiredate BETWEEN '21/01/01' AND '21/12/31';

SELECT *
FROM emp
WHERE hiredate LIKE '21%';

SELECT *
FROM emp
WHERE TO_CHAR(hiredate,'YY')=21;

SELECT *
FROM emp
WHERE SUBSTR(hiredate,1,2)=21;

-- 6. 복합 => 부서번호가 10 이거나 ,직위가 과장 
SELECT *
FROM emp 
WHERE deptno=10 OR job='과장';

-- 7. IN 연산자 ==> 같은 컬럼에서 찾는다 => 필터링(검색)
-- 안수빈 , 문채린 , 백유림 
SELECT *
FROM emp
WHERE ename IN('안수빈','문채린','백유림');

-- 8. NULL 처리 (연산처리가 안된다) => IS NULL , IS NOT NULL
-- 회원중에 전화가 없는 회원의 모든 정보 
SELECT *
FROM customer
WHERE phone IS NULL;
-- 사원중에 성과급이 있는 사람 
SELECT *
FROM emp
WHERE comm IS NOT NULL;

-- 9 부정 => NOT 
SELECT *
FROM emp
WHERE ename NOT IN('안수빈','문채린','백유림');


SELECT *
FROM emp
WHERE hiredate NOT BETWEEN '21/01/01' AND '21/12/31';

SELECT *
FROM emp 
WHERE NOT (deptno=10 OR job='과장');

-- 10. LIKE : 검색 
-- 1) 강씨 성을 가진 모든 사원 정보 
SELECT *
FROM emp
WHERE ename LIKE '강%';
-- 2) 원으로 끝나는 사원의 정보 
SELECT *
FROM emp
WHERE ename LIKE '%원';

-- 3) 채가 포함된 사원 
SELECT *
FROM emp
WHERE ename LIKE '%채%';

-- 4) 두번째 글자 채인 사원 목록 
SELECT *
FROM emp 
WHERE ename LIKE '_채%';

-- 5) 세글자를 가진 사원의 정보 
SELECT *
FROM emp
WHERE ename LIKE '___';

/*
     1. 비교연산자 => 로그인 / 아이디 찾기 / 비밀번호 찾기 / 상세보기  
     2. BETWEEN => 페이지 나누기 
     3. IN => 검색 필터링 
     4. LIKE => 검색 => %값%
*/
-- 1. 정렬 => 오라클은 정렬이 안되어 있다 
/*
       ORDER BY => 버블정렬 => 속도가 늦다 (인덱스로 변경) 
       
       사용법) ORDER BY 컬럼명|함수 ASC|DESC 
                                 ---- 생략이 가능 
              컬럼의 위치를 이용할 수 있다 
                       1     2    3     4
              SELECT ename,empno,job,hiredate
              FROM emp
              ORDER BY 1 => ename을 정렬 => ASC
              
              * => 오라클에 저장된 순서 
              
              이중 정렬 
              no  val
              1    A
              2    C
              4    D
              3    E
              1    B
              
              ORDER BY no ASC , val DESC
              => 대댓글 
              1  B
              1  A
              2  C
              3  D
              4  E
              
*/