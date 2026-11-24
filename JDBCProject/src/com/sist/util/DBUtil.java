package com.sist.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DBUtil {
	private Connection conn; // 오라클 연결 => Socket 
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	// 1. 드라이버 설정 
	  public DBUtil()
	  {
		  try
		  {
			  Class.forName("oracle.jdbc.driver.OracleDriver");
		  }catch(Exception ex) {
			  ex.printStackTrace();
		  }
	  }
	  // 2. 오라클 연결 
	  public Connection getConnection()
	  {
		  try
		  {
			  conn=DriverManager.getConnection(URL,"hr","happy");
			  // => 오라클  conn hr/happy
		  }catch(Exception ex) {}
		  return conn;
	  }
	  // 3. 오라클 닫기 
	  public void disConnection(Connection conn,PreparedStatement ps)
	  {
		  try
		  {
			  if(ps!=null)
				  ps.close(); // in.close() , out.close()
			  if(conn!=null)
				  conn.close(); // socket.close()
			  // => exit 
		  }catch(Exception ex) {}
		  
	  }
}
