/*
1. �����Լ�
    - ����Ŭ ���� �Լ�
        - �������Լ� : ���� ������ ó��
        - �������Լ� : �÷� ������ ó��
    cf. ����� ���� �Լ�
        - FUNCTION : �������� �ִ� �Լ� 
            ex. CREATE FUNCTION RETURN NUMBER
        - PROCEDURE : �������� ���� �Լ�
            ex. CREATE PROCEDURE
            
    1) �������Լ� : ���پ� ó��(ROW ����)
        - �Լ� : ������ ���� 
                -> ���������� ���� �з�
                -> ��������(����, ����, ��¥, ��Ÿ)�� �°� ���۵� �Լ� ����
        (1) �����Լ�(String)
            - ��ȯ�Լ�
                - UPPER(���ڿ�) : �빮�ں�ȯ
                - LOWER(���ڿ�) : �ҹ��ں�ȯ
                    -> �˻��� ���, �ڹٿ��� �����ؼ� �����ϹǷ� ��� �� ���� ����
                - INITCAP(���ڿ�)(*) : �̴ϼȺ���, �ܾ�� ����
                    ex. INITCAP('ABC') -> Abc
            - �����Լ�
                - SUBSTR(���ڿ�,������ġ,�ڸ�����)(*) : ���ڿ� �ڸ��� substring()
                                -> �ε��� 1������ ����
                - INSTR(���ڿ�,�˻�����,������ġ,����)(*) : ���� ��ġ ã�� indexOf()
                                        -> ������ġ �տ������� 1, �ڿ������� -1
                - REPLACE(���ڿ�,old,new)(*) : ����, ���ڿ� ����
                    - ����Ŭ���� ���Ǵ� ��ȣ : &, ^, |, $ ..
                - TRIM() : ���ϴ� ���ڿ� ���� -> ���ڿ� �������� ������ ���� ����
                    - TRIM(�����ҹ��ڿ� FROM ����ڿ�) : �¿�
                    - LTRIM(����ڿ�, ���Ź��ڿ�) : ���ʸ�
                    - RTRIM(����ڿ�, ���Ź��ڿ�) : �����ʸ�
                - PAD(���ڿ�,���ڼ�,����ҹ���) : ���ڼ��� ���� Ư������ ���
                                                -> ���ڼ��� �� ������ Ư������ ���, ���ڼ��� �� ������ �߰��� �ڸ�
                    - LPAD() : ###��
                    - RPAD()(*) : ��###
                        ex. ���̵�ã�� -> ad***
                - LENGTH() : ���� ���� Ȯ��
                - LENGTHB() : ������ byte �� Ȯ��
                    - ����� 1byte, �ѱ��� 3byte
                    cf. VARCHAR2(1~4000byte), CLOB(4GB)
                - CONCAT() : ���ڿ� ���� ||
                    ����Ŭ> WHERE ename LIKE '%'||��||'%'
                    MySQL> WHERE ename Like CONCAT('%',��,'%')
            - ���Խ��Լ�
        (2) �����Լ�(Math)
            - MOD() : ������
                -> ���� �ڹٿ��� % ó��
            - CEIL()(*) : �ø�
            - ROUND()(*) : �ݿø�
            - TRUNC() : ����
        (3) ��¥�Լ�(Date, Calender)
            - SYSDATE(*) : �ý����� ��¥�� �ð� ���� �� ���
                - ������ -> ���� ����
                - ��¥ + �ð� -> �Ǽ���
                - SYSDATE�� �ð����� ���� -> �ݿø�/����/�ø� �ʼ�
            - MONTHS_BETWEEN(�ֱ���,������)(*) : �Ⱓ�� �ش�Ǵ� ���� ��
            - ADD_MONTHS(������,������) : �� �߰�
            - NEXT_DAY(��¥, ����) : ��¥ ���� ���ǿ� �ش��ϴ� ��¥
            - LAST_DAY(��¥) : �ش� ���� ������ ��
        (4) ��ȯ�Լ�(Format)
            - TO_CHAR(*) : ���ڿ� ��ȯ, ���� �̿�
                - ��¥����
                    d/dd ��
                    yy(rr)/yyyy(rrrr) ��
                    m/mm ��
                    dy ����
                    hh/hh24 �ð�
                    mi ��
                    s/ss ��
                - ��������
                    $999,999 : �޷�
                    L999,999 : ��ȭ
                cf. JSTL : ǥ�������� ��� -> �׻� ��ȯ�Ͽ� ����ؾ� ��
            - TO_DATE : ��¥�� ��ȯ
            - TO_NUMBER : ������ ��ȯ
                -> ����ó�� �� �ڵ����� �߰��ǹǷ� ��� �� ���� ����
            - CHR(����) : ���� -> ���ڷ� ����
        (5) ��Ÿ�Լ�(Oracle Only)
            - NVL(������,��)(*) : �����Ͱ� NULL�� ��� �� ����
                - NULL�� ��ü -> ���� �����ϵ��� ��
                - �����Ϳ� ���� ���������� ���ƾ� ��
                - ũ�Ѹ� �� ���� ���
            - DECODE(*) : switch case
                - �Ϲ� SQL ���� -> �������
                ex. DECODE(score,1,'�ڡ١١١�',
                                 2,'�ڡڡ١١�',
                                 3,'�ڡڡڡ١�')
            - CASE WHEN ���� THEN ó���� END(*) : �������ǹ�
                - TRIGGER, PROCEDURE -> ����� ���� ��� ��ȭ
*/
DESC emp;
    -- ����
