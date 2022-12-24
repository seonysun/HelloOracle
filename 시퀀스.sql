/*
3. SEQUENCE : �ڵ� ������ȣ
    - �Խù� ��ȣ, ��� ��ȣ, ��ٱ��� ���� ��
    - ����/���� �� ���� �߻� ���� ����(�ߺ� ��ȣ ������ ����)
        -> �߰� ��ȣ ���� �� ��ȣ ���� ����, ������ ����
    cf. �ߺ� �Ұ��� ������ : ���̺��, �÷���, ���, ��������, �������Ǹ�
    1) Ű����
        - MAXVALUE : ������
        - MINVALUE : ���۰�
        - START WITH : ���� ��ġ ����
            ex. START WITH 100 -> 100���� ����
        - INCREMENT BY : ���� ���� ����
            ex. INCREMENT BY 1 -> 1�� ����
        - CACHE / NOCACHE
            - �ַ� NOCACHE ���
            - CACHE : �̸� ���� ���� ��ȣ ���� �� ����
                ex. 1~20 ���� �� 1���� ����
        - CYCLE / NOCYCLE
            - �ַ� NOCYCLE ���
            - CYCLE : ������ ������ ��� ���Ǿ��� ��� �ٽ� ó������ ����
        - ���簪 �б� : CURRVAL
          ������ �б� : NEXTVAL
    2) �����
        - ����
            CREATE SEQUENCE seq_name
            START WITH num
            INCREMENT BY num
            NOCACHE
            NOCYCLE
        - ���� : DROP SEQUENCE seq_name
        cf. ������ ����(�̸��ֱ�) : ���̺��_�÷���_seq;
        
cf. ������ ����ȭ
    - ����ȭ�� ������ : ���α׷����� �ʿ��� �����͸� ����
        ex. RDBMS(����Ŭ, MySQL)
    - ������ȭ�� ������ : ���ʿ��� ������ ����, ���еǾ�����
        ex. HTML, XML, JSON
    - ������ȭ�� ������ : ���ʿ��� ������ ����, ���� ����
        ex. Ʈ����, ���̽���
        
4. SYNONYM : ���̺��� ��Ī
    - ���� ����
    - ���� : CREATE SYNONYM ��Ī��
             FOR ���̺��
    - ���� : DROP SYNONYM ��Ī��
*/
CREATE SEQUENCE test_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
SELECT test_no_seq.NEXTVAL FROM DUAL;
SELECT test_no_seq.CURRVAL FROM DUAL;

DROP SEQUENCE test_no_seq;

CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT board_name_nn NOT NULL,
    subject VARCHAR2(4000) CONSTRAINT board_sub_nn NOT NULL,
    content CLOB CONSTRAINT board_cont_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT board_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    CONSTRAINT board_no_pk PRIMARY KEY(no)
);
CREATE SEQUENCE board_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.NEXTVAL,'ȫ�浿','������..','������ ��� ���..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.NEXTVAL,'ȫ�浿','������..','������ ��� ���..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.NEXTVAL,'ȫ�浿','������..','������ ��� ���..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.NEXTVAL,'ȫ�浿','������..','������ ��� ���..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.NEXTVAL,'ȫ�浿','������..','������ ��� ���..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.NEXTVAL,'ȫ�浿','������..','������ ��� ���..','1234');
COMMIT;
SELECT * FROM board;
DELETE FROM board WHERE no=3;

CREATE TABLE notice(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT notice_name_nn NOT NULL,
    msg CLOB CONSTRAINT notice_msg_nn NOT NULL,
    CONSTRAINT notice_no_pk PRIMARY KEY(no)
);
CREATE SEQUENCE notice_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
INSERT INTO notice VALUES(notice_no_seq.NEXTVAL,'ȫ�浿','��������');
INSERT INTO notice VALUES(notice_no_seq.NEXTVAL,'ȫ�浿','��������');
INSERT INTO notice VALUES(notice_no_seq.NEXTVAL,'ȫ�浿','��������');
INSERT INTO notice VALUES(notice_no_seq.NEXTVAL,'ȫ�浿','��������');
INSERT INTO notice VALUES(notice_no_seq.NEXTVAL,'ȫ�浿','��������');
COMMIT;
	--SYNONYM
SELECT * FROM notice;
CREATE SYNONYM �������
FOR emp;

SELECT * FROM �������;