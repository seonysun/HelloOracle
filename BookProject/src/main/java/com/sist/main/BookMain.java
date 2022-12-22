package com.sist.main;
import java.util.*;
import com.sist.dao.*;

public class BookMain {

	public static void main(String[] args) {
		BookDAO dao=new BookDAO();
		
		ArrayList<BookVO> list1=dao.book3_1();
		for(BookVO vo:list1) {
			System.out.println(vo.getBookname()+" "+vo.getPrice());
		}
		System.out.println();
		
		ArrayList<BookVO> list2=dao.book3_2();
		for(BookVO vo:list2) {
			System.out.println(vo.getBookid()+" "
					+vo.getBookname()+" "
					+vo.getPublisher()+" "
					+vo.getPrice());
		}
		System.out.println();
		
		ArrayList<String> list3=dao.book3_3();
		for(String s:list3) {
			System.out.println(s);
		}
		System.out.println();
		
		ArrayList<CustomerVO> list21=dao.book3_21();
		for(CustomerVO vo:list21) {
			System.out.println(vo.getName()+" "
					+vo.getAddress()+" "
					+vo.getPhone()+" "
					+vo.getOvo().getBookid()+" "
					+vo.getOvo().getSaleprice()+" "
					+vo.getOvo().getOrderDate());
		}
		System.out.println();
		
	}

}
