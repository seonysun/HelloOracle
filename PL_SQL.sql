/*
1. PL/SQL : Procedure Language
    - 프로시저/함수/트리거 만드는 언어
        cf. FUNCTION : 리턴형을 가지는 함수(내장함수)
            PROCEDURE : 리턴형이 없는 함수, 기능만 수행
            TRIGGER : 자동 처리 
    1) 형식
        DECLARE
            선언부 --변수(지역변수, 매개변수) 선언
        BEGIN 
            구현부 --SQL(DML,DQL), 제어문
        END;
        /
    2) 변수
        - 스칼라변수 : 일반 변수, 데이터형 직접 설정
            - 변수명 데이터형
                ex. no NUMBER;
        - %TYPE : 실제 테이블 변수의 데이터형 가져옴
            - 테이블명.컬럼명%TYPE
                ex. emp.empno%TYPE;
        - %ROWTYPE : 실제 테이블 전체 변수의 모든 데이터형 가져옴(VO)
            - 테이블명%ROWTYPE
                ex. emp%ROWTYPE;
            - 테이블 1개만 사용 가능(보안에 뛰어남)
        - RECORD : 사용자 정의 데이터형 -> 테이블 여러개 묶어서 사용할 때(조인, 서브쿼리)
            - TYPE record_데이터타입명 IS RECORD(
                변수명 데이터형..
              );
              record_변수명 record_데이터타입명;
        - CURSOR : 전체 ROW에 대한 데이터 저장 가능한 변수 -> 자바의 ResultSet
            - CURSOR 커서명 IS
                SELECT~
            - SELECT 이하 내용 커서에 저장(뷰와 비슷한 기능)          
            - 사용 순서
                1. 커서 설정
                    CURSOR 커서명 IS
                    SELECT 
                    --select문 실행 결과값이 커서명에 저장
                2. 커서 열기
                    OPEN 커서명;
                3. 인출
                    - LOOP문 수행
                    - FETCH 커서명 IN 받는변수명
                    - 종료시점 설정
                        커서명%NOTFOUND
                        커서명%FOUND
                        커서명%COUNT
                4. 커서 닫기
                    CLOSE 커서명;
    3) 제어문
        (1) 조건문
            - 단일
                IF 조건문 THEN 실행문장 
                END IF;
            - 선택
                IF 조건문 THEN 실행문장 
                ELSE 실행문장
                END IF;
            - 다중
                IF 조건문 THEN 실행문장
                ELSIF 조건문 THEN 처리문장
                ELSE 처리문장
                END IF;
            - CASE 
                - 변수명2의 값2 조건에 따라 변수명1과 관련된 실행문장(값1 설정 등) 설정
                변수명1:=CASE 변수명2
                    WHEN 값2 THEN 실행문장(값1)
                    WHEN 값2 THEN 실행문장(값1)
                    WHEN 값2 THEN 실행문장(값1)
                    ELSE 값1 --default
                END;
        (2) 반복문
            - BASIC
                LOOP 
                    실행문장;
                    증가식;
                    EXIT WHEN 조건식;
                END LOOP;
            - WHILE 
                WHILE 조건식 LOOP
                    실행문장;
                    증가식;
                END LOOP;
            - FOR(*)
                FOR 변수 IN [REVERSE] 범위조건 LOOP 
                    실행문장;
                END LOOP;
                - 범위 설정 시 무조건 증가만 가능 ex. 1..100
                    -> 순서 거꾸로 실행하고 싶을 때 REVERSE 추가
*/
-- DBMS_OUTPUT.PUT_LINE(); -> System.out.println()
-- & -> Scanner
SET SERVEROUTPUT ON;
--스칼라변수
DECLARE
    pEmpno NUMBER(4):=10; --초기화 :=
    pEname VARCHAR2(34);
    pJob VARCHAR2(20);
    pHiredate DATE;
    pSal NUMBER(7,2);
BEGIN
    SELECT empno,ename,job,hiredate,sal 
    INTO pEmpno,pEname,pJob,pHiredate,pSal
    FROM emp
    WHERE empno=7788;
DBMS_OUTPUT.PUT_LINE('결과>');
DBMS_OUTPUT.PUT_LINE('사번:'||pEmpno);
DBMS_OUTPUT.PUT_LINE('이름:'||pEname);
DBMS_OUTPUT.PUT_LINE('직위:'||pJob);
DBMS_OUTPUT.PUT_LINE('입사일:'||pHiredate);
DBMS_OUTPUT.PUT_LINE('급여:'||pSal);
END;
/
--%TYPE
DECLARE
    vEmpno emp.empno%TYPE;
    vEname emp.ename%TYPE;
    vJob emp.job%TYPE;
    vDname dept.dname%TYPE;
    vLoc dept.loc%TYPE;
    vGrade salgrade.grade%TYPE;
