/*
1. �� VIEW : ���̺��� ����(�������̺�)
    - �� �� �̻��� ���̺��� �����ؼ� ����
        -> ���� ���̺� �ʼ��� ����
        -> ���̺�� �����ϰ� ��� ����(�Լ�, ������ ��� ����)
    1) Ư¡
        - �б����� �ɼ� -> ���� ����
            - WITH CHECK : DML ����(DEFAULT)
              WITH READ ONLY(*) : DML �Ұ� -> �Ϲ������� �ַ� ���
        - �����Ͱ� �ƴ� SQL ������ �����ϴ� ����
        - ������ ���̺� -> INSERT, UPDATE, DELETE ���� �� �䰡 �ƴ� ���� ���̺� ����
        - SQL ���� ����ȭ
            -> ���� ���Ǵ� SQL ������ VIEW ���·� ����, ����
    2) ����
        - �ܼ��� : ���̺��� �Ѱ��� ����
            - ��� �� ����(�ʹ� ����)
        - ���պ� : ���̺��� ������ ���� -> JOIN, �������� ����
            - �ڹٿ��� �ַ� ���(SQL ���� ����ȭ ����)
        - �ζ��κ�(*) : �� ���� �������� �ʰ� SELECT �̿�
    3) �������
        - CREATE VIEW view_name
          AS
          SELECT
            -> SELECT ������ ������ VIEW�� �����
        - ���� ����(*) : CREATE OR REPLACE VIEW view_name
                        AS
                        SELECT
        - ���� : DROP VIEW view_name;
        cf. ����� ������ ������ ���� ���� ����
        	 -> ���̺� �� VIEW, SYNONYM, FUNCTION �� ���� ����
             -> system �������� ���� �ο� ���� ����
                  SQLPLUS system/happy
                  GRANT CREATE view TO hr; --���Ѻο�
                  REVOKE CREATE view TO hr; --��������
        cf. ����Ŭ�� ����� ������ Ȯ�� : tab, user_tables, user_views, user_constraints
    - �� ���� Ȯ��
    	SELECT text FROM user_views WHERE view_name='�빮��';
        
2. �ζ��κ�
    - rownum : ���� �÷�, INSERT ������� ��ȣ �ڵ� �ο�
    - ���̺�� ��� ������ ���
      SELECT * | column
      FROM table_name | view_name | SELECT~
    - �ζ��κ信�� ���������� ���� �� ������ �÷��� �������� ������ ����
    
cf. �䱸���׺м�
    - ȸ������
        �α���/�α׾ƿ�
        ���̵� �ߺ�üũ
        ȸ������
        ȸ��Ż��
        ���̵�/��й�ȣ ã��
    - �Խ���(���)
    - ��������(���� ����)
    ------------------------- �⺻, ����¡���(*) -> �ζ��κ�, ����������
    - ����, ����, ��õ, ��Ƽ�̵�� (1�� ������Ʈ)
    - ����, �����ٷ�, �����ͺм� (2��)
    - �ű�� (3��)
*/
CREATE VIEW emp_view
AS 
SELECT empno,ename,job,hiredate,sal,deptno
FROM emp;
--����Ŭ ���� ������ Ȯ��
SELECT * FROM tab;
SELECT * FROM user_views;
SELECT * FROM user_constraints;

SELECT * FROM user_tables WHERE table_name='EMP';
SELECT text FROM user_views WHERE view_name='EMP_VIEW';

DROP VIEW emp_view;
--���̺� ����
CREATE TABLE myDept
AS
SELECT * FROM dept;
--VIEW ����/�б�����
CREATE VIEW dept_view
AS
SELECT * FROM myDept;
--DML
INSERT INTO dept_view VALUES(60,'���ߺ�','����');
SELECT * FROM dept_view;
SELECT * FROM myDept;

DROP VIEW dept_view;
--VIEW ����/����
--�Ϲ�
CREATE OR REPLACE VIEW empDeptGrade_1
AS
SELECT e1.empno,e1.ename,e2.ename mgr,e1.job,e1.hiredate,e1.sal,e1.comm,dname,loc,grade
FROM emp e1,emp e2,dept,salgrade
WHERE e1.deptno=dept.deptno
AND e1.sal BETWEEN losal AND hisal
AND e1.mgr=e2.empno;
--����
CREATE OR REPLACE VIEW empDeptGrade
AS
SELECT e1.empno,e1.ename,e2.ename mgr,e1.job,e1.hiredate,e1.sal,e1.comm,dname,loc,grade
FROM emp e1 JOIN dept
ON e1.deptno=dept.deptno
JOIN salgrade
ON e1.sal BETWEEN losal AND hisal
LEFT OUTER JOIN emp e2
ON e1.mgr=e2.empno;
--��������
CREATE OR REPLACE VIEW empDeptGrade_2
AS
SELECT empno,ename,hiredate,sal,comm,
(SELECT ename FROM emp e2 WHERE e1.mgr=e2.empno) manager,
(SELECT dname FROM dept WHERE deptno=e1.deptno) dname,
(SELECT loc FROM dept WHERE deptno=e1.deptno) loc,
(SELECT grade FROM salgrade WHERE e1.sal BETWEEN losal AND hisal) grade
FROM emp e1;

DROP VIEW empDeptGrade_2;

    --�ζ��κ�
SELECT empno,ename,job,hiredate,sal,comm
FROM (SELECT * FROM emp);

SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,dname,loc 
      FROM emp,dept
      WHERE emp.deptno=dept.deptno);
--�������� �̿� �ÿ��� ��Ī �ʼ�
SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,
        (SELECT dname FROM dept WHERE deptno=emp.deptno) dname,
        (SELECT loc FROM dept WHERE deprno=emp.deptno) loc
        FROM emp);
    --rownum
SELECT empno,ename,job,hiredate,sal,rownum
FROM (SELECT empno,ename,job,hiredate,sal FROM emp ORDER BY sal DESC)
WHERE rownum<=5;
--����¡ -> �ܼ� 1�� �ζ��κ�δ� rownum�� TOP-N ����̹Ƿ� �߰��� �ڸ��� �� �Ұ�
SELECT ename,job,sal,num
FROM (SELECT ename,job,sal,rownum as num
        FROM (SELECT ename,job,sal
        FROM emp ORDER BY sal DESC))
WHERE num BETWEEN 11 AND 14;