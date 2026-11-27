-- chapter 3장 
-- 145page 169page
/*
    1. 테이블 구조 및 관계 
       BOOK -- 도서 테이블  
         bookid  도서번호 (PK) => 중복없는 데이터  
         bookname 도서명 
         publisher 출판사 
         price  도서 가격 
         
       CUSTOMER -- 고객 테이블 
         custid 고객번호 (PK)
         name 
         address
         phone 
         
       ORDERS -- 주문 테이블 
         orderid : 주문번호 (PK)
         custid : 고객번호 
         bookid : 도서번호 
         saleprice : 판매가격 
         orderdate : 주문일자 
         
         custid        bookid 
       Customer -------  Book
                   |
                  custid 
                  bookid
                 Orders : 매핑 테이블 
                 
       Customer(1) -- (n)Orders 고객 1명이 여러개 주문 
                           (n)
                            |
                           (1)
                          BOOK 
          
    2. SELECT 기본 문법 
       형식,순서) 
                SELECT * | column_list => 튜닝 (IO 반복 줄인다 => *사용하지 않는다)
                FROM table_name (view_name,SELECT~)
                ------------------------------------ 필수 
                [
                   WHERE 조건 (컬럼 연산자 값)
                   GROUP BY 그룹 컬럼 
                   HAVING 그룹에 대한 조건 
                   ORDER BY 정렬 (ASC|DESC)
                ]
                
                실행 순서 
                FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY
                
                JOIN 
                ----
                SELECT 
                FROM 
                JOIN 
                ON 
                GROUP BY 
                HAVING 
                ORDER BY 
                
    [3-1] 모든 도서의 이름과 가격을 검색 
          SELECT bookname,price 
          FROM book;
    [3-2] 도서번호 , 도서이름 , 출판사 , 가격 검색 
          SELECT bookid,bookname,publisher,price
          FROM book;
          --- 컬럼은 ,로 구분 키워드가 나오면 한칸을 띈다 
    [3-3] 중복이 없게 출력 ==>  대부분의 프로그램의 데이터 : 오라클 
                              공유한 데이터 
          DISTINCT ======> Set
          SELECT DISTINCT publisher 
          FROM book;
    기타 : 
            DISTINCT : 중복없는 데이터 출력 
            || : 문자열 결합 
            as : 별칭 
            문자열,날짜  => ''
            "" : 인용부후, 별칭 
            문장 종료 => ; 
                        자바는 자동으로 ;을 설정 
                        AUTOCOMMIT 
                        LIKE '%'||?||'%'
    3. WHERE 조건 검색 = 연산자 => 3-4 ~ 3-11 : WHERE  (조건 검색)
          SI / SM  / 솔루션 / 프레임워크 
                             ---------
          --------   ------  | => 위탁을 받아서 자체 개발 (맨택)  
           | 유지보수  | 유지보수 => 영업 
          오라클에서 지원 연산자 
          = 산술 연산자 
             + : 덧셈만 가능 => 문자열 결합은 (||)
             / : 정수/정수=실수 
             %는 존재하지 않는다 => MOD()
             => SELECT 뒤에 => ROW단위 통계 
             SELECT name,kor,eng,math,kor+eng+math,
                                 (math,kor+eng+math)/3
             FROM student;
          = 비교 연산자 (가장 많이 사용되는 연산자)
              = 같다 
                오라클(=) , 자바(==) , 자바스크립트(===) : ES6
              !=(<>) 같지 않다 
              < 작다 
              > 크다 
              <= 작거나 같다
              >= 크거나 같다  =======> 기준 왼쪽 
              *** 날짜 , 문자열에서 비교된다 
          = 논리 연산자
            AND : JOIN시에 주로 사용 / 직렬 => 두개가 동시 처리  
            OR : LIKE , 여러개 동시 검색
                 || (문자열) , && (입력)
          = BETWEEN ~ AND : 기간 , 범위 => 페이징 기법 
                            NON-EQUI-JOIN
                            이상 , 이하 => 포함 
                            >= AND <=
          = IN : 다중 필터링 => IN(값,값...) 
          = NOT : 부정 조건 => NOT IN , NOT BETWEEN , NOT LIKE 
          = NULL : => 연산 처리가 안된다
                      IS NULL , IS NOT NULL
          = LIKE : 검색 => %(글자수를 모르는 경우) , _ (한글자) 
          
          [3-4] 가격이 20000 미만인 도서 검색 
          SELECT * 
          FROM book
          WHERE price<20000;
          
          [3-5] 가격이 10000 , 20000 에 있는 도서 검색 
          SELECT *
          FROM book
          WHERE price BETWEEN 10000 AND 20000;
          
          SELECT *
          FROM book
          WHERE price>=10000 AND price<=20000;
          
          집합 => IN
          [3-6] 출판사가 굿스포츠 , 대한미디어 도서 검색 
          SELECT *
          FROM book
          WHERE publisher IN('굿스포츠','대한미디어');
          
          SELECT *
          FROM book
          WHERE publisher='굿스포츠' OR publisher='대한미디어';
          
          패턴 = LIKE 
          [3-7] 축구의 역사를 출간한 출판사 검색
          SELECT publisher
          FROM book 
          WHERE bookname='축구의 역사';
          -- 책 제목이 정확히 일치하는 데이터를 검색 
          
          [3-8] 축구가 포함된 도서의 출판사 출력 
          SELECT bookname,publisher
          FROM book
          WHERE bookname LIKE '%축구%';
          
          % 0개 이상의 임의 문자열 
          _ 1개의 문자 
          [3-9] 도서이름중에 두번째 자리에 구가 있는 도서 검색 
          SELECT *
          FROM book
          WHERE bookname LIKE '_구%';
          
          중첩 조건 
          [3-10] 축구에 관한 도서 중에 가격 20000이상인 도서 검색 
          SELECT *
          FROM book
          WHERE bookname LIKE '%축구%'
          AND price>=20000;
          
          [3-11] 출판사가 굿스포츠 또는 대한미디어에서 출판한 도서 검색
          SELECT *
          FROM book
          WHERE publisher='굿스포츠' OR publisher='대한미디어';
    4. ORDER BY 정렬 
          오라클은 정렬이 없다 
          ----------------- 입력된 순서가 아니다
          => 정렬 
             ORDER BY 정렬 컬럼 | 함수 ASC|DESC
                                     ---- 생략이 가능 
             INDEX : 속도가 빠르다 (수정,삭제,추가가 많은 경우 => rebuild)
                     게시판 / 댓글 => ORDER BY
             => INDEX_ASC()
             => INDEX_DESC() 
          [3-12] 도서를 이름순으로 검색 
          SELECT *
          FROM  book
          ORDER BY bookname DESC;
          
          [3-13] 가격순으로 검색 가격이 같으면 이름순으로 검색 
                 -----         ------------------ ,
          SELECT *
          FROM book
          ORDER BY price ASC,bookname ASC;
          1) 가격이 낮은 순 
          2) 같은 가격일때 책이름순으로 => (가나다라...)
    5. 집계 함수 / Group By [3-15~3-20] 
       -------- 여러 행의 데이터를 묶어서 집계 하는 함수 
                COLUMN단위로 계산 
                avg(sal) / sum(sal)  / max(sal) / min(sal) / count(sal)
                count(*) => null 값 포함 
        [3-15] 고객이 주문한 도서의 총판매액 
               SELECT TO_CHAR(SUM(saleprice),'L999,999,999')
               FROM orders;
        select * from orders;
        [3-16] 김연아 고객이 주문한 도서의 총판매액 
        SELECT custid,SUM(saleprice) 
        FROM orders
        GROUP BY custid;
        [3-17] 고객이 주문한 도서의 판매액 , 평균 , 최저 ,최고
        SELECT SUM(saleprice),
               AVG(saleprice),
               MIN(saleprice),
               MAX(saleprice)
        FROM orders;
        [3-18] 서적의 도서 판매 건수 
        SELECT COUNT(*) 
        from ORDERS;
        
        => GROUP BY : 관련된 데이터를 묶어서 통계 (157page)
        [3-19] 고객별 주문도서의 총 수량 / 총 판매액 
        SELECT custid , 
               COUNT(*),
               SUM(saleprice) 
        FROM orders
        GROUP BY custid;
        [3-20] 가격이 8000 이상 도서구매한 구매한 고객중에 2권 이상 구매한 
               고객별 총 수량 
        SELECT custid,
               COUNT(*) 
        FROM orders
        WHERE saleprice>=8000
        GROUP BY custid
        HAVING count(*) > =2;
        
        WHERE : 그룹을 만들기전에 필터링 (실제 데이터)
        GROUP BY : 동일한 값끼리 그룹화 
        HAVING : 그룹화한 결과를 필터링 (그룹 필터링)
        
        실행 
          FROM orders : 데이터을 읽어올 위치 => orders 테이블
          WHERE saleprice>=8000 : 8000 이상인 주문 데이터 읽기 
          GROUP BY custid : 고객별 그룹화 
          HAVING COUNT(*)>=2 : 2권 이상인 고객만 선택 
          SELECT : 고객뱐호 / 주문 건수 출력 
    6. JOIN :  두개이상의 테이블에 필요한 데이터를 연결해서 데이터를 추출하는 방법 
               형식) 
                     INNER JOIN  : 교집합 => 같은 값일때 추출 
                                   NULL값이 있는 경우에 처리 할 수 없다
                                   연산자 => =
                     SELECT A.column , B.column
                     FROM A,B 
                     WHERE A.column=B.column
                     
                     SELECT A.column , B.column
                     FROM A INNER JOIN B 
                            ----- 생략이 가능 
                     ON A.column=B.column
                                
                     OUTER JOIN : INNER JOIN + NULL일 경우 처리
                     LEFT OUTER JOIN 
                         SELECT A.column , B.column
                         FROM A,B 
                         WHERE A.column=B.column(+)
                         
                         SELECT A.column , B.column
                         FROM A LEFT OUTER JOIN B 
                         ON A.column=B.column
                     RIGHT OUTER JOIN
                         SELECT A.column , B.column
                         FROM A,B 
                         WHERE A.column(+)=B.column
                         
                         SELECT A.column , B.column
                         FROM A RIGHT OUTER JOIN B 
                         ON A.column=B.column
        1) orders에 있는 데이터 출력 
           SELECT orderid,custid,bookid,saleprice,orderdate
           FROM orders;
           
           => SELECT orderid,name,bookname,saleprice,orderdate
              FROM orders JOIN customer
              ON orders.custid=customer.custid
              JOIN book
              ON orders.bookid=book.bookid; -- 테이블 연결 (조건)
    7. SubQuery / DDL / INSERT / UPDATE / DELETE 
*/