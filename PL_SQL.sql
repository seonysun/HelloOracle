/*
1. PL/SQL : Procedure Language
    - ���ν���/�Լ�/Ʈ���� ����� ���
        cf. FUNCTION : �������� ������ �Լ�(�����Լ�)
            PROCEDURE : �������� ���� �Լ�, ��ɸ� ����
            TRIGGER : �ڵ� ó�� 
    1) ����
        DECLARE
            ����� --����(��������, �Ű�����) ����
        BEGIN 
            ������ --SQL(DML,DQL), ���
        END;
        /
    2) ����
        - ��Į�󺯼� : �Ϲ� ����, �������� ���� ����
            - ������ ��������
                ex. no NUMBER;
        - %TYPE : ���� ���̺� ������ �������� ������
            - ���̺��.�÷���%TYPE
                ex. emp.empno%TYPE;
        - %ROWTYPE : ���� ���̺� ��ü ������ ��� �������� ������(VO)
            - ���̺��%ROWTYPE
                ex. emp%ROWTYPE;
            - ���̺� 1���� ��� ����(���ȿ� �پ)
        - RECORD : ����� ���� �������� -> ���̺� ������ ��� ����� ��(����, ��������)
            - TYPE record_������Ÿ�Ը� IS RECORD(
                ������ ��������..
              );
              record_������ record_������Ÿ�Ը�;
        - CURSOR : ��ü ROW�� ���� ������ ���� ������ ���� -> �ڹ��� ResultSet
            - CURSOR Ŀ���� IS
                SELECT~
            - SELECT ���� ���� Ŀ���� ����(��� ����� ���)          
            - ��� ����
                1. Ŀ�� ����
                    CURSOR Ŀ���� IS
                    SELECT 
                    --select�� ���� ������� Ŀ���� ����
                2. Ŀ�� ����
                    OPEN Ŀ����;
                3. ����
                    - LOOP�� ����
                    - FETCH Ŀ���� IN �޴º�����
                    - ������� ����
                        Ŀ����%NOTFOUND
                        Ŀ����%FOUND
                        Ŀ����%COUNT
                4. Ŀ�� �ݱ�
                    CLOSE Ŀ����;
    3) ���
        (1) ���ǹ�
            - ����
                IF ���ǹ� THEN ���๮�� 
                END IF;
            - ����
                IF ���ǹ� THEN ���๮�� 
                ELSE ���๮��
                END IF;
            - ����
                IF ���ǹ� THEN ���๮��
                ELSIF ���ǹ� THEN ó������
                ELSE ó������
                END IF;
            - CASE 
                - ������2�� ��2 ���ǿ� ���� ������1�� ���õ� ���๮��(��1 ���� ��) ����
                ������1:=CASE ������2
                    WHEN ��2 THEN ���๮��(��1)
                    WHEN ��2 THEN ���๮��(��1)
                    WHEN ��2 THEN ���๮��(��1)
                    ELSE ��1 --default
                END;
        (2) �ݺ���
            - BASIC
                LOOP 
                    ���๮��;
                    ������;
                    EXIT WHEN ���ǽ�;
                END LOOP;
            - WHILE 
                WHILE ���ǽ� LOOP
                    ���๮��;
                    ������;
                END LOOP;
            - FOR(*)
                FOR ���� IN [REVERSE] �������� LOOP 
                    ���๮��;
                END LOOP;
                - ���� ���� �� ������ ������ ���� ex. 1..100
                    -> ���� �Ųٷ� �����ϰ� ���� �� REVERSE �߰�
*/
-- DBMS_OUTPUT.PUT_LINE(); -> System.out.println()
-- & -> Scanner
SET SERVEROUTPUT ON;
--��Į�󺯼�
DECLARE
    pEmpno NUMBER(4):=10; --�ʱ�ȭ :=
    pEname VARCHAR2(34);
    pJob VARCHAR2(20);
    pHiredate DATE;
    pSal NUMBER(7,2);
BEGIN
    SELECT empno,ename,job,hiredate,sal 
    INTO pEmpno,pEname,pJob,pHiredate,pSal
    FROM emp
    WHERE empno=7788;
DBMS_OUTPUT.PUT_LINE('���>');
DBMS_OUTPUT.PUT_LINE('���:'||pEmpno);
DBMS_OUTPUT.PUT_LINE('�̸�:'||pEname);
DBMS_OUTPUT.PUT_LINE('����:'||pJob);
DBMS_OUTPUT.PUT_LINE('�Ի���:'||pHiredate);
DBMS_OUTPUT.PUT_LINE('�޿�:'||pSal);
END;
/
--%TYPE
DECLARE
    vEmpno emp.empno%TYPE;
    vEname emp.ename%TYPE;
    vJob emp.job%TYPE;
    vDname dept.dname%TYPE;
    vLoc dept.loc%TYPE;
    vGrade salgrade.grade%TYPE;
