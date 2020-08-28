package com.j.dao;

import java.util.ArrayList;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;


@Repository
public class AdminDAO {
	@Autowired
	@Qualifier("admin_sqlSession")
	private SqlSession admin_sqlSession;
	public static final String namespace = "com.j.admin_mybatis.myMapper";
	/* 트랜잭션 */
	@Autowired
	@Resource(name = "admin_transactionTemplate")
	private TransactionTemplate transactionTemplate;

	public void setTransactionTemplate(TransactionTemplate transactionTemplate) {
		this.transactionTemplate = transactionTemplate;
	}

	/* Admin Page 기능 */
	//
	
}
