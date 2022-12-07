package com.sist.dao;
import java.util.*;
import java.sql.*;

public class EmpDAO {
	private Connection conn; //오라클 연결
	private PreparedStatement ps; //SQL 문장 전송
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE"; //오라클 주소 연결
							//java database connection -> 여러 업체(ex.oracle)의 드라이버 연결하는 라이브러리
							//thin 드라이브 : 연결만 하는 드라이브
							//XE : 오라클 데이터베이스 폴더 이름
	//드라이버 등록
	public EmpDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch(Exception ex) {}
	}
	//오라클 연결
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
		} catch(Exception ex) {}
	}
	//오라클 해제
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch(Exception ex) {}
	}
	//기능
	public ArrayList<EmpVO> empListData(){
		ArrayList<EmpVO> list=new ArrayList<EmpVO>();
		try {
			//오라클 연결
			getConnection();
			//SQL 문장 제작
			String sql="SELECT empno,ename,job,hiredate,deptno "
					+"FROM emp";
			//SQL 문장 전송
			ps=conn.prepareStatement(sql);
			//실행 결과 수신
			ResultSet rs=ps.executeQuery();
			//결과값 ArrayList에 저장
			while(rs.next()) {
				EmpVO vo=new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setHiredate(rs.getDate(4));
				vo.setDeptno(rs.getInt(5));
				list.add(vo);
			}
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			//오라클 해제
			disConnection();
		}
		return list;
	}
}
