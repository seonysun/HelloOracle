/*
1. ������
    - ��������� : �ַ� SELECT �ڿ� �ٿ��� ��� -> ���� �˻� �� ���
            +,-,*,/ 
            - ���ڿ� ����ó�� �� ����, ���ڿ� ���� �� ||
            - ����/����=�Ǽ�, 0���� ������ �Ұ�
            - �÷� ���� ���� ���(NULL) ���� ��� NULL
                ex. NULL + 1 = NULL
            - ���������̺� DUAL
            - ��������� ���� �ڵ����� ���ڷ� ��ȯ�� TO_NUMBER
            cf. ����Ŭ�� �÷�(������) �����δ� ��� ����, Tuple(row) �����δ� ��� �Ұ� 
                    -> row ���� ��� �� ��������ڷ� �ַ� ���
                ������ ��� -> CUBE, ROLLUP
    --------------------------------------------------
    WHERE, HAVING���� �ַ� ����ϴ� �߰� ����(TRUE/FALSE)
    --------------------------------------------------
    - �񱳿�����(*) : = (����) !=, <>, ^= (���� �ʴ�) <, >, <=, >= 
            cf. JavaScript : ===, !==
            - ��� true/false
            - ������, ��¥��, ������ ��� ��� ����
    - ��������(*) : AND, OR
            - AND : ���� -> ��� true�̸� true
                    BETWEEN ������ ��ü ����
            - OR : ���� -> �� �� �ϳ��� true�̸� true
                   IN ������ ��ü ����
            cf. & : �Է°� ���� �� Scanner
               || : ���ڿ� ����
    - ���Կ����� : = (WHERE, HAVING������ �񱳿�����, �� ���� ��ҿ����� ���Կ�����) -> :=
    - NOT ������ : NOT LIKE, NOT BETWEEN, NOT IN
    - NULL ������ : ���� �������� ���� -> ��� ���� ���� �Ұ�
            - IS NULL / IS NOT NULL
            - NVL() : NULL�� ��ü
    - IN ������ : OR�� �������� ��� ó���ϴ� ������
    - BETWEEN ~ AND(*) : �Ⱓ�̳� ���� ��Ÿ��
            ex. BETWEEN 1 AND 10 : 1�� X ��10
    - LIKE(*) : ���繮�ڿ� �˻�
            - % : ���ڿ� ������ �𸣴� ���
                ex. 'A%' : A�� �����ϴ� ��� ���ڿ�(startsWith)
                    '%A' : A�� ������ ��� ���ڿ�(endsWith)
                    '%A%' : A�� ���Ե� ��� ���ڿ�(contains)
            - _ : �ѱ���
                ex. __A__ : �� 5����, ��� ���� A
                    __A% : 3��° ���ڰ� A
            - REGEXP_LIKE : ���Խ� -> �ֱٿ��� ���� �ַ� ���
                ex. WHERE REGEXP_LIKE(name,'[A-E]')
*/
-- �������
SELECT 10+2,10-2,10*2,10/2
FROM DUAL;
-- 0���� ������ �Ұ�
SELECT 10+2,10-2,10*2,10/0
FROM DUAL;
-- Integer.parseInt(), trim() �ڵ� ����(�ڵ� ����ȯ)
SELECT ' 10'+2,10-2,10*2,10/2
FROM DUAL;
-- NULL�� ��ü ����
SELECT ename,sal+NVL(comm,0) "�����޿�"
FROM emp;
-- &��AND
SELECT * FROM emp
WHERE empno=&sabun;
-- ��� �������� ���
CREATE TABLE student(
name VARCHAR2(34),
kor NUMBER,
eng NUMBER,
math NUMBER
);
SELECT * FROM student;
INSERT INTO student VALUES('ȫ�浿',89,78,67);
INSERT INTO student VALUES('��û��',78,76,90);
INSERT INTO student VALUES('�ڹ���',90,90,78);
COMMIT;
SELECT name,kor,eng,math,kor+eng+math "total",(kor+eng+math)/3 "avg"
FROM student;
-- �� /�����ʴ�
SELECT ename,job,hiredate,sal
FROM emp
WHERE sal<>3000;

SELECT ename,job,hiredate,sal
FROM emp
WHERE sal!=3000;

SELECT ename,job,hiredate,sal
FROM emp
WHERE sal^=3000;
-- �� /ũ���
SELECT * FROM emp
WHERE hiredate>'81/12/31';

SELECT ename,job,sal FROM emp
WHERE ename>'KING'; 
--����� �����ʹ� ��ҹ��� ����
SELECT * FROM emp
WHERE ename='king';

SELECT * FROM emp
WHERE ename='KING';
-- AND
SELECT * FROM emp
WHERE hiredate>='81/01/01' AND hiredate<='81/12/31';
-- ��
SELECT * FROM emp
WHERE sal>=1500 AND SAL<=3000;

SELECT * FROM emp
WHERE sal=1500 OR sal=3000;

SELECT * FROM emp
WHERE deptno=30;
-- NULL
SELECT * FROM emp
WHERE comm IS NOT NULL AND comm<>0;

SELECT * FROM emp
WHERE comm IS NULL OR comm=0;
-- IN
SELECT * FROM emp
WHERE sal=5000 OR sal=2850 OR sal=3000;

SELECT * FROM emp
WHERE sal IN(5000,2850,3000);
-- NOT
SELECT * FROM emp WHERE comm IS NULL OR comm NOT BETWEEN 500 AND 1400;

SELECT * FROM emp
WHERE job NOT IN('MANAGER','CLERK','SALESMAN');
-- BETWEEN AND
SELECT * FROM emp
WHERE sal BETWEEN 1500 AND 3000;
-- LIKE
SELECT * FROM emp
WHERE ename NOT LIKE '%A%';

SELECT * FROM emp
WHERE ename LIKE '%EN' OR ename LIKE '%AN';

SELECT * FROM emp
WHERE ename LIKE '__O%';