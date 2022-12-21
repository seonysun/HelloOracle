//DAO : 오라클 연결 클래스
package com.sist.dao;
import java.util.*;
import java.sql.*;
/* 
 * - C/S => Server Socket -> 네트워크 프로그램(오라클 서버)
 * 		  	DAO(클라이언트) Socket, BufferedReader, OutputStream -> TCP 프로그램
 * 
 * 1. 오라클 연결 인터페이스
 * 	1) Connection : 데이터 연결 인터페이스
 * 	2) Statement : SQL 문장 송수신 인터페이스
 * 		- Statement : SQL 문장, 데이터값 동시에 전송
 * 		- PreparedStatement : SQL 문장 먼저 전송 후 데이터값 전송
 * 		- CallableStatement : PL/SQL에서 오라클 함수(프로시저) 호출할 때 사용
 * 	3) ResultSet : 결과값 메모리에 저장 인터페이스
 *  	-----------------------
 *          id   sex   name    ===> row단위로 읽어옴
 *      -----------------------
 *              BOF
 *      -----------------------
 *         aaa   man    hong | ===> next()
 *      -----------------------
 *         bbb   woman shim
 *      -----------------------
 *         ccc   man   park  | ===> previous()
 *      -----------------------
 *              EOF 
 *      -----------------------
 *      | 커서위치 (결과값 저장한 직후 커서 위치는 데이터 바깥 -> 데이터 안쪽으로 옮겨서 읽어야 함)
 */
public class EmpDAO {
	private Connection conn; //오라클 연결
	private PreparedStatement ps; //SQL 문장 전송
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE"; //오라클 주소 연결
	private static EmpDAO dao;
			//싱글턴패턴(메모리 한개만 생성) -> 재사용 -> 메모리 누수현상(사용하지 않는 메모리 존재) 방지
	//드라이버 등록
	public EmpDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch(Exception ex) {}
	}
	public static EmpDAO newInstance() { 
						//getInstance(), newInstance() -> 싱글턴
		if(dao==null)
			dao=new EmpDAO();
		return dao;
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
	//기능_데이터출력
	public ArrayList<EmpVO> empListData(){
		ArrayList<EmpVO> list=new ArrayList<EmpVO>();
		try {
			getConnection();
			//SQL 문장 제작
			String sql="SELECT empno,ename,job,mgr,hiredate,sal,comm,emp.deptno,dname,loc,grade "
					+"FROM emp,dept,salgrade "
					+"WHERE emp.deptno=dept.deptno "
					+"AND sal BETWEEN losal AND hisal";
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
				vo.setMgr(rs.getInt(4));
				vo.setHiredate(rs.getDate(5));
				vo.setSal(rs.getInt(6));
				vo.setComm(rs.getInt(7));
				vo.setDeptno(rs.getInt(8));
				vo.getDvo().setDname(rs.getString(9));
				vo.getDvo().setLoc(rs.getString(10));
				vo.getSvo().setGrade(rs.getInt(11));
				list.add(vo);
			}
			rs.close();
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
		} finally {
			disConnection();
		}
		return list;
	}
	//검색_LIKE
	public ArrayList<EmpVO> empFindData(String ename){
			//여러명 정보 받아옴
		ArrayList<EmpVO> list=new ArrayList<EmpVO>();
		try {
			getConnection();
			String sql="SELECT empno,ename,job,hiredate,sal "
					+ "FROM emp "
					+ "WHERE ename LIKE '%'||?||'%'";
										//오라클과 형태 다름 주의 : '%?%' -> 오류
			ps=conn.prepareStatement(sql);
			ps.setString(1, ename); //첫번째 ?에 ename을 입력
				//setString 처리 시 ename 입력값에 자동으로 '' 첨부
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				EmpVO vo=new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setHiredate(rs.getDate(4));
				vo.setSal(rs.getInt(5));
				list.add(vo);
			}
			rs.close();
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
		} finally {
			disConnection();
		}
		return list;
	}
	//SUBQuery
	public EmpVO empSubQueryData(String ename){
			//한명에 대한 정보만 받아옴
		EmpVO vo=new EmpVO();
		try {
			getConnection();
			String sql="SELECT empno,ename,job,hiredate,sal,"
					+ "(SELECT dname FROM dept WHERE deptno=emp.deptno) dname,"
					+ "(SELECT loc FROM dept WHERE deptno=emp.deptno) loc "
					+ "FROM emp "
					+ "WHERE ename=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, ename);
			ResultSet rs=ps.executeQuery();
			rs.next(); //커서 위치 이동 -> 맨 앞으로
				//1명에 대한 정보이므로 반복문 필요하지 않음
			vo.setEmpno(rs.getInt(1));
			vo.setEname(rs.getString(2));
			vo.setJob(rs.getString(3));
			vo.setHiredate(rs.getDate(4));
			vo.setSal(rs.getInt(5));
			vo.getDvo().setDname(rs.getString(6));
			vo.getDvo().setLoc(rs.getString(7));
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return vo;
	}
	//인라인뷰
	public ArrayList<EmpVO> empInlineView(int num) {
		ArrayList<EmpVO> list=new ArrayList<EmpVO>();
		try {
			getConnection();
			String sql="SELECT empno,ename,job,hiredate,sal,rownum "
					+ "FROM (SELECT * FROM emp ORDER BY sal DESC) "
					+ "WHERE rownum<=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, num);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				EmpVO vo=new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setHiredate(rs.getDate(4));
				vo.setSal(rs.getInt(5));
					//rownum은 받아오지 않아도 됨, 컬럼 수보다 적게 받아오는 것도 가능
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
