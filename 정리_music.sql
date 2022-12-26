/*
0. 오라클 정보 저장
    - 테이블 : user_tables
    - 제약조건 : user_constraints
    - 뷰 : user_views
    - 모든 요소 대문자로 저장되어있으므로 검색 시 대문자 주의

지니뮤직; 멜론뮤직;
 구분자 PK(정수)
 //순위
 등폭
 포스터
 제목
 가수명
 앨범명
 카테고리
 키(링크)
 조회수
*/
CREATE TABLE genie_music(
    mno NUMBER,
    cno NUMBER(2) CONSTRAINT gm_cno_nn NOT NULL,
    title VARCHAR2(200) CONSTRAINT gm_title_nn NOT NULL,
    singer VARCHAR2(100) CONSTRAINT gm_singer_nn NOT NULL,
    album VARCHAR2(200) CONSTRAINT gm_album_nn NOT NULL,
    poster VARCHAR2(260) CONSTRAINT gm_poster_nn NOT NULL,
    state VARCHAR2(30),
    idcrement NUMBER(3) CONSTRAINT gm_idcre_nn NOT NULL,
    key VARCHAR2(30),
    hit NUMBER DEFAULT 0,
    CONSTRAINT gm_mno_pk PRIMARY KEY(MNO),
    CONSTRAINT gm_state_ck CHECK(state IN('유지','상승','하강'))
);
ALTER TABLE genie_music ADD liked NUMBER;
ALTER TABLE genie_music ADD jjim NUMBER;
ALTER TABLE genie_music MODIFY liked DEFAULT 0 CONSTRAINT gm_liked_nn NOT NULL;
ALTER TABLE genie_music MODIFY jjim DEFAULT 0 CONSTRAINT gm_jjim_nn NOT NULL;

DROP TABLE genie_music;

CREATE TABLE melon_music(
    mno NUMBER,
    cno NUMBER(2) CONSTRAINT mm_cno_nn NOT NULL,
    title VARCHAR2(200) CONSTRAINT mm_title_nn NOT NULL,
    singer VARCHAR2(100) CONSTRAINT mm_singer_nn NOT NULL,
    album VARCHAR2(200) CONSTRAINT mm_album_nn NOT NULL,
    poster VARCHAR2(260) CONSTRAINT mm_poster_nn NOT NULL,
    state VARCHAR2(30),
    idcrement NUMBER(3) CONSTRAINT mm_idcre_nn NOT NULL,
    key VARCHAR2(30),
    hit NUMBER DEFAULT 0,
    liked NUMBER DEFAULT 0 CONSTRAINT mm_liked_nn NOT NULL,
    jjim NUMBER DEFAULT 0 CONSTRAINT mm_jjim_nn NOT NULL,
    CONSTRAINT mm_mno_pk PRIMARY KEY(MNO),
    CONSTRAINT mm_state_ck CHECK(state IN('유지','상승','하락'))
);
--user_constraints
SELECT owner,constraint_name,constraint_type,status
FROM user_constraints
WHERE table_name='MELON_MUSIC';
--user_cons_columns
SELECT owner,constraint_name,table_name,column_name
FROM user_cons_columns
WHERE table_name='MELON_MUSIC';

DROP TABLE melon_music;