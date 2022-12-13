package com.sist.dao;
import java.util.*;
import java.sql.*;

public class LocationDAO {
	//데이터 연결(오라클 연결) 객체
	private Connection conn;
	//데이터 송수신(SQL 문장 전송) 객체
	private PreparedStatement ps; 
	//DBMS(오라클) 프로그램 연결
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE"; 
							//java database connection -> DBMS(ex.oracle)의 드라이버 연결하는 라이브러리
							//thin 드라이브 : 연결만 하는 드라이브
							//XE : 오라클 데이터베이스 폴더 이름
	//드라이버 등록 :드라이버가 소프트웨어 형식(클래스)으로 등록됨 -> 한번만 실행
	public LocationDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
											//대소문자 구분 주의
			//리플렉션 : 클래스의 모든 정보 읽어서 메모리 할당, 멤버변수/메소드 제어
		} catch(Exception ex) {}
	}
	//오라클 연결
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		} catch(Exception ex) {}
	}
	//오라클 닫기
	public void disConnection() {
		try {
			//통신 종료
			if(ps!=null) ps.close();
			//conn exit()
			if(conn!=null) conn.close();
		} catch(Exception ex) {}
	}
	//SQL 쿼리 문장(기능)
	public ArrayList<LocationVO> locationListData(){
		ArrayList<LocationVO> list=new ArrayList<LocationVO>();
		try {
			//오라클 연결
			getConnection();
			//SQL 문장 제작
			String sql="SELECT no,title,poster,msg "
					+ "FROM seoul_location "
					+ "WHERE no BETWEEN 1 AND 20";
			//SQL 문장 전송
			ps=conn.prepareStatement(sql);
			//결과값 수신
			ResultSet rs=ps.executeQuery();
							//Record 단위(row)로 수행 -> while문 한번 수행(rs.next())마다 한줄 읽기
							//row 여러개 정보 읽어올 때는 ArrayList<VO>+반복문, 한개 정보 읽어올 때는 그냥 저장
			//결과값 저장
			while(rs.next()) {
				LocationVO vo=new LocationVO();
				vo.setNo(rs.getInt("no"));
							/* 문자열 : getString()
 							   정수 : getInt()
							   실수 : getDouble()
  							   날짜 : getDate() */
				vo.setTitle(rs.getString("title"));
				vo.setPoster(rs.getString("poster"));
				vo.setMsg(rs.getString("msg"));
							//컬럼 수보다 적게 받아오는 것도 가능
				list.add(vo);
			}
			rs.close();
		} catch(Exception ex) {
			//오류 확인
			ex.printStackTrace();
		} finally {
			//오라클 닫기
			disConnection();
		}
		return list;
	}
	public ArrayList<ZipcodeVO> postfind(){
		ArrayList<ZipcodeVO> list=new ArrayList<ZipcodeVO>();
		try {
			getConnection();
			String sql="SELECT zipcode,sido,gugun,dong,NVL(bunji,' ') "
					+ "FROM zipcode "
					+ "WHERE dong LIKE '%서초%'";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				ZipcodeVO vo=new ZipcodeVO();
				vo.setZipcode(rs.getString(1));
				vo.setSido(rs.getString(2));
				vo.setGugun(rs.getString(3));
				vo.setDong(rs.getString(4));
				vo.setBunji(rs.getString(5));
				list.add(vo);
			}
			rs.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return list;
	}
}
