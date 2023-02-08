package com.sist.chat;

import java.util.*;
import java.io.*;
import java.net.*;

/*
 * - 서버 : 접속 시 client 정보 저장 -> IP, PORT
 * 		   & client 통신 담당 소켓 매번 생성 => 쓰레드
 * 		-> 서버의 멤버를 사용해야 하므로 내부 클래스로 사용
 * cf. 내부클래스 : 쓰레드, 네트워크에서 주로 사용(공유하는 데이터 많음)
 * 		- 멤버클래스
 * 		- 익명의 클래스 : 상속 없이 오버라이딩하여 사용
 * 
 * - 서버
 * P2P : 클라이언트 프로그램 서버 작동 -> 게임(방마다 서버 따로 두고 처리)
 * 멀티
 * 
 * 클라이언트 : 소켓 생성, 
 * 	accpet() 메소드 접속 시도
 * Input/Output Stream 통한 통신
 * close() 메소드 
 * 서버 : 교환소켓 생성
 * 
 * 클라이언트에서 요청, 처리, 출력
 * 클라이언트 : 요청, 출력
 * 서버 : 요청 처리 -> 모든 클라이언트가 데이터를 공유해야하므로 서버에서 요청을 처리하는 것
 * ** 클라이언트에서 로그인, 로그아웃, 장바구니 등의 요청 -> 서버에서 id/pw 등의 요청 데이터 받음
	 
	오라클서버 : OutputStream, BufferedReader -> PreparedStatement에 포함
	웹 서버 : OutputStream -> HttpServletRequest
	 		BufferedReader -> HttpServletResponse
 */

public class ChatServer implements Runnable{
	//client 정보 저장(접속 시마다) => 교환 Socket
	private Vector<Client> waitVc=new Vector<Client>();
	//서버 가동 -> 서버 PORT, IP 고정
	private ServerSocket ss; //교환소켓
	private final static int PORT=3355;
		/*
		 * PORT 번호 0~65535
		 * 	- 0~1023 : 알려진 포트 -> 사용 금지
		 * 		FTP 21
		 * 		SMTP 25
		 * 		HTTP 80
		 * 	  	  //P : protocol(약속)
		 * 		TELNET 23
		 * 	- 1521 : 오라클
		 * 	- 3306 : MySQL
		 * 	- 3000 : React
		 * 	- 8080 : 스프링
		 * 	- 음성 : 2만번대
		 * 	  화상 : 3만번대
		 */
	public ChatServer() { //서버는 딱 1번만 실행 -> 여러번 실행하려면 PORT 바꿔야 함
		try{
			ss=new ServerSocket(PORT); //default 포트 생성 : 50(50명까지만 접근 가능) -> 인트라넷(사내)에서 사용
			//new ServerSocket(PORT,100) -> 100명까지 접근 가능
			System.out.println("Server Start...");
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
			}
	}
	public void run() {
		try {
			while(true) {
				Socket client=ss.accept();
								//접속되었을 경우에만 호출됨(특수메소드) -> 클라이언트 정보 가져옴
				//System.out.println("접속한 클라이언트 IP:"+client.getInetAddress().getHostAddress());
				//System.out.println("접속한 클라이언트 PORT:"+client.getPort());
				
				//서버는 고정 PORT, 클라이언트는 자동 PORT(중복 없음)
				Client c=new Client(client); //클라이언트 생성
				waitVc.add(c); //저장
				c.start(); //출력
			}
		} catch(Exception ex) {}
	}
	public static void main(String[] args) {
		ChatServer server=new ChatServer();
		new Thread(server).start();
	}
	//통신 담당 쓰레드(접속자마다 개별 생성) -> 사용자 요청 받기, 사용자 요청 처리 후 응답 => 통신 Socket
	class Client extends Thread{
		private Socket s; //클라이언트 소켓 -> 쓰레드가 담당하는 클라이언트 정보 보유
		private OutputStream out; //클라이언트에게 전송될 값
		private BufferedReader in; //클라이언트가 저장해둔 메모리(클라이언트 요청값)
		public Client(Socket s) {
			try {
				this.s=s;
				in=new BufferedReader(new InputStreamReader(s.getInputStream()));
				out=s.getOutputStream();
					//메모리에 저장된 값을 클라이언트가 읽어감 -> 신뢰성 높음(TCP)
			} catch(Exception ex) {}
		}
		public void run() {
			try {
				while(true) {
					String msg=in.readLine();
					System.out.println("Client가 전송한 값:"+msg);
					for(Client c:waitVc) {
						c.out.write((msg+"\n").getBytes());
										//마지막에 \n 반드시 추가해야 함 -> 한줄로 전송
					}
				}
			} catch(Exception ex) {}
		}
	}
}
