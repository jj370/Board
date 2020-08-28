package com.j.controller;
import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.j.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	private AdminService service;
	
	@RequestMapping("admin_page")
	public String admin_page() {
		return "admin/admin_page";
	}
	@RequestMapping("notice_event")
	public String notice_event() {
		return "admin/notice_event";
	}
 
	
}
