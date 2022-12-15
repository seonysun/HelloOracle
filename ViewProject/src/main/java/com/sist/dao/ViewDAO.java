package com.sist.dao;
import java.util.*;
import java.sql.*;

public class ViewDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	public ViewDAO() {
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
	public void empListData() {
		try {
			getConnection();
			String sql="SELECT e1.empno,e1.ename,e2.ename as manager,e1.job,e1.hiredate,e1.sal,e1.comm,dname,loc,grade "
					+ "FROM emp e1 JOIN dept "
					+ "ON e1.deptno=dept.deptno "
					+ "JOIN salgrade "
					+ "ON e1.sal BETWEEN losal AND hisal "
					+ "LEFT OUTER JOIN emp e2 "
					+ "ON e1.mgr=e2.empno";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				System.out.println(
						rs.getInt(1)+" "
						+rs.getString(2)+" "
						+rs.getString(3)+" "
						+rs.getString(4)+" "
						+rs.getDate(5).toString()+" "
						+rs.getInt(6)+" "
						+rs.getInt(7)+" "
						+rs.getString(8)+" "
						+rs.getString(9)+" "
						+rs.getInt(10)						
						);
			}
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
	}
	public void empDetailData(int empno) {
		try {
			getConnection();
			String sql="SELECT e1.empno,e1.ename,e2.ename as manager,e1.job,e1.hiredate,e1.sal,e1.comm,dname,loc,grade "
					+ "FROM emp e1 JOIN dept "
					+ "ON e1.deptno=dept.deptno "
					+ "JOIN salgrade "
					+ "ON e1.sal BETWEEN losal AND hisal "
					+ "LEFT OUTER JOIN emp e2 "
					+ "ON e1.mgr=e2.empno "
					+ "WHERE e1.empno="+empno;
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			System.out.println(
					rs.getInt(1)+" "
					+rs.getString(2)+" "
					+rs.getString(3)+" "
					+rs.getString(4)+" "
					+rs.getDate(5).toString()+" "
					+rs.getInt(6)+" "
					+rs.getInt(7)+" "
					+rs.getString(8)+" "
					+rs.getString(9)+" "
					+rs.getInt(10)
					);
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
	}
	public void viewListData() {
		try {
			getConnection();
			String sql="SELECT * FROM empDeptGrade";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				System.out.println(
						rs.getInt(1)+" "
						+rs.getString(2)+" "
						+rs.getString(3)+" "
						+rs.getString(4)+" "
						+rs.getDate(5).toString()+" "
						+rs.getInt(6)+" "
						+rs.getInt(7)+" "
						+rs.getString(8)+" "
						+rs.getString(9)+" "
						+rs.getInt(10)						
						);
			}
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
	}
	public void viewDetailData(int empno) {
		try {
			getConnection();
			String sql="SELECT * FROM empDeptGrade "
					+ "WHERE empno="+empno;
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			System.out.println(
					rs.getInt(1)+" "
					+rs.getString(2)+" "
					+rs.getString(3)+" "
					+rs.getString(4)+" "
					+rs.getDate(5).toString()+" "
					+rs.getInt(6)+" "
					+rs.getInt(7)+" "
					+rs.getString(8)+" "
					+rs.getString(9)+" "
					+rs.getInt(10)
					);
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
	}
	public static void main(String[] args) {
		ViewDAO dao=new ViewDAO();
		dao.empListData();
		System.out.println("────────────────────────────────────────────────────────────────");
		dao.viewListData();
		System.out.println("────────────────────────────────────────────────────────────────");
		dao.empDetailData(7788);
		System.out.println("────────────────────────────────────────────────────────────────");
		dao.viewDetailData(7788);
	}
}
