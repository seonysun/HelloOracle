/*
 * 1. Single Thread : 동기화
 * 		- A 종료 후 B 동작
 * 		- 단점 : deadlock, starvation -> A가 중지되면 B는 수행 불가
 * 		- 이더넷
 * 
 * 2. Multi Thread : 비동기화
 * 		- A와 B 번갈아가며 동시에 동작
 * 		- 2개가 세트로 한턴씩 반복되지만 한턴 내에서 순서가 정해져있지는 않음
 * */

class MultiThread extends Thread{
	private String data="";
	public MultiThread(String data) {
		this.data=data;
	}
	public void run() {
		try {
			for(int i=0;i<=50;i++) {
				System.out.print(data);
				Thread.sleep(300);
			}
		} catch(Exception e) {}
	}
}
public class Single_Multi {

	public static void main(String[] args) {
		//싱글 쓰레드
		long start=System.currentTimeMillis();
		for(int i=0;i<=100;i++) {
			System.out.print("★");
		}
		long end=System.currentTimeMillis();
		System.out.println("\n소요시간:"+(end-start));
		
		start=System.currentTimeMillis();
		for(int i=0;i<=100;i++) {
			System.out.print("☆");
		}
		end=System.currentTimeMillis();
		System.out.println("\n소요시간:"+(end-start));

		
		//멀티 쓰레드
		MultiThread t1=new MultiThread("♥");
		MultiThread t2=new MultiThread("♡");
		t1.start();
		t2.start();
		
	}

}
