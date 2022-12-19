package com.sist.dao;
import java.util.*;

import oracle.jdbc.internal.OracleTypes;

import java.sql.*;

public class StudentDAO {
	private Connection conn;
	private CallableStatement cs; //프로시저 호출 시 사용하는 클래스
								  //일반 SQL문장 호출 시 PreparedStatement
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	public StudentDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch(Exception ex) {}
	}
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		} catch(Exception ex) {}
	}
	public void disConnection() {
		try {
			if(cs!=null) cs.close();
			if(conn!=null) conn.close();
		} catch(Exception ex) {}
	}
	public void studentInsert(StudentVO vo) {
		try {
			getConnection();
			String sql="{CALL studentInsert(?,?,?,?)}";
			cs=conn.prepareCall(sql);
			cs.setString(1, vo.getName());
			cs.setInt(2, vo.getKor());
			cs.setInt(3, vo.getEng());
			cs.setInt(4, vo.getMath());
			cs.executeQuery(); //SQL에서 프로시저에 커밋을 포함시켰으므로 Query, 무조건 Query 사용!
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
	}
	public ArrayList<StudentVO> studentListData(){
		ArrayList<StudentVO> list=new ArrayList<StudentVO>();
		try {
			getConnection();
			String sql="{CALL studentLisrData(?)}";
			cs=conn.prepareCall(sql);
			cs.registerOutParameter(1, OracleTypes.CURSOR);
									//오라클 데이터형과 동일한 타입 생성
			cs.executeQuery();
			ResultSet rs=(ResultSet)cs.getObject(1);
			while(rs.next()) {
				StudentVO vo=new StudentVO();
				vo.setHakbun(rs.getInt(1));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return list;
	}
}
