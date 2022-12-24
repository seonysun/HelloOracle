/*
1. JOIN : �� �� �̻��� ���̺��� �Ӽ��� ���� ���� ������ �Բ� ���� (���ο� ���̺� ����)
    - ����ȭ -> ���̺� ������ ����� -> ���̺��� �����ؼ� ������ ������ �;� ��
    - SELECT������ ��� ����
    - INNER JOIN
        - ������ ���� ���� ó�� ����
            -> �ݵ�� ���� �Ӽ�(���� ������)�� �־�� ��
        - NULL ó�� �Ұ�
        1) EQUI JOIN(��������) : = ������ ���
            - ���̺��.�÷���
                -> �÷��� �ٸ� ��� ���̺�� ���� ����(�ڵ� �ν�)
                -> �÷��� ���� ��� ���̺���̳� ��Ī������ ���� �ʿ�
            - ORACLE JOIN(����Ŭ)
                - SELECT A.column,B.column
                  FROM A,B
                  WHERE A.column=B.column
                - SELECT a.column,b.column
                  FROM A a,B b
                  WHERE a.column=b.column
            - ANSI JOIN(�Ƚ�) : ǥ��ȭ�� ����
                                -> �ٸ� DB���� ���(MySQL, MariaDB)
                - , -> JOIN / WHERE -> ON
                - SELECT A.column,B.column
                  FROM A JOIN B
                  ON A.column=B.column
                - SELECT a.column,b.column
                  FROM A a JOIN B b
                  ON a.column=b.column
        2) NON EQUI JOIN(������) : = �̿� �ٸ� ������(��, ��) ���
            - ���� ���� ���� �Ǵܽ� �ַ� ���
            - ����Ŭ ����
                SELECT A.column,B.column
                FROM A,B
                WHERE A.column BETWEEN B.column AND B.column
            - �Ƚ� ����
                SELECT A.column,B.column
                FROM A JOIN B
                ON A.column BETWEEN B.column AND B.column
        3) NATURAL JOIN : EQUI JOIN���� �ߺ� �Ӽ� ���� �� ��ȯ
            ex. emp�� dept ���� �� deptno �ߺ����� 2�� ��ȯ���� �ʰ� 1���� ��ȯ
            - �÷����� ���� ���� ���� �� �ڵ����� ���� ó�� ����
            - ������ ���ʿ�
        4) USING
            - �÷��� ���� �� JOIN�� ���ǿ��� ON ��� USING ��� ����
            - SELECT A.column,B.column
              FROM A JOIN B
              USING(column)
        5) SELF JOIN : �ϳ��� ���̺� ������ ����
            - �÷����� �޶� ���� ���� ������ ���� �� ���� ó�� ����
            - ���̺� 1�� -> ��Ī���� ����
            - �÷��� �ٸ��Ƿ� NATURAL JOIN/JOIN USING�� ��� �Ұ�
    - OUTER JOIN 
        - ������ ���� ���� ��� ����(INNER JOIN ����), ���� �������� ����
        - ������ ���� ��� NULL ��ȯ
        1) LEFT OUTER JOIN
            - ����Ŭ ����
                SELECT A.column,B.column
                FROM A,B
                WHERE A.column=B.column(+)
            - �Ƚ� ����
                SELECT A.column,B.column
                FROM A LEFT OUTER JOIN B
                ON A.column=B.column
        2) RIGHT OUTER JOIN
            - ����Ŭ ����
                SELECT A.column,B.column
                FROM A,B
                WHERE A.column(+)=B.column
            - �Ƚ� ����
                SELECT A.column,B.column
                FROM A RIGHT OUTER JOIN B
                ON A.column=B.column
        3) FULL OUTER JOIN
            - ����Ŭ ���� ����
            - �Ƚ� ����
                SELECT A.column,B.column
                FROM A FULL OUTER JOIN B
                ON A.column=B.column
*/
--INNER
SELECT empno,ename,job,hiredate,sal,dname,loc,emp.deptno
FROM emp,dept
WHERE emp.deptno=dept.deptno;
--ANSI
SELECT empno,ename,job,hiredate,sal,dname,loc,emp.deptno
FROM emp JOIN dept
ON emp.deptno=dept.deptno;
--NATURAL
SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
FROM emp NATURAL JOIN dept;
--JOIN USING
SELECT empno,ename,job,hiredate,sal,dname,loc,deptno
FROM emp JOIN dept 
USING(deptno);
--SELF
SELECT e1.ename "����", e2.ename "���"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno;
    --3�� ����
--INNER
SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;
--ANSI
SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp JOIN dept
ON emp.deptno=dept.deptno
JOIN salgrade
ON sal BETWEEN losal AND hisal;
--NATURAL
SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp NATURAL JOIN dept
JOIN salgrade
ON sal BETWEEN losal AND hisal;
--JOIN USING
SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp JOIN dept 
USING(deptno)
JOIN salgrade
ON sal BETWEEN losal AND hisal;
--
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND ename='SCOTT';

SELECT ename,sal,grade
FROM emp,salgrade
WHERE sal BETWEEN losal AND hisal;