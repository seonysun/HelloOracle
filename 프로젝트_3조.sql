CREATE TABLE project_keyword_3(
    pkno NUMBER,
    keyword VARCHAR2(100),
    id VARCHAR2(20),
    CONSTRAINT pk3_pkno_pk PRIMARY KEY(pkno),
    CONSTRAINT pk3_id_fk FOREIGN KEY(id)
        REFERENCES project_member_3(id)
);
CREATE TABLE project_ask_3(
    pano NUMBER,
    subject VARCHAR2(1000) CONSTRAINT pa3_sub_nn NOT NULL,
    type VARCHAR2(20) CONSTRAINT pa3_type_nn NOT NULL,
    content CLOB CONSTRAINT pa3_cont_nn NOT NULL,
    pwd VARCHAR2(20) CONSTRAINT pa3_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    ans_state VARCHAR2(20) DEFAULT '미답변',
    hit NUMBER DEFAULT 0,
    group_id NUMBER CONSTRAINT pa3_gid_nn NOT NULL,
    group_step NUMBER DEFAULT 0,
    group_tab NUMBER DEFAULT 0,
    msg CLOB CONSTRAINT pa3_msg_nn NOT NULL,
    id VARCHAR2(20),
    CONSTRAINT pa3_pano_pk PRIMARY KEY(pano),
    CONSTRAINT pa3_id_fk FOREIGN KEY(id)
        REFERENCES project_member_3(id),
    CONSTRAINT pa3_astate_ch CHECK(ans_state IN('미답변','답변완료'))
);
CREATE TABLE project_faq_3(
    pfno NUMBER,
    type VARCHAR2(20) CONSTRAINT pf3_type_nn NOT NULL,
    subject VARCHAR2(1000) CONSTRAINT pf3_sub_nn NOT NULL, 
    content CLOB CONSTRAINT pf3_cont_nn NOT NULL,
    hit NUMBER DEFAULT 0,
    CONSTRAINT pf3_pfno_pk PRIMARY KEY(pfno)
);