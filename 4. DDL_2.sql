/*   
�Ǹ���ǥ;
    �÷���    ��ǥ��ȣ   �Ǹ�����   ����     �Ѿ�
    ��������     pk        nn       nn       ck     
                       default
    �������̺�
    �����÷�
    ��������  VARCHAR2    DATE   VARCHAR2  NUMBER
    ũ��        13                 34
    üũ                                    >0
*/
CREATE TABLE �Ǹ���ǥ(
    ��ǥ��ȣ VARCHAR2(13),
    �Ǹ����� DATE CONSTRAINT �Ǹ���ǥ_�Ǹ�����_nn NOT NULL,
    ���� VARCHAR2(34) CONSTRAINT �Ǹ���ǥ_����_nn NOT NULL,
    �Ѿ� NUMBER,
    CONSTRAINT �Ǹ���ǥ_��ǥ��ȣ_pk PRIMARY KEY(��ǥ��ȣ),
    CONSTRAINT �Ǹ���ǥ_�Ѿ�_ck CHECK(�Ѿ�>0)
);
ALTER TABLE �Ǹ���ǥ MODIFY �Ǹ����� DEFAULT SYSDATE;
/*
��ǰ;
    �÷���    ��ǰ��ȣ    ��ǰ��    ��ǰ�ܰ�
    ��������     pk       nn        ck   
    �������̺�
    �����÷�
    ��������  VARCHAR2  VARCHAR2  NUMBER
    ũ��        13       100
    üũ                           >0
*/
CREATE TABLE ��ǰ(
    ��ǰ��ȣ VARCHAR2(13),
    ��ǰ�� VARCHAR2(100) CONSTRAINT ��ǰ_��ǰ��_nn NOT NULL,
    ��ǰ�ܰ� NUMBER,
    CONSTRAINT ��ǰ_��ǰ��ȣ_pk PRIMARY KEY(��ǰ��ȣ),
    CONSTRAINT ��ǰ_��ǰ��ȣ_ck CHECK(��ǰ�ܰ�>0)
);
/*
��ǥ��;
    �÷���    ��ǥ��ȣ   ��ǰ��ȣ    ����     �ܰ�     �ݾ�
    ��������   pk/fk       fk       nn      nn       ck
    �������̺� �Ǹ���ǥ     ��ǰ
    �����÷�   ��ǥ��ȣ   ��ǰ��ȣ
    ��������  VARCHAR2  VARCHAR2  NUMBER   NUMBER  NUMBER
    ũ��        13         13
    üũ                                            >0
*/
CREATE TABLE ��ǥ��(
    ��ǥ��ȣ VARCHAR2(13),
    ��ǰ��ȣ VARCHAR2(13),
    ���� NUMBER CONSTRAINT ��ǥ��_����_nn NOT NULL,
    �ܰ� NUMBER CONSTRAINT ��ǥ��_�ܰ�_nn NOT NULL,
    �ݾ� NUMBER,
    CONSTRAINT ��ǥ��_��ǥ��ȣ_pk PRIMARY KEY(��ǥ��ȣ),
    CONSTRAINT ��ǥ��_�ݾ�_ck CHECK(�ݾ�>0),
    CONSTRAINT ��ǥ��_��ǥ��ȣ_fk FOREIGN KEY(��ǥ��ȣ)
    REFERENCES �Ǹ���ǥ(��ǥ��ȣ) ON DELETE CASCADE,
    CONSTRAINT ��ǥ��_��ǰ��ȣ_fk FOREIGN KEY(��ǰ��ȣ)
    REFERENCES ��ǰ(��ǰ��ȣ) ON DELETE CASCADE
);

-- ���̺� �������� Ȯ��
SELECT * FROM user_constraints
WHERE table_name='�Ǹ���ǥ';
/*
- CONSTRAINT TYPE
    C : CHECK, NOT NULL
    P : PRIMARY KEY
    R : FOREIGN KEY
    U : UNIQUE
*/

