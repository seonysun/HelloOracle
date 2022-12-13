/*
0. 테이블 설계
    - 개념설계 : 데이터 추출
    - 논리설계 : 데이터형 설정
    - 물리설계 : 메모리 크기 설정
    
1. 릴레이션(테이블) : 관련된 데이터 모아둔 곳
    - 2차원 구조로 구성 -> 컬럼(열) + row(행)
    - 특징
        - 컬럼은 단일값 가짐, 도메인 동일, 순서 없음, 중복 불가
            cf. 도메인 : 컬럼이 가질 수 있는 데이터 집합 ex. 1보다 큰 정수 집합
        - 데이터(투플) 순서 없음, 중복 불가
    - 정규화 : 여러개의 테이블을 세분화하여 제작 -> 중복 최소화
    1) 테이블명(식별자)
        - 같은 데이터베이스에서 테이블 이름 중복 불가
        - 문자로 시작, 키워드 사용 불가, 숫자/특수문자(_) 가능
            cf. 운영체제마다 한글 읽는 방식 다름
        - 실제 오라클에 저장될 때 대문자로 저장(*) -> 테이블 형식 읽을 때 대문자 필수
            ex. WHERE table_name='EMP'
    2) 제약조건
        - 이상 현상(원하지 않는 데이터가 수정, 삭제되는 경우) 방지
            -> 신뢰도 유지된(무결성) 데이터 저장
        - 필요에 따라 여러 개 사용 가능
        - 형식 : 컬럼명 CONSTRAINT 제약조건
        (1) NOT NULL : NULL 불가
            - 필수 입력 데이터
        (2) 키 : 테이블에서 row 식별할 때 사용하는 속성
            - UNIQUE : 유일값, 후보키(대체키)
                - row 식별 가능하게 하는 키 ex. email, tel
                - 중복 없는 데이터, NULL 허용
            - PRIMARY KEY : 기본키
                - 여러 후보키 중 대표 ex. ID
                - NOT NULL + UNIQUE 
                    -> 중복 없는 데이터, NULL 불가
                    -> 대부분 숫자로 저장, 자동 증가되도록 설정
                - 모든 테이블에서 한 개 이상 포함(무결성의 원칙)
                    cf. 무결성 : 데이터의 일관성, 정확성 유지하는 것
                - 여러개로 설정은 가능하나 권장하지 않음(제어 어려움)
            - FOREIGN KEY : 참조키, 외래키
                - 다른 테이블의 기본키(도메인 동일)를 참조
                - 자기 자신의 기본키 참조도 가능
                - NULL, 중복 허용
                - 게시판의 댓글, 영화의 리뷰
        (3) CHECK : 지정된 데이터값만 입력 가능
            ex. 부서명, 근무지, 성별
        (4) DEFAULT : 미리 기본값 설정 후 데이터값이 없는 경우 자동으로 값 입력
            - 정확하게는 제약조건은 아님 -> CONSTRAINT 사용하지 않음
    3) 관계연산 : 테이블 간 연산

2. CREATE : 테이블의 구조 생성
    - CREATE TABLE table_name : 파일
    - CREATE VIEW view_name : 가상 테이블(읽기 전용)
    - CREATE INDEX index_name : ORDER BY -> 속도 최적화
    - CREATE SEQUENCE seq_name : 자동 증가번호
    - CREATE FUNCTION func_name : 리턴형이 있는 함수(내장함수)
    - CREATE PROCEDURE proc_name : 리턴형이 없는 함수(기능 가진 함수) PL/SQL(*)
    - CREATE TRIGGER trig_name : 이벤트(자동화 처리)
    - AUTO COMMIT 
        -> COMMIT 테이블 생성시 불필요, 데이터가 들어갈 때만 필요
    1) 기존 테이블 복사
        - CREATE TABLE table_name
          AS
          SELECT
    2) 테이블 형태만 복사
        - CREATE TABLE table_name
          AS
          SELECT
          WHERE 1=2;(false 조건)
    3) 사용자 정의
        - CREATE TABLE table_name
            컬럼명 데이터형 [제약조건], ..
                            //컬럼레벨(컬럼과 동시에 생성)
            [제약조건]
              //테이블레벨(테이블 생성 후 생성)
        - 보통 NOT NULL, DEFAULT만 컬럼레벨로 제시, 나머지 테이블레벨로 제시
        - 제약조건 이름 중복 불가(다른 테이블 간에도 중복 불가)
            -> '테이블명_컬럼명_제약조건약자'로 표기
            -> 제약조건 약자 : nn, pk, uk, fk, ck
            cf. 제약조건 이름을 설정해야 이후 수정, 삭제 등 관리 용이하므로 주로 사용
        ex. CREATE TABLE member(
                id VARCHAR2(20) PRIMARY KEY,
                pwd VARCHAR2(10) NOT NULL,
                name VARCHAR2(34) NOT NULL,
                sex CHAR(10) CHECK(sex IN('남자','여자')),
                email VARCHAR2(100) UNIQUE,
                tel VARCHAR2(13) UNIQUE,
                regdate DATE DEFAULT SYSDATE
            );
        ex. CREATE TABLE member(
                id VARCHAR2(20),
                pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL
                name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
                sex CHAR(10),
                email VARCHAR2(100),
                tel VARCHAR2(13),
                regdate DATE DEFAULT SYSDATE,
                CONSTRAINT member_id_pk PRIMARY KEY(id),
                CONSTRAINT member_sex_ck CHECK(IN('남자','여자')),
                CONSTRAINT member_et_uk UNIQUE(email,tel)
            );     

3. ALTER : 컬럼 수정, 삭제, 추가, 제약조건 변경
    - 생성된 테이블에서 수정사항 있을 때 이미 실행된 CREATE절 수정할 수 없음 
        -> DROP 후 재생성 / ALTER 사용
    - 컬럼 추가 ADD
    - 컬럼 삭제 DROP COLUMN
    - 컬럼 수정 MODIFY, RENAME COLUMN
    - 컬럼 제약조건 수정
        - 데이터가 있는 경우 NOT NULL 등의 제약조건 포함한 컬럼 추가 불가
            -> 데이터 수집 전 테이블 반드시 확인
            -> default값 설정으로 NOT NULL 오류 방지
        - 제약조건 추가
            ADD : PRIMARY KEY, UNIQUE, FOREIGN KEY, CHECK
            MODIFY : NOT NULL, DEFAULT
        - 제약조건 삭제
            DROP 컬럼명 CONSTRAINT

4. DROP : 테이블 완전 삭제
5. TRUNCATE : 테이블만 유지, 데이터 잘라내기
*/
//    --테이블 전체복사
//CREATE TABLE myEmp
//AS
//SELECT * FROM emp;
//
//SELECT * FROM myEmp;
//DESC myEmp;
//--테이블 전체삭제
//DROP TABLE myEmp;
//    --테이블 형태만 복사
//CREATE TABLE myEmp2
//AS
//SELECT * FROM emp
//WHERE 1=2;
//
//SELECT * FROM myEmp2;
//DROP TABLE myEmp2;
//    --조인 형태 복사
//CREATE TABLE myEmp
//AS
//SELECT Emp.*,dname,loc
//FROM emp,dept
//WHERE emp.deptno=dept.deptno;
//
//SELECT * FROM myEmp;
//DESC myEmp;
//--데이터만 삭제
//--DELETE는 DML이므로 복구 가능, TRUNCATE,DROP은 DDL이므로 복구 불가
//TRUNCATE TABLE myEMP;
//--테이블명 변경
//RENAME myEmp TO myEmp2;
//DROP TABLE myEmp2;
///*
//게시판;
//    게시물 번호 : PK(중복 없음 -> 자동 증가), NUMBER
//    이름 : NOT NULL, VARCHAR2
//    제목 : NOT NULL, VARCHAR2
//    내용 : NOT NULL, CLOB
//    비밀번호 : NOT NULL
//    등록일 : DEFAULT(SYSDATE)
//    조회수 : DAFAULE(0)
//    -------------------------------------------------------------------
//    컬럼명     no    name    subject  content    pwd     regdate    hit
//    제약조건   pk     nn        nn       nn       nn     default  default
//    참조테이블
//    참조컬럼
//    데이터형 NUMBER VARCHAR2 VARCHAR2   CLOB   VARCHAR2   DATE     NUMBER
//    크기       8     34       4000                10
//    체크
//*/
//DROP TABLE board;
//CREATE TABLE board(
//    no NUMBER,
//    name VARCHAR2(34) CONSTRAINT board_name_nn NOT NULL,
//    subject VARCHAR2(4)CONSTRAINT board_subject_nn NOT NULL,
//    content CLOB CONSTRAINT board_content_nn NOT NULL,
//    pwd VARCHAR2(10) CONSTRAINT board_pwd_nn NOT NULL,
//    regdate DATE DEFAULT SYSDATE,
//    address VARCHAR2(100),
//    CONSTRAINT board_no_pk PRIMARY KEY(no)
//    );
//ALTER TABLE board ADD hit NUMBER DEFAULT 0;
//ALTER TABLE board MODIFY subject VARCHAR2(4000);
//ALTER TABLE board DROP COLUMN address;
//ALTER TABLE board MODIFY address VARCHAR2(100) CONSTRAINT board_address_nn NOT NULL;
//ALTER TABLE board RENAME COLUMN address TO email;
//DESC board;
///*
//회원가입;
//    id pk
//    pwd nn
//    sex check
//    name nn
//    address 
//    tel
//*/
//SELECT * FROM tab;
//CREATE TABLE member(
//    id VARCHAR2(20),
//    pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL,
//    sex VARCHAR2(6),
//    name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
//    CONSTRAINT member_id_pk PRIMARY KEY(id),
//    CONSTRAINT member_sex_ck CHECK(sex IN('남자','여자'))
//);
//INSERT INTO member VALUES('bbb',' ','남자','홍길동');
//    -- NOT NULL에서 공백은 가능
//SELECT * FROM member;
//ALTER TABLE member ADD address VARCHAR2(100) DEFAULT ' ' CONSTRAINT member_address_nn NOT NULL;
//    -- 데이터가 이미 있는 상태이므로 NOT NULL인 컬럼 추가 불가 -> default 처리
//--테이블 생성 후 제약조건 추가
//DROP TABLE board;
//CREATE TABLE board(
//    no NUMBER,
//    name VARCHAR2(34),
//    subject VARCHAR2(4000),
//    content CLOB,
//    pwd VARCHAR2(10),
//    regdate DATE,
//    address VARCHAR2(100)
//    );
//DESC board;
//ALTER TABLE board ADD CONSTRAINT board_no_pk PRIMARY KEY(no);
//ALTER TABLE board MODIFY name CONSTRAINT board_name_nn NOT NULL;
//ALTER TABLE board DROP CONSTRAINT board_name_nn;
//ALTER TABLE board MODIFY regdate DATE DEFAULT SYSDATE;
//--primary key
//DROP TABLE member;
//CREATE TABLE member(
//    id VARCHAR2(20),
//    name VARCHAR2(30),
//    email VARCHAR2(100),
//    pwd VARCHAR2(10)
//);
//INSERT INTO member VALUES('aaa','hong','','1234');
//SELECT * FROM member;
//DELETE FROM member WHERE id='aaa';
//
//CREATE TABLE member(
//    id VARCHAR2(20),
//    pwd VARCHAR2(10) CONSTRAINT member_pwd_nn NOT NULL,
//    email VARCHAR2(100),
//    name VARCHAR2(34) CONSTRAINT member_name_nn NOT NULL,
//    CONSTRAINT member_ie_pk PRIMARY KEY(id,email)
//);
//INSERT INTO member VALUES('aaa','hong','hong@co.kr','1234');
//INSERT INTO member VALUES('aaa','shim','shim@co.kr','1234');
//    --기본키 2개 잡을 경우 둘 중 하나만 달라도 입력 가능 -> 제어 어려움
//INSERT INTO member VALUES('bbb','park','park@co.kr','1234');
//INSERT INTO member VALUES('ccc','kim','kim@co.kr','1234');
//SELECT * FROM member;
///*
//판매전표;
//    컬럼명    전표번호   판매일자   고객명     총액
//    제약조건     pk        nn       nn       ck     
//                       default
//    참조테이블
//    참조컬럼
//    데이터형  VARCHAR2    DATE   VARCHAR2  NUMBER
//    크기        13                 34
//    체크                                    >0
//*/
//CREATE TABLE 판매전표(
//    전표번호 VARCHAR2(13),
//    판매일자 DATE CONSTRAINT 판매전표_판매일자_nn NOT NULL,
//    고객명 VARCHAR2(34) CONSTRAINT 판매전표_고객명_nn NOT NULL,
//    총액 NUMBER,
//    CONSTRAINT 판매전표_전표번호_pk PRIMARY KEY(전표번호),
//    CONSTRAINT 판매전표_총액_ck CHECK(총액>0)
//);
//ALTER TABLE 판매전표 MODIFY 판매일자 DEFAULT SYSDATE;
///*
//제품;
//    컬럼명    제품번호    제품명    제품단가
//    제약조건     pk       nn        ck   
//    참조테이블
//    참조컬럼
//    데이터형  VARCHAR2  VARCHAR2  NUMBER
//    크기        13       100
//    체크                           >0
//*/
//CREATE TABLE 제품(
//    제품번호 VARCHAR2(13),
//    제품명 VARCHAR2(100) CONSTRAINT 제품_제품명_nn NOT NULL,
//    제품단가 NUMBER,
//    CONSTRAINT 제품_제품번호_pk PRIMARY KEY(제품번호),
//    CONSTRAINT 제품_제품번호_ck CHECK(제품단가>0)
//);
///*
//전표상세;
//    컬럼명    전표번호   제품번호    수량     단가     금액
//    제약조건   pk/fk       fk       nn      nn       ck
//    참조테이블 판매전표     제품
//    참조컬럼   전표번호   제품번호
//    데이터형  VARCHAR2  VARCHAR2  NUMBER   NUMBER  NUMBER
//    크기        13         13
//    체크                                            >0
//*/
//CREATE TABLE 전표상세(
//    전표번호 VARCHAR2(13),
//    제품번호 VARCHAR2(13),
//    수량 NUMBER CONSTRAINT 전표상세_수량_nn NOT NULL,
//    단가 NUMBER CONSTRAINT 전표상세_단가_nn NOT NULL,
//    금액 NUMBER,
//    CONSTRAINT 전표상세_전표번호_pk PRIMARY KEY(전표번호),
//    CONSTRAINT 전표상세_금액_ck CHECK(금액>0),
//    CONSTRAINT 전표상세_전표번호_fk FOREIGN KEY(전표번호)
//    REFERENCES 판매전표(전표번호) ON DELETE CASCADE,
//    CONSTRAINT 전표상세_제품번호_fk FOREIGN KEY(제품번호)
//    REFERENCES 제품(제품번호) ON DELETE CASCADE
//);
//
//-- 테이블 제약조건 확인
//SELECT * FROM user_constraints
//WHERE table_name='판매전표';
///*
//- CONSTRAINT TYPE
//    C : CHECK, NOT NULL
//    P : PRIMARY KEY
//    R : FOREIGN KEY
//    U : UNIQUE
//*/
//
//DROP TABLE 전표상세;
//    -- FOREIGN KEY를 가진 테이블 먼저 삭제해야 함(생성 순서는 반대)
//    -- ON DELETE CASCADE 주면 삭제 시 연결 X -> 삭제 순서 상관 없음
//DROP TABLE 판매전표;
//DROP TABLE 제품;
//
//CREATE TABLE 판매전표(
//    전표번호 VARCHAR2(13),
//    판매일자 DATE,
//    고객명 VARCHAR2(34),
//    총액 NUMBER
//);
//ALTER TABLE 판매전표 ADD CONSTRAINT 판매전표_전표번호_pk PRIMARY KEY(전표번호);
//ALTER TABLE 판매전표 MODIFY 판매일자 DATE CONSTRAINT 판매전표_판매일자_nn NOT NULL;
//ALTER TABLE 판매전표 MODIFY 고객명 DATE CONSTRAINT 판매전표_고객명_nn NOT NULL;
//ALTER TABLE 판매전표 ADD CONSTRAINT 판매전표_총액_ck CHECK(총액>0);
//
//CREATE TABLE 제품(
//    제품번호 VARCHAR2(13),
//    제품명 VARCHAR2(100),
//    제품단가 NUMBER
//);
//ALTER TABLE 제품 ADD CONSTRAINT 제품_제품번호_PK PRIMARY KEY(제품번호);
//ALTER TABLE 제품 ADD CONSTRAINT 제품_제품명_uk UNIQUE(제품명);
//ALTER TABLE 제품 ADD CONSTRAINT 제품_제품단가_ck CHECK(제품단가>0);
//
//CREATE TABLE 전표상세(
//    전표번호 VARCHAR2(13),
//    제품번호 VARCHAR2(13),
//    수량 NUMBER,
//    단가 NUMBER,
//    금액 NUMBER
//);
//ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_전표번호_PK PRIMARY KEY(전표번호);
//ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_전표번호_FK FOREIGN KEY(전표번호)
//REFERENCES 판매전표(전표번호);
//ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_제품번호_FK FOREIGN KEY(제품번호)
//REFERENCES 제품(제품번호);
//ALTER TABLE 전표상세 MODIFY 수량 CONSTRAINT 전표상세_수량_nn NOT NULL;
//ALTER TABLE 전표상세 MODIFY 단가 CONSTRAINT 전표상세_단가_nn NOT NULL;
//ALTER TABLE 전표상세 ADD CONSTRAINT 전표상세_금액_ck CHECK(금액>0);
//
//CREATE TABLE student(
//    hakbun NUMBER,
//    name VARCHAR2(34) CONSTRAINT std_name_nn NOT NULL,
//    CONSTRAINT std_hakbun_pk PRIMARY KEY(hakbun)
//);
//ALTER TABLE student ADD kor NUMBER DEFAULT 0;
//ALTER TABLE student ADD eng NUMBER DEFAULT 0;
//ALTER TABLE student ADD math NUMBER DEFAULT 0;
//ALTER TABLE student MODIFY math CONSTRAINT stu_math_nn NOT NULL;
//ALTER TABLE student ADD avg NUMBER NOT NULL;
//ALTER TABLE student MODIFY avg NUMBER(5,2);
//DESC STUDENT;
public class DDL {

}
