

class MyThread2 implements Runnable{

	@Override
	public void run() {
		try {
			for(int i=1;i<=10;i++) {
				System.out.println(Thread.currentThread()+":"+i);
				Thread.sleep(300);
			}
		} catch(Exception e) {}
	}
	
}
public class Runnable_ {

	public static void main(String[] args) {
		MyThread2 t1=new MyThread2();
		new Thread(t1).start();
			//Runnable은 쓰레드를 생성할 수 없음, 쓰레드 동작만 생성 -> Thread로 쓰레드 생성

	}

}
