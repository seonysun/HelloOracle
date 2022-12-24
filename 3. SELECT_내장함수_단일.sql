/*
1. 내장함수
    - 오라클 지원 함수
        - 단일행함수 : 한줄 단위로 처리
        - 집합행함수 : 컬럼 단위로 처리
    cf. 사용자 정의 함수
        - FUNCTION : 리턴형이 있는 함수 
            ex. CREATE FUNCTION RETURN NUMBER
        - PROCEDURE : 리턴형이 없는 함수
            ex. CREATE PROCEDURE
            
    1) 단일행함수 : 한줄씩 처리(ROW 단위)
        - 함수 : 데이터 제어 
                -> 데이터형에 따라 분류
                -> 데이터형(문자, 숫자, 날짜, 기타)에 맞게 제작된 함수 지원
        (1) 문자함수(String)
            - 변환함수
                - UPPER(문자열) : 대문자변환
                - LOWER(문자열) : 소문자변환
                    -> 검색시 사용, 자바에서 변경해서 전송하므로 사용 빈도 거의 없음
                - INITCAP(문자열)(*) : 이니셜변경, 단어마다 구분
                    ex. INITCAP('ABC') -> Abc
            - 제어함수
                - SUBSTR(문자열,시작위치,자를갯수)(*) : 문자열 자르기 substring()
                                -> 인덱스 1번부터 시작
                - INSTR(문자열,검색문자,시작위치,순서)(*) : 문자 위치 찾기 indexOf()
                                        -> 시작위치 앞에서부터 1, 뒤에서부터 -1
                - REPLACE(문자열,old,new)(*) : 문자, 문자열 변경
                    - 오라클에서 사용되는 기호 : &, ^, |, $ ..
                - TRIM() : 원하는 문자열 제거 -> 문자열 지정하지 않으면 공백 제거
                    - TRIM(제거할문자열 FROM 대상문자열) : 좌우
                    - LTRIM(대상문자열, 제거문자열) : 왼쪽만
                    - RTRIM(대상문자열, 제거문자열) : 오른쪽만
                - PAD(문자열,글자수,출력할문자) : 글자수에 따라 특수문자 출력
                                                -> 글자수가 더 많으면 특수문자 출력, 글자수가 더 적으면 중간에 자름
                    - LPAD() : ###값
                    - RPAD()(*) : 값###
                        ex. 아이디찾기 -> ad***
                - LENGTH() : 문자 갯수 확인
                - LENGTHB() : 문자의 byte 수 확인
                    - 영어는 1byte, 한글은 3byte
                    cf. VARCHAR2(1~4000byte), CLOB(4GB)
                - CONCAT() : 문자열 결합 ||
                    오라클> WHERE ename LIKE '%'||값||'%'
                    MySQL> WHERE ename Like CONCAT('%',값,'%')
            - 정규식함수
        (2) 숫자함수(Math)
            - MOD() : 나머지
                -> 보통 자바에서 % 처리
            - CEIL()(*) : 올림
            - ROUND()(*) : 반올림
            - TRUNC() : 버림
        (3) 날짜함수(Date, Calender)
            - SYSDATE(*) : 시스템의 날짜와 시간 읽을 때 사용
                - 숫자형 -> 연산 가능
                - 날짜 + 시간 -> 실수형
                - SYSDATE는 시간까지 포함 -> 반올림/버림/올림 필수
            - MONTHS_BETWEEN(최근일,이전일)(*) : 기간에 해당되는 개월 수
            - ADD_MONTHS(시작일,개월수) : 월 추가
            - NEXT_DAY(날짜, 조건) : 날짜 이후 조건에 해당하는 날짜
            - LAST_DAY(날짜) : 해당 달의 마지막 날
        (4) 변환함수(Format)
            - TO_CHAR(*) : 문자열 변환, 패턴 이용
                - 날짜패턴
                    d/dd 일
                    yy(rr)/yyyy(rrrr) 년
                    m/mm 월
                    dy 요일
                    hh/hh24 시간
                    mi 분
                    s/ss 초
                - 숫자패턴
                    $999,999 : 달러
                    L999,999 : 원화
                cf. JSTL : 표준형으로 출력 -> 항상 변환하여 사용해야 함
            - TO_DATE : 날짜형 변환
            - TO_NUMBER : 숫자형 변환
                -> 연산처리 시 자동으로 추가되므로 사용 빈도 거의 없음
            - CHR(숫자) : 숫자 -> 문자로 변경
        (5) 기타함수(Oracle Only)
            - NVL(데이터,값)(*) : 데이터가 NULL일 경우 값 대입
                - NULL값 대체 -> 연산 가능하도록 함
                - 데이터와 값의 데이터형이 같아야 함
                - 크롤링 시 많이 사용
            - DECODE(*) : switch case
                - 일반 SQL 문장 -> 별점출력
                ex. DECODE(score,1,'★☆☆☆☆',
                                 2,'★★☆☆☆',
                                 3,'★★★☆☆')
            - CASE WHEN 조건 THEN 처리문 END(*) : 다중조건문
                - TRIGGER, PROCEDURE -> 입출고에 따른 재고 변화
*/
DESC emp;
    -- 정렬
--숫자 정렬
SELECT * FROM emp ORDER BY sal DESC;
--날짜 정렬
SELECT * FROM emp ORDER BY hiredate;
--알파벳 정렬
SELECT * FROM emp ORDER BY ename ASC;
--이중 정렬
SELECT empno,ename,job,deptno
FROM emp
ORDER BY deptno, 2;

    -- 문자함수
-- 변환함수
SELECT ename "저장된 데이터", UPPER(ename) "대문자",LOWER(ename) "소문자",INITCAP(ename) "이니셜" FROM emp;
SELECT INITCAP('hello oracle') FROM DUAL;

