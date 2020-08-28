<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="resources/html5up-spectral/assets/css/main.css" />
<noscript><link rel="stylesheet" href="resources/html5up-spectral/assets/css/noscript.css" /></noscript>
</head>
<body>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<fmt:requestEncoding value="utf-8" />
	<!-- Header -->
	<header id="header">
		<h1>
			<a href="/Travelers">Travelers</a>
		</h1>
		<nav id="nav">
			<ul>
				<li class="special"><a href="#menu" class="menuToggle"><span>Menu</span></a>
					<div id="menu">
						<ul>
							<c:choose>
								<c:when test="${loginUser.id == 'admin'}">
									<li><a href="/Travelers/">Home</a></li>
									<li><a href="about">About</a></li>
									<li><a href="logout">로그아웃</a></li>
									<li><a href="admin_page">관리자 페이지</a></li>
									<li><a href="mate_board_list?page=1">여행 동행 찾기</a></li>
									<li><a href="reviewboard?page=1">여행 리뷰 게시판</a></li>
									<li><a href="info_list?page=1">정보 공유 게시판</a></li>
									<li><a href="free_board_list?page=1">자유 게시판</a></li>
								</c:when>
								<c:when test="${loginUser!=null }">
									<li><a href="/Travelers/">Home</a></li>
									<li><a href="about">About</a></li>
									<li><a href="logout">로그아웃</a></li>
									<li><a href="mypage">마이페이지</a></li>
									<li><a href="mate_board_list?page=1">여행 동행 찾기</a></li>
									<li><a href="reviewboard?page=1">여행 리뷰 게시판</a></li>
									<li><a href="info_list?page=1">정보 공유 게시판</a></li>
									<li><a href="free_board_list?page=1">자유 게시판</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="/Travelers/">Home</a></li>
									<li><a href="about">About</a></li>
									<li><a href="login">로그인</a></li>
									<li><a href="reg_tos">회원가입</a></li>
									<li><a href="mate_board_list?page=1">여행 동행 찾기</a></li>
									<li><a href="reviewboard?page=1">여행 리뷰 게시판</a></li>
									<li><a href="info_list?page=1">정보 공유 게시판</a></li>
									<li><a href="free_board_list?page=1">자유 게시판</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</li>
			</ul>
		</nav>
	</header>
</body>
</html>