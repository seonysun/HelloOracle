/*
2) �������Լ�(�����Լ�) : Column ���� ó��
    - ���� �÷��̳� �������Լ��� �Բ� ��� �Ұ�
        -> GROUP BY�� ��� �Բ� ���
        cf. WHERE ������ row ������ ó���ϹǷ� �׷��Լ� ��� �Ұ�
            -> �׷� �÷��� ���� ������ HAVING
    - COUNT(*) : ����� ROW ���� ���
        COUNT(*) : NULL ����
        COUNT(�÷���) : NULL ����
        -> �˻����, ������, ���̵� ���, �α���, ��ٱ���
    - MAX()(*) : �ִ�
        - ��ȣ �ڵ� ���� ���α׷� MAX()+1
    - MIN() : �ּڰ�
    - SUM() : ��
    - AVG() : ���
   ---------------------------------- 
    - RANK() OVER(���Ĺ��)(*) : ����(���� ���� ����)
        ex. 1 2 2 4
    - DENSE_RANK() OVER(���Ĺ��)(*) : ����(���� ���� ������)
        ex. 1 2 2 3
    - CUBE() : ����+���� ���
    - ROLLUP() : ���� ���
*/
SELECT COUNT(comm),COUNT(mgr),COUNT(*) FROM emp;
SELECT SUM(sal) "��",ROUND(AVG(sal),2) "���" FROM emp;
SELECT MAX(sal),MIN(sal) FROM emp;

SELECT ename,hiredate,sal,RANK() OVER(ORDER BY sal DESC) rank
FROM emp;
SELECT ename,hiredate,sal,DENSE_RANK() OVER(ORDER BY sal) rank
FROM emp;
-- GROUP BY
    --deptno�� ������(ROW), SUM/AVG/COUNT�� �������̹Ƿ� GROUP BY�� �������� ������ ����
SELECT deptno,SUM(sal),ROUND(AVG(sal),2),COUNT(*)
FROM emp
GROUP BY deptno
ORDER BY deptno;
/*
SELECT SUM(sal),AVG(sal),COUNT(*)
FROM emp
WHERE deptno=10;
SELECT SUM(sal),AVG(sal),COUNT(*)
FROM emp
WHERE deptno=20;
SELECT SUM(sal),AVG(sal),COUNT(*)
FROM emp
WHERE deptno=30;
*/
SELECT TO_CHAR(hiredate,'YYYY') �Ի�⵵,COUNT(*) �ο���,MAX(sal),MIN(sal)
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')
HAVING COUNT(*)>=1
ORDER BY TO_CHAR(hiredate,'YYYY');