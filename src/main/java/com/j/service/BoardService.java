package com.j.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.j.dao.BoardDAO;
import com.j.dto.BoardDTO;

@Service
public class BoardService {
	@Autowired
	private BoardDAO dao;
	
	// 게시판 전체 글 목록 가져오기 기능
	public void listAll(Model model, int page) {
		model.addAttribute("list",dao.listAll(page));
		model.addAttribute("notis_list",dao.notis_list());
		model.addAttribute("totPage",dao.totPage());
	}
	
	
	
	// 글 저장
	public int write_save(BoardDTO dto) {
		return dao.write_save(dto);
	}
}
