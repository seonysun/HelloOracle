/*
1. JOIN : 두 개 이상의 테이블에서 속성값 서로 같은 데이터 함께 추출 -> 새로운 테이블 생성
    - 정규화(테이블 나눠서 저장) -> 테이블끼리 연결해서 데이터 가지고 와야 함
    - SELECT에서만 사용 가능
    - INNER JOIN
        - 교집합 있을 때만 처리 가능
            -> 반드시 공통 속성(동일 도메인)이 있어야 함
        - NULL 처리 불가
        1) EQUI JOIN(동등조인) : = 연산자 사용
            - 테이블명.컬럼명
                -> 컬럼명 다른 경우 테이블명 생략 가능(자동 인식)
                -> 컬럼명 같은 경우 테이블명이나 별칭명으로 구분 필요
            - ORACLE JOIN(오라클)
                - SELECT A.column,B.column
                  FROM A,B
                  WHERE A.column=B.column
                - SELECT a.column,b.column
                  FROM A a,B b
                  WHERE a.column=b.column
            - ANSI JOIN(안시) : 표준화된 조인
                                -> 다른 DB에서 사용(MySQL, MariaDB)
                - , -> JOIN / WHERE -> ON
                - SELECT A.column,B.column
                  FROM A JOIN B
                  ON A.column=B.column
                - SELECT a.column,b.column
                  FROM A a JOIN B b
                  ON a.column=b.column
        2) NON EQUI JOIN(비등가조인) : = 이외 다른 연산자(비교, 논리) 사용
            - 범위 포함 여부 판단시 주로 사용
            - 오라클 조인
                SELECT A.column,B.column
                FROM A,B
                WHERE A.column BETWEEN B.column AND B.column
            - 안시 조인
                SELECT A.column,B.column
                FROM A JOIN B
                ON A.column BETWEEN B.column AND B.column
        3) NATURAL JOIN : EQUI JOIN에서 중복 속성 제거 후 반환
            ex. emp와 dept 조인 시 deptno 중복으로 2번 반환하지 않고 1번만 반환
            - 컬럼명이 같은 것이 있을 때 자동으로 조인 처리 해줌
            - 조건절 불필요
        4) USING
            - 컬럼명 같을 때 JOIN의 조건에서 ON 대신 USING 사용 가능
            - SELECT A.column,B.column
              FROM A JOIN B
              USING(column)
        5) SELF JOIN : 하나의 테이블 내에서 조인
            - 컬럼명이 달라도 같은 값을 가지고 있을 때 조인 처리 가능
            - 테이블 1개 -> 별칭으로 구분
            - 컬럼명 다르므로 NATURAL JOIN/JOIN USING은 사용 불가
    - OUTER JOIN -> INNER JOIN 보완, 많이 나오지는 않음
        - 교집합 없는 경우 NULL 반환
        1) LEFT OUTER JOIN
            - 오라클 조인
                SELECT A.column,B.column
                FROM A,B
                WHERE A.column=B.column(+)
            - 안시 조인
                SELECT A.column,B.column
                FROM A LEFT OUTER JOIN B
                ON A.column=B.column
        2) RIGHT OUTER JOIN
            - 오라클 조인
                SELECT A.column,B.column
                FROM A,B
                WHERE A.column(+)=B.column
            - 안시 조인
                SELECT A.column,B.column
                FROM A RIGHT OUTER JOIN B
                ON A.column=B.column
        3) FULL OUTER JOIN
            - 오라클 조인 없음
            - 안시 조인
                - SELECT A.column,B.column
                  FROM A FULL OUTER JOIN B
                  ON A.column=B.column
*/
//--INNER
//SELECT empno,ename,job,hiredate,sal,dname,loc,emp.deptno
//FROM emp,dept
//WHERE emp.deptno=dept.deptno;
//--ANSI
//SELECT empno,ename,job,hiredate,sal,dname,loc,emp.deptno
//FROM emp JOIN dept
//ON emp.deptno=dept.deptno;
//--NATURAL
//SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
//FROM emp NATURAL JOIN dept;
//--JOIN USING
//SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
//FROM emp JOIN dept 
//USING(deptno);
//--SELF
//SELECT e1.ename "본인", e2.ename "사수"
//FROM emp e1,emp e2
//WHERE e1.mgr=e2.empno;
//    --3개 조인
//--INNER
//SELECT empno,ename,job,hiredate,sal,dname,loc,grade
//FROM emp,dept,salgrade
//WHERE emp.deptno=dept.deptno
//AND sal BETWEEN losal AND hisal;
//--ANSI
//SELECT empno,ename,job,hiredate,sal,dname,loc,grade
//FROM emp JOIN dept
//ON emp.deptno=dept.deptno
//JOIN salgrade
//ON sal BETWEEN losal AND hisal;
//--NATURAL
//SELECT empno,ename,job,hiredate,sal,dname,loc,grade
//FROM emp NATURAL JOIN dept
//JOIN salgrade
//ON sal BETWEEN losal AND hisal;
//--JOIN USING
//SELECT empno,ename,job,hiredate,sal,dname,loc,grade
//FROM emp JOIN dept 
//USING(deptno)
//JOIN salgrade
//ON sal BETWEEN losal AND hisal;
//--
//SELECT empno,ename,job,hiredate,sal,dname,loc
//FROM emp,dept
//WHERE emp.deptno=dept.deptno
//AND ename='SCOTT';
//
//SELECT ename,sal,grade
//FROM emp,salgrade
//WHERE sal BETWEEN losal AND hisal;
public class DQL_SELECT_JOIN {

}