DROP TABLE ��ǥ��;
    -- FOREIGN KEY�� ���� ���̺� ���� �����ؾ� ��(���� ������ �ݴ�)
    -- ON DELETE CASCADE �ָ� ���� �� ���� X -> ���� ���� ��� ����
DROP TABLE �Ǹ���ǥ;
DROP TABLE ��ǰ;

CREATE TABLE �Ǹ���ǥ(
    ��ǥ��ȣ VARCHAR2(13),
    �Ǹ����� DATE,
    ���� VARCHAR2(34),
    �Ѿ� NUMBER
);
ALTER TABLE �Ǹ���ǥ ADD CONSTRAINT �Ǹ���ǥ_��ǥ��ȣ_pk PRIMARY KEY(��ǥ��ȣ);
ALTER TABLE �Ǹ���ǥ MODIFY �Ǹ����� DATE CONSTRAINT �Ǹ���ǥ_�Ǹ�����_nn NOT NULL;
ALTER TABLE �Ǹ���ǥ MODIFY ���� DATE CONSTRAINT �Ǹ���ǥ_����_nn NOT NULL;
ALTER TABLE �Ǹ���ǥ ADD CONSTRAINT �Ǹ���ǥ_�Ѿ�_ck CHECK(�Ѿ�>0);

CREATE TABLE ��ǰ(
    ��ǰ��ȣ VARCHAR2(13),
    ��ǰ�� VARCHAR2(100),
    ��ǰ�ܰ� NUMBER
);
ALTER TABLE ��ǰ ADD CONSTRAINT ��ǰ_��ǰ��ȣ_PK PRIMARY KEY(��ǰ��ȣ);
ALTER TABLE ��ǰ ADD CONSTRAINT ��ǰ_��ǰ��_uk UNIQUE(��ǰ��);
ALTER TABLE ��ǰ ADD CONSTRAINT ��ǰ_��ǰ�ܰ�_ck CHECK(��ǰ�ܰ�>0);

CREATE TABLE ��ǥ��(
    ��ǥ��ȣ VARCHAR2(13),
    ��ǰ��ȣ VARCHAR2(13),
    ���� NUMBER,
    �ܰ� NUMBER,
    �ݾ� NUMBER
);
ALTER TABLE ��ǥ�� ADD CONSTRAINT ��ǥ��_��ǥ��ȣ_PK PRIMARY KEY(��ǥ��ȣ);
ALTER TABLE ��ǥ�� ADD CONSTRAINT ��ǥ��_��ǥ��ȣ_FK FOREIGN KEY(��ǥ��ȣ)
REFERENCES �Ǹ���ǥ(��ǥ��ȣ);
ALTER TABLE ��ǥ�� ADD CONSTRAINT ��ǥ��_��ǰ��ȣ_FK FOREIGN KEY(��ǰ��ȣ)
REFERENCES ��ǰ(��ǰ��ȣ);
ALTER TABLE ��ǥ�� MODIFY ���� CONSTRAINT ��ǥ��_����_nn NOT NULL;
ALTER TABLE ��ǥ�� MODIFY �ܰ� CONSTRAINT ��ǥ��_�ܰ�_nn NOT NULL;
ALTER TABLE ��ǥ�� ADD CONSTRAINT ��ǥ��_�ݾ�_ck CHECK(�ݾ�>0);

CREATE TABLE student(
    hakbun NUMBER,
    name VARCHAR2(34) CONSTRAINT std_name_nn NOT NULL,
    CONSTRAINT std_hakbun_pk PRIMARY KEY(hakbun)
);
ALTER TABLE student ADD kor NUMBER DEFAULT 0;
ALTER TABLE student ADD eng NUMBER DEFAULT 0;
ALTER TABLE student ADD math NUMBER DEFAULT 0;
ALTER TABLE student MODIFY math CONSTRAINT stu_math_nn NOT NULL;
ALTER TABLE student ADD avg NUMBER NOT NULL;
ALTER TABLE student MODIFY avg NUMBER(5,2);
DESC STUDENT;