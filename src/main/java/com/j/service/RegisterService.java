package com.j.service;
import javax.inject.Inject;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.j.dao.ServiceLoginDAO;
import com.j.dto.EmailDTO;
import com.j.dto.TravelersDTO;

@Service
public class RegisterService {
	@Autowired
	private ServiceLoginDAO dao;
	@Autowired
	private EmailSender emailSender;
	private String result;
	// 이메일 인증코드 보내기
	public String send_email(String useremail) {
		//인증코드 생성
		char[] characterTable =  { //72개
				  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 
                'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
                'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
                'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 
                'w', 'x', 'y', 'z', '!', '@', '#', '$', '%', '^', '&', '*',
                '(', ')', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
		int[] num=new int[8];
		String code="";
		for(int n:num) {
			n = (int) ( Math.random() * 72 );
			code+=characterTable[n];
		}
		
		EmailDTO email = new EmailDTO();
		String reciver = useremail; //유저가 입력한 이메일
		String subject = "[Travelers] 회원가입 인증번호 전송";
		String content = "<div style='display: inline-block; width: 500px; margin: 0 auto; font-size: 14px; border-top: 1px solid #a5a1a0; "
				+"border-bottom: 1px solid #a5a1a0; padding: 5px 0; font-size: 30px;'> Trevelers </div>"
				+"<div style='padding: 10px 0 25px 0; font-size: 15px; color: #221815; letter-spacing: 0;'> Authentication code : </div>"
		+"<div style='font-size: 20px; color: #221815; letter-spacing: 0;'><b>"+code+"</b></div>";
		
		email.setReciver(reciver);
		email.setSubject(subject);
		email.setContent(content);
		try {
			emailSender.SendEmail(email);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return code;
	}
	// 이메일 인증코드 확인
	public String code_chk(String email_code, String usercode) {
		if (email_code.equals(usercode)) {
			result="인증 완료";
		}
		return result;
	}
	// 이메일 중복 확인
	public String email_chk(String email) {
		System.out.println(email);
		TravelersDTO dto=dao.email_chk(email);
		if(dto!=null) {
			result="중복";
		}else {
			result="사용가능";
		}
		return result;
	}
	// 아이디 중복 확인
	public String id_chk(String id) {
		TravelersDTO dto=dao.id_chk(id);
		if(dto!=null) {
			result="중복";
		}else {
			result="사용가능";
		}
		return result;
	}
	// 닉네임 중복 확인
	public String nick_chk(String usernick) {
		TravelersDTO dto=dao.nick_chk(usernick);
		if(dto!=null) {
			result="중복";
		}else {
			result="사용가능";
		}
		return result;
	}
	// 회원 추가
	@Inject
	PasswordEncoder passwordEncoder;
	public void insert_user(TravelersDTO dto) {
		try {
			dto.setPwd(security(dto.getPwd()));
			dao.insert_user(dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	// 비밀번호 암호화
	public String security(String pwd) throws Exception {
		String encPassword = passwordEncoder.encode(pwd);
		return encPassword;
	}
}
