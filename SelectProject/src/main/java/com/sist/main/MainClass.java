package com.sist.main;
import java.util.*;
import com.sist.dao.*;

public class MainClass {
	public static void main(String[] args) {
		EmpDAO dao=EmpDAO.newInstance(); //싱글턴 객체 생성
		
		//데이터출력
		ArrayList<EmpVO> list=dao.empListData();
		for(EmpVO vo:list) {
			System.out.println(vo.getEmpno()+" "
					+vo.getEname()+" "
					+vo.getJob()+" "
					+vo.getHiredate().toString()+" "
					+vo.getSal()+" "
					+vo.getDvo().getDname()+" "
					+vo.getDvo().getLoc()+" "
					+vo.getSvo().getGrade());
		}
		
		Scanner scan=new Scanner(System.in);
		System.out.print("이름 입력:");
		String ename=scan.next();
		
		//LIKE
		ArrayList<EmpVO> list1=dao.empFindData(ename);
		for(EmpVO vo:list1) {
			System.out.println(vo.getEmpno()+" "+vo.getEname()+" "+vo.getJob()+" "
					+vo.getHiredate().toString()+" "+vo.getSal());
		}
		
		//SUBQuery
		EmpVO vo=dao.empSubQueryData(ename.toUpperCase());
									//대소문자 상관없이 변환되어 전송되도록 설정
		System.out.println("사번:"+vo.getEmpno());
		System.out.println("이름:"+vo.getEname());
		System.out.println("직위:"+vo.getJob());
		System.out.println("입사일:"+vo.getHiredate());
		System.out.println("급여:"+vo.getSal());
		System.out.println("부서명:"+vo.getDvo().getDname());
		System.out.println("근무지:"+vo.getDvo().getLoc());
		
		//InlineView
		System.out.print("인원 입력:");
		int rownum=scan.nextInt();
		
		ArrayList<EmpVO> list2=dao.empInlineView(rownum);
		for(EmpVO vo2:list2) {
			System.out.println(vo2.getEmpno()+" "+vo2.getEname()+" "+vo2.getJob()+" "
					+vo2.getHiredate().toString()+" "+vo2.getSal());
		}
	}
}
