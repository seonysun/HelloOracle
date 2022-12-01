package com.sist.dao;

import java.sql.*;
import java.util.*;

public class MemberDAO {
	private Connection conn;
			//오라클 연결 클래스
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:xe"; 
							//오라클주소, XE : 자동 설정 DB 이름
	
	//드라이버(thin) 등록 -> ojdbc8.jar 라이브러리 이용
	public MemberDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
						//ojdbc8.jar 라이브러리에 존재하는 클래스 호출
		} catch(Exception ex) {}
	}
	//오라클 연결
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
											//오라클에 conn hr/happy 전송
		} catch(Exception ex) {}
	}
	//오라클 연결 해제
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch(Exception ex) {}
	}
	
	//기능 -로그인
	public String isLogin(String id,String pwd) {
		String result="";
		try {
			getConnection();
			//SQL 문장 제작, 전송
			String sql="SELECT COUNT(*) FROM member WHERE id='"+id+"'";
															//오라클 문법이므로 '' 줘야 함
						//id를 가진 member의 갯수 찾기
			ps=conn.prepareStatement(sql);
			//실행결과 저장
			ResultSet rs=ps.executeQuery();
			rs.next();
			int count=rs.getInt(1);
			if(count==0) {
				result="NOID";
			} else {
				sql="SELECT pwd,name FROM member WHERE id='"+id+"'";
					//해당되는 id의 member의 pwd와 name 찾기
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				rs.next();
				String db_pwd=rs.getString(1);
				String name=rs.getString(2);
				
				if(db_pwd.equals(pwd))
					result=name;
				else result="NOPWD";
			}
			//오라클 전송
			//결과값 받기
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return result;
	}
}
