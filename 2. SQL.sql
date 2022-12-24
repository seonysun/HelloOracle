/*
1. 데이터베이스 언어 : SQL -> 오라클의 명령어
    - 모든 사용자에게 데이터 공유 목적
    - 데이터베이스에 저장된 데이터 제어
    - 컬럼으로 구분, 필요한 데이터만 수집 -> 테이블 제작 시 키 종류, 제약조건 설정
        cf. DESC 테이블명 : 컬럼명, 데이터형 출력
    1) DML : 데이터 조작 언어
        - DQL 
            - SELECT(*) 데이터 검색 
                - 사용자 요청 데이터 검색 : 저장된 데이터 중에 필요한 데이터를 얻어올 경우
                    -> 목록출력, 상세보기, 검색, 추천데이터 읽기, 테이블 연결(JOIN, SubQuery)
                - SELECT *(전체 출력) | column명(컬럼 일부 출력)
                  FROM table_name[]
        - DML
            - INSERT 데이터 추가
                - 사용자 요청 데이터 오라클에 추가
                    -> 회원가입, 글쓰기, 댓글작성
            - UPDATE 데이터 수정
                - 사용자 요청에 의해 데이터 수정
                    -> 회원정보수정, 장바구니
            - DELETE 데이터 삭제
                - 사용자 요청에 의해 데이터 삭제
                    -> 회원탈퇴, 구매취소, 예약취소
            - MERGE 데이터 병합
    ----------------------------------------- 프로그래머 중심 -> 데이터 조작(CURD)
    2) DDL : 데이터 정의 언어
        - 저장공간, 가상저장공간, 인덱스, 자동 증가번호, 함수 등의 생성
        - 복구 불가능하므로 삭제 등 주의
        - 데이터 저장 공간
            - bit < byte < word < row(문장) < table(파일) < 데이터베이스(폴더)
            - TABLE : 파일 한 개에 대한 정보 보유
                      데이터가 저장되어있는 최소 단위
                      2차원 구조로 구분되어 있음
                ex. id  pw  name -> 구분자, (오라클)column컬럼 (자바)멤버변수
                    ───────
                    aa 1234 홍길동 -> (오라클)record, row, tuple (자바)객체
                    bb 1234 박문수
                    cc 1234 심청이
                    	↓
                      도메인
            - View: 가상 테이블 생성(보안 목적), Sequence: 자동 증가 번호, Index: 검색 PL/SQL
        - CREATE 데이터 저장 공간 생성
             -> CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE INDEX
             -> 제약조건, 데이터형, 키 설정 => 데이터베이스 모델링(정규화)
        - ALTER 데이터 저장 공간 수정
            - ADD 컬럼 추가
            - MODIFY 컬럼 수정
            - DROP 데이터 저장 공간(테이블, View) 삭제
            - TRUNCATE 잘라내기(테이블은 유지, 데이터만 잘라내기)
            - 한글 3byte
        - RENAME 테이블명, 컬럼명 수정   
    3) DCL : 데이터 제어 언어
        - 권한 없이는 테이블, View 등 생성이 불가
            -> system sysdba 계정에서 수행(사용자 계정 X)
        - GRANT 권한 부여
        - REVOKE 권한 해제
    ----------------------------------------- DBA 중심
    4) TCL : 일괄 처리(트랜젝션) 언어
        - COMMIT 정상적인 저장
        - ROLLBACK 비정상 취소 : 비정상 수행 시 명령 취소
            -> COMMIT 수행 시 ROLLBACK 불가하므로 주의

2. 오라클 SQL
    - 사용자 요청 -> 자바 --> 오라클 --> 자바 ----> 브라우저
                        SQL       결과   ArrayList
    - 명령문 순서
        SELECT - FROM - [WHERE - GROUP BY - HAVING - ORDER BY]
    - 명령문은 대소문자 구분하지 않음(데이터값은 대소문자 구분)
    - 키워드는 대문자 서술 약속
    - 문장 종료 시 ;
    - 표현법 : 정수, 실수 -> 그대로 표현
              문자, 날짜 -> ''
              인용부호 -> "" (별칭 첨부, 빈도 적음)
        ex. WHERE hiredate='22/01/02';
    cf. 자바에서 오라클로 SQL 문장(String) 보낼 때 주의할 점
        - 공백처리 -> 키워드 대문자로 작성, 공백 추가 기준 삼기
        - 비교연산자 (오라클)= (자바)== (자바스크립트)===
            -> 문자열, 날짜도 사용 가능(equals 없음)
        - ' ' -> 오류 NULL로 출력되어 찾기 힘듬
        - &(scanner), ||(문자열결합)
        - 페이지 나누기는 오라클로 하는 것이 편함 -> 데이터 선별하여 일부 출력 가능 BETWEEN
            cf. 한 페이지 적정 데이터 : 테이블 20개, 이미지 15개

3. 오라클 데이터형
    - 지정된 글자 수 넘어가면 저장 불가 -> 데이터 크기 확인 필수
    1) 문자형 : String
        - ' '
        - CHAR(1~2000byte) 고정형 -> 사용 거의 안 함, 성별, 어드민 확인
        - VARCHAR2(1~4000byte) 가변형 -> 대부분, 제목
        - CLOB(4GB) 가변형 -> 줄거리, 자기소개
    2) 숫자형
        - NUMBER(4) : 4자리 정수까지 사용 int
        - NUMBER(7,2) : 7자리 중 2자리는 소수점 가능 double
            -> 디폴트는 (8,2)
    3) 날짜형 : Java.util.Date
        - ' '
        - DATE : 일반 날짜(디폴트)
        - TIMESTAMP : 기록 경기
    4) 기타형(4GB) -> 동영상, 이미지 저장
        - BLOB(binary) : 오라클 자체 저장
        - BFILE(file) : 폴더에 저장 후 파일명 읽어서 출력
        - HTML : 링크로 읽어서 출력

4. SELECT : 데이터 검색, 추출 -> Query문
    - SELECT * | column 1, column 2.. -> 전체 데이터(*), 출력에 필요한 데이터만 나열
      FROM table_name
      [ 추가 조건(선택)
          WHERE 조건 -> if(연산자, 내장함수 이용)
          GROUP BY 컬럼명|함수 -> 같은 값을 가지고 있는 컬럼 그룹 ex. 부서별, 직위별
          HAVING 그룹함수 -> 그룹에 대한 조건
                            단독 사용 불가, GROUP BY 필수
          ORDER BY 컬럼명|함수 ASC(생략가능)|DESC -> 정렬
      ]
    - 중복 없는 데이터 추출 : DISTINCT

5. ORDER BY
    - 정렬 : 오라클은 입력된 순서대로 저장됨 -> 정렬 후 데이터 가져오는 것이 좋음
    - 속도 느림, 가급적이면 사용 X, INDEX(*)로 대체
        -> 데이터가 작은 경우 ORDER BY 사용, 빅데이터의 경우 인덱스(**) 사용
        cf. INDEX -> 최적화(**)
    - ASC(오름차순) 생략, DESC(내림차순)
    - 컬럼번호 1번부터 시작
         
emp; 사원 정보
    8개 컬럼으로 구성 -> 사원수 14명
    empno 사번 정수형
    ename 이름 문자형
    job 직위 문자형
    mgr 사수사번 정수형
    hiredate 입사일 날짜형
    sal 급여 정수형
    comm 성과급 정수형
    deptno 부서번호 정수형 -> dept와 연결 시 사용하는 컬럼명
    => 확인 -> DESC 테이블명;
dept; 부서 정보
*/
-- 테이블 컬럼명, 데이터형 확인
DESC emp;
-- 테이블에 있는 모든 데이터 검색
SELECT * FROM emp;
-- 테이블의 일부 컬럼 검색
SELECT empno,ename,job,hiredate FROM emp;
-- 컬럼에 별칭 추가
/* 컬럼명 "별칭"
   컬럼명 as 별칭 */
SELECT empno "사번", ename "이름", hiredate "입사일" FROM emp;
SELECT empno as 사번, ename as 이름, hiredate as 입사일 FROM emp;
-- 테이블명이 너무 길거나 JOIN 줄 때 테이블명 별칭 사용
SELECT empno as 사번, ename as 이름, hiredate as 입사일 
FROM emp e;
-- 문자열 결합
SELECT ename||'님의 입사일은 '||hiredate||'입니다' FROM emp;
-- 중복 제거
SELECT deptno FROM emp;
SELECT DISTINCT deptno FROM emp;
-- 정렬
SELECT empno,ename,sal FROM emp ORDER BY sal DESC;