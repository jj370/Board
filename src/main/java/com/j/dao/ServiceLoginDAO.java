package com.j.dao;
import java.util.HashMap;

import java.util.Map;

import javax.annotation.Resource;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import com.j.dto.TravelersDTO;

@Repository
public class ServiceLoginDAO {
	@Autowired
	@Resource(name="servicelogin_sqlSession")
	private SqlSession servicelogin_sqlSession;
	public static final String namespace="com.j.ServiceLogin_mybatis.myMapper";
	private TravelersDTO dto;
	private String result;
	/* 트랜잭션 */
	@Autowired
	@Resource(name="servicelogin_transactionTemplate")
	private TransactionTemplate transactionTemplate;
	public void setTransactionTemplate(TransactionTemplate transactionTemplate) {
		this.transactionTemplate = transactionTemplate;
	}
	// 로그인 정보 가져오기
	public TravelersDTO login_chk(final String id) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					dto=servicelogin_sqlSession.selectOne(namespace+".login_chk", id);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	// 아이디 찾기. 이메일로 아이디 가져오기
	public String get_id(final String useremail) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					dto=servicelogin_sqlSession.selectOne(namespace+".get_id", useremail);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
		if (dto==null) {
			result="아이디없음";
		}else {
			result=dto.getId();
		}
		return result;
	}
	// 아이디 찾기. 아이디와 이메일로 아이디 가져오기
	public String get_pwd(final TravelersDTO dto2) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					dto=servicelogin_sqlSession.selectOne(namespace+".get_pwd", dto2);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
		if (dto==null) {
			result="아이디없음";
		}else {
			result=dto.getId();
		}
		return result;
	}
	// 비밀번호 임시 비밀번호로 설정
	public void update_pwd(final TravelersDTO dto) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					servicelogin_sqlSession.selectOne(namespace+".update_pwd", dto);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 이메일 중복 체크
	public TravelersDTO email_chk(final String email) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					dto=servicelogin_sqlSession.selectOne(namespace+".email_chk", email);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	// 아이디 중복 확인
	public TravelersDTO id_chk(final String id) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					dto=servicelogin_sqlSession.selectOne(namespace+".login_chk", id);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	// 닉네임 중복 확인
	public TravelersDTO nick_chk(final String usernick) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					dto=servicelogin_sqlSession.selectOne(namespace+".nick_chk", usernick);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	// 회원가입 기능
	public String insert_user(final TravelersDTO dto) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					servicelogin_sqlSession.selectOne(namespace+".insert_user", dto);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	// 회원탈퇴 기능
	public void delete_User(final TravelersDTO dto) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					servicelogin_sqlSession.selectOne(namespace+".delete_User", dto);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 정보 수정
	String nickname;
	public void update_user(final TravelersDTO dto) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					String id=dto.getId();
					nickname=servicelogin_sqlSession.selectOne(namespace+".getNick", id);
					servicelogin_sqlSession.update(namespace+".update_user", dto);
					Map<String, String> map=new HashMap<String, String>();
					map.put("old_nick", nickname);
					map.put("new_nick", dto.getNick());
					System.out.println(nickname);
					System.out.println(dto.getNick());
					servicelogin_sqlSession.update(namespace+".update_info_nick", map);
					servicelogin_sqlSession.update(namespace+".update_review_nick", map);
					servicelogin_sqlSession.update(namespace+".update_free_nick", map);
					servicelogin_sqlSession.update(namespace+".update_mate_nick", map);
					servicelogin_sqlSession.update(namespace+".update_info_comment_nick", map);
					servicelogin_sqlSession.update(namespace+".update_review_comment_nick", map);
					servicelogin_sqlSession.update(namespace+".update_free_comment_nick", map);
					servicelogin_sqlSession.update(namespace+".update_mate_comment_nick", map);
					servicelogin_sqlSession.update(namespace+".update_mate_reply_nick", map);
					servicelogin_sqlSession.update(namespace+".update_diary_comment_nick", map);
					servicelogin_sqlSession.update(namespace+".update_report_writer_nick", map);
					servicelogin_sqlSession.update(namespace+".update_report_nick", map);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 정보 수정 후 loginUser 값 다시 담기
	public TravelersDTO change_session_value(final String id) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					dto=servicelogin_sqlSession.selectOne(namespace+".login_chk", id);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	// 비밀번호 변경
	public void change_pwd_save(final TravelersDTO dto) {
		try {
			transactionTemplate.execute(new TransactionCallbackWithoutResult() {
				@Override
				protected void doInTransactionWithoutResult(TransactionStatus status) {
					servicelogin_sqlSession.selectOne(namespace+".change_pwd_save", dto);
				}
			});
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}