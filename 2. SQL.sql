/*
1. �����ͺ��̽� ��� : SQL -> ����Ŭ�� ���ɾ�
    - ��� ����ڿ��� ������ ���� ����
    - �����ͺ��̽��� ����� ������ ����
    - �÷����� ����, �ʿ��� �����͸� ���� -> ���̺� ���� �� Ű ����, �������� ����
        cf. DESC ���̺��� : �÷���, �������� ���
    1) DML : ������ ���� ���
        - DQL 
            - SELECT(*) ������ �˻� 
                - ����� ��û ������ �˻� : ����� ������ �߿� �ʿ��� �����͸� ���� ���
                    -> ������, �󼼺���, �˻�, ��õ������ �б�, ���̺� ����(JOIN, SubQuery)
                - SELECT *(��ü ���) | column��(�÷� �Ϻ� ���)
                  FROM table_name[]
        - DML
            - INSERT ������ �߰�
                - ����� ��û ������ ����Ŭ�� �߰�
                    -> ȸ������, �۾���, ����ۼ�
            - UPDATE ������ ����
                - ����� ��û�� ���� ������ ����
                    -> ȸ����������, ��ٱ���
            - DELETE ������ ����
                - ����� ��û�� ���� ������ ����
                    -> ȸ��Ż��, �������, �������
            - MERGE ������ ����
    ----------------------------------------- ���α׷��� �߽� -> ������ ����(CURD)
    2) DDL : ������ ���� ���
        - �������, �����������, �ε���, �ڵ� ������ȣ, �Լ� ���� ����
        - ���� �Ұ����ϹǷ� ���� �� ����
        - ������ ���� ����
            - bit < byte < word < row(����) < table(����) < �����ͺ��̽�(����)
            - TABLE : ���� �� ���� ���� ���� ����
                      �����Ͱ� ����Ǿ��ִ� �ּ� ����
                      2���� ������ ���еǾ� ����
                ex. id  pw  name -> ������, (����Ŭ)column�÷� (�ڹ�)�������
                    ��������������
                    aa 1234 ȫ�浿 -> (����Ŭ)record, row, tuple (�ڹ�)��ü
                    bb 1234 �ڹ���
                    cc 1234 ��û��
                    	��
                      ������
            - View: ���� ���̺� ����(���� ����), Sequence: �ڵ� ���� ��ȣ, Index: �˻� PL/SQL
        - CREATE ������ ���� ���� ����
             -> CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE INDEX
             -> ��������, ��������, Ű ���� => �����ͺ��̽� �𵨸�(����ȭ)
        - ALTER ������ ���� ���� ����
            - ADD �÷� �߰�
            - MODIFY �÷� ����
            - DROP ������ ���� ����(���̺�, View) ����
            - TRUNCATE �߶󳻱�(���̺��� ����, �����͸� �߶󳻱�)
            - �ѱ� 3byte
        - RENAME ���̺���, �÷��� ����   
    3) DCL : ������ ���� ���
        - ���� ���̴� ���̺�, View �� ������ �Ұ�
            -> system sysdba �������� ����(����� ���� X)
        - GRANT ���� �ο�
        - REVOKE ���� ����
    ----------------------------------------- DBA �߽�
    4) TCL : �ϰ� ó��(Ʈ������) ���
        - COMMIT �������� ����
        - ROLLBACK ������ ��� : ������ ���� �� ���� ���
            -> COMMIT ���� �� ROLLBACK �Ұ��ϹǷ� ����

2. ����Ŭ SQL
    - ����� ��û -> �ڹ� --> ����Ŭ --> �ڹ� ----> ������
                        SQL       ���   ArrayList
    - ���ɹ� ����
        SELECT - FROM - [WHERE - GROUP BY - HAVING - ORDER BY]
    - ���ɹ��� ��ҹ��� �������� ����(�����Ͱ��� ��ҹ��� ����)
    - Ű����� �빮�� ���� ���
    - ���� ���� �� ;
    - ǥ���� : ����, �Ǽ� -> �״�� ǥ��
              ����, ��¥ -> ''
              �ο��ȣ -> "" (��Ī ÷��, �� ����)
        ex. WHERE hiredate='22/01/02';
    cf. �ڹٿ��� ����Ŭ�� SQL ����(String) ���� �� ������ ��
        - ����ó�� -> Ű���� �빮�ڷ� �ۼ�, ���� �߰� ���� ���
        - �񱳿����� (����Ŭ)= (�ڹ�)== (�ڹٽ�ũ��Ʈ)===
            -> ���ڿ�, ��¥�� ��� ����(equals ����)
        - ' ' -> ���� NULL�� ��µǾ� ã�� ����
        - &(scanner), ||(���ڿ�����)
        - ������ ������� ����Ŭ�� �ϴ� ���� ���� -> ������ �����Ͽ� �Ϻ� ��� ���� BETWEEN
            cf. �� ������ ���� ������ : ���̺� 20��, �̹��� 15��

3. ����Ŭ ��������
    - ������ ���� �� �Ѿ�� ���� �Ұ� -> ������ ũ�� Ȯ�� �ʼ�
    1) ������ : String
        - ' '
        - CHAR(1~2000byte) ������ -> ��� ���� �� ��, ����, ���� Ȯ��
        - VARCHAR2(1~4000byte) ������ -> ��κ�, ����
        - CLOB(4GB) ������ -> �ٰŸ�, �ڱ�Ұ�
    2) ������
        - NUMBER(4) : 4�ڸ� �������� ��� int
        - NUMBER(7,2) : 7�ڸ� �� 2�ڸ��� �Ҽ��� ���� double
            -> ����Ʈ�� (8,2)
    3) ��¥�� : Java.util.Date
        - ' '
        - DATE : �Ϲ� ��¥(����Ʈ)
        - TIMESTAMP : ��� ���
    4) ��Ÿ��(4GB) -> ������, �̹��� ����
        - BLOB(binary) : ����Ŭ ��ü ����
        - BFILE(file) : ������ ���� �� ���ϸ� �о ���
        - HTML : ��ũ�� �о ���

4. SELECT : ������ �˻�, ���� -> Query��
    - SELECT * | column 1, column 2.. -> ��ü ������(*), ��¿� �ʿ��� �����͸� ����
      FROM table_name
      [ �߰� ����(����)
          WHERE ���� -> if(������, �����Լ� �̿�)
          GROUP BY �÷���|�Լ� -> ���� ���� ������ �ִ� �÷� �׷� ex. �μ���, ������
          HAVING �׷��Լ� -> �׷쿡 ���� ����
                            �ܵ� ��� �Ұ�, GROUP BY �ʼ�
          ORDER BY �÷���|�Լ� ASC(��������)|DESC -> ����
      ]
    - �ߺ� ���� ������ ���� : DISTINCT

5. ORDER BY
    - ���� : ����Ŭ�� �Էµ� ������� ����� -> ���� �� ������ �������� ���� ����
    - �ӵ� ����, �������̸� ��� X, INDEX(*)�� ��ü
        -> �����Ͱ� ���� ��� ORDER BY ���, �������� ��� �ε���(**) ���
        cf. INDEX -> ����ȭ(**)
    - ASC(��������) ����, DESC(��������)
    - �÷���ȣ 1������ ����
         
emp; ��� ����
    8�� �÷����� ���� -> ����� 14��
    empno ��� ������
    ename �̸� ������
    job ���� ������
    mgr ������ ������
    hiredate �Ի��� ��¥��
    sal �޿� ������
    comm ������ ������
    deptno �μ���ȣ ������ -> dept�� ���� �� ����ϴ� �÷���
    => Ȯ�� -> DESC ���̺���;
dept; �μ� ����
*/
-- ���̺� �÷���, �������� Ȯ��
DESC emp;
-- ���̺��� �ִ� ��� ������ �˻�
SELECT * FROM emp;
-- ���̺��� �Ϻ� �÷� �˻�
SELECT empno,ename,job,hiredate FROM emp;
-- �÷��� ��Ī �߰�
/* �÷��� "��Ī"
   �÷��� as ��Ī */
SELECT empno "���", ename "�̸�", hiredate "�Ի���" FROM emp;
SELECT empno as ���, ename as �̸�, hiredate as �Ի��� FROM emp;
-- ���̺����� �ʹ� ��ų� JOIN �� �� ���̺��� ��Ī ���
SELECT empno as ���, ename as �̸�, hiredate as �Ի��� 
FROM emp e;
-- ���ڿ� ����
SELECT ename||'���� �Ի����� '||hiredate||'�Դϴ�' FROM emp;
-- �ߺ� ����
SELECT deptno FROM emp;
SELECT DISTINCT deptno FROM emp;
-- ����
SELECT empno,ename,sal FROM emp ORDER BY sal DESC;