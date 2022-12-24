/*
5. �ε���
    - ���� �˻�, ���� �����ϵ��� ���� ������ ����
        -> SQL ���� ó�� �ӵ� ���(����ȭ)
           (ORDER BY�� �ӵ� ���� ����)
    - ������ Ű�� ��ġ(rowid) ����
        -> �߰� ���� ���� �ʿ�, �޸� ���� �Ҹ�
        -> B-tree ���·� ����
    - ���̺� �ϳ��� ������ ���� ����(����/���� �÷� ���)
    - ������ ���� �� �ε��� �籸�� �ʿ� -> build
    1) �ε����� ���
        - �����Ǵ� ���
            - WHERE���� ���� �˻��Ǵ� �÷��� �ִ� ���
            - JOIN���� �ַ� ���Ǵ� �÷��� �ִ� ���
            - NULL���� �����ϴ� �÷��� ���� ���
            - �����Ǵ� �÷��� ���� ���; UNIQUE, PRIMARY KEY
        - �������� �ʴ� ���
            - INSERT, UPDATE, DELETE�� ���� ���
    2) ����
        - ���� : CREATE INDEX �ε����� 
                ON ���̺��(�÷��� ASC|DESC..)
        - ���� : ALTER INDEX �ε�����
                [ON ���̺��(�÷���)] 
                REBUILD
        - ���� : DROP INDEX �ε�����
        - ����
            ORDER BY : ��Ʈ, ����
            SELECT /*+ INDEX_ASC(���̺�� �⺻Ű) * / �÷���.. FROM ���̺��
                       INDEX_DESC(���̺�� PK)
            SELECT * FROM ���̺�� WHERE �ε����� �÷��� ����
*/
SELECT rowid,ename FROM emp;

CREATE INDEX idx_emp_ename ON emp(ename DESC);
SELECT * FROM emp;
SELECT * FROM emp WHERE ename>='H';

CREATE INDEX idx_emp_sal ON emp(sal);
SELECT * FROM emp WHERE sal>0;

SELECT title FROM seoul_hotel ORDER BY title;
SELECT /*+ INDEX_ASC(seoul_hotel sh_no_pk) */ title FROM seoul_hotel;

CREATE INDEX idx_sh_title ON seoul_hotel(title);
SELECT title FROM seoul_hotel WHERE title>='A';

DROP INDEX idx_emp_ename;
DROP INDEX idx_emp_sal;
DROP INDEX idx_sh_title;