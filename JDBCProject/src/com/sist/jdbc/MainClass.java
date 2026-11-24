package com.sist.jdbc;
import java.util.*;
// jdbc = dbcp = orm(mybatis / jpa)
/*
 *    select * 
 *    from emp
 *    where ename like '%a%'
 *    
 *    findByEnameLike(String ename)
 *    findByNo(int no) => where no=10
 */
public class MainClass {
    
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		Set set=map.keySet();
        EmpDAO dao=EmpDAO.newInstance();
        List<EmpVO> list=dao.empListData();
        for(EmpVO vo:list)
        {
        	System.out.println(vo.getEmpno()+" "
        			+vo.getEname()+" "
        			+vo.getJob()+" "
        			+vo.getSal());
        }
	}

}
