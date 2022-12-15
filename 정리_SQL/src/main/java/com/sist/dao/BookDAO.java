package com.sist.dao;
import java.util.*; //ArrayList 사용 위함
import java.sql.*;

public class BookDAO {
	private Connection conn; //DBMS 연결 객체
	private PreparedStatement ps; //데이터 송수신 객체
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE"; //오라클 저장 주소(DB)
	//드라이버 등록 
	public BookDAO() { //한번만 수행하는 작업이므로 생성자 처리
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			/* Class.forName("클래스명") : 클래스명의 jbdc 드라이버 로딩(등록)
				- 클래스 정보 읽어서 제어할 때 주로 사용
				- new 대신 메모리 할당에 사용 = 리플렉션
					-> new : 결합성 높은 프로그램
					-> 리플렉션 : 결합성 낮은 프로그램
			 */
		} catch(Exception ex) {}
	}
	//오라클 연결
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		} catch(Exception ex) {} //ClassNotFoundException
	}
	//오라클 해제
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch(Exception ex) {} //SQLException
	}
	public ArrayList<BookVO> book3_1(){
		ArrayList<BookVO> list=new ArrayList<BookVO>();
		try {
			getConnection();
			//SQL 문장 작성
			String sql="SELECT bookname,price "
					+ "FROM book";
			//SQL 문장 전송
			ps=conn.prepareStatement(sql);
			//결과값 읽기
			ResultSet rs=ps.executeQuery();
				/* 결과값 있는 경우 SELECT : executeQuery()
				   결과값 없는 경우 INSERT, UPDATE, DELETE : executeUpdate() -> 커밋 포함
				- ResultSet 구조
				 	컬럼1 컬럼2 컬럼3
				 	-------------
				 	row1	| next(): 첫번째 줄로 이동 후 데이터 읽기
				 	row2
				 	row3	| previous(): 마지막줄로 이동 후 데이터 읽기
				 	-------------
				 	| : 데이터 저장 직후 커서 위치 -> 이동시켜야 데이터 읽기 가능
				 */
			while(rs.next()) { //커서위치 이동 후 데이터 읽기 시작
				BookVO vo=new BookVO();
				vo.setBookname(rs.getString(1));
				vo.setPrice(rs.getInt(2));
				list.add(vo);
			}
			rs.close(); //메모리 닫기
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return list;
	}
	public ArrayList<BookVO> book3_2(){
		ArrayList<BookVO> list=new ArrayList<BookVO>();
		try {
			getConnection();
			String sql="SELECT bookid,bookname,publisher,price "
					+ "FROM book";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BookVO vo=new BookVO();
				vo.setBookid(rs.getInt(1));
				vo.setBookname(rs.getString(2));
				vo.setPublisher(rs.getString(3));
				vo.setPrice(rs.getInt(4));
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
	public ArrayList<String> book3_3(){
					//컬럼 1개 정보만 가져옴 -> 데이터가 1개이므로 VO로 가져올 필요 없음
		ArrayList<String> list=new ArrayList<String>();
		try {
			getConnection();
			String sql="SELECT DISTINCT publisher "
					+ "FROM book";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
				list.add(rs.getString(1));
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return list;
	}
	public ArrayList<CustomerVO> book3_21(){
		ArrayList<CustomerVO> list=new ArrayList<CustomerVO>();
		try {
			getConnection();
			String sql="SELECT name,address,phone,bookid,saleprice,orderdate "
					+ "FROM customer,orders "
					+ "WHERE customer.custid=orders.custid "
					+ "ORDER BY customer.custid";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				CustomerVO vo=new CustomerVO();
				vo.setName(rs.getString(1));
				vo.setAddress(rs.getString(2));
				vo.setPhone(rs.getString(3));
				vo.getOvo().setBookid(rs.getInt(4));
				vo.getOvo().setSaleprice(rs.getInt(5));
				vo.getOvo().setOrderDate(rs.getDate(6));
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
