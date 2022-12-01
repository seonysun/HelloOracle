

import java.io.*;
import java.util.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class MultiThread_ extends JFrame implements ActionListener{
													//Button, Menu, JTextField(Enter)
	JTextArea my,thread;
	JButton b;
	MyThread3 t;
	public MultiThread_() {
		my=new JTextArea();
		JScrollPane js1=new JScrollPane(my);
		thread=new JTextArea();
		thread.setEditable(false); //비활성화
		JScrollPane js2=new JScrollPane(thread);
		b=new JButton("저장");
		
		//규격 설정
		setLayout(null); 
				 //사용자 지정
		js1.setBounds(10, 15, 300, 420); //가로
		js2.setBounds(320, 15, 300, 420); //세로
		b.setBounds(10, 450, 100, 30);
		
		//윈도우에 추가
		add(js1);add(js2);add(b);
		setSize(650, 520);
		setVisible(true);
		
		b.addActionListener(this);
	}
	public static void main(String[] args) {
		new MultiThread_();

	}
	@Override
	public void actionPerformed(ActionEvent e) {
		if(e.getSource()==b) {
			try {
				String msg=my.getText();
				if(msg.trim().length()<1) {
					JOptionPane.showMessageDialog(this, "데이터를 입력하세요");
					my.requestFocus();
					return;
				}
				FileWriter fw=new FileWriter("c:\\java_data\\chat.txt",true);
																	//append 모드
				fw.write(msg);
				fw.close();
				
				t=new MyThread3();
				t.start();
			} catch(Exception ex) {}
		}
	}
	class MyThread3 extends Thread{ //내부클래스 -> 클래스의 멤버처럼 사용(서로 데이터 공유)
		public void run() {
			try {
				//파일 읽기
				FileReader fr=new FileReader("c:\\java_data\\chat.txt");
				int i=0;
				String msg="";
				while((i=fr.read())!=-1) {
					msg+=String.valueOf((char)i);
				}
				fr.close();
				//윈도우 창에 출력
				thread.setText(msg);
				//쓰레드 종료
				t.interrupt();
			} catch(Exception ex) {}
		}
	}

}
