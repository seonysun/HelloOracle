package com.sist.server;

import java.net.*; 
import java.io.*; 
import java.util.*; 

public class Server implements Runnable{
	//클라이언트 정보 저장 공간 생성 (웹 : HttpSession)
	private Vector<Client> waitVc=new Vector<Client>();
	private ServerSocket ss;
	private final int PORT=3355;
	//서버 구동
	public Server() {
		try {
			ss=new ServerSocket(PORT);
				//클래스 생성 시 호출되는 메소드 -> bind(IP,PORT) : 소켓 생성(개통), listen() 대기
			System.out.println("Server Start..");
		} catch(Exception ex) {}
	}
	public static void main(String[] args) {
		Server server=new Server();
		new Thread(server).start();
	}
	//접속시 처리
	@Override
	public void run() {
		try {
			while(true) {
				Socket s=ss.accept(); //클라이언트가 접속했을 때 Socket 내 정보(IP, PORT) 확인
				//멀티 서버 : 클라이언트마다 생성, 에코서버 -> 1:1
			}
		} catch(Exception ex) {}
	}
	//실제 클라이언트와 통신 -> 쓰레드
	class Client extends Thread{
		private String id,name,sex;
		private OutputStream out;
		private BufferedReader in;
		private Socket s; //클라이언트 정보 보유
		public Client(Socket s) {
			try {
				this.s=s;
				in=new BufferedReader(new InputStreamReader(s.getInputStream()));
				out=s.getOutputStream();
			} catch(Exception ex) {}
		}
		//실제 통신
		public void run() {
			try {
				while(true) {
					String msg=in.readLine();
					StringTokenizer st=new StringTokenizer(msg,"|");
					int protocol=Integer.parseInt(st.nextToken());
					switch(protocol) {
					case 100:{
						id=st.nextToken();
						name=st.nextToken();
						sex=st.nextToken();
						messageAll(100+"|"+id+"|"+name+"|"+sex);
						waitVc.add(this);
						messageTo(100+"|"+id+"|"+name+"|"+sex);
						waitVc.add(null);
						}
					}
				}
			} catch(Exception ex) {}
		}
		//전체적으로 전송
		public synchronized void messageAll(String msg) {
			
		}
		//개인적으로 전송
		public synchronized void messageTo(String msg) {
			
		}
	}
}
