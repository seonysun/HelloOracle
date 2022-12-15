package com.sist.dao;
import java.util.*;
import java.sql.*;

public class FoodDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	public FoodDAO() {
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
	//페이징(인라인뷰)
	public ArrayList<FoodVO> foodListData(int page) {
		ArrayList<FoodVO> list=new ArrayList<FoodVO>();
		try {
			getConnection();
			String sql="SELECT fno,name,poster,num "
					+ "FROM (SELECT fno,name,poster,rownum as num "
					+ "FROM (SELECT fno,name,poster "
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
				list.add(vo);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		
		/* 자바로 페이지 나누기
		//페이지 나누기는 주로 오라클에서 인라인뷰로 수행 (자바는 while문이 데이터 갯수만큼 돌아가므로 효율적이지 못함)
		try {
			getConnection();
			String sql="SELECT fno,name,poster "
					+ "FROM food_location "
					+ "ORDER BY fno";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			
			int i=0; //20개씩 나눠주는 변수
			int j=0; //while 반복 횟수
			final int rowSize=20;
			int pagecnt=(page*rowSize)-rowSize; //각 페이지 시작점
			
			while(rs.next()) {
				if(i<rowSize && j>=pagecnt) {
					FoodVO vo=new FoodVO();
					vo.setFno(rs.getInt(1));
					vo.setName(rs.getString(2));
					String poster=rs.getString(3);
					poster=poster.substring(0,poster.indexOf("^"));
					vo.setPoster(poster);
					list.add(vo);
					i++;
				}
				j++;
			}
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		*/
		
		return list;
	}
	public int foodTotalPage() {
		int total=0;
		try {
			getConnection();
			String sql="SELECT CEIL(COUNT(*)/20.0) FROM food_location";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return total;
	}
	//검색
	public ArrayList<FoodVO> foodFind(String name){
		ArrayList<FoodVO> list=new ArrayList<FoodVO>();
		try {
			getConnection();
			String sql="SELECT fno,name,poster "
					+ "FROM food_location "
					+ "WHERE name LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			ps.setString(1, name);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				FoodVO vo=new FoodVO();
				vo.setFno(rs.getInt(1));
				vo.setName(rs.getString(2));
				String poster=rs.getString(3);
				poster=poster.substring(0,poster.indexOf("^"));
				vo.setPoster(poster);
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
	//상세보기
	public FoodVO foodDetailData(int fno) {
		FoodVO vo=new FoodVO();
		try {
			getConnection();
			String sql="SELECT fno,name,tel,score,type,time,parking,menu,poster "
					+ "FROM food_location "
					+ "WHERE fno="+fno;
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setFno(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setTel(rs.getString(3));
			vo.setScore(rs.getDouble(4));
			vo.setType(rs.getString(5));
			vo.setTime(rs.getString(6));
			vo.setParking(rs.getString(7));
			vo.setMenu(rs.getString(8));
			vo.setPoster(rs.getString(9));
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return vo;
	}
	public static void main(String[] args) {
		FoodDAO dao=new FoodDAO();
		
		Scanner scan=new Scanner(System.in);
		int totalpage=dao.foodTotalPage();
		System.out.print("페이지 입력(1~"+totalpage+"):");
		int page=scan.nextInt();
		ArrayList<FoodVO> list=dao.foodListData(page);
		for(FoodVO vo:list) {
			System.out.println(vo.getFno()+" "+vo.getName());
		}
		
		System.out.print("가게명 입력:");
		String name=scan.next();
		ArrayList<FoodVO> list1=dao.foodFind(name);
		for(FoodVO vo:list1) {
			System.out.println(vo.getFno()+" "+vo.getName());
		}
	}
}
