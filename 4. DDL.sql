/*
1. �����̼�(���̺�) : ���õ� ������ ��Ƶ� ��
    - 2���� ������ ���� -> �÷�(��) + row(��)
    - Ư¡
        - �÷��� ���ϰ� ����, ������ ����, ���� ����, �ߺ� �Ұ�
            cf. ������ : �÷��� ���� �� �ִ� ������ ���� ex. 1���� ū ���� ����
        - ������(����) ���� ����, �ߺ� �Ұ�
    - ����ȭ : �������� ���̺��� ����ȭ�Ͽ� ���� -> �ߺ� �ּ�ȭ
    1) ���̺��(�ĺ���)
        - ���� �����ͺ��̽����� ���̺� �̸� �ߺ� �Ұ�
        - ���ڷ� ����, Ű���� ��� �Ұ�, ����/Ư������(_) ����
            cf. �ü������ �ѱ� �д� ��� �ٸ�
        - ���� ����Ŭ�� ����� �� �빮�ڷ� ����(*) -> ���̺� ���� ���� �� �빮�� �ʼ�
            ex. WHERE table_name='EMP'
    2) ��������
        - �̻� ����(������ �ʴ� �����Ͱ� ����, �����Ǵ� ���) ����
            -> �ŷڵ� ������(���Ἲ) ������ ����
        - �ʿ信 ���� ���� �� ��� ����
        - ���� : �÷��� CONSTRAINT �������Ǹ� ��������
        - ����
            (1) NOT NULL : NULL �Ұ�
                - �ʼ� �Է� ������
            (2) Ű : ���̺��� row �ĺ��� �� ����ϴ� �Ӽ�
                - UNIQUE : ���ϰ�, �ĺ�Ű(��üŰ)
                    - row �ĺ� �����ϰ� �ϴ� Ű 
                    ex. email, tel
                    - �ߺ� ���� ������, NULL ���
                - PRIMARY KEY : �⺻Ű
                    - ���� �ĺ�Ű �� ��ǥ 
                    ex. ID
                    - NOT NULL + UNIQUE 
                        -> �ߺ� ���� ������, NULL �Ұ�
                        -> ��κ� ���ڷ� ����, �ڵ� �����ǵ��� ����
                    - ��� ���̺��� �� �� �̻� ����(���Ἲ�� ��Ģ)
                        cf. ���Ἲ : �������� �ϰ���, ��Ȯ�� �����ϴ� ��
                    - �������� ������ �����ϳ� �������� ����(���� �����)
                - FOREIGN KEY : ����Ű, �ܷ�Ű
                    - �ٸ� ���̺��� �⺻Ű(������ ����)�� ����
                    - �ڱ� �ڽ��� �⺻Ű ������ ����
                    - �ߺ� ���, NULL ���
                    ex. �Խñ��� ���, ��ȭ�� ����
            (3) CHECK : ������ �����Ͱ��� �Է� ����(������ �� ���� 1)
                    ex. �μ���, �ٹ���, ����
            (4) DEFAULT : �̸� �⺻�� ���� �� �����Ͱ��� ���� ��� �ڵ����� �� �Է�
                    - ��Ȯ�ϰԴ� ���������� �ƴ� -> CONSTRAINT ������� ����
    3) ���迬�� : ���̺� �� ����

2. CREATE : ���̺��� ���� ����
    - CREATE TABLE table_name : ����
    - CREATE VIEW view_name : ���� ���̺�(�б� ����)
    - CREATE INDEX index_name : ORDER BY -> �ӵ� ����ȭ
    - CREATE SEQUENCE seq_name : �ڵ� ������ȣ
    - CREATE FUNCTION func_name : �������� �ִ� �Լ�(�����Լ�)
    - CREATE PROCEDURE proc_name : �������� ���� �Լ�(��� ���� �Լ�) PL/SQL(*)
    - CREATE TRIGGER trig_name : �̺�Ʈ(�ڵ�ȭ ó��)
    - AUTO COMMIT 
        -> COMMIT ���̺� ������ ���ʿ�, �����Ͱ� �� ���� �ʿ�
    1) ���� ���̺� ����
        - CREATE TABLE table_name
          AS
          SELECT �÷��� FROM ���̺��
    2) ���̺� ����(�÷�)�� ����
        - CREATE TABLE table_name
          AS
          SELECT �÷��� FROM ���̺��
          WHERE 1=2;(false ����)
    3) ����� ����
        - CREATE TABLE table_name
            �÷��� �������� [��������], ..
                            //�÷�����(�÷��� ���ÿ� ����)
            [��������(�÷���)]
              //���̺���(���̺� ���� �� ����)
        - ���� NOT NULL, DEFAULT�� �÷������� ����, ������ ���̺����� ����
        - �������� �̸� �ߺ� �Ұ�(�ٸ� ���̺� ������ �ߺ� �Ұ�)
            -> '���̺��_�÷���_�������Ǿ���'�� ǥ��
            -> �������� ���� : nn, pk, uk, fk, ck
            cf. �������� �̸��� �����ؾ� ���� ����, ���� �� ���� �����ϹǷ� �ַ� ���
        ex. CREATE TABLE member(
                id VARCHAR2(20) PRIMARY KEY,
                pwd VARCHAR2(10) NOT NULL,
                name VARCHAR2(34) NOT NULL,
                sex CHAR(10) CHECK(sex IN('����','����')),
                email VARCHAR2(100) UNIQUE,
                tel VARCHAR2(13) UNIQUE,
                regdate DATE DEFAULT SYSDATE
            );
        ex. CREATE TABLE member(
                id VARCHAR2(20),
                pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL
                name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
                sex CHAR(10),
                email VARCHAR2(100),
                tel VARCHAR2(13),
                regdate DATE DEFAULT SYSDATE,
                CONSTRAINT member_id_pk PRIMARY KEY(id),
                CONSTRAINT member_sex_ck CHECK(IN('����','����')),
                CONSTRAINT member_et_uk UNIQUE(email,tel)
            );     

3. ALTER : �÷� ����, ����, �߰�, �������� ����
    - ������ ���̺��� �������� ���� �� �̹� ����� CREATE�� ������ �� ���� 
        -> DROP �� ����� / ALTER ���
    - ALTER TABLE ���̺�� ADD|MODIFY|RENAME COLUMN|DROP COLUMN �÷���
        - �÷� �߰� ADD
        - �÷� ���� DROP COLUMN
        - �÷� ���� MODIFY, RENAME COLUMN
    - �÷� �������� ����
        - �����Ͱ� �ִ� ��� NOT NULL ���� �������� ������ �÷� �߰� �Ұ�
          (�̹� �����ϴ� row�� ������ �����Ƿ� NULL -> ����)
            -> ������ ���� �� ���̺� �ݵ�� Ȯ��
            -> default�� �������� NOT NULL ���� ����
        - �������� �߰�
            ADD : PRIMARY KEY, UNIQUE, FOREIGN KEY, CHECK
            MODIFY : NOT NULL, DEFAULT
        - �������� ����
            DROP �÷��� CONSTRAINT

4. DROP : ���̺� ���� ����
5. TRUNCATE : ���̺� ����(�÷�)�� ����, ������ �߶󳻱�
*/
    --���̺� ��ü����
