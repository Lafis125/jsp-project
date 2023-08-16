package com.team3.bongguu.email;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MailAuth extends Authenticator {

	PasswordAuthentication pa;

	public MailAuth() {

		String mail_id = "qhdvlfrbs@gmail.com";
		String mail_pw = "glmbuxossdirsosf";

		pa = new PasswordAuthentication(mail_id, mail_pw);
	}

	public PasswordAuthentication getPasswordAuthentication() {

		return pa;

	}
}
