/*
1. DML : ROW ����
    - COMMIT �ʼ�
    cf. �ڹ� : AutoCommit -> executeUpdate()
              ��� 1���� SQL ���� ������ ���� ���� 
                  ex. �󼼺��� ���> Update(��ȸ�� ����), SELECT(������ �б�)
    1) INSERT : ������ �߰� 
        - ��� �÷��� ������ �߰�
            - INSERT INTO table_name VALUES(��..)
            - ���̺��� �÷� ������ �� ����, �������� �����ؾ� ��
        - ������ �÷����� ������ �߰�(�ʿ��� �����͸� ���)
            - INSERT INTO table_name(�÷�..) VALUES(��..)
            - ������ �÷� ������ �� ����, �������� �����ؾ� ��
            - DEFAULT �ִ� ��� �ַ� ���
        - �������ǿ� �´� ������ �߰�
            - INSERT ALL 
              WHEN ���� THEN
              INTO ���̺�� VALUES(��..) 
    2) UPDATE : ������ ����
        - UPDATE table_name SET
          �÷���=��..
          [WHERE ����]
        - �������� �ʼ��� �ƴϳ� ���� ����
    3) DELETE : ������ ����
        - DELETE FROM table_name
          [WHERE ����]
        - TRUNCATE�� ���� : ROLLBACK ����
*/
    --INSERT
--�����ͺ��� �����ؼ� ���̺� �����ϱ�
CREATE TABLE emp_10
AS
SELECT empno,ename,job,hiredate,sal FROM emp
WHERE 1=2;
CREATE TABLE emp_20
AS
SELECT empno,ename,job,hiredate,sal FROM emp
WHERE 1=2;
CREATE TABLE emp_30
AS
SELECT empno,ename,job,hiredate,sal FROM emp
WHERE 1=2;

INSERT ALL
WHEN deptno=10 THEN
INTO emp_10 VALUES(empno,ename,job,hiredate,sal)
WHEN deptno=20 THEN
INTO emp_20 VALUES(empno,ename,job,hiredate,sal)
WHEN deptno=30 THEN
INTO emp_30 VALUES(empno,ename,job,hiredate,sal)
SELECT * FROM emp;

CREATE TABLE emp_1980
AS
SELECT empno,ename,job,hiredate,sal FROM emp
WHERE 1=2;
CREATE TABLE emp_1981
AS
SELECT empno,ename,job,hiredate,sal FROM emp
WHERE 1=2;
CREATE TABLE emp_1982
AS
SELECT empno,ename,job,hiredate,sal FROM emp
WHERE 1=2;
CREATE TABLE emp_1983
AS
SELECT empno,ename,job,hiredate,sal FROM emp
WHERE 1=2;

INSERT ALL
WHEN TO_CHAR(hiredate,'YYYY')=1980 THEN
INTO emp_1980 VALUES(empno,ename,job,hiredate,sal)
WHEN TO_CHAR(hiredate,'YYYY')=1981 THEN
INTO emp_1981 VALUES(empno,ename,job,hiredate,sal)
WHEN TO_CHAR(hiredate,'YYYY')=1982 THEN
INTO emp_1982 VALUES(empno,ename,job,hiredate,sal)
WHEN TO_CHAR(hiredate,'YYYY')=1983 THEN
INTO emp_1983 VALUES(empno,ename,job,hiredate,sal)
SELECT * FROM emp;

SELECT * FROM emp_1983;
drop table emp_1983;

CREATE TABLE student (
    hakbun NUMBER,
    name VARCHAR2(34) CONSTRAINT std_name_nn NOT NULL,
    subject VARCHAR2(100),
    kor NUMBER(3),
    eng NUMBER(3),
    math NUMBER(3),
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT std_hak_pk PRIMARY KEY(hakbun)
);
INSERT INTO student VALUES(1,'ȫ�浿','',90,80,90,sysdate);
INSERT INTO student(hakbun,name,kor,eng,math) VALUES(2,'��û��',89,78,90);
SELECT hakbun,name,kor,eng,math,(kor+eng+math) total,ROUND((kor+eng+math)/3,2) avg
FROM student;
--������������_�ڵ�������ȣ
INSERT INTO student(hakbun,name,kor,eng,math) VALUES((SELECT MAX(hakbun)+1 FROM student),'�ڹ���',90,80,67);

ALTER TABLE student ADD COLUMN total NUMBER;
ALTER TABLE student ADD COLUMN avg NUMBER(8,2);
ALTER TABLE student DROP COLUMN subject;
ALTER TABLE student DROP COLUMN regdate;

CREATE TABLE emp_test 
AS
SELECT * FROM emp;
TRUNCATE TABLE emp_test;

INSERT INTO emp_test(empno,ename,job,mgr,hiredate,sal,comm,deptno)
SELECT * FROM emp;

SELECT * FROM emp_test;
DROP TABLE emp_test;

    --Update
CREATE TABLE emp_update 
AS
SELECT * FROM emp;

UPDATE emp_update SET
job='CLERK';
--Ŀ�� ���Ŀ��� �ѹ� ���� �Ұ�
ROLLBACK;

INSERT INTO emp_update VALUES((SELECT MAX(empno)+1 FROM emp_update),
'ȫ�浿','CLERK',7788,SYSDATE,2000,100,40);
INSERT INTO emp_update VALUES((SELECT MAX(empno)+1 FROM emp_update),
'��û��','MANAGER',7788,'21/10/10',3000,500,40);
INSERT INTO emp_update VALUES((SELECT MAX(empno)+1 FROM emp_update),
'�ڹ���','CLERK',7788,SYSDATE,2000,100,40);
COMMIT;

UPDATE emp_update SET
job='SALESMAN',mgr=7698,hiredate='20/01/05',sal=3500,comm=700,deptno=30
WHERE empno=7936;
--�������� ����
UPDATE emp_update SET
deptno=60
WHERE deptno=(SELECT deptno FROM emp_update WHERE empno=7937);

SELECT * FROM emp_update;

    --delete
DELETE FROM emp_dpdate
WHERE deptno=60;
--�������� ����
DELETE FROM emp_update
WHERE deptno=(SELECT MAX(deptno) FROM emp_update);

DROP TABLE emp_update;