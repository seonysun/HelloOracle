package com.sist.client;

import java.awt.*;
import javax.swing.*;
import javax.swing.table.*;

public class WaitRoom extends JPanel{
	JTable table1, table2;
	DefaultTableModel model1, model2;
	JTextArea ta;
	JTextField tf;
	JButton b1,b2,b3,b4,b5,b6;
	JLabel la1,la2;
	public WaitRoom() {
		String[] col1= {"방이름","상태","인원"};
		String[][] row1=new String[0][3];
								//한 줄에 데이터 3개 대입 -> 2차 배열
		model1=new DefaultTableModel(row1,col1){
			/* 익명의 클래스
			 * 	- 상속 없이 오버라이딩, 메소드 추가할 경우 주로 사용
			 * 		-> 오버라이딩에 상속이 반드시 선행되어야 하는 것은 아님
			 * 	class B{
			 * 		public void disp(){}
			 * 	}
			 * 	class A{
			 * 		B b=new B(){ //익명의 클래스
			 * 			public void disp(){} //생성자 내에서 상속 없이 오버라이딩
			 * 		}
			 * 	}
			 */
			//편집 방지
			@Override
			public boolean isCellEditable(int row, int column) {
				return false;
			}
		};
		table1=new JTable(model1);
		JScrollPane js1=new JScrollPane(table1);
		
		String[] col2= {"ID","이름","성별"};
		String[][] row2=new String[0][3];
		model2=new DefaultTableModel(row2,col2){
			@Override
			public boolean isCellEditable(int row, int column) {
				return false;
			}
		};
		table2=new JTable(model2);
		JScrollPane js2=new JScrollPane(table2);
		
		ta=new JTextArea();
		JScrollPane js3=new JScrollPane(ta);
		ta.setEditable(false);
		
		tf=new JTextField();
		
		la1=new JLabel("개설된 방 정보");
		la2=new JLabel("접속한 사용자 정보");
		
		b1=new JButton("방만들기");
		b2=new JButton("입장하기");
		b3=new JButton("쪽지보내기");
		b4=new JButton("정보보기");
		b5=new JButton("1:1 채팅");
		b6=new JButton("종료하기");
		
		//배치
		setLayout(null);
		la1.setBounds(10, 15, 120, 30);
		js1.setBounds(10, 50, 500, 330);
		la2.setBounds(520, 15, 300, 30);
		js2.setBounds(520, 50, 300, 200);
		js3.setBounds(10, 390, 500, 150);
		tf.setBounds(10, 520, 500, 30);
		
		JPanel p=new JPanel();
		p.add(b1);p.add(b2);p.add(b3);p.add(b4);p.add(b5);p.add(b6);
		p.setLayout(new GridLayout(3, 2, 5, 5));
		p.setBounds(520,265,300,100);
		
		add(la1);add(la2);
		add(js1);add(js2);add(js3);
		add(tf);
		add(p);
	}
}
