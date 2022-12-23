/*  
2. SubQuery; 부속질의
    - SQL 문장 여러개 연결해서 한번에 처리할 목적으로 제작
        -> SQL 문장 1개로 묶는 경우와 여러개인 경우 데이터 크기가 커질수록 속도 차이가 커짐
        ex. SQL문장 여러개 -> 오라클 열기
                            평균값 구하기
                            오라클 닫기
                            오라클 열기
                            평균 대입 결과값 얻기
                            오라클 닫기
            SQL 문장 1개 -> 오라클 열기
                           평균값 구해서 대입 결과값 얻기
                           오라클 닫기
    - SELECT 문장을 값/컬럼/테이블 대신 사용 : 페이징기법(**)
    - 괄호로 묶어서 제작
        -> SUBQuery 먼저 실행, 결과값 MainQuery에 전송하여 처리
    - DML 전체, DDL에서 사용 가능
        -> SELECT,INSERT,UPDATE,DELETE 모두 가능
    - 다른 테이블 간에서도 묶어서 사용 가능    
    cf. 조인 VS 서브쿼리
        - 조인 : 여러개의 테이블에서 필요한 데이터 추출 목적
                -> 데이터를 모두 모아서 연산하기 위함
        - 서브쿼리 : 여러개의 SQL 문장 통합해서 한번에 실행 목적
                    -> 필요한 데이터만 찾아서 공급해서 처리 속도 빠르게 하기 위함
        - JOIN은 FOR문 형식 -> 데이터 많아지면 속도 저하 -> 서브쿼리 권장
    1) WHERE 뒤
        - 단일행 서브쿼리 : 컬럼 1개, 결과값 1개
        - 다중행 서브쿼리 : 컬럼 1개, 결과값 여러개
            -> 조건에 따라 결과값이 여러개인 경우 처리가 불가능할 수 있음 -> 하나 선택 처리
                ex. 비교연산자 뒤에 오는 경우
            - 결과값 전체 대입 : IN
            - 최솟값, 최댓값 찾기 : ANY, SOME, ALL
                ex. column< ANY(1,2,3) : 최댓값(3) 대입 = SOME
                    column> ANY(1,2,3) : 최솟값(1) 대입
                    column< ALL(1,2,3) : 최솟값(1) 대입
                    column> ALL(1,2,3) : 최댓값(3) 대입
                -> MAX, MIN을 주로 사용하므로 거의 사용하지 않음
        - 다중컬럼 서브쿼리 : 컬럼 여러개
        - 연관 서브쿼리
    2) SELECT 뒤
        - 스칼라 서브쿼리(*) : 컬럼 대신 사용, JOIN 대신 사용
            - 쿼리 한개당 반드시 컬럼 1개만 가지고 옴
            - 소스 코딩 길지만 검색 속도 빠름
    3) FROM 뒤
        - 인라인뷰(*) : 테이블 대신 사용
            - 가상의 테이블(뷰) 제작하여 기존 테이블 데이터 옮긴 후 정렬, 실행 -> 보안에 뛰어남
            - TOP-N : 항상 1번부터 가져옴, 중간 번호부터 가져오는 것은 불가
                - 원하는 주제의 순위 가져올 때 사용
                - 기존 테이블의 rownum은 고정 -> 가상 테이블 설정하여 rownum 변경 후 순서대로 자료 출력
            - 인라인뷰에서 가져온 컬럼(FROM 다음에 실행된 SELECT 문장의 컬럼)만 SELECT문에서 사용 가능
            - rownum(행 번호) -> ArrayList 처럼 행 수정 시 번호 자동 재부여
            
3. 데이터베이스
    - 소형 SQLite : 브라우저, 핸드폰 내장
    - 중형 (유료)Oracle (무료)MySQL, MariaDB
    - 대용량 사이베이스, DB2
*/
//    --GROUP BY
//SELECT job,COUNT(*),SUM(sal),ROUND(AVG(sal))
//FROM emp
//GROUP BY job
//HAVING AVG(sal)>(SELECT ROUND(AVG(sal)) FROM emp);
//--다중 그룹
//SELECT deptno,job,COUNT(*),MAX(sal),MIN(sal)
//FROM emp
//GROUP BY (deptno,job)
//ORDER BY deptno;
//    --서브쿼리
//SELECT empno,ename,job,hiredate,sal,
//    (SELECT dname FROM dept WHERE deptno=emp.deptno) dname,
//    (SELECT loc FROM dept WHERE deptno=emp.deptno) loc
//FROM emp
//WHERE ename='SCOTT';
//
//SELECT ename,job FROM emp; --다중컬럼
//SELECT deptno FROM emp WHERE ename='KING'; --단일행
//SELECT DISTINCT deptno FROM emp; --다중행
//
//--emp에서 평균 급여보다 적게 받는 사원 목록 출력
//    --SQL 문장 여러개로 출력(단일쿼리)
//--1. 평균 급여 구하기
//SELECT ROUND(AVG(sal)) FROM emp;
//--2. 평균 급여 대입하여 결과값 얻기
//SELECT * FROM emp
//WHERE sal<2073;
//    --SQL 문장 하나로 출력(서브쿼리)
//SELECT * FROM emp
//WHERE sal<(SELECT ROUND(AVG(sal)) FROM emp);
//
//--KING의 부서명, 근무지 출력
//    --단일쿼리
//--1. KING의 부서번호 얻기
//SELECT deptno FROM emp
//WHERE ename='KING';
//--2. 부서번호 대입하여 부서명, 근무지 얻기
//SELECT dname,loc FROM dept
//WHERE deptno=10;
//    --서브쿼리
//SELECT dname,loc FROM dept
//WHERE deptno=(SELECT deptno FROM emp
//WHERE ename='KING');
//
//--SCOTT와 같은 부서에 근무하는 사원 목록 출력
//    --단일쿼리
//--1. SCOTT의 부서번호 얻기
//SELECT deptno FROM emp
//WHERE ename='SCOTT';
//--2. 부서번호 대입하여 사원 목록 얻기
//SELECT * FROM emp
//WHERE deptno=20;
//    --서브쿼리
//SELECT * FROM emp
//WHERE deptno=(SELECT deptno FROM emp
//WHERE ename='SCOTT');
//
//--부서번호 10,20,30인 사원 출력
//    --다중행 서브쿼리
//SELECT * FROM emp
//WHERE deptno IN(SELECT DISTINCT deptno FROM emp);
//
//--급여가 가장 많은 사원과 같은 부서에 근무하는 사원 정보 출력
//    --단일쿼리
//--1. 급여 가장 많은 사원
//SELECT MAX(sal) FROM emp;
//SELECT ename FROM emp 
//WHERE sal=5000;
//--2. 해당 사원의 부서번호 확인
//SELECT deptno FROM emp 
//WHERE ename='KING';
//--3. 해당 부서 근무자 확인
//SELECT * FROM emp 
//WHERE deptno=10;
//    --서브쿼리
//SELECT * FROM emp 
//WHERE deptno=(
//SELECT deptno FROM emp WHERE ename=(
//SELECT ename FROM emp WHERE sal=(
//SELECT MAX(sal) FROM emp)));
//
//    --IN/ANY/ALL
//--IN
//SELECT * FROM emp
//WHERE deptno IN(SELECT DISTINCT deptno FROM emp);
//--ANY
//SELECT * FROM emp
//WHERE deptno <ANY(SELECT DISTINCT deptno FROM emp);
//
//SELECT * FROM emp
//WHERE deptno >ANY(SELECT DISTINCT deptno FROM emp);
//--SOME
//SELECT * FROM emp
//WHERE deptno <SOME(SELECT DISTINCT deptno FROM emp);
//
//SELECT * FROM emp
//WHERE deptno >SOME(SELECT DISTINCT deptno FROM emp);
//--MAX,MIN
//SELECT * FROM emp
//WHERE deptno < (SELECT MAX(deptno) FROM emp);
//
//SELECT * FROM emp
//WHERE deptno > (SELECT MIN(deptno) FROM emp);
//--ALL
//SELECT * FROM emp
//WHERE deptno <= ALL(SELECT DISTINCT deptno FROM emp);
//
//SELECT * FROM emp
//WHERE deptno >= ALL(SELECT DISTINCT deptno FROM emp);
//
//    --인라인뷰
//SELECT ename,sal,rownum
//FROM emp;
//
//SELECT ename,job,hiredate,sal,deptno 
//FROM (SELECT * FROM emp ORDER BY deptno);
//
//--급여 많은 사원 5명 출력
//SELECT ename,sal,rownum
//FROM (SELECT ename,sal FROM emp ORDER BY sal DESC)
//WHERE rownum<=5;
//
//SELECT title,hit,rownum
//FROM (SELECT title,hit FROM seoul_location ORDER BY hit desc)
//WHERE rownum<=5;
//
//SELECT fno,name
//FROM food_location
//ORDER BY fno;
//--rownum 한번만 쓰면 TOP-N 방식이므로 중간 추출 불가 -> 2번 사용해야 함
//SELECT fno,name,num
//FROM (SELECT fno,name,rownum as num 
//FROM (SELECT fno,name FROM food_location ORDER BY fno))
//WHERE num BETWEEN 21 AND 30;
public class DQL_SELECT_서브쿼리 {

}
 