package com.sist.dao;
import java.util.*;
import java.sql.*;

public class FoodDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	private final String DRIVER="oracle.jdbc.driver.OracleDriver";
	private final String USER="hr";
	private final String PW="happy";
	public FoodDAO() {
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
	public ArrayList<FoodVO> foodListData(int page) {
		ArrayList<FoodVO> list=new ArrayList<FoodVO>();
		try {
			getConnection();
			String sql="SELECT fno,title,poster,score,num "
					+ "FROM (SELECT fno,name,poster,score,rownum as num "
					+ "FROM (SELECT /*+ INDEX_ASC(food_location pk_food_location)*/ fno,name,poster "
					+ "FROM food_location ORDER BY fno)) "
					+ "WHERE num BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			int rowSize=20;
			int start=rowSize*(page-1)+1;
			int end=rowSize*page;
			ps.setInt(1, start);
			ps.setInt(2, end);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				FoodVO vo=new FoodVO();
				vo.setFno(rs.getInt(1));
				vo.setName(rs.getString(2));
				String poster=rs.getString(3);
				poster=poster.substring(0,poster.indexOf("^"));
				vo.setPoster(poster);
				vo.setScore(rs.getInt(4));
				list.add(vo);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return list;
	}
}