--���� ����
SELECT * FROM emp ORDER BY sal DESC;
--��¥ ����
SELECT * FROM emp ORDER BY hiredate;
--���ĺ� ����
SELECT * FROM emp ORDER BY ename ASC;
--���� ����
SELECT empno,ename,job,deptno
FROM emp
ORDER BY deptno, 2;

    -- �����Լ�
-- ��ȯ�Լ�
SELECT ename "����� ������", UPPER(ename) "�빮��",LOWER(ename) "�ҹ���",INITCAP(ename) "�̴ϼ�" FROM emp;
SELECT INITCAP('hello oracle') FROM DUAL;

SELECT ename,sal,job
FROM emp
WHERE ename=UPPER('king');

SELECT ename,sal,job
FROM emp
WHERE LOWER(ename)='king';
-- LENGTH, LENGTHB
SELECT ename,LENGTH(ename),LENGTHB(ename) FROM emp;
SELECT LENGTH('ABC'),LENGTH('ȫ�浿'),LENGTHB('ABC'),LENGTHB('ȫ�浿') FROM DUAL;

SELECT ename
FROM emp
WHERE LENGTH(ename)=4;

SELECT ename
FROM emp
WHERE LENGTH(ename) BETWEEN 4 AND 5;
-- REPLACE
SELECT REPLACE('Hello Oracle','l','m') FROM DUAL;
--&�� ��� REPLACE ���� ���� �Է°� �ޱ� ����Ǿ� ���� �Ұ�, Java���� ���� �� ����
SELECT REPLACE('Hello Oracle&Spring','&','^') FROM DUAL;
-- SUBSTR
SELECT SUBSTR('Hello Oracle',7,1) FROM DUAL;

SELECT ename,hiredate
FROM emp
WHERE SUBSTR(hiredate,1,2)=81;

SELECT ename,hiredate
FROM emp
WHERE SUBSTR(hiredate,4,2)=12;
-- ��Ī�� �� �� "" ���� �ʾƵ� ������ �ٸ� ���α׷��� ���� �� ������ �� �����Ƿ� �߰�(Ư�� �ѱ��̳� ���� ���� ���)
SELECT ename,SUBSTR(hiredate,-2,2) hireday
FROM emp;