BEGIN
    SELECT empno,ename,job,dname,loc,grade 
    INTO vEmpno,vEname,vJob,vDname,vLoc,vGrade
    FROM emp JOIN dept
    ON emp.deptno=dept.deptno
    JOIN salgrade
    ON sal BETWEEN losal AND hisal
    WHERE empno=7788;
DBMS_OUTPUT.PUT_LINE('결과>');
DBMS_OUTPUT.PUT_LINE('사번:'||vEmpno);
DBMS_OUTPUT.PUT_LINE('이름:'||vEname);
DBMS_OUTPUT.PUT_LINE('직위:'||vJob);
DBMS_OUTPUT.PUT_LINE('부서명:'||vDname);
DBMS_OUTPUT.PUT_LINE('근무지:'||vLoc);
DBMS_OUTPUT.PUT_LINE('호봉:'||vGrade);
END;
/
--%ROWTYPE
DECLARE
    vEmp emp%ROWTYPE;
BEGIN
    SELECT * INTO vEmp
    FROM emp
    WHERE empno=7788;
DBMS_OUTPUT.PUT_LINE('결과>');
DBMS_OUTPUT.PUT_LINE('사번:'||vEmp.empno);
DBMS_OUTPUT.PUT_LINE('이름:'||vEmp.ename);
DBMS_OUTPUT.PUT_LINE('직위:'||vEmp.job);
DBMS_OUTPUT.PUT_LINE('사수번호:'||vEmp.mgr);
DBMS_OUTPUT.PUT_LINE('입사일:'||vEmp.hiredate);
DBMS_OUTPUT.PUT_LINE('급여:'||vEmp.sal);
DBMS_OUTPUT.PUT_LINE('성과급:'||vEmp.comm);
DBMS_OUTPUT.PUT_LINE('부서번호:'||vEmp.deptno);
END;
/
--사용자 정의 데이터형
DECLARE
    TYPE empDept IS RECORD(
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        job emp.job%TYPE,
        hiredate emp.hiredate%TYPE,
        dname dept.dame%TYPE,
        loc dept.loc%TYPE
    );
    ed empDept;
BEGIN
    SELECT empno,ename,job,hiredate,dname,loc INTO ed
    FROM emp,dept
    WHERE emp.deptno=dept.deptno
    AND empno=7788;
DBMS_OUTPUT.PUT_LINE('결과>');
DBMS_OUTPUT.PUT_LINE('사번:'||ed.empno);
DBMS_OUTPUT.PUT_LINE('이름:'||ed.ename);
DBMS_OUTPUT.PUT_LINE('직위:'||ed.job);
DBMS_OUTPUT.PUT_LINE('입사일:'||ed.hiredate);
DBMS_OUTPUT.PUT_LINE('부서명:'||ed.dname);
DBMS_OUTPUT.PUT_LINE('근무지:'||ed.loc);
END;
/
--IF
DECLARE
    vEmpno NUMBER(4):=0;
    vEname VARCHAR2(34):=' ';
    vJob VARCHAR2(20):=' ';
    vDname VARCHAR2(20):=' ';
    vDeptno NUMBER(2):=0;
BEGIN
    SELECT empno,ename,job,deptno
    INTO vEmpno,vEname,vJob,vDeptno
    FROM emp
    WHERE empno=&empno;
    
    IF vDeptno=10 
        THEN vDname:='영업부';
    END IF;
    IF vDeptno=20 
        THEN vDname:='개발부';
    END IF;
    IF vDeptno=30
        THEN vDname:='자재부';
    END IF;
    IF vDeptno=40
        THEN vDname:='신입';
    END IF;
DBMS_OUTPUT.PUT_LINE('결과>');
DBMS_OUTPUT.PUT_LINE('사번:'||vEmpno);
DBMS_OUTPUT.PUT_LINE('이름:'||vEname);
DBMS_OUTPUT.PUT_LINE('직위:'||vJob);
DBMS_OUTPUT.PUT_LINE('부서명:'||vDname);
DBMS_OUTPUT.PUT_LINE('부서번호:'||vDeptno);
END;
/
--IF ELSE
DECLARE 
    vEname emp.ename%TYPE:=' ';
    vComm emp.comm%TYPE:=0;
    vSal emp.sal%TYPE:=0;
    vTotal NUMBER(7,2):=0;
BEGIN
    SELECT ename,comm,sal,sal+NVL(comm,0) 
    INTO vEname,vComm,vSal,vTotal
    FROM emp
    WHERE empno=&empno;
    
    IF vComm>0
        THEN DBMS_OUTPUT.PUT_LINE(vEname||'님의 급여는 '||vSal||', 성과급은 '||vComm||', 총 급여는 '||vTotal||'입니다.');
    ELSE DBMS_OUTPUT.PUT_LINE(vEname||'님의 급여는 '||vSal||', 성과급은 없으며, 총 급여는 '||vTotal||'입니다.');
    END IF;
