/*  
2. SubQuery; �μ�����
    - SQL ���� ������ �����ؼ� �ѹ��� ó���� �������� ����
        -> SQL ���� 1���� ���� ���� �������� ��� ������ ũ�Ⱑ Ŀ������ �ӵ� ���̰� Ŀ��
        ex. SQL���� ������ -> ����Ŭ ����
                            ��հ� ���ϱ�
                            ����Ŭ �ݱ�
                            ����Ŭ ����
                            ��� ���� ����� ���
                            ����Ŭ �ݱ�
            SQL ���� 1�� -> ����Ŭ ����
                           ��հ� ���ؼ� ���� ����� ���
                           ����Ŭ �ݱ�
    - SELECT ������ ��/�÷�/���̺� ��� ��� : ����¡���(**)
    - ��ȣ�� ��� ����
        -> SUBQuery ���� ����, ����� MainQuery�� �����Ͽ� ó��
    - DML ��ü, DDL���� ��� ����
        -> SELECT,INSERT,UPDATE,DELETE ��� ����
    - �ٸ� ���̺� �������� ��� ��� ����    
    cf. ���� VS ��������
        - ���� : �������� ���̺��� �ʿ��� ������ ���� ����
                -> �����͸� ��� ��Ƽ� �����ϱ� ����
        - �������� : �������� SQL ���� �����ؼ� �ѹ��� ���� ����
                    -> �ʿ��� �����͸� ã�Ƽ� �����ؼ� ó�� �ӵ� ������ �ϱ� ����
        - JOIN�� FOR�� ���� -> ������ �������� �ӵ� ���� -> �������� ����
    1) WHERE ��
        - ������ �������� : �÷� 1��, ����� 1��
        - ������ �������� : �÷� 1��, ����� ������
            -> ���ǿ� ���� ������� �������� ��� ó���� �Ұ����� �� ���� -> �ϳ� ���� ó��
                ex. �񱳿����� �ڿ� ���� ���
            - ����� ��ü ���� : IN
            - �ּڰ�, �ִ� ã�� : ANY, SOME, ALL
                ex. column< ANY(1,2,3) : �ִ�(3) ���� = SOME
                    column> ANY(1,2,3) : �ּڰ�(1) ����
                    column< ALL(1,2,3) : �ּڰ�(1) ����
                    column> ALL(1,2,3) : �ִ�(3) ����
                -> MAX, MIN�� �ַ� ����ϹǷ� ���� ������� ����
        - �����÷� �������� : �÷� ������
        - ���� ��������
    2) SELECT ��
        - ��Į�� ��������(*) : �÷� ��� ���, JOIN ��� ���
            - ���� �Ѱ��� �ݵ�� �÷� 1���� ������ ��
            - �ҽ� �ڵ� ������ �˻� �ӵ� ����
    3) FROM ��
        - �ζ��κ�(*) : ���̺� ��� ���
            - ������ ���̺�(��) �����Ͽ� ���� ���̺� ������ �ű� �� ����, ���� -> ���ȿ� �پ
            - TOP-N : �׻� 1������ ������, �߰� ��ȣ���� �������� ���� �Ұ�
                - ���ϴ� ������ ���� ������ �� ���
                - ���� ���̺��� rownum�� ���� -> ���� ���̺� �����Ͽ� rownum ���� �� ������� �ڷ� ���
            - �ζ��κ信�� ������ �÷�(FROM ������ ����� SELECT ������ �÷�)�� SELECT������ ��� ����
            - rownum(�� ��ȣ) -> ArrayList ó�� �� ���� �� ��ȣ �ڵ� ��ο�
            
3. �����ͺ��̽�
    - ���� SQLite : ������, �ڵ��� ����
    - ���� (����)Oracle (����)MySQL, MariaDB
    - ��뷮 ���̺��̽�, DB2
*/
    --GROUP BY
SELECT job,COUNT(*),SUM(sal),ROUND(AVG(sal))
FROM emp
GROUP BY job
HAVING AVG(sal)>(SELECT ROUND(AVG(sal)) FROM emp);
--���� �׷�
SELECT deptno,job,COUNT(*),MAX(sal),MIN(sal)
FROM emp
GROUP BY (deptno,job)
ORDER BY deptno;
    --��������
SELECT empno,ename,job,hiredate,sal,
    (SELECT dname FROM dept WHERE deptno=emp.deptno) dname,
    (SELECT loc FROM dept WHERE deptno=emp.deptno) loc
FROM emp
WHERE ename='SCOTT';

