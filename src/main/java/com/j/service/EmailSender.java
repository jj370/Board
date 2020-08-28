package com.j.service;
import javax.mail.internet.MimeMessage;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage.RecipientType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;

import com.j.dto.EmailDTO;
 
@Component
public class EmailSender  {
    @Autowired
    protected JavaMailSender mailSender;
 
    public void SendEmail(final EmailDTO email) throws Exception {
    	MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message,
				true, "UTF-8");

		messageHelper.setFrom("Trevelers"); // 보내는사람 생략하거나 하면 정상작동을 안함
		messageHelper.setTo(email.getReciver()); // 받는사람 이메일
		messageHelper.setSubject(email.getSubject()); // 메일제목은 생략이 가능하다
		messageHelper.setText(email.getContent(), true); // 메일 내용
		mailSender.send(message);

		// 파일 전송시 여기가 추가
//		FileSystemResource fsr = new FileSystemResource();
//	    messageHelper.addAttachment(filename, fsr);
//		mailSender.send(message);
		
		//기존
//        MimeMessage msg = mailSender.createMimeMessage();
//        msg.setSubject(email.getSubject());
//        msg.setText(email.getContent());
//        msg.setRecipient(RecipientType.TO , new InternetAddress(email.getReciver()));
//        mailSender.send(msg); 
    }
}