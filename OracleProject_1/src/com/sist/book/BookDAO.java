package com.sist.book;
// 테이블당 한개 생성 = 필요시에 재사용 
/*
 *     자바   ========>  오라클 (자바 = txt)
 *             SQL
 *             
 *     자바   ========  브라우저 (자바 = txt)
 *             HTML
 *             
 *     자바   ========  자바스크립트
 *             JSON
 *     ---------------------------------+ 웹 사이트 
 *     
 *     GIT   ========  AWS (우분투) 
 *          우분투 명령어(CI/CD)
 *          
 *     => Spring-Boot / MyBatis (JPA) / Oracle (MySQL) 
 *         | 자바 / JSP / ThymeLeaf 
 *     => GIT (Branch) , Git Action , Pull Request 
 *        => 명령어 이용  
 *     => Docker / 쿠바네티스 / 젠킨스 
 *     ------------------------------------------------
 *     => Spring AI / 파이썬 / LLM 
 *     => React / Next 
 *     
 *     1. 오라클 연동 
 *     = 드라이버 등록 => 한번만 수행 => 생성자 
 *     = 오라클 연결   => URL / UserName / Password 
 *     = SQL문장 전송 => SQL문장을 작성이 가능 
 *     = 실행 결과값 받기 => 레코드 => 한줄씩 => ~VO
 *     2. 브라우저 / JavaScript / 자바 자체 처리 
 *     
 *     Connection : 오라클 연결
 *        getConnection()  
 *     PreparedStatement : SQL문장을 보내고 실행 결과 받기
 *        prepareStatement(): SQL문장으로 오라클 전송 
 *        executeQuery() : 실행후에 결과값 읽기 
 *     ResultSet : 오라클에 가지고 온 데이터가 저장 
 *        커서의 위치 변경
 *           **next() => 처음부터 => 밑으로 내려가면서 데이터 읽기 
 *           prevous() => 밑에서부터 위로 올라온다 
 *           데이터 읽을때 
 *             getInt() / getDouble() / getString() / getDate()
 *             
 *      => rs.close()
 *         ps.close()
 *         conn.close()  
 */
import java.sql.*;
import java.util.*;
// 웹 => VO/DAO => 80%
public class BookDAO {
    // 연결 객체
	private Connection conn;
	// SQL 송신/수신 
	private PreparedStatement ps;
	// URL
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	// 1. 드라이버 등록 
	public BookDAO()
	{
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	// 2. 연결 
	public void getConnection()
	{
		try
		{
			conn=DriverManager.getConnection(URL,"hr","happy");
		}catch(Exception ex) {}
	}
	// 3. 닫기 
	public void disConnection()
	{
		try
		{
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		}catch(Exception ex) {}
	}
	
	// 기능 => findByAll()
	public void bookAllData()
	{
		try
		{
			// 1. 연결 
			getConnection();
			// 2. 오라클로 보낼 SQL문장 작성 
			String sql="SELECT bookname,bookid,publisher,price FROM book "
					  +"WHERE publisher='굿스포츠'";
			ps=conn.prepareStatement(sql,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY); // SQL로 전송 메소드 
			// 3. 결과값을 받는다 
			ResultSet rs=ps.executeQuery();
			rs.last();
			// ResultSet => 결과값을 저장하는 메모리 공간 
			/*
			 *    ResultSet
			 *    --------------------------------
			 *     no  name address rate regdate
			 *    --------------------------------
			 next |  1   홍길동   서울   10.5  26/11/24
			   getInt()  rs.getString()         |
			                             |    rs.getDate()
			                           rs.getDouble()
			 *    --------------------------------
			 *     1   홍길동   서울   10.5  26/11/24
			 *    --------------------------------
			 *     1   홍길동   서울   10.5  26/11/24 | rs.previous()
			 *    --------------------------------
			 */
			do
			{
				System.out.println(
				  rs.getInt(2)+" "
				  +rs.getString(1)+" "
				  +rs.getString(3)+" "
				  +rs.getInt(4)
				  
				);
			}while(rs.previous());
			
			rs.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		finally
		{
			disConnection(); // 무조건 닫기 
		}
	}
	
	
	public void find()
	{
		Scanner scan=new Scanner(System.in);
		System.out.print("책 제목:");
		String name=scan.next();
		try
		{
			getConnection();
			String sql="SELECT bookname,publisher "
					  +"FROM book "
					  +"WHERE bookname LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			// ? 에 값을 채운다 
			ps.setString(1, name);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				System.out.println(rs.getString(1)+" "
						+rs.getString(2));
			}
			rs.close();
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			disConnection();
		}
	}
	
	public static void main(String[] args) {
		BookDAO dao=
				new BookDAO();
		//dao.bookAllData();
		dao.find();
	}
	
}











