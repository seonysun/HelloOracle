/*
1. DML : ROW 단위
    - COMMIT 필수
    cf. 자바 : AutoCommit -> executeUpdate()
              기능 1개에 SQL 문장 여러개 수행 가능 
                  ex. 상세보기 기능> Update(조회수 증가), SELECT(데이터 읽기)
    1) INSERT : 데이터 추가 
        - INSERT ALL
        - 모든 컬럼에 데이터 추가
            - INSERT INTO table_name VALUES(값..)
            - 테이블의 컬럼 갯수와 값 갯수, 데이터형 동일해야 함
        - 지정된 컬럼에만 데이터 추가(필요한 데이터만 등록)
            - INSERT INTO table_name(컬럼..) VALUES(값..)
            - 지정한 컬럼 갯수와 값 갯수, 데이터형 동일해야 함
            - DEFAULT 있는 경우 주로 사용
        - 제약조건에 맞는 데이터 추가
    2) UPDATE : 데이터 수정
        - UPDATE table_name SET
          컬럼명=값..
          [WHERE 조건]
        - 조건절이 필수는 아니나 보통 사용됨
    3) DELETE : 데이터 삭제
        - DELETE FROM table_name
          [WHERE 조건]
        - TRUNCATE와 차이 : ROLLBACK 가능
*/
//    --INSERT
//--데이터별로 구분해서 테이블 생성하기
//CREATE TABLE emp_10
//AS
//SELECT empno,ename,job,hiredate,sal FROM emp
//WHERE 1=2;
//CREATE TABLE emp_20
//AS
//SELECT empno,ename,job,hiredate,sal FROM emp
//WHERE 1=2;
//CREATE TABLE emp_30
//AS
//SELECT empno,ename,job,hiredate,sal FROM emp
//WHERE 1=2;
//
//INSERT ALL
//WHEN deptno=10 THEN
//INTO emp_10 VALUES(empno,ename,job,hiredate,sal)
//WHEN deptno=20 THEN
//INTO emp_20 VALUES(empno,ename,job,hiredate,sal)
//WHEN deptno=30 THEN
//INTO emp_30 VALUES(empno,ename,job,hiredate,sal)
//SELECT * FROM emp;
//
//CREATE TABLE emp_1980
//AS
//SELECT empno,ename,job,hiredate,sal FROM emp
//WHERE 1=2;
//CREATE TABLE emp_1981
//AS
//SELECT empno,ename,job,hiredate,sal FROM emp
//WHERE 1=2;
//CREATE TABLE emp_1982
//AS
//SELECT empno,ename,job,hiredate,sal FROM emp
//WHERE 1=2;
//CREATE TABLE emp_1983
//AS
//SELECT empno,ename,job,hiredate,sal FROM emp
//WHERE 1=2;
//
//INSERT ALL
//WHEN TO_CHAR(hiredate,'YYYY')=1980 THEN
//INTO emp_1980 VALUES(empno,ename,job,hiredate,sal)
//WHEN TO_CHAR(hiredate,'YYYY')=1981 THEN
//INTO emp_1981 VALUES(empno,ename,job,hiredate,sal)
//WHEN TO_CHAR(hiredate,'YYYY')=1982 THEN
//INTO emp_1982 VALUES(empno,ename,job,hiredate,sal)
//WHEN TO_CHAR(hiredate,'YYYY')=1983 THEN
//INTO emp_1983 VALUES(empno,ename,job,hiredate,sal)
//SELECT * FROM emp;
//
//SELECT * FROM emp_1983;
//drop table emp_1983;
//
//CREATE TABLE student (
//    hakbun NUMBER,
//    name VARCHAR2(34) CONSTRAINT std_name_nn NOT NULL,
//    subject VARCHAR2(100),
//    kor NUMBER(3),
//    eng NUMBER(3),
//    math NUMBER(3),
//    regdate DATE DEFAULT SYSDATE,
//    CONSTRAINT std_hak_pk PRIMARY KEY(hakbun)
//);
//INSERT INTO student VALUES(1,'홍길동','',90,80,90,sysdate);
//INSERT INTO student(hakbun,name,kor,eng,math) VALUES(2,'심청이',89,78,90);
//SELECT hakbun,name,kor,eng,math,(kor+eng+math) total,ROUND((kor+eng+math)/3,2) avg
//FROM student;
//--서브쿼리가능_자동증가번호
//INSERT INTO student(hakbun,name,kor,eng,math) VALUES((SELECT MAX(hakbun)+1 FROM student),'박문수',90,80,67);
//
//ALTER TABLE student DROP COLUMN subject;
//ALTER TABLE student DROP COLUMN regdate;
//
//CREATE TABLE emp_test 
//AS
//SELECT * FROM emp;
//TRUNCATE TABLE emp_test;
//
//INSERT INTO emp_test(empno,ename,job,mgr,hiredate,sal,comm,deptno)
//SELECT * FROM emp;
//
//SELECT * FROM emp_test;
//DROP TABLE emp_test;
//
//    --Update
//CREATE TABLE emp_update 
//AS
//SELECT * FROM emp;
//
//UPDATE emp_update SET
//job='CLERK';
//--커밋 이후에는 롤백 적용 불가
//ROLLBACK;
//
//INSERT INTO emp_update VALUES((SELECT MAX(empno)+1 FROM emp_update),
//'홍길동','CLERK',7788,SYSDATE,2000,100,40);
//INSERT INTO emp_update VALUES((SELECT MAX(empno)+1 FROM emp_update),
//'심청이','MANAGER',7788,'21/10/10',3000,500,40);
//INSERT INTO emp_update VALUES((SELECT MAX(empno)+1 FROM emp_update),
//'박문수','CLERK',7788,SYSDATE,2000,100,40);
//COMMIT;
//
//UPDATE emp_update SET
//job='SALESMAN',mgr=7698,hiredate='20/01/05',sal=3500,comm=700,deptno=30
//WHERE empno=7936;
//--서브쿼리 가능
//UPDATE emp_update SET
//deptno=60
//WHERE deptno=(SELECT deptno FROM emp_update WHERE empno=7937);
//
//SELECT * FROM emp_update;
//
//    --delete
//DELETE FROM emp_dpdate
//WHERE deptno=60;
//--서브쿼리 가능
//DELETE FROM emp_update
//WHERE deptno=(SELECT MAX(deptno) FROM emp_update);
//
//DROP TABLE emp_update;