package com.sist.emp;
// => 람다
import java.util.*;
public class UserMain {
  public static void main(String[] args) {
	 EmpDAO dao=EmpDAO.getInstance();
	 List<EmpVO> list=dao.empdeptJoinData();
	 for(EmpVO vo:list)
	 {
		 System.out.println(vo.getEmpno()+" "
				 +vo.getEname()+" "
				 +vo.getJob()+" "
				 +vo.getHiredate().toString()+" "
				 +vo.getSal()+" "
				 +vo.getDvo().getDname()+" "
				 +vo.getDvo().getLoc());
	 }
  }
}
