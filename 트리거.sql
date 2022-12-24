/*
3. Trigger : 자동 이벤트 처리
    - 미리 설정된 조건에 맞는 경우 저장된 문장 실행
    - INSERT, UPDATE, DELETE에서만 사용 가능
        ex. 입고/출고(INSERT) -> 재고수량 자동반영
    - AutoCOMMIT -> 커밋 추가 시 오류
    - 오라클 자체에서 실행 -> 자바에서 호출하지 않음 -> 매개변수 없음
    - 형식
        CREATE [OR REPLACE] TRIGGER tri_name
        BEFORE|AFTER INSERT|UPDATE|DELETE ON 테이블명
        FOR EACH ROW
        DECLARE
            변수 선언(생략 가능)
        BEGIN 
            구현부
        END;
        /
    - 수정 : ALTER TRIGGER tri_name
        - 사용 빈도 적음(OR REPLACE로 주로 사용)
    - 삭제 : DROP TRIGGER tri_name
*/
CREATE TABLE 상품(
    품번 NUMBER,
    상품명 VARCHAR2(20),
    단가 NUMBER
);
CREATE TABLE 입고(
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER
);
CREATE TABLE 출고(
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER
);
CREATE TABLE 재고(
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER,
    누적금액 NUMBER
);
INSERT INTO 상품 VALUES(100,'새우깡',1500);
INSERT INTO 상품 VALUES(200,'감자깡',1000);
INSERT INTO 상품 VALUES(300,'맛동산',2000);
INSERT INTO 상품 VALUES(400,'짱구',700);
INSERT INTO 상품 VALUES(500,'고구마깡',1300);
COMMIT;
/*
테이블에 데이터 입력(INSERT,UPDATE,DELETE)할 때
    -> :NEW.컬럼명
테이블에 기존에 저장된 데이터 가져올 때
    -> :OLD.컬럼명

<입출고시 재고 관리>
입고
    재고=0 INSERT
    재고>0 UPDATE
출고
    수량=0 DELETE
    수량>0 UPDATE
*/
CREATE OR REPLACE TRIGGER input_trigger
AFTER INSERT ON 입고
FOR EACH ROW
DECLARE
    v_cnt NUMBER:=0;
BEGIN
    SELECT COUNT(*) INTO v_cnt
    FROM 재고
    WHERE 품번=:NEW.품번;
    
    IF v_cnt=0 THEN
        INSERT INTO 재고 VALUES(:NEW.품번,:NEW.수량,:NEW.금액,:NEW.수량*:NEW.금액);
    ELSE 
        UPDATE 재고 SET
        수량=수량+:NEW.수량,
        누적금액=누적금액+(:NEW.수량*:NEW.금액)
        WHERE 품번=:NEW.품번;
    END IF;
END;
/

INSERT INTO 입고 VALUES(100,3,1500);
SELECT * FROM 입고;
SELECT * FROM 재고;

CREATE OR REPLACE TRIGGER output_trigger
AFTER INSERT ON 출고
FOR EACH ROW
DECLARE
    v_cnt NUMBER:=0;
BEGIN
    SELECT 수량 INTO v_cnt
    FROM 재고
    WHERE 품번=:NEW.품번;
    
    IF :NEW.수량=v_cnt THEN
        DELETE FROM 재고
        WHERE 품번=:NEW.품번;
    ELSE
        UPDATE 재고 SET
        수량=수량-:NEW.수량,
        누적금액=누적금액-(:NEW.수량*:NEW.금액)
        WHERE 품번=:NEW.품번;
    END IF;
END;
/