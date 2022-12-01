package com.sist.client;

import java.awt.CardLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;

import com.sist.dao.*;

public class ClientMain extends JFrame implements ActionListener{
	CardLayout card=new CardLayout();
	Login login=new Login();
	WaitRoom wr=new WaitRoom();
	MemberDAO dao=new MemberDAO();
	public ClientMain() {
		setLayout(card);
		setSize(1300,850);
		setVisible(true);
		setDefaultCloseOperation(EXIT_ON_CLOSE); //X 버튼 클릭 시 메모리 해제
		
		add("LOGIN",login);
		add("WR",wr);
		
		login.b1.addActionListener(this);
	}
	public static void main(String[] args) {
		try {
			UIManager.setLookAndFeel("com.jtattoo.plaf.mcwin.McWinLookAndFeel");
						//윈도우창 모양(UI) 설정
		} catch(Exception ex) {}
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
			String pwd=login.tf2.getText();
			if(pwd.trim().length()<1){
				JOptionPane.showMessageDialog(this, "비밀번호를 입력하세요");
				login.tf2.requestFocus();
				return;
			}
			
			String result=dao.isLogin(id, pwd);
			if(result.equals("NOID")) {
				JOptionPane.showMessageDialog(this, "ID가 존재하지 않습니다");
				login.tf1.setText("");
				login.tf2.setText("");
			} else if(result.equals("NOPWD")) {
				JOptionPane.showMessageDialog(this, "비밀번호가 틀립니다");
				login.tf2.setText("");
			} else JOptionPane.showMessageDialog(this, result+"님 로그인되었습니다");
		}
	}

}
