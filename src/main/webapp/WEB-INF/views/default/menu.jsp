<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
							<ul class="alt">
								<li><a href="mypage">내정보</a></li>
								<li><a href="travelDiary">여행수첩</a></li>
								<li><a href="note?nick=${loginUser.nick }">쪽지함</a></li>
								<li><a href="myPost?page=1&nick=${loginUser.nick }">작성한 글 관리</a></li>
								<li><a href="chk_pwd?page=change_userinfo">회원정보 수정</a></li>
								<li><a href="chk_pwd?page=change_pwd">비밀번호 수정</a></li>
								<li><a href="withdrawal">회원탈퇴</a></li>
							</ul>
</body>
</html>