BEGIN
    SELECT empno,ename,job,dname,loc,grade 
    INTO vEmpno,vEname,vJob,vDname,vLoc,vGrade
    FROM emp JOIN dept
    ON emp.deptno=dept.deptno
    JOIN salgrade
    ON sal BETWEEN losal AND hisal
    WHERE empno=7788;
DBMS_OUTPUT.PUT_LINE('���>');
DBMS_OUTPUT.PUT_LINE('���:'||vEmpno);
DBMS_OUTPUT.PUT_LINE('�̸�:'||vEname);
DBMS_OUTPUT.PUT_LINE('����:'||vJob);
DBMS_OUTPUT.PUT_LINE('�μ���:'||vDname);
DBMS_OUTPUT.PUT_LINE('�ٹ���:'||vLoc);
DBMS_OUTPUT.PUT_LINE('ȣ��:'||vGrade);
END;
/
--%ROWTYPE
DECLARE
    vEmp emp%ROWTYPE;
BEGIN
    SELECT * INTO vEmp
    FROM emp
    WHERE empno=7788;
DBMS_OUTPUT.PUT_LINE('���>');
DBMS_OUTPUT.PUT_LINE('���:'||vEmp.empno);
DBMS_OUTPUT.PUT_LINE('�̸�:'||vEmp.ename);
DBMS_OUTPUT.PUT_LINE('����:'||vEmp.job);
DBMS_OUTPUT.PUT_LINE('�����ȣ:'||vEmp.mgr);
DBMS_OUTPUT.PUT_LINE('�Ի���:'||vEmp.hiredate);
DBMS_OUTPUT.PUT_LINE('�޿�:'||vEmp.sal);
DBMS_OUTPUT.PUT_LINE('������:'||vEmp.comm);
DBMS_OUTPUT.PUT_LINE('�μ���ȣ:'||vEmp.deptno);
END;
/
--����� ���� ��������
DECLARE
    TYPE empDept IS RECORD(
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        job emp.job%TYPE,
        hiredate emp.hiredate%TYPE,
        dname dept.dame%TYPE,
        loc dept.loc%TYPE
    );
    ed empDept;
BEGIN
    SELECT empno,ename,job,hiredate,dname,loc INTO ed
    FROM emp,dept
    WHERE emp.deptno=dept.deptno
    AND empno=7788;
DBMS_OUTPUT.PUT_LINE('���>');
DBMS_OUTPUT.PUT_LINE('���:'||ed.empno);
DBMS_OUTPUT.PUT_LINE('�̸�:'||ed.ename);
DBMS_OUTPUT.PUT_LINE('����:'||ed.job);
DBMS_OUTPUT.PUT_LINE('�Ի���:'||ed.hiredate);
DBMS_OUTPUT.PUT_LINE('�μ���:'||ed.dname);
DBMS_OUTPUT.PUT_LINE('�ٹ���:'||ed.loc);
END;
/
--IF
DECLARE
    vEmpno NUMBER(4):=0;
    vEname VARCHAR2(34):=' ';
    vJob VARCHAR2(20):=' ';
    vDname VARCHAR2(20):=' ';
    vDeptno NUMBER(2):=0;
BEGIN
    SELECT empno,ename,job,deptno
    INTO vEmpno,vEname,vJob,vDeptno
    FROM emp
    WHERE empno=&empno;
    
    IF vDeptno=10 
        THEN vDname:='������';
    END IF;
    IF vDeptno=20 
        THEN vDname:='���ߺ�';
    END IF;
    IF vDeptno=30
        THEN vDname:='�����';
    END IF;
    IF vDeptno=40
        THEN vDname:='����';
    END IF;
DBMS_OUTPUT.PUT_LINE('���>');
DBMS_OUTPUT.PUT_LINE('���:'||vEmpno);
DBMS_OUTPUT.PUT_LINE('�̸�:'||vEname);
DBMS_OUTPUT.PUT_LINE('����:'||vJob);
DBMS_OUTPUT.PUT_LINE('�μ���:'||vDname);
DBMS_OUTPUT.PUT_LINE('�μ���ȣ:'||vDeptno);
END;
/
--IF ELSE
DECLARE 
    vEname emp.ename%TYPE:=' ';
    vComm emp.comm%TYPE:=0;
    vSal emp.sal%TYPE:=0;
    vTotal NUMBER(7,2):=0;
BEGIN
    SELECT ename,comm,sal,sal+NVL(comm,0) 
    INTO vEname,vComm,vSal,vTotal
    FROM emp
    WHERE empno=&empno;
    
    IF vComm>0
        THEN DBMS_OUTPUT.PUT_LINE(vEname||'���� �޿��� '||vSal||', �������� '||vComm||', �� �޿��� '||vTotal||'�Դϴ�.');
    ELSE DBMS_OUTPUT.PUT_LINE(vEname||'���� �޿��� '||vSal||', �������� ������, �� �޿��� '||vTotal||'�Դϴ�.');
    END IF;
