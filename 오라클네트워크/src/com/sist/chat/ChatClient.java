package com.sist.chat;

import java.util.*; //StringTokenizer
import java.io.*; //OutputStream, BufferedReader
import java.net.*; //Socket
import javax.swing.*; //JFrame
import java.awt.*;
import java.awt.event.*;

public class ChatClient extends JFrame implements ActionListener,Runnable{
	JTextArea ta;
	JTextField tf;
	JButton b1,b2;
	private String name;
	//네트워크 관련 라이브러리
	private Socket s; //연결 기기
	private OutputStream out; //서버로 전송
	private BufferedReader in; //서버 값 읽기
	public ChatClient() {
		ta=new JTextArea();
		JScrollPane js=new JScrollPane(ta);
		ta.setEditable(false);
		tf=new JTextField();
		tf.setEnabled(false); //접속하지 않으면 입력 불가하도록 창 비활성화
		b1=new JButton("접속");
		b2=new JButton("종료");
		
		JPanel p=new JPanel();
		p.add(tf);
		p.add(b1);p.add(b2);
		add("Center",js);
		add("South",p);
		setSize(520,600);
		setVisible(true);
		
		b1.addActionListener(this);
		b2.addActionListener(this);
			//버튼을 누르면 CallBack -> ActionListener가 갖는 메소드 자동 호출; actionPerformed()
			//CallBack : 시스템(JVM)에 의해 자동 호출 ex.main
		tf.addActionListener(this);
			//엔터 누르면 CallBack
	}
	public static void main(String[] args) {
		new ChatClient();
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		if(e.getSource()==b1) {
			name=JOptionPane.showInputDialog("이름 입력:");
			//서버 연결
			try {
				s=new Socket("localhost",3355); //서버 연결
				in=new BufferedReader(new InputStreamReader(s.getInputStream())); //서버로부터 값 받기
				out=s.getOutputStream(); //서버로 전송
			} catch(Exception ex) {}
			b1.setEnabled(false);
			tf.setEnabled(true);
			tf.requestFocus();
		}
		if(e.getSource()==b2) {
			dispose(); //윈도우 메모리 회수 -> gc()
			System.exit(0);
		}
		if(e.getSource()==tf) {
			String msg=tf.getText();
			if(msg.trim().length()<1)
				return;
			try {
				out.write(("["+name+"]"+msg+"\n").getBytes());
			} catch(Exception ex) {}
			//ta.append(msg+"\n");
			//서버로부터 들어오는 데이터 읽기 시작 명력
			new Thread(this).start();
			tf.setText("");
		}
	}
	@Override
	public void run() { //서버에서 보내준 데이터 출력
		try {
			while(true) {
				String msg=in.readLine(); //서버에서 보내준 데이터 받음
				ta.append(msg+"\n");
			}
		} catch(Exception ex) {}
	}
}
