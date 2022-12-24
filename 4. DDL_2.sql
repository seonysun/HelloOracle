/*   
판매전표;
    컬럼명    전표번호   판매일자   고객명     총액
    제약조건     pk        nn       nn       ck     
                       default
    참조테이블
    참조컬럼
    데이터형  VARCHAR2    DATE   VARCHAR2  NUMBER
    크기        13                 34
    체크                                    >0
*/
CREATE TABLE 판매전표(
    전표번호 VARCHAR2(13),
    판매일자 DATE CONSTRAINT 판매전표_판매일자_nn NOT NULL,
    고객명 VARCHAR2(34) CONSTRAINT 판매전표_고객명_nn NOT NULL,
    총액 NUMBER,
    CONSTRAINT 판매전표_전표번호_pk PRIMARY KEY(전표번호),
    CONSTRAINT 판매전표_총액_ck CHECK(총액>0)
);
ALTER TABLE 판매전표 MODIFY 판매일자 DEFAULT SYSDATE;
/*
제품;
    컬럼명    제품번호    제품명    제품단가
    제약조건     pk       nn        ck   
    참조테이블
    참조컬럼
    데이터형  VARCHAR2  VARCHAR2  NUMBER
    크기        13       100
    체크                           >0
*/
CREATE TABLE 제품(
    제품번호 VARCHAR2(13),
    제품명 VARCHAR2(100) CONSTRAINT 제품_제품명_nn NOT NULL,
    제품단가 NUMBER,
    CONSTRAINT 제품_제품번호_pk PRIMARY KEY(제품번호),
    CONSTRAINT 제품_제품번호_ck CHECK(제품단가>0)
);
/*
전표상세;
    컬럼명    전표번호   제품번호    수량     단가     금액
    제약조건   pk/fk       fk       nn      nn       ck
    참조테이블 판매전표     제품
    참조컬럼   전표번호   제품번호
    데이터형  VARCHAR2  VARCHAR2  NUMBER   NUMBER  NUMBER
    크기        13         13
    체크                                            >0
*/
CREATE TABLE 전표상세(
    전표번호 VARCHAR2(13),
    제품번호 VARCHAR2(13),
    수량 NUMBER CONSTRAINT 전표상세_수량_nn NOT NULL,
    단가 NUMBER CONSTRAINT 전표상세_단가_nn NOT NULL,
    금액 NUMBER,
    CONSTRAINT 전표상세_전표번호_pk PRIMARY KEY(전표번호),
    CONSTRAINT 전표상세_금액_ck CHECK(금액>0),
    CONSTRAINT 전표상세_전표번호_fk FOREIGN KEY(전표번호)
    REFERENCES 판매전표(전표번호) ON DELETE CASCADE,
    CONSTRAINT 전표상세_제품번호_fk FOREIGN KEY(제품번호)
    REFERENCES 제품(제품번호) ON DELETE CASCADE
);

-- 테이블 제약조건 확인
SELECT * FROM user_constraints
WHERE table_name='판매전표';
/*
- CONSTRAINT TYPE
    C : CHECK, NOT NULL
    P : PRIMARY KEY
    R : FOREIGN KEY
    U : UNIQUE
*/

DROP TABLE 전표상세;
    -- FOREIGN KEY를 가진 테이블 먼저 삭제해야 함(생성 순서는 반대)
    -- ON DELETE CASCADE 주면 삭제 시 연결 X -> 삭제 순서 상관 없음
DROP TABLE 판매전표;
DROP TABLE 제품;

CREATE TABLE 판매전표(
    전표번호 VARCHAR2(13),
    판매일자 DATE,
    고객명 VARCHAR2(34),
    총액 NUMBER
);
ALTER TABLE 판매전표 ADD CONSTRAINT 판매전표_전표번호_pk PRIMARY KEY(전표번호);
ALTER TABLE 판매전표 MODIFY 판매일자 DATE CONSTRAINT 판매전표_판매일자_nn NOT NULL;
ALTER TABLE 판매전표 MODIFY 고객명 DATE CONSTRAINT 판매전표_고객명_nn NOT NULL;
ALTER TABLE 판매전표 ADD CONSTRAINT 판매전표_총액_ck CHECK(총액>0);

CREATE TABLE 제품(
    제품번호 VARCHAR2(13),
    제품명 VARCHAR2(100),
    제품단가 NUMBER
);
ALTER TABLE 제품 ADD CONSTRAINT 제품_제품번호_PK PRIMARY KEY(제품번호);
ALTER TABLE 제품 ADD CONSTRAINT 제품_제품명_uk UNIQUE(제품명);
ALTER TABLE 제품 ADD CONSTRAINT 제품_제품단가_ck CHECK(제품단가>0);

CREATE TABLE 전표상세(
    전표번호 VARCHAR2(13),
    제품번호 VARCHAR2(13),
    수량 NUMBER,
    단가 NUMBER,
    금액 NUMBER
);
ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_전표번호_PK PRIMARY KEY(전표번호);
ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_전표번호_FK FOREIGN KEY(전표번호)
REFERENCES 판매전표(전표번호);
ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_제품번호_FK FOREIGN KEY(제품번호)
REFERENCES 제품(제품번호);
ALTER TABLE 전표상세 MODIFY 수량 CONSTRAINT 전표상세_수량_nn NOT NULL;
ALTER TABLE 전표상세 MODIFY 단가 CONSTRAINT 전표상세_단가_nn NOT NULL;
ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_금액_ck CHECK(금액>0);

CREATE TABLE student(
    hakbun NUMBER,
    name VARCHAR2(34) CONSTRAINT std_name_nn NOT NULL,
    CONSTRAINT std_hakbun_pk PRIMARY KEY(hakbun)
);
ALTER TABLE student ADD kor NUMBER DEFAULT 0;
ALTER TABLE student ADD eng NUMBER DEFAULT 0;
ALTER TABLE student ADD math NUMBER DEFAULT 0;
ALTER TABLE student MODIFY math CONSTRAINT stu_math_nn NOT NULL;
ALTER TABLE student ADD avg NUMBER NOT NULL;
ALTER TABLE student MODIFY avg NUMBER(5,2);
DESC STUDENT;