/*
1. FUNCTION : 리턴형이 있는 함수
    - 사용자 정의 함수
    - 서브쿼리 대체 -> SELECT문에서 컬럼 대신 사용, WHERE문
    - ROW 단위(단일행 함수) -> 리턴값 1가지만 설정 가능
    - 형식
        CREATE [OR REPLACE] FUNCTION func_name(
            매개변수..
        ) RETURN 데이터형
        IS 지역변수..
        ------------------- 선언부
        BEGIN 
            구현부
            RETURN 지역변수;
        END;
        /

2. PROCEDURE : 리턴형이 없는 함수, 기능만 수행
    - 반복 기능 수행(재사용) 목적으로 주로 사용
        -> 일반 기능(INSERT, UPDATE, DELETE, SELECT)
            ex. 게시판, 댓글, 목록, 예매, 추천, 페이징
    - 포인터 사용 : IN, OUT -> 값 전송할 때 매개변수 이용(변수의 주소값 전송)
    - 형식 
        CREATE [OR REPLACE] PROCEDURE pro_name(
            매개변수..
        )
        IS 지역변수..
        ------------------- 선언부
        BEGIN 
            구현부
        END;
        /
*/
SELECT empno,ename,job,hiredate,sal,comm,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;

SELECT empno,ename,job,hiredate,sal,comm,
    (SELECT dname FROM dept WHERE deptno=emp.deptno) dname,
    (SELECT loc FROM dept WHERE deptno=emp.deptno) loc,
    (SELECT grade FROM salgrade WHERE emp.sal BETWEEN losal AND hisal) grade
FROM emp;
--function 생성
CREATE OR REPLACE FUNCTION getDname(
    vDeptno emp.deptno%TYPE
) RETURN VARCHAR2
IS vDname dept.dname%TYPE;
BEGIN
    SELECT dname INTO vDname
    FROM dept
    WHERE deptno=vDeptno;
    RETURN vDname;
END;
/
CREATE OR REPLACE FUNCTION getLoc(
    vDeptno emp.deptno%TYPE
) RETURN VARCHAR2
IS vLoc dept.loc%TYPE;
BEGIN
    SELECT loc INTO vLoc
    FROM dept
    WHERE deptno=vDeptno;
    RETURN vLoc;
END;
/
CREATE OR REPLACE FUNCTION getGrade(
    vSal emp.sal%TYPE
) RETURN NUMBER
IS vGrade salgrade.grade%TYPE;
BEGIN
    SELECT grade INTO vGrade
    FROM salgrade
    WHERE vSal BETWEEN losal AND hisal;
    RETURN vGrade;
END;
/
--사용
SELECT empno,ename,job,hiredate,sal,getDname(deptno) dname,getLoc(deptno) loc,getGrade(sal) Grade
FROM emp;

--
SELECT empno,ename,job,hiredate,sal
FROM emp
WHERE sal>(SELECT ROUND(AVG(sal)) FROM emp);

CREATE OR REPLACE FUNCTION getAvg
RETURN NUMBER
IS vAvg NUMBER;
BEGIN
    SELECT ROUND(AVG(sal)) INTO vAvg
    FROM emp;
    RETURN vAvg;
END;
/
SELECT empno,ename,job,hiredate,sal
FROM emp
WHERE sal>getAvg();

CREATE OR REPLACE FUNCTION getMax
Return NUMBER
IS vMax NUMBER;
BEGIN
    SELECT MAX(empno)+1 INTO vMax
    FROM emp;
    RETURN vMax;
END;
/
SELECT getMax() FROM DUAL;

DROP FUNCTION getDname();
DROP FUNCTION getLoc();
DROP FUNCTION getGrade();
DROP FUNCTION getAvg();
DROP FUNCTION getMax();

