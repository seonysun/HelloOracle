package com.sist.client;

import java.awt.CardLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;
//네트워크 관련 라이브러리
import java.net.*; //네트워크 연결 -> Socket
import java.io.*; //서버와 통신(입출력) -> BufferedReader(결과값 읽기)/OutputStream(요청값 전송)
import java.util.*; //데이터 묶기(자름) -> StringTokenizer

//import com.sist.dao.*;
 
public class ClientMain extends JFrame implements ActionListener, Runnable{
	CardLayout card=new CardLayout();
	Login login=new Login();
	WaitRoom wr=new WaitRoom();
	//네트워크 관련 클래스
	private Socket s; //서버 연결
	private OutputStream out; //서버로 요청값 전송 -> 자체 처리 out.write()
	private BufferedReader in; //서버에서 전송된 값 받음 -> 쓰레드 이용 in.readLine()
//	MemberDAO dao=new MemberDAO();
	public ClientMain() { 
		//윈도우창 생성
		setLayout(card);
		setSize(850,650);
		setVisible(true);
		setDefaultCloseOperation(EXIT_ON_CLOSE); 
								//X 버튼 클릭 시 메모리 해제
		//로그인, waitRoom 기능 추가
		add("WR",wr); 
		add("LOGIN",login);
		//로그인의 버튼 기능 설정
		login.b1.addActionListener(this); 
	}
	public static void main(String[] args) {
		//윈도우창 모양(UI) 설정
		try {
			UIManager.setLookAndFeel("com.jtattoo.plaf.mcwin.McWinLookAndFeel"); 
		} catch(Exception ex) {}
		//실행
		new ClientMain();
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		if(e.getSource()==login.b1) {
			String id=login.tf1.getText();
			if(id.trim().length()<1){
				JOptionPane.showMessageDialog(this, "ID를 입력하세요");
				login.tf1.requestFocus();
				return;
			}
			String name=login.tf2.getText();
			if(name.trim().length()<1){
				JOptionPane.showMessageDialog(this, "이름을 입력하세요");
				login.tf2.requestFocus();
				return;
			}
			//오라클 연결
//			String result=dao.isLogin(id, pwd);
//			if(result.equals("NOID")) {
//				JOptionPane.showMessageDialog(this, "ID가 존재하지 않습니다");
//				login.tf1.setText(""); 
//				login.tf2.setText(""); //입력칸 공백으로 재설정
//			} else if(result.equals("NOPWD")) {
//				JOptionPane.showMessageDialog(this, "비밀번호가 틀립니다");
//				login.tf2.setText("");
//			} else JOptionPane.showMessageDialog(this, result+"님 로그인되었습니다");
			
			String sex="";
			if(login.rb1.isSelected()) {
				sex="남자";
			} else sex="여자";
		}
	}
	//로그인처리 -> 서버와 연결
	public void connection(String id, String name, String sex) {
		try {
			s=new Socket("localhost",3355);
						//IP, port
			in=new BufferedReader(new InputStreamReader(s.getInputStream()));
														//서버 요청값 서버 메모리에 저장
									//필터스트림 : byte->char 변환
			out=s.getOutputStream();
					//추상클래스 -> new 없이 객체 생성
			out.write((100+"|"+id+"|"+name+"|"+sex+"\n").getBytes());
		} catch(Exception ex) {}
	}
	//서버 요청값 받기 -> IO(읽기/보내기)는 단방향이므로 쓰레드 사용하여 동시 수행
	@Override
	public void run() {
		try {
			while(true) {
				String msg=in.readLine();
				StringTokenizer st=new StringTokenizer(msg,"|");
				int protocol=Integer.parseInt(st.nextToken());
				switch(protocol) {
				case 100:{
					String[] data= {
							st.nextToken(),
							st.nextToken(),
							st.nextToken()
					};
					wr.model2.addRow(data);
				}
					break;
				case 110:{
					card.show(getContentPane(), "WR");
				}
					break;
				}
			}
		} catch(Exception ex) {}
	}
}