END;
/
--ELSIF
DECLARE
    vEname emp.ename%TYPE;
    vDname dept.dname%TYPE;
    vDeptno emp.deptno%TYPE;
BEGIN
    SELECT ename,deptno
    INTO vEname,vDeptno
    FROM emp
    WHERE empno=7902;
    
    IF vDeptno=10
        THEN vDname:='������';
    ELSIF vDeptno=20
        THEN vDname:='��ȹ��';
    ELSIF vDeptno=30
        THEN vDname:='���ߺ�';
    ELSE vDname:='����';
    END IF;
DBMS_OUTPUT.PUT_LINE('���>');
DBMS_OUTPUT.PUT_LINE('�̸�:'||vEname);
DBMS_OUTPUT.PUT_LINE('�μ���:'||vDname);
END;
/
--CASE
DECLARE
    vEname emp.ename%TYPE;
    vDname dept.dname%TYPE;
    vDeptno emp.deptno%TYPE;
BEGIN
    SELECT ename,deptno
    INTO vEname,vDeptno
    FROM emp
    WHERE empno=7902;
    
    vDname:=CASE vDeptno
        WHEN 10 THEN '������'
        WHEN 20 THEN '��ȹ��'
        WHEN 30 THEN '���ߺ�'
        ELSE '����'
    END;
DBMS_OUTPUT.PUT_LINE('���>');
DBMS_OUTPUT.PUT_LINE('�̸�:'||vEname);
DBMS_OUTPUT.PUT_LINE('�μ���:'||vDname);
END;
/
--�ݺ�
DECLARE
    sno NUMBER:=1;
    eno NUMBER:=10;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(sno);
        sno:=sno+1;
        EXIT WHEN sno>eno;
    END LOOP;
END;
/
--do~while : ������(������ 1�� �̻��� ���� ����)
DECLARE
    no NUMBER:=1;
BEGIN
    WHILE no<=10 LOOP 
        DBMS_OUTPUT.PUT_LINE(no);
        no:=no+1;
    END LOOP;
END;
/
--for
DECLARE
BEGIN
    FOR i IN 1..10 LOOP 
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/
BEGIN --������ �����Ƿ� declare ���� ����
    FOR i IN REVERSE 1..10 LOOP --���� ��� 
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/
BEGIN
    FOR i IN 1..10 LOOP
        IF MOD(i,2)=0 THEN
            DBMS_OUTPUT.PUT_LINE(i);
        END IF;
    END LOOP;
END;
/
DECLARE
    total NUMBER:=0;
    even NUMBER:=0;
    odd NUMBER:=0;
BEGIN
    FOR i IN 1..100 LOOP
        total:=total+i;
        IF MOD(i,2)=0 THEN
            even:=even+i;
        END IF;
        IF MOD(i,2)<>0 THEN
            odd:=odd+i;
        END IF;
    END LOOP;
DBMS_OUTPUT.PUT_LINE('>���');
DBMS_OUTPUT.PUT_LINE('1~100 ����:'||total);
DBMS_OUTPUT.PUT_LINE('1~100 ¦����:'||even);
DBMS_OUTPUT.PUT_LINE('1~100 Ȧ����:'||odd);
END;
/
DECLARE
    dan NUMBER:=&dan;
    result VARCHAR2(100):=' ';
BEGIN
    FOR i IN 1..9 LOOP
        result:=dan||'*'||i||'='||(dan*i);
        DBMS_OUTPUT.PUT_LINE(result);
    END LOOP;
END;
/
--Ŀ�� : ������ ��Ƽ� ���� -> �ڹ� ��Ī Ŭ���� ResultSet -> ������ ���� ��� ����(ArrayList)
DECLARE
    vemp emp%ROWTYPE;
    CURSOR cur IS
        SELECT * FROM emp;
BEGIN
    --Ŀ�� ����
    OPEN cur;
    --����
    LOOP 
        FETCH cur INTO vemp;
        EXIT WHEN cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.job||' '||vemp.hiredate);
    END LOOP;
    --Ŀ�� �ݱ�
    CLOSE cur;
END;
/
--Ŀ�� for������ �迭(**)
DECLARE
    vemp emp%ROWTYPE;
    CURSOR cur IS 
        SELECT * FROM emp;
BEGIN
    FOR vemp IN cur LOOP
        DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.job||' '||vemp.hiredate);
    END LOOP;
END;
/
--Ŀ�� JOIN
DECLARE 
    TYPE empDept IS RECORD(
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        job emp.job%TYPE,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE
    );
    ed empDept;
    CURSOR cur IS
        SELECT empno,ename,job,dname,loc
        FROM emp,dept
        WHERE emp.deptno=dept.deptno;
BEGIN
    FOR ed IN cur LOOP
        DBMS_OUTPUT.PUT_LINE(ed.empno||' '||ed.ename||' '||ed.job||' '||ed.dname||' '||ed.loc);
    END LOOP;
END;
/