/*
1. 뷰 VIEW : 테이블의 일종(가상테이블)
    - 한 개 이상의 테이블을 통합해서 제작
        -> 참조 테이블 필수로 지님
        -> 테이블과 동일하게 사용 가능(함수, 연산자 사용 가능)
    1) 특징
        - 읽기전용 옵션 -> 보안 목적
            - WITH CHECK : DML 가능(DEFAULT)
              WITH READ ONLY(*) : DML 불가 -> 일반적으로 주로 사용
        - 데이터가 아닌 SQL 문장을 저장하는 형태
        - 가상의 테이블 -> INSERT, UPDATE, DELETE 수행 시 뷰가 아닌 기존 테이블에 적용
        - SQL 문장 간결화
            -> 많이 사용되는 SQL 문장을 VIEW 형태로 저장, 재사용
    2) 종류
        - 단순뷰 : 테이블을 한개만 참조
            - 사용 빈도 적음(너무 간단)
        - 복합뷰 : 테이블을 여러개 참조 -> JOIN, 서브쿼리 포함
            - 자바에서 주로 사용(SQL 문장 간결화 위함)
        - 인라인뷰(*) : 뷰 직접 생성하지 않고 SELECT 이용
    3) 생성방법
        - CREATE VIEW view_name
          AS
          SELECT
            -> SELECT 문장의 내용이 VIEW에 저장됨
        - 수정 가능(*) : CREATE OR REPLACE VIEW view_name
                        AS
                        SELECT
        - 삭제 : DROP VIEW view_name;
        cf. 사용자 계정은 권한이 없는 것이 많음
        	 -> 테이블 외 VIEW, SYNONYM, FUNCTION 등 생성 권한
             -> system 계정에서 권한 부여 생성 가능
                  SQLPLUS system/happy
                  GRANT CREATE view TO hr; --권한부여
                  REVOKE CREATE view TO hr; --권한해제
        cf. 오라클에 저장된 데이터 확인 : tab, user_tables, user_views, user_constraints
    - 뷰 내용 확인
    	SELECT text FROM user_views WHERE view_name='대문자';
        
2. 인라인뷰
    - rownum : 가상 컬럼, INSERT 순서대로 번호 자동 부여
    - 테이블명 대신 쿼리문 사용
      SELECT * | column
      FROM table_name | view_name | SELECT~
    - 인라인뷰에서 서브쿼리문 설정 시 지정된 컬럼명 범위보다 작으면 오류
    
cf. 요구사항분석
    - 회원가입
        로그인/로그아웃
        아이디 중복체크
        회원수정
        회원탈퇴
        아이디/비밀번호 찾기
    - 게시판(댓글)
    - 공지사항(어드민 계정)
    ------------------------- 기본, 페이징기법(*) -> 인라인뷰, 시퀀스제작
    - 예약, 결제, 추천, 멀티미디어 (1차 프로젝트)
    - 보안, 스케줄러, 데이터분석 (2차)
    - 신기술 (3차)
*/
CREATE VIEW emp_view
AS 
SELECT empno,ename,job,hiredate,sal,deptno
FROM emp;
--오라클 저장 데이터 확인
SELECT * FROM tab;
SELECT * FROM user_views;
SELECT * FROM user_constraints;

SELECT * FROM user_tables WHERE table_name='EMP';
SELECT text FROM user_views WHERE view_name='EMP_VIEW';

DROP VIEW emp_view;
--테이블 생성
CREATE TABLE myDept
AS
SELECT * FROM dept;
--VIEW 생성/읽기전용
CREATE VIEW dept_view
AS
SELECT * FROM myDept;
--DML
INSERT INTO dept_view VALUES(60,'개발부','서울');
SELECT * FROM dept_view;
SELECT * FROM myDept;

DROP VIEW dept_view;
--VIEW 생성/수정
--일반
CREATE OR REPLACE VIEW empDeptGrade_1
AS
SELECT e1.empno,e1.ename,e2.ename mgr,e1.job,e1.hiredate,e1.sal,e1.comm,dname,loc,grade
FROM emp e1,emp e2,dept,salgrade
WHERE e1.deptno=dept.deptno
AND e1.sal BETWEEN losal AND hisal
AND e1.mgr=e2.empno;
--조인
CREATE OR REPLACE VIEW empDeptGrade
AS
SELECT e1.empno,e1.ename,e2.ename mgr,e1.job,e1.hiredate,e1.sal,e1.comm,dname,loc,grade
FROM emp e1 JOIN dept
ON e1.deptno=dept.deptno
JOIN salgrade
ON e1.sal BETWEEN losal AND hisal
LEFT OUTER JOIN emp e2
ON e1.mgr=e2.empno;
--서브쿼리
CREATE OR REPLACE VIEW empDeptGrade_2
AS
SELECT empno,ename,hiredate,sal,comm,
(SELECT ename FROM emp e2 WHERE e1.mgr=e2.empno) manager,
(SELECT dname FROM dept WHERE deptno=e1.deptno) dname,
(SELECT loc FROM dept WHERE deptno=e1.deptno) loc,
(SELECT grade FROM salgrade WHERE e1.sal BETWEEN losal AND hisal) grade
FROM emp e1;

DROP VIEW empDeptGrade_2;

    --인라인뷰
SELECT empno,ename,job,hiredate,sal,comm
FROM (SELECT * FROM emp);

SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,dname,loc 
      FROM emp,dept
      WHERE emp.deptno=dept.deptno);
--서브쿼리 이용 시에는 별칭 필수
SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,
        (SELECT dname FROM dept WHERE deptno=emp.deptno) dname,
        (SELECT loc FROM dept WHERE deprno=emp.deptno) loc
        FROM emp);
    --rownum
SELECT empno,ename,job,hiredate,sal,rownum
FROM (SELECT empno,ename,job,hiredate,sal FROM emp ORDER BY sal DESC)
WHERE rownum<=5;
--페이징 -> 단순 1차 인라인뷰로는 rownum이 TOP-N 방식이므로 중간에 자르는 것 불가
SELECT ename,job,sal,num
FROM (SELECT ename,job,sal,rownum as num
        FROM (SELECT ename,job,sal
        FROM emp ORDER BY sal DESC))
WHERE num BETWEEN 11 AND 14;