package com.sist.main;
import java.util.*;
import com.sist.dao.*;

public class StudentMain {

	public static void main(String[] args) {
		Scanner scan=new Scanner(System.in);
		System.out.print("이름 입력:");
		String name=scan.next();
		System.out.print("국어 입력:");
		int kor=scan.nextInt();
		System.out.print("영어 입력:");
		int eng=scan.nextInt();
		System.out.print("수학 입력:");
		int math=scan.nextInt();
		
		StudentVO vo=new StudentVO();
		vo.setName(name);
		vo.setKor(kor);
		vo.setEng(eng);
		vo.setMath(math);
		
		StudentDAO dao=new StudentDAO();
		dao.studentInsert(vo);
		System.out.println("======== 저장 완료!");

	}

}