END;
/
--ELSIF
DECLARE
    vEname emp.ename%TYPE;
    vDname dept.dname%TYPE;
    vDeptno emp.deptno%TYPE;
BEGIN
    SELECT ename,deptno
    INTO vEname,vDeptno
    FROM emp
    WHERE empno=7902;
    
    IF vDeptno=10
        THEN vDname:='영업부';
    ELSIF vDeptno=20
        THEN vDname:='기획부';
    ELSIF vDeptno=30
        THEN vDname:='개발부';
    ELSE vDname:='신입';
    END IF;
DBMS_OUTPUT.PUT_LINE('결과>');
DBMS_OUTPUT.PUT_LINE('이름:'||vEname);
DBMS_OUTPUT.PUT_LINE('부서명:'||vDname);
END;
/
--CASE
DECLARE
    vEname emp.ename%TYPE;
    vDname dept.dname%TYPE;
    vDeptno emp.deptno%TYPE;
BEGIN
    SELECT ename,deptno
    INTO vEname,vDeptno
    FROM emp
    WHERE empno=7902;
    
    vDname:=CASE vDeptno
        WHEN 10 THEN '영업부'
        WHEN 20 THEN '기획부'
        WHEN 30 THEN '개발부'
        ELSE '신입'
    END;
DBMS_OUTPUT.PUT_LINE('결과>');
DBMS_OUTPUT.PUT_LINE('이름:'||vEname);
DBMS_OUTPUT.PUT_LINE('부서명:'||vDname);
END;
/
--반복
DECLARE
    sno NUMBER:=1;
    eno NUMBER:=10;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(sno);
        sno:=sno+1;
        EXIT WHEN sno>eno;
    END LOOP;
END;
/
--do~while : 후조건(무조건 1개 이상의 문장 수행)
DECLARE
    no NUMBER:=1;
BEGIN
    WHILE no<=10 LOOP 
        DBMS_OUTPUT.PUT_LINE(no);
        no:=no+1;
    END LOOP;
END;
/
--for
DECLARE
BEGIN
    FOR i IN 1..10 LOOP 
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/
BEGIN --변수가 없으므로 declare 생략 가능
    FOR i IN REVERSE 1..10 LOOP --역순 출력 
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/
BEGIN
    FOR i IN 1..10 LOOP
        IF MOD(i,2)=0 THEN
            DBMS_OUTPUT.PUT_LINE(i);
        END IF;
    END LOOP;
END;
/
DECLARE
    total NUMBER:=0;
    even NUMBER:=0;
    odd NUMBER:=0;
BEGIN
    FOR i IN 1..100 LOOP
        total:=total+i;
        IF MOD(i,2)=0 THEN
            even:=even+i;
        END IF;
        IF MOD(i,2)<>0 THEN
            odd:=odd+i;
        END IF;
    END LOOP;
DBMS_OUTPUT.PUT_LINE('>결과');
DBMS_OUTPUT.PUT_LINE('1~100 총합:'||total);
DBMS_OUTPUT.PUT_LINE('1~100 짝수합:'||even);
DBMS_OUTPUT.PUT_LINE('1~100 홀수합:'||odd);
END;
/
DECLARE
    dan NUMBER:=&dan;
    result VARCHAR2(100):=' ';
BEGIN
    FOR i IN 1..9 LOOP
        result:=dan||'*'||i||'='||(dan*i);
        DBMS_OUTPUT.PUT_LINE(result);
    END LOOP;
END;
/
--커서 : 데이터 모아서 저장 -> 자바 매칭 클래스 ResultSet -> 여러명 동시 출력 가능(ArrayList)
DECLARE
    vemp emp%ROWTYPE;
    CURSOR cur IS
        SELECT * FROM emp;
BEGIN
    --커서 열기
    OPEN cur;
    --인출
    LOOP 
        FETCH cur INTO vemp;
        EXIT WHEN cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.job||' '||vemp.hiredate);
    END LOOP;
    --커서 닫기
    CLOSE cur;
END;
/
--커서 for문으로 배열(**)
DECLARE
    vemp emp%ROWTYPE;
    CURSOR cur IS 
        SELECT * FROM emp;
BEGIN
    FOR vemp IN cur LOOP
        DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.job||' '||vemp.hiredate);
    END LOOP;
END;
/
--커서 JOIN
DECLARE 
    TYPE empDept IS RECORD(
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        job emp.job%TYPE,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
    );
    ed empDept;
    CURSOR cur IS
        SELECT empno,ename,job,dname,loc
        FROM emp,dept
        WHERE emp.deptno=dept.deptno;
BEGIN
    FOR ed IN cur LOOP
        DBMS_OUTPUT.PUT_LINE(ed.empno||' '||ed.ename||' '||ed.job||' '||ed.dname||' '||ed.loc);
    END LOOP;
END;
/