CREATE TABLE myEmp
AS
SELECT * FROM emp;

SELECT * FROM myEmp;
DESC myEmp;
--���̺� ��ü����
DROP TABLE myEmp;
    --���̺� ���¸� ����
CREATE TABLE myEmp2
AS
SELECT * FROM emp
WHERE 1=2;

SELECT * FROM myEmp2;
DROP TABLE myEmp2;
    --���� ���� ����
CREATE TABLE myEmp
AS
SELECT Emp.*,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;

SELECT * FROM myEmp;
DESC myEmp;
--�����͸� ����
--DELETE�� DML�̹Ƿ� ���� ����, TRUNCATE,DROP�� DDL�̹Ƿ� ���� �Ұ�
TRUNCATE TABLE myEMP;
--���̺�� ����
RENAME myEmp TO myEmp2;
DROP TABLE myEmp2;
/*
�Խ���;
    �Խù� ��ȣ : PK(�ߺ� ���� -> �ڵ� ����), NUMBER
    �̸� : NOT NULL, VARCHAR2
    ���� : NOT NULL, VARCHAR2
    ���� : NOT NULL, CLOB
    ��й�ȣ : NOT NULL
    ����� : DEFAULT(SYSDATE)
    ��ȸ�� : DAFAULE(0)
    -------------------------------------------------------------------
    �÷���     no    name    subject  content    pwd     regdate    hit
    ��������   pk     nn        nn       nn       nn     default  default
    �������̺�
    �����÷�
    �������� NUMBER VARCHAR2 VARCHAR2   CLOB   VARCHAR2   DATE     NUMBER
    ũ��       8     34       4000                10
    üũ
*/
DROP TABLE board;
CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT board_name_nn NOT NULL,
    subject VARCHAR2(4)CONSTRAINT board_subject_nn NOT NULL,
    content CLOB CONSTRAINT board_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT board_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    address VARCHAR2(100),
    CONSTRAINT board_no_pk PRIMARY KEY(no)
    );
