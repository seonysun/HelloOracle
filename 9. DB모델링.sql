/*
1. 데이터베이스 모델링
    - 데이터베이스 : 데이터를 저장하는 장소
        - 메모리, 파일, RDBMS : 제어 쉬움
        - 변수, 배열, 클래스, 파일 : 기능별 분리 -> 제어 어려움
    1) DB 생명주기
        (1) 요구사항 수집&분석
            - 사이트 파악(흐름, 기능)
            - 필요한 데이터 파악
                카테고리
                카테고리 번호
                제목
                이미지
                부가설명
        (2) 데이터베이스 설계
            - 중복된 데이터 고려
            - NULL 허용 컬럼 설정
            - 테이블 매핑
        (3) 구현
            - 테이블, 관련 객체(뷰, 인덱스 등) 생성
        (4) 유지보수
            - 소프트웨어 구축, 서비스 제공
        (5) 개선, 검사
        
2. 데이터 설계
    - 개념적 설계 : 데이터 추출 -> 엔티티(테이블) 구성 파악, PK 설정, 테이블 간 관계 정의
    - 논리적 설계 : 테이블 구체화 -> 키 설정, 정규화(중복 제거), 표준화 
    - 물리적 설계 : 테이블 제작 -> 데이터형, 메모리 크기 설정
    - 고려사항
        - 무결성 : 이상 현상 방지, 원하는 데이터만 제어
        - 일치성 : 데이터간 응답의 일치성(참조키 활용)
        - 보안성 : 파밍, SQL문장
        - 효율성 : 응답시간 최소화(인덱스 활용), 저장 공간 효율적 배치
*/
