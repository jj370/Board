package com.j.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.j.dto.BoardDTO;
import com.j.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	private BoardService ser;
	
	@RequestMapping("list")
	public String list(Model model, @RequestParam int page) {
		ser.listAll(model,page);
		return "board/list";
	}
	
	@RequestMapping("write")
	public String write() {
		return "board/write";
	}
	
	// 글 저장
	@RequestMapping("write_save")
	public String write_save(BoardDTO dto) {
		System.out.println("글 저장 컨트롤러");
		int result=ser.write_save(dto);
		dto.setNick("테스트닉");
		System.out.println("닉= "+dto.getNick());
		System.out.println("제목= "+dto.getTitle());
		System.out.println("내용= "+dto.getContent());
		if(result==1) {
			return "redirect:login";
		} else {
			return "redirect:write";
		}
	}
}
