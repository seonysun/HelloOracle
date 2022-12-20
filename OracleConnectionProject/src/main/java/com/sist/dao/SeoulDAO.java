package com.sist.dao;
import java.util.*;
import java.sql.*;

public class SeoulDAO {
	private Connection conn;
	private PreparedStatement ps;
	/* 오라클 주소, 유저명, 비밀번호, 드라이버명 -> final
	데이터 보안 위해서 직접 코딩하지 않고 xml, properties 파일에 저장(WEB-INF) 후 가져오는 방식 사용*/
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	private final String DRIVER="oracle.jdbc.driver.OracleDriver";
	private final String USER="hr";
	private final String PW="happy";
	public SeoulDAO() {
		try {
			Class.forName(DRIVER);
		} catch(Exception ex) {}
	}
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,USER,PW);
		} catch(Exception ex) {}
	}
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch(Exception ex) {}
	}
	public ArrayList<SeoulVO> seoulListData(int type) {
		String[] table_name= {"","seoul_location","seoul_nature","seoul_shop"};
		ArrayList<SeoulVO> list=new ArrayList<SeoulVO>();
		try {
			getConnection();
			String sql="SELECT no,title "
					+ "FROM "+table_name[type]
					+ " ORDER BY no";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				SeoulVO vo=new SeoulVO();
				vo.setNo(rs.getInt(1));
				vo.setTitle(rs.getString(2));
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
}
