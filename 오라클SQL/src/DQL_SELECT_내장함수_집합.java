/*
2) 집합행함수(집계함수) : Column 단위 처리
    - 단일 컬럼이나 단일행함수와 함께 사용 불가
        -> GROUP BY로 묶어서 함께 사용
        cf. WHERE 문장은 row 단위로 처리하므로 그룹함수 사용 불가
            -> 그룹 컬럼에 대한 조건은 HAVING
    - COUNT(*) : 저장된 ROW 갯수 출력
        COUNT(*) : NULL 포함
        COUNT(컬럼명) : NULL 제외
        -> 검색결과, 페이지, 아이디 출력, 로그인, 장바구니
    - MAX()(*) : 최댓값
        - 번호 자동 증가 프로그램 MAX()+1
    - MIN() : 최솟값
    - SUM() : 합
    - AVG() : 평균
   ---------------------------------- 
    - RANK() OVER(정렬방식)(*) : 순위(공동 순위 포함)
        ex. 1 2 2 4
    - DENSE_RANK() OVER(정렬방식)(*) : 순위(공동 순위 불포함)
        ex. 1 2 2 3
    - CUBE() : 가로+세로 계산
    - ROLLUP() : 가로 계산
*/
//SELECT COUNT(comm),COUNT(mgr),COUNT(*) FROM emp;
//SELECT SUM(sal) "합",ROUND(AVG(sal),2) "평균" FROM emp;
//SELECT MAX(sal),MIN(sal) FROM emp;
//
//SELECT ename,hiredate,sal,RANK() OVER(ORDER BY sal DESC) rank
//FROM emp;
//SELECT ename,hiredate,sal,DENSE_RANK() OVER(ORDER BY sal) rank
//FROM emp;
//-- GROUP BY
//    --deptno는 단일행(ROW), SUM/AVG/COUNT는 집합행이므로 GROUP BY로 묶어주지 않으면 오류
//SELECT deptno,SUM(sal),ROUND(AVG(sal),2),COUNT(*)
//FROM emp
//GROUP BY deptno
//ORDER BY deptno;
///*
//SELECT SUM(sal),AVG(sal),COUNT(*)
//FROM emp
//WHERE deptno=10;
//SELECT SUM(sal),AVG(sal),COUNT(*)
//FROM emp
//WHERE deptno=20;
//SELECT SUM(sal),AVG(sal),COUNT(*)
//FROM emp
//WHERE deptno=30;
//*/
//SELECT TO_CHAR(hiredate,'YYYY') 입사년도,COUNT(*) 인원수,MAX(sal),MIN(sal)
//FROM emp
//GROUP BY TO_CHAR(hiredate,'YYYY')
//HAVING COUNT(*)>=1
//ORDER BY TO_CHAR(hiredate,'YYYY');
public class DQL_SELECT_내장함수_집합 {

}
