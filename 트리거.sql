/*
3. Trigger : �ڵ� �̺�Ʈ ó��
    - �̸� ������ ���ǿ� �´� ��� ����� ���� ����
    - INSERT, UPDATE, DELETE������ ��� ����
        ex. �԰�/���(INSERT) -> ������ �ڵ��ݿ�
    - AutoCOMMIT -> Ŀ�� �߰� �� ����
    - ����Ŭ ��ü���� ���� -> �ڹٿ��� ȣ������ ���� -> �Ű����� ����
    - ����
        CREATE [OR REPLACE] TRIGGER tri_name
        BEFORE|AFTER INSERT|UPDATE|DELETE ON ���̺��
        FOR EACH ROW
        DECLARE
            ���� ����(���� ����)
        BEGIN 
            ������
        END;
        /
    - ���� : ALTER TRIGGER tri_name
        - ��� �� ����(OR REPLACE�� �ַ� ���)
    - ���� : DROP TRIGGER tri_name
*/
CREATE TABLE ��ǰ(
    ǰ�� NUMBER,
    ��ǰ�� VARCHAR2(20),
    �ܰ� NUMBER
);
CREATE TABLE �԰�(
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER
);
CREATE TABLE ���(
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER
);
CREATE TABLE ���(
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER,
    �����ݾ� NUMBER
);
INSERT INTO ��ǰ VALUES(100,'�����',1500);
INSERT INTO ��ǰ VALUES(200,'���ڱ�',1000);
INSERT INTO ��ǰ VALUES(300,'������',2000);
INSERT INTO ��ǰ VALUES(400,'¯��',700);
INSERT INTO ��ǰ VALUES(500,'������',1300);
COMMIT;
/*
���̺� ������ �Է�(INSERT,UPDATE,DELETE)�� ��
    -> :NEW.�÷���
���̺� ������ ����� ������ ������ ��
    -> :OLD.�÷���

<������ ��� ����>
�԰�
    ���=0 INSERT
    ���>0 UPDATE
���
    ����=0 DELETE
    ����>0 UPDATE
*/
CREATE OR REPLACE TRIGGER input_trigger
AFTER INSERT ON �԰�
FOR EACH ROW
DECLARE
    v_cnt NUMBER:=0;
BEGIN
    SELECT COUNT(*) INTO v_cnt
    FROM ���
    WHERE ǰ��=:NEW.ǰ��;
    
    IF v_cnt=0 THEN
        INSERT INTO ��� VALUES(:NEW.ǰ��,:NEW.����,:NEW.�ݾ�,:NEW.����*:NEW.�ݾ�);
    ELSE 
        UPDATE ��� SET
        ����=����+:NEW.����,
        �����ݾ�=�����ݾ�+(:NEW.����*:NEW.�ݾ�)
        WHERE ǰ��=:NEW.ǰ��;
    END IF;
END;
/

INSERT INTO �԰� VALUES(100,3,1500);
SELECT * FROM �԰�;
SELECT * FROM ���;

CREATE OR REPLACE TRIGGER output_trigger
AFTER INSERT ON ���
FOR EACH ROW
DECLARE
    v_cnt NUMBER:=0;
BEGIN
    SELECT ���� INTO v_cnt
    FROM ���
    WHERE ǰ��=:NEW.ǰ��;
    
    IF :NEW.����=v_cnt THEN
        DELETE FROM ���
        WHERE ǰ��=:NEW.ǰ��;
    ELSE
        UPDATE ��� SET
        ����=����-:NEW.����,
        �����ݾ�=�����ݾ�-(:NEW.����*:NEW.�ݾ�)
        WHERE ǰ��=:NEW.ǰ��;
    END IF;
END;
/