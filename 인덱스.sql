/*
5. 인덱스
    - 빠른 검색, 접근 가능하도록 만든 데이터 구조
        -> SQL 문장 처리 속도 향상(최적화)
           (ORDER BY의 속도 저하 보완)
    - 투플의 키값 위치(rowid) 저장
        -> 추가 저장 공간 필요, 메모리 많이 소모
        -> B-tree 형태로 저장
    - 테이블 하나당 여러개 생성 가능(단일/여러 컬럼 대상)
    - 데이터 변경 시 인덱스 재구성 필요 -> build
    1) 인덱스의 사용
        - 생성되는 경우
            - WHERE에서 자주 검색되는 컬럼이 있는 경우
            - JOIN에서 주로 사용되는 컬럼이 있는 경우
            - NULL값을 포함하는 컬럼이 많은 경우
            - 구별되는 컬럼이 많은 경우; UNIQUE, PRIMARY KEY
        - 생성되지 않는 경우
            - INSERT, UPDATE, DELETE가 많은 경우
    2) 형식
        - 생성 : CREATE INDEX 인덱스명 
                ON 테이블명(컬럼명 ASC|DESC..)
        - 수정 : ALTER INDEX 인덱스명
                [ON 테이블명(컬럼명)] 
                REBUILD
        - 삭제 : DROP INDEX 인덱스명
        - 정렬
            ORDER BY : 힌트, 조건
            SELECT /*+ INDEX_ASC(테이블명 기본키) * / 컬럼명.. FROM 테이블명
                       INDEX_DESC(테이블명 PK)
            SELECT * FROM 테이블명 WHERE 인덱스명 컬럼명 조건
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