ALTER TABLE board ADD hit NUMBER DEFAULT 0;
ALTER TABLE board MODIFY subject VARCHAR2(4000);
ALTER TABLE board MODIFY address VARCHAR2(100) CONSTRAINT board_address_nn NOT NULL;
ALTER TABLE board RENAME COLUMN address TO email;
ALTER TABLE board DROP COLUMN email;
DESC board;
/*
ȸ������;
    id pk
    pwd nn
    sex check
    name nn
    address 
    tel
*/
SELECT * FROM tab;
CREATE TABLE member(
    id VARCHAR2(20),
    pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL,
    sex VARCHAR2(6),
    name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
    CONSTRAINT member_id_pk PRIMARY KEY(id),
    CONSTRAINT member_sex_ck CHECK(sex IN('����','����'))
);
INSERT INTO member VALUES('bbb',' ','����','ȫ�浿');
    -- NOT NULL���� ������ ����
SELECT * FROM member;
ALTER TABLE member ADD address VARCHAR2(100) DEFAULT ' ' CONSTRAINT member_address_nn NOT NULL;
    -- �����Ͱ� �̹� �ִ� �����̹Ƿ� NOT NULL�� �÷� �߰� �Ұ� -> default ó���ϸ� ����
--���̺� ���� �� �������� �߰�
DROP TABLE board;
CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(34),
    subject VARCHAR2(4000),
    content CLOB,
    pwd VARCHAR2(10),
    regdate DATE,
    address VARCHAR2(100)
    );
DESC board;
ALTER TABLE board ADD CONSTRAINT board_no_pk PRIMARY KEY(no);
ALTER TABLE board MODIFY name CONSTRAINT board_name_nn NOT NULL;
ALTER TABLE board DROP CONSTRAINT board_name_nn;
ALTER TABLE board MODIFY regdate DATE DEFAULT SYSDATE;
--primary key
DROP TABLE member;
CREATE TABLE member(
    id VARCHAR2(20),
    name VARCHAR2(30),
    email VARCHAR2(100),
    pwd VARCHAR2(10)
);
INSERT INTO member VALUES('aaa','hong','','1234');
SELECT * FROM member;
DELETE FROM member WHERE id='aaa';

CREATE TABLE member(
    id VARCHAR2(20),
    pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL,
    email VARCHAR2(100),
    name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
    CONSTRAINT member_ie_pk PRIMARY KEY(id,email)
);
INSERT INTO member VALUES('aaa','hong','hong@co.kr','1234');
INSERT INTO member VALUES('aaa','shim','shim@co.kr','1234');
    --�⺻Ű 2�� ���� ��� �� �� �ϳ��� �޶� �Է� ���� -> ���� �����
INSERT INTO member VALUES('bbb','park','park@co.kr','1234');
INSERT INTO member VALUES('ccc','kim','kim@co.kr','1234');
SELECT * FROM member;