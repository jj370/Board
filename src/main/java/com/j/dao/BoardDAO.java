package com.j.dao;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;

import com.j.dto.BoardDTO;

@Repository
public class BoardDAO {
	@Autowired
	@Resource(name = "board_sqlSession")
	private SqlSession board_sqlSession;
	int result;
	private Map map;
	private List<BoardDTO> list;

	public BoardDAO() {
	}

	public static final String namespace = "com.j.mybatis.boardMapper";

	// 게시판 전체 글 목록 가져오기
	public List<BoardDTO> listAll(int page) {
		map = new HashMap<String, Object>();
		if (page > 1) {
			map.put("str", (page - 1) * 10 + 1);
			map.put("end", (Integer) map.get("str") + 9);
		} else {
			map.put("str", 1);
			map.put("end", 10);
		}
		list = board_sqlSession.selectList(namespace + ".listAll", map);
		return list;
	}

	// 공지, 이벤트 글 가져오기
	public List<BoardDTO> notis_list() {
		list = board_sqlSession.selectList(namespace + ".notis_list");
		return list;
	}

	// 정보 게시판 전체 글 수 가져오기 기능
	public int totPage() {
		result = board_sqlSession.selectOne(namespace + ".totPage");
		return result;
	}

	// 글 저장
	public int write_save(BoardDTO dto) {
		result = board_sqlSession.insert(namespace + ".write_save", dto);
		return result;
	}

}
