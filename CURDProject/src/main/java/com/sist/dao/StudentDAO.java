package com.sist.dao;
import java.util.*;
import java.sql.*;

public class StudentDAO {
	private Connection conn;
	private PreparedStatement ps;
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
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch(Exception ex) {}
	}
	//기능
		//데이터추가
	public void studentInsert(StudentVO vo) {
		try {
			getConnection();
			String sql="INSERT INTO student VALUES("
					+ "(SELECT NVL(MAX(hakbun)+1,1) FROM student),?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setInt(2, vo.getKor());
			ps.setInt(3, vo.getEng());
			ps.setInt(4, vo.getMath());
			ps.executeUpdate();
				//INSERT, UPDATE, DELETE -> executeUpdate() : COMMIT 포함
			   	//SELECT -> executeQuery() : COMMIT 미포함(필요없음)
		} catch(Exception ex) {
			ex.printStackTrace();//오류 확인
		} finally {
			disConnection();
		}
	}
		//데이터읽기
	public ArrayList<StudentVO> studentListData(){
		ArrayList<StudentVO> list=new ArrayList<StudentVO>();
		try {
			getConnection();
			String sql="SELECT hakbun,name,kor,eng,math,(kor+eng+math) total,"
					+ "ROUND((kor+eng+math)/3,2) avg "
					+ "FROM student";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				StudentVO vo=new StudentVO();
				vo.setHakbun(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setKor(rs.getInt(3));
				vo.setEng(rs.getInt(4));
				vo.setMath(rs.getInt(5));
				vo.setTotal(rs.getInt(6));
				vo.setAvg(rs.getDouble(7));
				list.add(vo);
			}
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return list;
	}
		//데이터수정
		//데이터삭제
}
