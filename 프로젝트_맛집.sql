--맛집프로젝트
CREATE TABLE project_member(
    id VARCHAR2(20),
    pwd VARCHAR2(10) CONSTRAINT pm_pwd_nn NOT NULL,
    name VARCHAR2(34) CONSTRAINT pm_name_nn NOT NULL,
    sex VARCHAR2(6), 
    birth VARCHAR2(15) CONSTRAINT pm_birth_nn NOT NULL,
    email VARCHAR2(50),
    post VARCHAR2(7) CONSTRAINT pm_post_nn NOT NULL,
    addr1 VARCHAR2(200) CONSTRAINT pm_addr1_nn NOT NULL,
    addr2 VARCHAR2(200),
    phone VARCHAR2(20) CONSTRAINT pm_phone_nn NOT NULL,
    content CLOB,
    admin CHAR(1) DEFAULT 'n',
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT pm_id_pk PRIMARY KEY(id),
    CONSTRAINT pm_sex_ck CHECK(sex IN('남자','여자')),
    CONSTRAINT pm_email_uk UNIQUE(email),
    CONSTRAINT pm_phone_uk UNIQUE(phone),
    CONSTRAINT pm_admin_ck CHECK(admin IN('y','n'))
);
CREATE TABLE project_board(
    bno NUMBER,
    name VARCHAR2(34) CONSTRAINT pb_name_nn NOT NULL,
    subject VARCHAR2(4000) CONSTRAINT pb_sub_nn NOT NULL,
    content CLOB CONSTRAINT pb_cont_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT pb_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    CONSTRAINT pb_bno_pk PRIMARY KEY(bno)
);
CREATE SEQUENCE pb_bno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
CREATE TABLE project_reply(
    rno NUMBER,
    bno NUMBER,
    id VARCHAR2(20),
    name VARCHAR2(34) CONSTRAINT pr_name_nn NOT NULL,
    msg CLOB CONSTRAINT pr_msg_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    group_id NUMBER CONSTRAINT pr_gi_nn NOT NULL,
    group_step NUMBER DEFAULT 0,
    group_tab NUMBER DEFAULT 0,
    root NUMBER DEFAULT 0,
    depth NUMBER DEFAULT 0,
    CONSTRAINT pr_rno_pk PRIMARY KEY(rno),
    CONSTRAINT pr_bno_fk FOREIGN KEY(bno)
        REFERENCES project_board(bno),
    CONSTRAINT pr_id_fk FOREIGN KEY(id)
        REFERENCES project_member(id)
);
CREATE SEQUENCE pr_rno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
CREATE TABLE project_food_category(
    cno NUMBER,
    title VARCHAR2(100) CONSTRAINT pfc_title_nn NOT NULL,
    subject VARCHAR2(200) CONSTRAINT pfc_subject_nn NOT NULL,
    poster VARCHAR2(300) CONSTRAINT pfc_poster_nn NOT NULL,
    link VARCHAR2(200) CONSTRAINT pfc_link_nn NOT NULL,
    CONSTRAINT pfc_cno_pk PRIMARY KEY(cno)
);
CREATE SEQUENCE pfc_cno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
CREATE TABLE project_food(
    fno NUMBER,
    cno NUMBER,
    poster VARCHAR2(1000) CONSTRAINT pf_poster_nn NOT NULL,
    name VARCHAR2(100) CONSTRAINT pf_name_nn NOT NULL,
    score NUMBER(2,1) CONSTRAINT pf_score_nn NOT NULL,
    address VARCHAR2(250) CONSTRAINT pf_address_nn NOT NULL,
    tel VARCHAR2(20) CONSTRAINT pf_tel_nn NOT NULL,
    type VARCHAR2(100) CONSTRAINT pf_type_nn NOT NULL,
    price VARCHAR2(20),
    parking VARCHAR2(20),
    time VARCHAR2(20),
    menu VARCHAR2(500),
    jjim_count NUMBER DEFAULT 0,
    like_count NUMBER DEFAULT 0,
    hit NUMBER DEFAULT 0,
    CONSTRAINT pf_fno_pk PRIMARY KEY(fno),
    CONSTRAINT pf_cno_fk FOREIGN KEY(cno)
        REFERENCES project_food_category(cno)
);
CREATE SEQUENCE pf_fno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
CREATE TABLE project_location_food(
    fno NUMBER,
    poster VARCHAR2(1000) CONSTRAINT plf_poster_nn NOT NULL,
    name VARCHAR2(100) CONSTRAINT plf_name_nn NOT NULL,
    score NUMBER(2,1) CONSTRAINT plf_score_nn NOT NULL,
    address VARCHAR2(250) CONSTRAINT plf_address_nn NOT NULL,
    tel VARCHAR2(20) CONSTRAINT plf_tel_nn NOT NULL,
    type VARCHAR2(100) CONSTRAINT plf_type_nn NOT NULL,
    price VARCHAR2(20),
    parking VARCHAR2(20),
    time VARCHAR2(20),
    menu VARCHAR2(500),
    jjim_count NUMBER DEFAULT 0,
    like_count NUMBER DEFAULT 0,
    hit NUMBER DEFAULT 0,
    CONSTRAINT plf_fno_pk PRIMARY KEY(fno)
);
CREATE SEQUENCE plf_fno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
CREATE TABLE project_keyword(
    kno NUMBER,
    id VARCHAR2(20),
    keyword VARCHAR2(100) CONSTRAINT pk_keyword_nn NOT NULL,
    CONSTRAINT pk_kno_pk PRIMARY KEY(kno),
    CONSTRAINT pk_id_fk FOREIGN KEY(id)
        REFERENCES project_member(id)
);
CREATE SEQUENCE pk_kno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
CREATE TABLE project_reserve_time(
    tno NUMBER,
    time VARCHAR2(20) CONSTRAINT prt_time_nn NOT NULL,
    CONSTRAINT prt_tno_pk PRIMARY KEY(tno)
);
CREATE TABLE project_reserve_date(
    dno NUMBER,
    rdate NUMBER CONSTRAINT prd_date_nn NOT NULL,
    rtime VARCHAR2(20) CONSTRAINT prd_time_nn NOT NULL,
    CONSTRAINT prd_dno_pk PRIMARY KEY(dno)
);
CREATE TABLE project_reserve(
    rno NUMBER,
    fno NUMBER,
    id VARCHAR2(20),
    rdate VARCHAR2(20) CONSTRAINT pres_rdate_nn NOT NULL, 
    rtime VARCHAR2(20) CONSTRAINT pres_rtime_nn NOT NULL,
    inwon NUMBER,
    reserve_no VARCHAR2(20) CONSTRAINT pres_rno_nn NOT NULL,
    ok CHAR(1),
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT pres_rno_pk PRIMARY KEY(rno),
    CONSTRAINT pres_fno_fk FOREIGN KEY(fno)
        REFERENCES project_food(fno),
    CONSTRAINT pres_id_fk FOREIGN KEY(id)
        REFERENCES project_member(id),
    CONSTRAINT pres_inwon_ck CHECK(inwon>0)
);
CREATE TABLE project_recipe(
    rno NUMBER,
    title VARCHAR2(500) CONSTRAINT prcp_title_nn NOT NULL,
    poster VARCHAR2(260) CONSTRAINT prcp_poster_nn NOT NULL,
    chef VARCHAR2(100) CONSTRAINT prcp_chef_nn NOT NULL,
    hit NUMBER DEFAULT 0,
    jjim_count NUMBER DEFAULT 0,
    like_count NUMBER DEFAULT 0,
    CONSTRAINT prcp_rno_pk PRIMARY KEY(rno)
);
CREATE SEQUENCE prcp_rno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
CREATE TABLE project_recipe_detail(
    rno NUMBER,
    title VARCHAR2(100) CONSTRAINT prd_title_nn NOT NULL,
    poster VARCHAR2(260) CONSTRAINT prd_poster_nn NOT NULL,
    content CLOB CONSTRAINT prd_content_nn NOT NULL,
    chef_name VARCHAR2(100) CONSTRAINT prd_cn_nn NOT NULL,
    chef_poster VARCHAR2(260) CONSTRAINT prd_cp_nn NOT NULL,
    chef_email VARCHAR2(100) CONSTRAINT prd_ce_nn NOT NULL,
    info1 VARCHAR2(20) CONSTRAINT prd_info1_nn NOT NULL,
    info2 VARCHAR2(20) CONSTRAINT prd_info2_nn NOT NULL,
    info3 VARCHAR2(20) CONSTRAINT prd_info3_nn NOT NULL,
    food_data CLOB CONSTRAINT prd_fd_nn NOT NULL,
    food_make CLOB CONSTRAINT prd_fm_nn NOT NULL,
    hashtag CLOB,
    CONSTRAINT prd_rno_fk FOREIGN KEY(rno)
        REFERENCES project_recipe(rno)
);
CREATE TABLE project_recipe_chef(
    cno NUMBER,
    id VARCHAR2(20),
    name VARCHAR2(100) CONSTRAINT prc_name_nn NOT NULL,
    poster VARCHAR2(260) CONSTRAINT prc_poster_nn NOT NULL,
    mem_cont1 NUMBER DEFAULT 0,
    mem_cont2 NUMBER DEFAULT 0,
    mem_cont7 NUMBER DEFAULT 0,
    mem_cont3 NUMBER DEFAULT 0,
    CONSTRAINT prc_cno_pk PRIMARY KEY(cno),
    CONSTRAINT prc_id_fk FOREIGN KEY(id)
        REFERENCES project_member(id)
);
CREATE SEQUENCE prc_cno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
CREATE TABLE project_goods_category(
    cno NUMBER,
    name VARCHAR2(30) CONSTRAINT pgc_name_nn NOT NULL,
    CONSTRAINT pgc_cno_pk PRIMARY KEY(cno)
);
CREATE TABLE project_recipe_goods(
    gno NUMBER,
    cno NUMBER,
    goods_name VARCHAR2(1000) CONSTRAINT prg_name_nn NOT NULL,
    goods_poster VARCHAR2(60) CONSTRAINT prg_poster_nn NOT NULL,
    goods_content VARCHAR2(4000) CONSTRAINT prg_content_nn NOT NULL,
    goods_price NUMBER CONSTRAINT prg_price_nn NOT NULL,
    goods_percent NUMBER CONSTRAINT prg_per_nn NOT NULL,
    first_buy_price NUMBER CONSTRAINT prg_first_nn NOT NULL,
    send VARCHAR2(30) CONSTRAINT prg_send_nn NOT NULL,
    account NUMBER CONSTRAINT prg_acc_nn NOT NULL,
    jjim_count NUMBER DEFAULT 0,
    like_count NUMBER DEFAULT 0,
    hit NUMBER DEFAULT 0,
    CONSTRAINT prg_gno_pk PRIMARY KEY(gno),
    CONSTRAINT prg_cno_fk FOREIGN KEY(cno)
        REFERENCES project_goods_category(cno)
);
CREATE SEQUENCE prg_gno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
CREATE TABLE project_goods_buy(
    bno NUMBER,
    gno NUMBER,
    id VARCHAR2(20),
    account NUMBER,
    total_price NUMBER,
    buy_ok CHAR(1),
    CONSTRAINT pgb_bno_pk PRIMARY KEY(bno),
    CONSTRAINT pgb_gno_fk FOREIGN KEY(gno)
        REFERENCES project_recipe_goods(gno),
    CONSTRAINT pgb_id_fk FOREIGN KEY(id)
        REFERENCES project_member(id),
    CONSTRAINT pgb_account_ck CHECK(account>0),
    CONSTRAINT pgb_tp_ck CHECK(total_price>0),
    CONSTRAINT pgb_bo_ck CHECK(buy_ok IN('y','n'))
);
CREATE TABLE project_seoul_category(
    cno NUMBER,
    name VARCHAR2(20) CONSTRAINT psc_name_nn NOT NULL,
    CONSTRAINT psc_cno_pk PRIMARY KEY(cno)
);
CREATE TABLE project_seoul(
    sno NUMBER,
    cno NUMBER,
    name VARCHAR2(100) CONSTRAINT ps_name_nn NOT NULL,
    poster VARCHAR2(260) CONSTRAINT ps_poster_nn NOT NULL,
    content CLOB,
    address VARCHAR2(300) CONSTRAINT ps_addr_nn NOT NULL,
    jjim_count NUMBER DEFAULT 0,
    like_count NUMBER DEFAULT 0,
    hit NUMBER DEFAULT 0,
    CONSTRAINT ps_sno_pk PRIMARY KEY(sno),
    CONSTRAINT ps_cno_fk FOREIGN KEY(cno)
        REFERENCES project_seoul_category(cno)
);
CREATE TABLE project_replyBoard(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT prb_name_nn NOT NULL,
    subject VARCHAR2(1000) CONSTRAINT prb_sub_nn NOT NULL,
    content CLOB CONSTRAINT prb_cont_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT prb_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    group_id NUMBER,
    group_step NUMBER DEFAULT 0,
    group_tab NUMBER DEFAULT 0,
    CONSTRAINT prb_no_pk PRIMARY KEY(no)
);
CREATE TABLE project_dataBoard(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT pdb_name_nn NOT NULL,
    subject VARCHAR2(1000) CONSTRAINT pdb_sub_nn NOT NULL,
    content CLOB CONSTRAINT pdb_cont_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT pdb_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    filename VARCHAR2(260),
    filesize NUMBER DEFAULT 0,
    CONSTRAINT pdb_no_pk PRIMARY KEY(no)
);
CREATE TABLE project_notice(
    no NUMBER,
    type NUMBER,
    name VARCHAR2(34) CONSTRAINT pn_name_nn NOT NULL,
    subject VARCHAR2(1000) CONSTRAINT pn_sub_nn NOT NULL,
    content CLOB CONSTRAINT pn_cont_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    CONSTRAINT pn_no_pk PRIMARY KEY(no)
);
CREATE TABLE project_all_jjim(
    jno NUMBER,
    cate_no NUMBER,
    no NUMBER,
    id VARCHAR2(20),
    CONSTRAINT paj_jno_pk PRIMARY KEY(jno),
    CONSTRAINT paj_id_fk FOREIGN KEY(id)
        REFERENCES project_member(id)
);
CREATE TABLE project_all_like(
    lno NUMBER,
    cate_no NUMBER,
    no NUMBER,
    id VARCHAR2(20),
    CONSTRAINT pal_lno_pk PRIMARY KEY(lno),
    CONSTRAINT pal_id_fk FOREIGN KEY(id)
        REFERENCES project_member(id)
);
CREATE TABLE project_all_reply(
    rno NUMBER,
    cate_no NUMBER,
    no NUMBER,
    id VARCHAR2(20),
    name VARCHAR2(34) CONSTRAINT par_name_nn NOT NULL,
    msg CLOB CONSTRAINT par_msg_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT par_rno_pk PRIMARY KEY(rno),
    CONSTRAINT par_id_fk FOREIGN KEY(id)
        REFERENCES project_member(id)
);
SELECT * FROM tab;