package com.sist.emp;
import javax.swing.*;
import java.awt.*;
public class UserMain extends JFrame{
    CardLayout card=new CardLayout();
    Login login=new Login();
    public UserMain()
    {
    	setLayout(card);
    	add("LOGIN",login);
    	
    	setSize(640, 480);
    	setVisible(true);
    	setDefaultCloseOperation(EXIT_ON_CLOSE);
    }
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try
		{
			UIManager.setLookAndFeel("com.jtattoo.plaf.hifi.HiFiLookAndFeel");
		}catch(Exception ex) {}
        new UserMain();
	}

}