--
CREATE TABLE student(
    hakbun NUMBER,
    name VARCHAR2(34) CONSTRAINT std_name_nn NOT NULL,
    kor NUMBER(3),
    eng NUMBER(3),
    math NUMBER(3),
    CONSTRAINT std_hakbun_pk PRIMARY KEY(hakbun),
    CONSTRAINT std_kor_ck CHECK(kor>=0),
    CONSTRAINT std_eng_ck CHECK(eng>=0),
    CONSTRAINT std_math_ck CHECK(math>=0)
);
--INSERT
CREATE OR REPLACE PROCEDURE studentInsert(
    pName IN student.name%TYPE,
    pKor student.kor%TYPE,
    pEng student.eng%TYPE,
    pMath student.math%TYPE
)
IS pMax NUMBER:=0;
BEGIN
    SELECT NVL(MAX(hakbun)+1,1) INTO pMax
    FROM student;
    
    INSERT INTO student VALUES(pMax,pName,pKor,pEng,pMath);
    COMMIT;
END;
/
CALL studentInsert('홍길동',90,89,78);
CALL studentInsert('심청이',89,78,67);
SELECT * FROM student;
/*
INSERT
IN : INSERT,UPDATE,DELETE에서 값을 대입할 때 사용하는 변수 -> 일반변수 Call By Value
    -> 다른 메모리 주소 이용
OUT : SELECT에서 값을 매개변수를 이용해서 가지고 오는 변수 -> 참조변수 Call By Reference
    -> 같은 메모리 주소 이용
*/
--UPDATE
CREATE OR REPLACE PROCEDURE studentUpdate(
    pHakbun IN student.hakbun%TYPE,
    pName IN student.name%TYPE,
    pKor student.kor%TYPE,
    pEng student.eng%TYPE,
    pMath student.math%TYPE
)
IS
BEGIN
    UPDATE student SET
    name=pName,kor=pKor,eng=pEng,math=pMath
    WHERE hakbun=pHakbun;
    COMMIT;
END;
/
CALL studentUpdate(1,'홍길동',100,90,90);
SELECT * FROM student;
--DELETE
CREATE OR REPLACE PROCEDURE studentDelete(
    pHakbun IN student.hakbun%TYPE
)
IS
BEGIN
    DELETE FROM student
    WHERE hakbun=pHakbun;
    COMMIT;
END;
/
CALL studentDelete(1);
SELECT * FROM student;
--SELECT
CREATE OR REPLACE PROCEDURE studentDetailData(
    pHakbun IN student.hakbun%TYPE,
    pName OUT student.name%TYPE,
    pKor OUT student.kor%TYPE,
    pEng OUT student.eng%TYPE,
    pMath OUT student.math%TYPE,
    pTotal OUT NUMBER,
    pAvg OUT NUMBER
)
IS
BEGIN
    SELECT name,kor,eng,math,(kor+eng+math),ROUND((kor+eng+math)/3) 
    INTO pName,pKor,pEng,pMath,pTotal,pAvg
    FROM student
    WHERE hakbun=pHakbun;
DBMS_OUTPUT.PUT_LINE(pName);
DBMS_OUTPUT.PUT_LINE(pKor);
DBMS_OUTPUT.PUT_LINE(pEng);
DBMS_OUTPUT.PUT_LINE(pMath);
DBMS_OUTPUT.PUT_LINE(pTotal);
DBMS_OUTPUT.PUT_LINE(pAvg);
END;
/
VARIABLE pName VARCHAR2(34);
VARIABLE pKor NUMBER;
VARIABLE pEng NUMBER;
VARIABLE pMath NUMBER;
VARIABLE pTotal NUMBER;
VARIABLE pAvg NUMBER;

EXECUTE studentDetailData(2,:pName,:pKor,:pEng,:pMath,:pTotal,:pAvg);
PRINT pName;
PRINT pKor;
PRINT pEng;
PRINT pMath;
PRINT pTotal;
PRINT pAvg;

CREATE OR REPLACE PROCEDURE studentListData(
    pResult OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN pResult FOR
        SELECT * FROM student;
END;
/