package com.team3.bongguu.email;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSend {

	public String MailSends(String email , String newPW) {

		Properties prop = System.getProperties();

		prop.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
		
		prop.put("mail.smtp.starttls.enable", "true");

		prop.put("mail.smtp.host", "smtp.gmail.com");

		prop.put("mail.smtp.auth", "true");

		prop.put("mail.smtp.port", "587");

		Authenticator auth = new MailAuth();

		Session session = Session.getDefaultInstance(prop, auth);

		MimeMessage msg = new MimeMessage(session);

		try {

			msg.setSentDate(new Date());

			msg.setFrom(new InternetAddress("qhdvlfrbs@gmail.com", "BongGuu-공동구매")); // 발송자의 메일, 발송자명

			InternetAddress to = new InternetAddress(email); // - 수신자의 메일을 생성한다.

			msg.setRecipient(Message.RecipientType.TO, to);
			// Message.RecipientType.TO : 받는 사람
			// Message.RecipientType.CC : 참조
			// Message.RecipientType.BCC : 숨은 참조

			msg.setSubject("test제목", "UTF-8");

			msg.setText("BongGuu-공동구매 오신걸 환영합니다.\n"
					+ " 새로운 임시 비밀번호 발급해드리겠습니다.\n"
					+ " 새로운 임시 비밀번호 : ["+newPW+"] 입니다.\n"
					+ "❤️ 오늘도 좋은 하루 보내시길 바랍니다 ❤️" , "UTF-8");
			

			Transport.send(msg);

		} catch (AddressException ae) {

			System.out.println("AddressException : " + ae.getMessage());

		} catch (MessagingException me) {

			System.out.println("MessagingException : " + me.getMessage());

		} catch (UnsupportedEncodingException e) {

			System.out.println("UnsupportedEncodingException : " + e.getMessage());

		}
		return "일단 전송 확인";

	}

}
