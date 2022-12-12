/*
1. SELECT : 데이터 검색, 추출 -> Query문
    - SELECT * | column 1, column 2.. -> 전체 데이터(*), 출력에 필요한 데이터만 나열
      FROM table_name
      [ 추가 조건(선택)
          WHERE -> if(연산자, 내장함수 이용)
          GROUP BY 그룹컬럼 -> 같은 값을 가지고 있는 컬럼 ex. 부서별, 직위별
          HAVING -> 그룹에 대한 조건
                    단독 사용 불가, GROUP BY 필수
          ORDER BY 컬럼명 -> 정렬(ASC(생략가능)/DESC)
      ]
      
2. 연산자
    - 산술연산자 : 주로 SELECT 뒤에 붙여서 사용 -> 조건 검색 시 사용
                 +,-,*,/ - 문자열 연산처리 시 오류, 문자열 결합 시 ||
                         - 정수/정수=실수, 0으로 나누기 불가
                         - 컬럼 값이 없는 경우(NULL) 연산 결과 NULL
                                ex. NULL + 1 = NULL
                         - 연습용테이블 DUAL
            cf. 오라클은 컬럼(도메인) 단위로는 통계 가능, Tuple(row) 단위로는 통계 불가 
                    -> row 단위 통계 시 산술연산자로 주로 사용
                복잡한 통계 -> CUBE, ROLLUP
    --------------------------------------------------
    WHERE, HAVING에서 주로 사용하는 추가 조건(TRUE/FALSE)
    --------------------------------------------------
    - 비교연산자 : = (같다) !=, <>, ^= (같지 않다) <, >, <=, >= 
                 결과 true/false
                 숫자형, 날짜형, 문자형 모두 사용 가능
    - 논리연산자 : AND, OR
                 AND : 직렬 -> 모두 true이면 true
                       BETWEEN 연산자 대체 가능
                 OR : 병렬 -> 둘 중 하나가 true이면 true
                      IN 연산자 대체 가능
            cf. & : 입력값 받을 때 Scanner
               || : 문자열 결합
    - 대입연산자 : = (WHERE, HAVING에서는 비교연산자, 그 외의 장소에서는 대입연산자)
    - NOT 연산자 : NOT LIKE, NOT BETWEEN, NOT IN
    - NULL 연산자 : 값이 존재하지 않음 -> 연산처리 불가
    - IN 연산자 : OR가 여러개일 경우 처리하는 연산자
    - BETWEEN ~ AND : 기간이나 범위 나타냄
                     ex. BETWEEN 1 AND 10 : 1≤ X ≤10
    - LIKE(*) : 유사문자열 검색
                % : 문자열 갯수를 모르는 경우
                    ex. 'A%' : A로 시작하는 모든 문자열(startsWith)
                        '%A' : A로 끝나는 모든 문자열(endsWith)
                        '%A%' : A가 포함된 모든 문자열(contains)
                _ : 한글자
                    ex. __A__ : 총 5글자, 가운데 문자 A
                        __A%
                REGEXP_LIKE : 정규식 -> 최근에는 패턴 주로 사용
                    ex. WHERE REGEXP_LIKE(name,'[A-E]')
*/
//-- 산술연산
//SELECT 10+2,10-2,10*2,10/2
//FROM DUAL;
//-- 0으로 나누기 불가
//SELECT 10+2,10-2,10*2,10/0
//FROM DUAL;
//-- Integer.parseInt(), trim() 자동 실행(자동 형변환)
//SELECT ' 10'+2,10-2,10*2,10/2
//FROM DUAL;
//-- NULL값 대체 연산
//SELECT ename,sal+NVL(comm,0) "실제급여"
//FROM emp;
//-- &≠AND
//SELECT * FROM emp
//WHERE empno=&sabun;
//-- 산술 연산으로 통계
//CREATE TABLE student(
//name VARCHAR2(34),
//kor NUMBER,
//eng NUMBER,
//math NUMBER
//);
//SELECT * FROM student;
//INSERT INTO student VALUES('홍길동',89,78,67);
//INSERT INTO student VALUES('심청이',78,76,90);
//INSERT INTO student VALUES('박문수',90,90,78);
//COMMIT;
//SELECT name,kor,eng,math,kor+eng+math "total",(kor+eng+math)/3 "avg"
//FROM student;
//-- 비교 /같지않다
//SELECT ename,job,hiredate,sal
//FROM emp
//WHERE sal<>3000;
//
//SELECT ename,job,hiredate,sal
//FROM emp
//WHERE sal!=3000;
//
//SELECT ename,job,hiredate,sal
//FROM emp
//WHERE sal^=3000;
//-- 비교 /크기비교
//SELECT * FROM emp
//WHERE hiredate>'81/12/31';
//
//SELECT ename,job,sal FROM emp
//WHERE ename>'KING'; 
//--저장된 데이터는 대소문자 구분
//SELECT * FROM emp
//WHERE ename='king';
//
//SELECT * FROM emp
//WHERE ename='KING';
//-- AND
//SELECT * FROM emp
//WHERE hiredate>='81/01/01' AND hiredate<='81/12/31';
//-- 논리
//SELECT * FROM emp
//WHERE sal>=1500 AND SAL<=3000;
//
//SELECT * FROM emp
//WHERE sal=1500 OR sal=3000;
//
//SELECT * FROM emp
//WHERE deptno=30;
//-- NULL
//SELECT * FROM emp
//WHERE comm IS NOT NULL AND comm<>0;
//
//SELECT * FROM emp
//WHERE comm IS NULL OR comm=0;
//-- IN
//SELECT * FROM emp
//WHERE sal=5000 OR sal=2850 OR sal=3000;
//
//SELECT * FROM emp
//WHERE sal IN(5000,2850,3000);
//-- NOT
//SELECT * FROM emp WHERE comm IS NULL OR comm NOT BETWEEN 500 AND 1400;
//
//SELECT * FROM emp
//WHERE job NOT IN('MANAGER','CLERK','SALESMAN');
//-- BETWEEN AND
//SELECT * FROM emp
//WHERE sal BETWEEN 1500 AND 3000;
//-- LIKE
//SELECT * FROM emp
//WHERE ename NOT LIKE '%A%';
//
//SELECT * FROM emp
//WHERE ename LIKE '%EN' OR ename LIKE '%AN';
//
//SELECT * FROM emp
//WHERE ename LIKE '__O%';
public class DQL_SELECT_연산자 {

}