SELECT ename,job FROM emp; --�����÷�
SELECT deptno FROM emp WHERE ename='KING'; --������
SELECT DISTINCT deptno FROM emp; --������

--emp���� ��� �޿����� ���� �޴� ��� ��� ���
    --SQL ���� �������� ���(��������)
--1. ��� �޿� ���ϱ�
SELECT ROUND(AVG(sal)) FROM emp;
--2. ��� �޿� �����Ͽ� ����� ���
SELECT * FROM emp
WHERE sal<2073;
    --SQL ���� �ϳ��� ���(��������)
SELECT * FROM emp
WHERE sal<(SELECT ROUND(AVG(sal)) FROM emp);

--KING�� �μ���, �ٹ��� ���
    --��������
--1. KING�� �μ���ȣ ���
SELECT deptno FROM emp
WHERE ename='KING';
--2. �μ���ȣ �����Ͽ� �μ���, �ٹ��� ���
SELECT dname,loc FROM dept
WHERE deptno=10;
    --��������
SELECT dname,loc FROM dept
WHERE deptno=(SELECT deptno FROM emp
WHERE ename='KING');

--SCOTT�� ���� �μ��� �ٹ��ϴ� ��� ��� ���
    --��������
--1. SCOTT�� �μ���ȣ ���
SELECT deptno FROM emp
WHERE ename='SCOTT';
--2. �μ���ȣ �����Ͽ� ��� ��� ���
SELECT * FROM emp
WHERE deptno=20;
    --��������
SELECT * FROM emp
WHERE deptno=(SELECT deptno FROM emp
WHERE ename='SCOTT');

--�μ���ȣ 10,20,30�� ��� ���
    --������ ��������
SELECT * FROM emp
WHERE deptno IN(SELECT DISTINCT deptno FROM emp);

--�޿��� ���� ���� ����� ���� �μ��� �ٹ��ϴ� ��� ���� ���
    --��������
--1. �޿� ���� ���� ���
SELECT MAX(sal) FROM emp;
SELECT ename FROM emp 
WHERE sal=5000;
--2. �ش� ����� �μ���ȣ Ȯ��
SELECT deptno FROM emp 
WHERE ename='KING';
--3. �ش� �μ� �ٹ��� Ȯ��
SELECT * FROM emp 
WHERE deptno=10;
    --��������
SELECT * FROM emp 
WHERE deptno=(
SELECT deptno FROM emp WHERE ename=(
SELECT ename FROM emp WHERE sal=(
SELECT MAX(sal) FROM emp)));

    --IN/ANY/ALL
--IN
SELECT * FROM emp
WHERE deptno IN(SELECT DISTINCT deptno FROM emp);
--ANY
SELECT * FROM emp
WHERE deptno <ANY(SELECT DISTINCT deptno FROM emp);

SELECT * FROM emp
WHERE deptno >ANY(SELECT DISTINCT deptno FROM emp);
--SOME
SELECT * FROM emp
WHERE deptno <SOME(SELECT DISTINCT deptno FROM emp);

SELECT * FROM emp
WHERE deptno >SOME(SELECT DISTINCT deptno FROM emp);
--MAX,MIN
SELECT * FROM emp
WHERE deptno < (SELECT MAX(deptno) FROM emp);

SELECT * FROM emp
WHERE deptno > (SELECT MIN(deptno) FROM emp);
--ALL
SELECT * FROM emp
WHERE deptno <= ALL(SELECT DISTINCT deptno FROM emp);

SELECT * FROM emp
WHERE deptno >= ALL(SELECT DISTINCT deptno FROM emp);

    --�ζ��κ�
SELECT ename,sal,rownum
FROM emp;

SELECT ename,job,hiredate,sal,deptno 
FROM (SELECT * FROM emp ORDER BY deptno);

--�޿� ���� ��� 5�� ���
SELECT ename,sal,rownum
FROM (SELECT ename,sal FROM emp ORDER BY sal DESC)
WHERE rownum<=5;

SELECT title,hit,rownum
FROM (SELECT title,hit FROM seoul_location ORDER BY hit desc)
WHERE rownum<=5;

SELECT fno,name
FROM food_location
ORDER BY fno;
--rownum �ѹ��� ���� TOP-N ����̹Ƿ� �߰� ���� �Ұ� -> 2�� ����ؾ� ��
SELECT fno,name,num
FROM (SELECT fno,name,rownum as num 
FROM (SELECT fno,name FROM food_location ORDER BY fno))
WHERE num BETWEEN 21 AND 30;