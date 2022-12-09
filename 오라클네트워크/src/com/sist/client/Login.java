package com.sist.client;

import java.awt.*;
import javax.swing.*;

public class Login extends JPanel{
	JTextField tf1,tf2;
		//포함클래스(Login이 가지는 클래스)
	JRadioButton rb1,rb2;
	JButton b1,b2;
	JLabel la1,la2,la3;
	public Login() {
		la1=new JLabel("ID");
		la2=new JLabel("이름");
		la3=new JLabel("성별");
		
		tf1=new JTextField();
		tf2=new JTextField();
		
		rb1=new JRadioButton("남자");
		rb2=new JRadioButton("여자");
		ButtonGroup bg=new ButtonGroup();
		bg.add(rb1);bg.add(rb2);
			//그룹으로 버튼 묶으면 한개만 선택할 수 있게 됨
		rb1.setSelected(true); //기본으로 rb1 선택되도록 설정
		
		b1=new JButton("로그인");
		b2=new JButton("취소");
		
		//배치 Layout (웹 : CSS)
		setLayout(null); 
				//직접 배치
		la1.setBounds(10, 15, 50, 30);
					//x좌표 시작점, y좌표 시작점, x길이, y길이
		tf1.setBounds(65, 15, 150, 30);
		la2.setBounds(10, 50, 50, 30);
		tf2.setBounds(65, 50, 150, 30);
		la3.setBounds(10, 85, 50, 30);
		rb1.setBounds(65, 85, 70, 30);
		rb2.setBounds(140, 85, 70, 30);
		
		add(la1);add(tf1);
		add(la2);add(tf2);
		add(la3);add(rb1);add(rb2);
		
		JPanel p=new JPanel();
		p.add(b1);p.add(b2);
		p.setBounds(10, 125, 205, 35);
		add(p);
	}
}
