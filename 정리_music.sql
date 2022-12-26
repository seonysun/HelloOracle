/*
0. ����Ŭ ���� ����
    - ���̺� : user_tables
    - �������� : user_constraints
    - �� : user_views
    - ��� ��� �빮�ڷ� ����Ǿ������Ƿ� �˻� �� �빮�� ����

���Ϲ���; ��й���;
 ������ PK(����)
 //����
 ����
 ������
 ����
 ������
 �ٹ���
 ī�װ�
 Ű(��ũ)
 ��ȸ��
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
    CONSTRAINT gm_state_ck CHECK(state IN('����','���','�ϰ�'))
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
    CONSTRAINT mm_state_ck CHECK(state IN('����','���','�϶�'))
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