/*
3. SEQUENCE : 자동 증가번호
    - 중간 번호 삭제 시 번호 수정 없음, 무조건 증가
    - 수정/삭제 시 문제 발생 방지 위함(중복 번호 없도록 설정)
        cf. 중복 불가한 데이터
            : 테이블명, 컬럼명, 뷰명, 시퀀스명, 제약조건명
    - 게시물 번호, 댓글 번호, 장바구니 갯수 등
    - MAXVALUE : 최종값
    - MINVALUE : 시작값
    - START WITH : 시작 위치 설정
        ex. START WITH 100 -> 100부터 시작
    - INCREMENT BY : 증가 간격 설정
        ex. INCREMENT BY 1 -> 1씩 증가
    - CACHE / NOCACHE
        - 주로 NOCACHE 사용
        - CACHE : 미리 일정 범위 번호 저장 후 설정
    - CYCLE / NOCYCLE
        - 주로 NOCYCLE 사용
        - CYCLE : 설정된 범위가 모두 사용되었을 경우 다시 처음부터 시작
    - 현재값 읽기 : CURRVAL
      다음값 읽기 : NEXTVAL
    - 사용방법
        - 생성
            CREATE SEQUENCE seq_name
            START WITH num
            INCREMENT BY num
            NOCACHE
            NOCYCLE
        - 삭제 : DROP SEQUENCE seq_name
        cf. 시퀀스 구분(이름주기) : 테이블명_컬럼명_seq;
        
cf. 데이터 정형화
    - 정형화된 데이터 : 프로그램에서 필요한 데이터만 저장
        ex. RDBMS(오라클, MySQL)
    - 반정형화된 데이터 : 불필요한 데이터 포함, 구분되어있음
        ex. HTML, XML, JSON
    - 비정형화된 데이터 : 불필요한 데이터 포함, 구분 없음
        ex. 트위터, 페이스북
        
4. SYNONYM : 테이블의 별칭
    - 보안 목적
    - 생성 : CREATE SYNONYM 별칭명
             FOR 테이블명
    - 삭제 : DROP SYNONYM 별칭명
*/
//CREATE SEQUENCE test_no_seq
//    START WITH 1
//    INCREMENT BY 1
//    NOCACHE
//    NOCYCLE;
//SELECT test_no_seq.NEXTVAL FROM DUAL;
//SELECT test_no_seq.CURRVAL FROM DUAL;
//
//DROP SEQUENCE test_no_seq;
//
//CREATE TABLE board(
//    no NUMBER,
//    name VARCHAR2(34) CONSTRAINT board_name_nn NOT NULL,
//    subject VARCHAR2(4000) CONSTRAINT board_sub_nn NOT NULL,
//    content CLOB CONSTRAINT board_cont_nn NOT NULL,
//    pwd VARCHAR2(10) CONSTRAINT board_pwd_nn NOT NULL,
//    regdate DATE DEFAULT SYSDATE,
//    hit NUMBER DEFAULT 0,
//    CONSTRAINT board_no_pk PRIMARY KEY(no)
//);
//CREATE SEQUENCE board_no_seq
//    START WITH 1
//    INCREMENT BY 1
//    NOCACHE
//    NOCYCLE;
//INSERT INTO board(no,name,subject,content,pwd)
//VALUES(board_no_seq.NEXTVAL,'홍길동','시퀀스..','시퀀스 사용 방법..','1234');
//INSERT INTO board(no,name,subject,content,pwd)
//VALUES(board_no_seq.NEXTVAL,'홍길동','시퀀스..','시퀀스 사용 방법..','1234');
//INSERT INTO board(no,name,subject,content,pwd)
//VALUES(board_no_seq.NEXTVAL,'홍길동','시퀀스..','시퀀스 사용 방법..','1234');
//INSERT INTO board(no,name,subject,content,pwd)
//VALUES(board_no_seq.NEXTVAL,'홍길동','시퀀스..','시퀀스 사용 방법..','1234');
//INSERT INTO board(no,name,subject,content,pwd)
//VALUES(board_no_seq.NEXTVAL,'홍길동','시퀀스..','시퀀스 사용 방법..','1234');
//INSERT INTO board(no,name,subject,content,pwd)
//VALUES(board_no_seq.NEXTVAL,'홍길동','시퀀스..','시퀀스 사용 방법..','1234');
//COMMIT;
//SELECT * FROM board;
//DELETE FROM board WHERE no=3;
//
//CREATE TABLE notice(
//    no NUMBER,
//    name VARCHAR2(34) CONSTRAINT notice_name_nn NOT NULL,
//    msg CLOB CONSTRAINT notice_msg_nn NOT NULL,
//    CONSTRAINT notice_no_pk PRIMARY KEY(no)
//);
//CREATE SEQUENCE notice_no_seq
//    START WITH 1
//    INCREMENT BY 1
//    NOCACHE
//    NOCYCLE;
//INSERT INTO notice VALUES(notice_no_seq.NEXTVAL,'홍길동','공지사항');
//INSERT INTO notice VALUES(notice_no_seq.NEXTVAL,'홍길동','공지사항');
//INSERT INTO notice VALUES(notice_no_seq.NEXTVAL,'홍길동','공지사항');
//INSERT INTO notice VALUES(notice_no_seq.NEXTVAL,'홍길동','공지사항');
//INSERT INTO notice VALUES(notice_no_seq.NEXTVAL,'홍길동','공지사항');
//COMMIT;
//	--SYNONYM
//SELECT * FROM notice;
//CREATE SYNONYM 사원정보
//FOR emp;
//
//SELECT * FROM 사원정보;
public class 시퀀스 {

}