SELECT ename,sal,job
FROM emp
WHERE ename=UPPER('king');

SELECT ename,sal,job
FROM emp
WHERE LOWER(ename)='king';
-- LENGTH, LENGTHB
SELECT ename,LENGTH(ename),LENGTHB(ename) FROM emp;
SELECT LENGTH('ABC'),LENGTH('홍길동'),LENGTHB('ABC'),LENGTHB('홍길동') FROM DUAL;

SELECT ename
FROM emp
WHERE LENGTH(ename)=4;

SELECT ename
FROM emp
WHERE LENGTH(ename) BETWEEN 4 AND 5;
-- REPLACE
SELECT REPLACE('Hello Oracle','l','m') FROM DUAL;
--&의 경우 REPLACE 실행 전에 입력값 받기 진행되어 변경 불가, Java에서 변경 후 전송
SELECT REPLACE('Hello Oracle&Spring','&','^') FROM DUAL;
-- SUBSTR
SELECT SUBSTR('Hello Oracle',7,1) FROM DUAL;

SELECT ename,hiredate
FROM emp
WHERE SUBSTR(hiredate,1,2)=81;

SELECT ename,hiredate
FROM emp
WHERE SUBSTR(hiredate,4,2)=12;
-- 별칭을 줄 때 "" 주지 않아도 되지만 다른 프로그램에 들어갔을 때 오류날 수 있으므로 추가(특히 한글이나 공백 있을 경우)
SELECT ename,SUBSTR(hiredate,-2,2) hireday
FROM emp;

SELECT SUBSTR(hiredate,1,2),SUM(sal),ROUND(AVG(sal),1) AVG
FROM emp
GROUP BY SUBSTR(hiredate,1,2)
ORDER BY SUBSTR(hiredate,1,2) DESC;
-- PAD
SELECT LPAD('Hello Oracle',15,'#'),RPAD('Hello Oracle',5,'#') FROM DUAL;
SELECT ename,RPAD(SUBSTR(ename,1,2),LENGTH(ename),'*') FROM emp;
-- TRIM
SELECT LTRIM('AAABBBCCC','A'),RTRIM('AAABBBCCC','C') FROM DUAL;
SELECT TRIM('A' FROM 'AAABABABAAA') FROM DUAL;
-- CONCAT
SELECT CONCAT('Hello ','Oracle') FROM DUAL;
SELECT 'Hello ' || 'Oracle' FROM DUAL;
-- INSTR
SELECT ename, INSTR(ename,'A',1,1) FROM emp;
SELECT INSTR('Hello Java','a',-1,1) FROM DUAL;

    -- 숫자함수
-- MOD
SELECT MOD(10,3) FROM DUAL;

SELECT empno,ename,job
FROM emp
WHERE MOD(empno,2)=0
ORDER BY 1;
-- CEIL
SELECT CEIL(10.1) FROM DUAL;
SELECT CEIL(10.0) FROM DUAL;
    --총 페이지 구하기
SELECT CEIL(COUNT(*)/10.0) FROM emp;
-- ROUND
SELECT ROUND(10.23456,3) FROM DUAL;
-- TRUNC
SELECT TRUNC(10.23456,3) FROM DUAL;

    -- 날짜함수
-- SYSDATE
SELECT SYSDATE-1 "어제",SYSDATE "오늘",SYSDATE+1 "내일" FROM DUAL;
-- MONTHS_BETWEEN, ROUND
SELECT ename,hiredate,ROUND(MONTHS_BETWEEN(SYSDATE,hiredate)) "근무개월수"
FROM emp;
SELECT ename,hiredate,TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate))/12) "근무년수"
FROM emp;
SELECT SYSDATE,ADD_MONTHS(SYSDATE,12) FROM DUAL;
-- LASTDAY
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('22/03/01') FROM DUAL;
-- NEXTDAY
SELECT NEXT_DAY(SYSDATE,'월') FROM DUAL;

    -- 변환함수
-- TO NUMBER
SELECT TO_NUMBER('100')+TO_NUMBER('200') FROM DUAL;
SELECT '100'+'200' FROM DUAL;
-- TO DATE
SELECT TO_DATE(SYSDATE)+5 After,
       TO_DATE(SYSDATE,'RRRR-MM-DD')-5 Before
FROM DUAL;
-- TO CHAR
SELECT ename, TO_CHAR(sal,'L999,999') FROM emp;
SELECT ename, TO_CHAR(SYSDATE,'RRRR-MM-DD'), TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM emp;
SELECT TO_CHAR(SYSDATE,'HH24:MI:SS') "현재시간" FROM DUAL;
SELECT TO_CHAR(SYSDATE,'DY') "요일" FROM DUAL;
SELECT ename,TO_CHAR(hiredate,'YYYY') 입사년도 FROM emp;
SELECT ename,TO_CHAR(hiredate,'DY')||'요일' "입사요일" FROM emp;

SELECT * FROM emp
WHERE TO_CHAR(hiredate,'DY')='목';

-- 기타함수
SELECT ename,sal,comm,sal+NVL(comm,0) FROM emp;
SELECT zipcode,sido||' '||gugun||' '||dong||' '||NVL(bunji,' ') FROM zipcode;
SELECT ename,job,hiredate,DECODE(deptno,10,'개발부',20,'총무부',30,'기획부') "dname"
FROM emp;

SELECT ename,job,hiredate,CASE WHEN deptno=10 THEN '개발부'
                               WHEN deptno=20 THEN '기획부'
                               WHEN deptno=30 THEN '자재부' 
                               END "dname"
FROM emp;