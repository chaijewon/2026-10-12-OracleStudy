package com.sist.emp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
public class EmpDAO {
	   // 연결 객체 
	   private Connection conn;
	   // 송수신 객체 
	   private PreparedStatement ps;
	   // URL 
	   private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	   // 메모리 한개 사용 => 메모리 절약 / 일관성 => 싱글턴 방식 
	   private static EmpDAO dao;// 
	   // 총페이지 / 페이지 나누기 / 조회 (LIKE)
	   // 1. 드라이버 등록 => 한번만 등록 => 생성자 
	   public EmpDAO()
	   {
		   try
		   {
			   Class.forName("oracle.jdbc.driver.OracleDriver");
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
		   }
	   }
	   // 2. 오라클 연결 
	   public void getConnection()
	   {
		   try
		   {
			   conn=DriverManager.getConnection(URL,"hr","happy");
			   // 오라클 => conn hr/happy 
		   }catch(Exception ex) {}
	   }
	   // 3. 오라클 닫기 
	   public void disConnection()
	   {
		   try
		   {
			   if(ps!=null) ps.close();
			   if(conn!=null) conn.close();
		   }catch(Exception ex) {}
	   }
	   // 4. 싱글턴 패턴 
	   public static EmpDAO getInstance()
	   {
		   if(dao==null)
			   dao=new EmpDAO();
		   return dao;
	   }
	   // 조인 
	   public List<EmpVO> empdeptJoinData()
	   {
		   List<EmpVO> list=
				   new ArrayList<EmpVO>();
		   try
		   {
			   // 1. 연결 
			   getConnection();
			   // 2. SQL문장 => 오라클로 전송
			   String sql="SELECT empno,ename,job,hiredate,sal,dname,loc "
					     +"FROM emp JOIN dept "
					     +"ON emp.deptno=dept.deptno "
					     +"ORDER BY empno ASC";
			   // 3. 전송 
			   ps=conn.prepareStatement(sql); 
			   // conn:Socket , ps: BufferedReader , OutputStream 
			   // 4. 오라클에 실행 요청 / 데이터를 메모리에 저장해라 
			   ResultSet rs=ps.executeQuery();
			   // 5. 메모리에 저장된 데이터를 읽어서 => List에 저장 
			   while(rs.next()) // 데이터의 첫번째 위치부터 마지막까지 출력 
			   {
				   // Box => VO 
				   EmpVO vo=new EmpVO();
				   vo.setEmpno(rs.getInt(1));
				   vo.setEname(rs.getString(2));
				   vo.setJob(rs.getString(3));
				   vo.setHiredate(rs.getDate(4));
				   vo.setSal(rs.getInt(5));
				   vo.getDvo().setDname(rs.getString(6));
				   vo.getDvo().setLoc(rs.getString(7));
				   list.add(vo);
			   }
			   rs.close();
		   }catch(Exception ex)
		   {
			   // 에러 확인 
			   ex.printStackTrace();
		   }
		   finally
		   {
			   // 닫기 
			   disConnection();
		   }
		   return list;
	   }
}
