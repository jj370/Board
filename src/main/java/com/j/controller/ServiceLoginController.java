package com.j.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.j.dto.TravelersDTO;
import com.j.service.LoginService;
import com.j.service.RegisterService;

@Controller
public class ServiceLoginController {
	@Autowired
	private LoginService logingservice;
	@Autowired
	private RegisterService regservice;
	
	/* 로그인 기능 */
	// 로그인 페이지 연결
	@RequestMapping("login")
	public String login() {
		return "service_login/login";
	}
	// 로그인 유효성 검사
	@RequestMapping(value="login_chk",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String login_chk(TravelersDTO dto, HttpSession session) throws JsonProcessingException {
		String result=logingservice.login_chk(dto, session);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString(result);
		return strJson;
	}
	// 아이디 찾기 페이지
	@RequestMapping("find_id")
	public String find_id() {
		return "service_login/find_id";
	}
	@RequestMapping(value="get_id",method=RequestMethod.POST,
		produces = "application/json;charset=utf-8")
	@ResponseBody
	public String get_id(@RequestParam(value="email") String useremail) throws Exception {
		String result = logingservice.get_id(useremail);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString(result);
		return strJson;
	}
	// 비밀번호 찾기 페이지
	@RequestMapping("find_pwd")
	public String find_pwd() {
		return "service_login/find_pwd";
	}
	@RequestMapping(value="send_pwd",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String send_pwd(TravelersDTO dto) throws Exception {
		String result = logingservice.send_pwd(dto);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString(result);
		return strJson;
	}
	// 로그아웃
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		TravelersDTO dto = (TravelersDTO) session.getAttribute("loginUser");
		LoginService.sessions.get(dto.getId()).invalidate();
		LoginService.sessions.remove(dto.getId());
		LoginService.loginUserList.remove(dto.getNick());
		return "home";
	}
	
	/* 회원가입 기능 */
	// 이용약관 & 개인정보처리방침 동의 페이지
	@RequestMapping("reg_tos")
	public String reg_tos() {
		return "service_login/reg_tos";
	}
	// 회원가입 페이지
	@RequestMapping("reg")
	public String reg() {
		return "service_login/reg";
	}
	// 회원가입 완료 페이지
	@RequestMapping("reg_end")
	public String reg_end() {
		return "service_login/reg_end";
	}
	/* 회원가입 유효성 검사 */
	// 이메일 인증코드 보내기
	private String email_code;
	@RequestMapping(value="send_email",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String send_email(@RequestParam(value="email") String useremail) throws Exception {
		email_code=regservice.send_email(useremail);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString(email_code);
		return strJson;
	}
	// 이메일 인증코드 확인
	@RequestMapping(value="code_chk",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String code_chk(@RequestParam(value="usercode") String usercode) throws Exception {
		String result=regservice.code_chk(email_code, usercode);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString(result);
		return strJson;
	}
	// email 중복 확인
	@RequestMapping(value="email_chk",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String email(@RequestParam(value="email") String email) throws JsonProcessingException {
		String result=regservice.email_chk(email);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString(result);
		return strJson;
	}
	// 아이디 중복 확인
	@RequestMapping(value="id_chk",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String id_chk(@RequestParam(value="userid") String userid) throws JsonProcessingException {
		String result=regservice.id_chk(userid);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString(result);
		return strJson;
	}
	// 닉네임 중복 확인
	@RequestMapping(value="nick_chk",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String nick_chk(@RequestParam(value="usernick") String usernick) throws JsonProcessingException {
		String result=regservice.nick_chk(usernick);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString(result);
		return strJson;
	}
	// 회원가입
	@RequestMapping(value="insert_user",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String insert_user(TravelersDTO dto) throws JsonProcessingException {
		regservice.insert_user(dto);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString("회원가입");
		return strJson;
	}
	/* 마이페이지 기능 */
	// 마이페이지 연결
	@RequestMapping("mypage")
	public String mypage() {
		return "service_login/mypage";
	}
	// 마이페이지 기능 사용전 본인확인을 위한 비밀번호 체크 페이지
	@RequestMapping("chk_pwd")
	public String chk_pwd() {
		return "service_login/chk_pwd";
	}
	// 마이페이지 기능 사용전 본인확인을 위한 비밀번호 체크 기능
	@RequestMapping(value="chk_dbpwd",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String chk_dbpwd(TravelersDTO dto) throws Exception {
		String result=logingservice.chk_dbpwd(dto);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString(result);
		return strJson;
	}
	// 회원정보 수정 페이지
	@RequestMapping("change_userinfo")
	public String change_userinfo() {
		return "service_login/change_userinfo";
	}
	// 회원정보 수정
	@RequestMapping(value="update_user",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String update_user(TravelersDTO dto, HttpSession session) throws Exception {
		logingservice.update_user(dto,session);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString("");
		return strJson;
	}
	// 회원탈퇴 페이지
	@RequestMapping("withdrawal")
	public String withdrawal() {
		return "service_login/withdrawal";
	}
	// 회원탈퇴 기능
	@RequestMapping(value="delete_User",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String delete_User(TravelersDTO dto, HttpSession session) throws JsonProcessingException {
		logingservice.delete_User(dto,session);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString("회원가입");
		return strJson;
	}
	// 비밀번호 수정 페이지
	@RequestMapping("change_pwd")
	public String change_pwd() {
		return "service_login/change_pwd";
	}
	@RequestMapping(value="change_pwd_save",method=RequestMethod.POST,
			produces = "application/json;charset=utf-8")
	@ResponseBody
	public String change_pwd_save(TravelersDTO dto, HttpSession session) throws Exception {
		String result = logingservice.change_pwd_save(dto,session);
		ObjectMapper mapper=new ObjectMapper();
		String strJson=mapper.writeValueAsString(result);
		return strJson;
	}
	
}
