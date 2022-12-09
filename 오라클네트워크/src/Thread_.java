/*
 * 1. 쓰레드(Thread)
 * 	- 각각의 client가 서버에 접속하면 통신 담당 서버 개별적으로 새로 개설 -> 쓰레드
 * 		-> 모든 프로그램은 1개 이상의 쓰레드를 지님
 * 			cf. 자바(이클립스) : main, gc, 컴파일, 에러출력...
 * 		-> 각각의 세부 작업 동시에 개별적으로 동작 가능, 충돌 방지
 * 	- 각각의 쓰레드는 1가지 작업만 수행하도록 생성
 * 	- 동시 작업(읽기, 쓰기), 실시간(Ajax, VueJS, ReactJS)에 쓰레드 주로 사용
 * 		-> 입출력은 동시에 불가 -> 쓰레드로 동시 수행
 * 	- 장점
 * 		- CPU 사용률 향상, 속도 빠름
 * 		- 자원(파일, 클래스 등) 효율적으로 사용 가능
 * 		- 사용자 응답성 향상
 * 		- 소스 간결해짐(작업 분리)
 * 
 * 	1) 쓰레드 생명주기
 * 		- 생성 : Thread t1=new Thread();
 * 			- JVM 역할 
 * 				-> 쓰레드 이름 부여 : Thread-0 순차적으로 
 * 					- 재설정 : setName(String name)
 * 				-> 순서 부여 : 0~10; 숫자가 클수록 우선 순위
 * 					MIN_PRIORITY : 0 -> gc()
 * 					NORM_PRIORITY : 5 -> 사용자 정의 쓰레드
 * 					MAX_PRIORITY : 10 -> main
 * 					- 가장 높은 순위의 쓰레드부터 순차적으로 수행
 * 					- 재설정 : setPriority(int priority)
 * 		- 대기 : 사용할 데이터 수집
 * 			t1.start()
 * 		- 동작 : 재정의(동작 방법 설정)
 * 			run() -> 일반적으로 호출하지 않음(start() 호출 시 자동으로 호출)
 * 		- 일시정지
 * 			sleep()
 * 			wait()
 * 		- 제거
 * 			interrupt()
 * 			join()
 * 
 * 	- 비동기화 프로그램 : 서로 다른 쓰레드 동시에 동작 (default)
 * 	  동기화 프로그램 : 한개의 쓰레드가 종료하면 다음 쓰레드 동작 (synchronized)
 * 					-> 은행권 프로그램
 * 
 * 	2) 생성 방법
 * 		(1) Thread(클래스) 상속 -> 네트워크, 대부분
 *  		class MyThread extends Thread{
 *  			public void run(){}
 *  		}
 * 		(2) Runnable(인터페이스) 구현 -> 윈도우
 * 			- 윈도우의 경우 윈도우 클래스(JFrame) 상속 필요함 -> 다중 상속이 불가능하므로 인터페이스로 구현
 * 			- 쓰레드 자체가 아닌 쓰레드 동작만 생성
 * 				-> Thread 이용하여 쓰레드 생성 후 메소드 호출
 *  		class MyThread implements Runnable{
 *  			public void start(){
 *  				run()
 *  			}
 *  		}
 */

class MyThread extends Thread{
	public void run() {
		try {
			for(int i=1;i<=10;i++) {
				System.out.println(getName()+"."+i);
									//Thread 상속 시에만 사용 가능(Runnable 구현에서는 사용 불가)
				Thread.sleep(200);
			}
		} catch(InterruptedException e) {} //쓰레드는 충돌방지 예외처리(Checked Exception)
	}
}
public class Thread_ {

	public static void main(String[] args) {
		System.out.println(Thread.currentThread());
		
		MyThread t1=new MyThread();
		t1.setName("홍길동");
		t1.setPriority(Thread.NORM_PRIORITY); //반복 횟수가 적어서 실제 속도 차이가 크지는 않음 -> 설정 순위와 다르게 나올 수 있음
		MyThread t2=new MyThread();
		t2.setName("심청이");
		t2.setPriority(Thread.MIN_PRIORITY);
		MyThread t3=new MyThread();
		t3.setName("이순신");
		t3.setPriority(Thread.MAX_PRIORITY);
		System.out.println("t1:"+t1.getName()+", 우선순위:"+t1.getPriority());
		System.out.println("t2:"+t2.getName()+", 우선순위:"+t2.getPriority());
		System.out.println("t3:"+t3.getName()+", 우선순위:"+t3.getPriority());
		System.out.println("동작>");
		t1.start();
		t2.start();
		t3.start();

	}

}
