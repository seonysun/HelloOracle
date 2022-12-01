import java.sql.*;
 
/*
 * 자바 프로그래밍 목적 -> 네트워크 / 데이터베이스 설계
 * 	- DB : 자바지원 라이브러리 JDBC(Java DataBase Connect) 
 * 		   외부 라이브러리 MyBatis, JPA
 * 	- SQL : 오라클의 명령어
 * 		DQL : SELECT(*) 데이터 검색
 * 				- SELECT *(전체 출력) | column(컬럼 일부 출력)
 * 				  FROM table_name[]
 * 		DML : 데이터 조작 언어
 * 			- INSERT 데이터 추가
 * 			- UPDATE 데이터 수정
 * 			- DELETE 데이터 삭제
 * 	   ----------------------------- 프로그래머 중심 -> 데이터 조작(CURD)
 * 		DDL : 데이터 정의 언어
 * 			- TABLE 데이터 저장 공간 생성
 * 				cf. bit < byte < word < row(문장) < table(파일) < 데이터베이스(폴더)
 * 					- table : 2차원 구조로 구분되어 있음
 * 						ex. id  pw  name -> 구분자, (오라클)column컬럼 (자바)멤버변수
 * 							────────────
 * 							aa 1234 홍길동 -> (오라클)record, row, tuple (자바)객체
 * 							bb 1234 박문수
 * 							cc 1234 심청이
							 	↓
 * 							   도메인
 * 				- View: 가상 테이블 생성(보안 목적), Sequence: 자동 증가 번호, Index: 검색 PL/SQL
 * 			- ALTER 데이터 저장 공간 수정
 * 			- DROP 데이터 저장 공간 삭제
 * 			- TRANCATE 잘라내기(테이블은 유지, 데이터만 잘라내기)
 * 			- RENAME 테이블명 변경
 * 		DCL : 제어 언어
 * 			- GRANT 권한 부여
 * 			- REVOKE 권한 해제
 *     ----------------------------- DBA 중심
 * 		TCL : 일괄 처리 언어
 * 			- COMMIT 정상적인 저장
 * 			- ROLLBACK 취소
 * */

public class 오라클연결 {

	public static void main(String[] args) {
		try {
			//드라이버(thin) 등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			//오라클 연결
			String url="jdbc:oracle:thin:@localhost:1521:XE";
			Connection conn=DriverManager.getConnection(url,"hr","happy");
			//SQL 문장 전송
			String sql="SELECT ename,job,hiredate FROM emp";
			PreparedStatement ps=conn.prepareStatement(sql);
			//실행 결과 저장
			ResultSet rs=ps.executeQuery();
			//실행 결과 호출
			while(rs.next()) {
				//커서 위치 데이터 맨 위로 이동 (맨 뒤: previous)
				System.out.println(rs.getString(1)+" "+rs.getString(2)+" "+rs.getDate(3).toString());
			}
		} catch(Exception e) {}

	}

}
