package com.sist.jdbc;
/*
 *   NUMBER  =======> int / double  
 *   VARCHAR2 ======> String 
 *   DATE    =======> java.util.Date 
 *   --> 오라클은 대소문자 구분이 없다 
 *   약속 
 *    키워드는 대문자 
 *    CREATE TABLE food_data(
 *       
 *    );
 *    => FOODDATA
 *    
 *     EMPNO  NUMBER(4) ==> int  0~9999 
       ENAME VARCHAR2(20) ==> String
       JOB  VARCHAR2(20) ==> String
       HIREDATE  DATE ==> Date
       COMM   NUMBER(10,2) ==> int 10000000
       SAL  NUMBER(10,2)  ==> int
       DEPTNO  NUMBER(2) ==> int
 */
import java.util.*;

import lombok.Data;
@Data
public class EmpVO {
   private int empno;
   private String ename;
   private String job;
   private Date hiredate;
   private int comm;
   private int sal;
   private int deptno;
}