SELECT SUBSTR(hiredate,1,2),SUM(sal),ROUND(AVG(sal),1) AVG
FROM emp
GROUP BY SUBSTR(hiredate,1,2)
ORDER BY SUBSTR(hiredate,1,2) DESC;
-- PAD
SELECT LPAD('Hello Oracle',15,'#'),RPAD('Hello Oracle',5,'#') FROM DUAL;
SELECT ename,RPAD(SUBSTR(ename,1,2),LENGTH(ename),'*') FROM emp;
-- TRIM
SELECT LTRIM('AAABBBCCC','A'),RTRIM('AAABBBCCC','C') FROM DUAL;
SELECT TRIM('A' FROM 'AAABABABAAA') FROM DUAL;
-- CONCAT
SELECT CONCAT('Hello ','Oracle') FROM DUAL;
SELECT 'Hello ' || 'Oracle' FROM DUAL;
-- INSTR
SELECT ename, INSTR(ename,'A',1,1) FROM emp;
SELECT INSTR('Hello Java','a',-1,1) FROM DUAL;

    -- �����Լ�
-- MOD
SELECT MOD(10,3) FROM DUAL;

SELECT empno,ename,job
FROM emp
WHERE MOD(empno,2)=0
ORDER BY 1;
-- CEIL
SELECT CEIL(10.1) FROM DUAL;
SELECT CEIL(10.0) FROM DUAL;
    --�� ������ ���ϱ�
SELECT CEIL(COUNT(*)/10.0) FROM emp;
-- ROUND
SELECT ROUND(10.23456,3) FROM DUAL;
-- TRUNC
SELECT TRUNC(10.23456,3) FROM DUAL;

    -- ��¥�Լ�
-- SYSDATE
SELECT SYSDATE-1 "����",SYSDATE "����",SYSDATE+1 "����" FROM DUAL;
-- MONTHS_BETWEEN, ROUND
SELECT ename,hiredate,ROUND(MONTHS_BETWEEN(SYSDATE,hiredate)) "�ٹ�������"
FROM emp;
SELECT ename,hiredate,TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate))/12) "�ٹ����"
FROM emp;
SELECT SYSDATE,ADD_MONTHS(SYSDATE,12) FROM DUAL;
-- LASTDAY
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('22/03/01') FROM DUAL;
-- NEXTDAY
SELECT NEXT_DAY(SYSDATE,'��') FROM DUAL;

    -- ��ȯ�Լ�
-- TO NUMBER
SELECT TO_NUMBER('100')+TO_NUMBER('200') FROM DUAL;
SELECT '100'+'200' FROM DUAL;
-- TO DATE
SELECT TO_DATE(SYSDATE)+5 After,
       TO_DATE(SYSDATE,'RRRR-MM-DD')-5 Before
FROM DUAL;
-- TO CHAR
SELECT ename, TO_CHAR(sal,'L999,999') FROM emp;
SELECT ename, TO_CHAR(SYSDATE,'RRRR-MM-DD'), TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM emp;
SELECT TO_CHAR(SYSDATE,'HH24:MI:SS') "����ð�" FROM DUAL;
SELECT TO_CHAR(SYSDATE,'DY') "����" FROM DUAL;
SELECT ename,TO_CHAR(hiredate,'YYYY') �Ի�⵵ FROM emp;
SELECT ename,TO_CHAR(hiredate,'DY')||'����' "�Ի����" FROM emp;

SELECT * FROM emp
WHERE TO_CHAR(hiredate,'DY')='��';

-- ��Ÿ�Լ�
SELECT ename,sal,comm,sal+NVL(comm,0) FROM emp;
SELECT zipcode,sido||' '||gugun||' '||dong||' '||NVL(bunji,' ') FROM zipcode;
SELECT ename,job,hiredate,DECODE(deptno,10,'���ߺ�',20,'�ѹ���',30,'��ȹ��') "dname"
FROM emp;

SELECT ename,job,hiredate,CASE WHEN deptno=10 THEN '���ߺ�'
                               WHEN deptno=20 THEN '��ȹ��'
                               WHEN deptno=30 THEN '�����' 
                               END "dname"
FROM emp;