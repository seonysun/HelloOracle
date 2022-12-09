import java.sql.*;
 
/*
 * 0. 자바 프로그래밍 목적 -> 네트워크 / 데이터베이스 설계
 * 	- DB : 자바지원 라이브러리 JDBC(Java DataBase Connect) 
 * 		   외부 라이브러리 MyBatis, JPA
 * 
 * 	1) 데이터베이스 관리 언어 : SQL -> 오라클의 명령어
 * 		- DQL 
 * 		- DML : 데이터 조작 언어
 * 			- SELECT(*) 데이터 검색
 * 				- 저장된 데이터 중에 필요한 데이터를 얻어올 결루
 * 				- SELECT *(전체 출력) | column(컬럼 일부 출력)
 * 				  FROM table_name[]
 * 			- INSERT 데이터 추가
 * 				- 프로그램에 필요한 데이터를 저장
 * 			- UPDATE 데이터 수정
 * 			- DELETE 데이터 삭제
 * 			- MERGE 데이터 병합
 * 	   ----------------------------------------- 프로그래머 중심 -> 데이터 조작(CURD)
 * 		- DDL : 데이터 정의 언어
 * 			- 저장공간, 가상저장공간, 인덱스, 자동 증가번호, 함수 등의 생성
 * 			- 데이터 저장 공간
 * 				- bit < byte < word < row(문장) < table(파일) < 데이터베이스(폴더)
 * 				- TABLE : 파일 한 개에 대한 정보 보유
 * 						  2차원 구조로 구분되어 있음
 * 					ex. id  pw  name -> 구분자, (오라클)column컬럼 (자바)멤버변수
 * 						────────────
 * 						aa 1234 홍길동 -> (오라클)record, row, tuple (자바)객체
 * 						bb 1234 박문수
 * 						cc 1234 심청이
 *						 	↓
 * 						   도메인
 * 			- CREATE 데이터 저장 공간 생성
 * 			- ALTER 데이터 저장 공간 수정
 * 			- DROP 데이터 저장 공간 삭제
 * 			- TRUNCATE 잘라내기(테이블은 유지, 데이터만 잘라내기)
 * 			- RENAME 테이블명, 컬럼명 수정
 * 			- View: 가상 테이블 생성(보안 목적), Sequence: 자동 증가 번호, Index: 검색 PL/SQL
 * 		- DCL : 데이터 제어 언어
 * 			- GRANT 권한 부여
 * 			- REVOKE 권한 해제
 *     ----------------------------------------- DBA 중심
 * 		- TCL : 일괄 처리(트랜젝션) 언어
 * 			- COMMIT 정상적인 저장
 * 			- ROLLBACK 비정상 취소
 * 
 * 	2) 데이터베이스 모델
 * 		- 릴레이션(테이블) 
 * 			- 구성요소 : 컬럼, 실제값
 * 같은 데이터베이스 내에서 테이블명은 1개만 존재
 * 컬럼명은 순서 없음
 * 튜플 순서 없음
 * 
 * 	- 설계
 * 추출
 * 학생)
 * 학번, 학과, 이름 성별, 성적 -> 개념적 설계
 * 학번(숫자), 학과(문자열), 이름(문자열), 성별(문자열), 성적(숫자) - 논리적 설계
 * 학번 NUMBER(8), 학과 VARCHAR2(20) -> 물리적 설계
 * 
 * 관계대수
 * 합집합, 교집합, 차집합 등의 일반 연산
 * 순수 관계 연산 -> 셀렉션, 프로젝션, 조인, 디비전
 * 셀렉션 : 테이블에서 조건에 맞는 튜플을 갖고옴(조건 검색) -> WHERE(행중심)
 * 프로젝션 : 원하는 컬럼만 골라서 데이터를 가지오 옴(열중심)
 * 개명 : 이름을 변경 -> 별칭
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
