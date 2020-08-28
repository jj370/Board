<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:requestEncoding value="utf-8" />
<html>
<head>
<title>메인</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="resources/html5up-spectral/assets/css/main.css" />
<noscript><link rel="stylesheet" href="resources/html5up-spectral/assets/css/noscript.css" /></noscript>
</head>
<body class="landing is-preload">
	
	<!-- Page Wrapper -->
	<div id="page-wrapper">
		
		<!-- Header -->
		<header id="header" class="alt">
			<h1 id="top">
				<a href="/Travelers/">Travelers</a>
			</h1>
			<nav id="nav">
				<ul>
					<li class="special"><a href="#menu" class="menuToggle"><span>Menu</span></a>
						<div id="menu">
							<ul>
								<c:choose>
									<c:when test="${loginUser.id == 'admin' }">
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
										<li><a href="login">로그인</a></li>
										<li><a href="about">About</a></li>
										<li><a href="reg_tos">회원가입</a></li>
										<li><a href="mate_board_list?page=1">여행 동행 찾기</a></li>
										<li><a href="reviewboard?page=1">여행 리뷰 게시판</a></li>
										<li><a href="info_list?page=1">정보 공유 게시판</a></li>
										<li><a href="free_board_list?page=1">자유 게시판</a></li>
									</c:otherwise>
								</c:choose>
							</ul>
						</div></li>
				</ul>
			</nav>
		</header>
		<!-- Banner -->
		<section id="banner">
			<div class="inner">
				<!-- <h2>Travelers</h2>
				<p>
					대충 여행가자는 문구<br> 대충 여행가자는 문구 ^^<br>
				</p> -->
				<h2>
					Travelers<br />
					<!--  eget augue amet aliquet-->
				</h2>
				<p>
				함께 여행 갈 동행을 찾아보세요.<br>
               	마음이 맞는 친구를 만나 어디든 함께 떠나세요.
				</p>
				<!-- <p style="color: white;">
					준 만큼 받는 관계보다 누군가에게 준 것이 돌고 돌아<br> 다시 나에게로 돌아오는 세상이 더 살 만한 세상이
					아닐까.<br> 이런 환대의 순환을 가장 잘 경험할 수 있는게 여행이다.<br> - 김영하 '여행의
					이유'
				</p> -->
				<ul class="actions special">
					<li><a href="mate_board_list?page=1" class="button small">여행 동행 찾기</a></li>
				</ul>
				<a href="#three" class="more scrolly">INTRODUCE</a>
			</div>
		</section>
		
		<!-- Three -->
      <section id="three" class="wrapper style3 special" style="background: #436f9c;">
         <div class="inner">
            <header class="major">
               <h2>USE TECHNOLOGY</h2>
               <p>
                  	제작기간 : 2020.06.25 ~ 2020.08.17
               </p>
            </header>
            <ul class="features">
               <li class="icon fa-paper-plane">
                  <h3>프로그래밍 언어와 프로그램 </h3>
                  <p>
					⦁ Java - Eclipse<br>
					⦁ JSP - EL, JSTL, JavaScript, JQuery<br>
					⦁ Oracle - Oracle SQL Developer<br>
					⦁ Apache Tomcat (Server)<br>
                  </p>
               </li>
               <li class="icon fa-paper-plane">
                  <h3>라이브러리 및 기능</h3>
                  <p>
					⦁ Spring MVC Project<br>
					⦁ Mybatis - Oracle<br>
					⦁ Transaction<br>
					⦁ Ajax<br>
					⦁ Java Mail API<br>
					⦁ 네이버 Smart Editor<br>
					⦁ Spring Security<br>
                  </p>
               </li>
            </ul>
            <br><Br><br>
            <header class="major">
               <h2>Travelers를 만든 사람들</h2>
            </header>
            <ul class="features">
               <li class="icon fa-paper-plane">
                  <h3>권&nbsp;지&nbsp;섭</h3>
                  <p>
                  	1. 여행 리뷰 게시판<br>
					2. 게시판 웹 에디터 적용 (Smart Editor)<br>
					3. 게시판 추천 기능 구현<br>
					4. 마이페이지 - 여행 수첩 (다녀온 여행지 목록 띄우기, 추가, 삭제, 수정)<br>
					5. 중복 로그인 방지<br>
					6. 담당 페이지 CSS 템플릿 적용<br>
                  </p>
               </li>
               <li class="icon solid fa-headphones-alt">
                  <h3>박&nbsp;지&nbsp;원</h3>
                  <p>
                 	1. 동행 찾기 페이지<br>
                 	2. 동행 찾기 상세 검색 구현<br>
					3. 동행 찾기 페이지 달력 기능 구현<br>
					4. 담당 페이지 CSS 템플릿 적용<br>
                  </p>
               </li>
               <li class="icon fa-heart">
                  <h3>이&nbsp;미&nbsp;혜</h3>
                  <p>
                 	1. 정보 공유 게시판<br>
					2. 로그인, 회원가입 페이지<br>
					3. 마이페이지 - 개인정보수정, 비밀번호 변경, 회원탈퇴 <br>
					4. 어드민페이지 - 신고 글 관리<br>
					5. 게시판 신고 기능 구현<br>
					6. CSS 템플릿 적용 및 전체 기본 틀 작성<br>
                  </p>
               </li>
               <li class="icon solid fa-gem">
                  <h3>차&nbsp;은&nbsp;주</h3>
                  <p>
                  	1. 자유 게시판<br>
					2. 게시판 웹 에디터 적용 (Smart Editor)<br>
					3. 마이페이지 - 내가 작성한 글 목록<br>
					4. about 페이지<br>
					5. 담당 페이지 CSS 템플릿 적용<br>
                  </p>
               </li>
            </ul>
         </div>
      </section>
		
		
		<%@ include file="default/footer.jsp"%>
	</div>
</body>
</html>