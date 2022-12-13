package com.sist.dao;
import java.util.*;
import java.sql.*;

public class BoardDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	public BoardDAO() {
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
	//목록출력 SELECT ORDER BY
	public ArrayList<BoardVO> boardListData() {
		ArrayList<BoardVO> list=new ArrayList<BoardVO>();
		try {
			getConnection();
			String sql="SELECT no,subject,name,TO_CHAR(regdate,'YYYY/MM/DD'),hit "
					+ "FROM freeboard "
					+ "ORDER BY no DESC";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BoardVO vo=new BoardVO();
				vo.setNo(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setDbday(rs.getString(4));
				vo.setHit(rs.getInt(5));
				list.add(vo);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return list;
	}
	//게시물추가 INSERT
	public void boardInsert(BoardVO vo) {
		try {
			getConnection();
			String sql="INSERT INTO freeboard(no,name,subject,content,pwd) VALUES "
					+ "(SELECT NVL(MAX(no)+1,1) FROM freeboard),?,?,?,?)";
	    	ps=conn.prepareStatement(sql);
	    	ps.setString(1, vo.getName());
	    	ps.setString(2, vo.getSubject());
	    	ps.setString(3, vo.getContent());
	    	ps.setString(4, vo.getPwd());
    		ps.executeUpdate();
    	} catch(Exception ex) {
    		ex.printStackTrace();
	    } finally {
	    	disConnection();
	    }
	}
	//상세보기 SELECT WHERE
	public BoardVO boardDetailData(int no) {
		BoardVO vo=new BoardVO();
		try {
			getConnection();
			String sql="UPDATE freeboard SET "
					+ "hit=hit+1 "
					+ "WHERE no="+no;
			ps=conn.prepareStatement(sql);
			ps.executeUpdate();
			sql="SELECT no,name,subject,content,regdate,hit "
					+ "FROM freeboard "
					+ "WHERE no="+no;
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setNo(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setSubject(rs.getString(3));
			vo.setContent(rs.getString(4));
			vo.setRegdate(rs.getDate(5));
			vo.setHit(rs.getInt(6));
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
		return vo;
	}
	//-----------본인 여부 확인
	//수정 UPDATE
	//삭제 DELETE
	public void boardDelete(int no) {
		try {
			getConnection();
			String sql="DELETE FROM freeboard "
					+ "WHERE no="+no;
			ps=conn.prepareStatement(sql);
			ps.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			disConnection();
		}
	}
}
