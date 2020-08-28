<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="is-preload" onload="chk_loginUser()">
	<%@ include file="../default/header.jsp"%>
	<!-- Page Wrapper -->
	<div id="page-wrapper">
		<!-- Main -->
		<article id="main">
			<section class="wrapper style5">
				<div class="inner">
					<section>
						<c:choose>
							<c:when test="${loginUser.id=='admin'}">
								<h2>Admin Page</h2>
								<div class="row" style="width:1400px;display: flex;">
									<div class="col-6 col-12-medium" style="width:250px;">
										<ul class="alt">
											<li><a href="myPost?page=1&nick=${loginUser.nick }">작성한 글 관리</a></li>
											<li><a href="report_post">신고 글 관리</a></li>
											<li><a href="chk_pwd?page=change_userinfo">회원정보 수정</a></li>
											<li><a href="chk_pwd?page=change_pwd">비밀번호 수정</a></li>
											<li><a href="withdrawal">회원탈퇴</a></li>
										</ul>
									</div>
							</c:when>
							<c:otherwise>
								<h2>My Page</h2>
									<div class="row" style="width:1400px;display: flex;">
									<div class="col-6 col-12-medium" style="width:200px;">
										<ul class="alt">
											<li><a href="mypage">내정보</a></li>
											<li><a href="travelDiary">여행수첩</a></li>
											<li><a href="note?nick=${loginUser.nick }">쪽지함</a></li>
											<li><a href="myPost?page=1&nick=${loginUser.nick }">작성한 글 관리</a></li>
											<li><a href="chk_pwd?page=change_userinfo">회원정보 수정</a></li>
											<li><a href="chk_pwd?page=change_pwd">비밀번호 수정</a></li>
											<li><a href="withdrawal">회원탈퇴</a></li>
										</ul>
									</div>
							</c:otherwise>
							</c:choose>
							<div align="center" style="margin-left: 50px;">
							<h2>작성한 글 관리</h2>
									<a href="myPost?page=1&nick=${loginUser.nick }">여행 동행 찾기</a>&nbsp;|&nbsp;
									<a href="myPost_info?page=1&nick=${loginUser.nick }">정보 공유 게시판</a>&nbsp;|&nbsp;
									<a href="myPost_review?page=1&nick=${loginUser.nick }">여행 리뷰 게시판</a>&nbsp;|&nbsp;
									<a href="myPost_free?page=1&nick=${loginUser.nick }">자유 게시판</a>
								<table style="font-size:0.9em; text-align: center;width: 750px; margin: 0 auto; height : 60px; background-color: white;">
									<tr>
										<th style="width:500px;text-align:center;">제목</th>
										<th style="width:150px;text-align:center;">작성일</th>
										<th style="width:100px;text-align:center;">조회</th>
									</tr>
										<c:choose>
											<c:when test="${free_list.size() eq 0}">
												<tr>
													<td colspan="3" style="text-align:ceter;">작성된 게시글이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${free_list }" var="list">
													<tr>			
														<jsp:useBean id="now" class="java.util.Date" />
														<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
														<fmt:formatDate var="savedate" value="${list.savedate }" pattern="yyyy-MM-dd"/>
													<c:choose>
														<c:when test="${savedate==today}">
															<td style="text-align:left;"><a href="free_content_view?num=${list.num }">${list.title }</a>
															<img src="resources/main_image/new.png" style="width:25px;"></td>
															<fmt:formatDate var="savedate" value="${list.savedate }" pattern="hh:mm"/>
															<td style="text-align:ceter;">${savedate }</td>
															<td style="text-align:ceter;">${list.hit }</td></tr>
														</c:when>
														<c:otherwise>
															<td style="text-align:left;"><a href="free_content_view?num=${list.num }">${list.title }</a></td>
															<fmt:formatDate var="savedate" value="${list.savedate }" pattern="yyyy-MM-dd"/>
															<td style="text-align:ceter;">${savedate }</td>
															<td style="text-align:ceter;">${list.hit }</td>
														</tr>
															</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:otherwise>
											</c:choose>
										</table>
									</div>
								</div>
								</div>
						</section>
					</div>
			</section>
		</article>
	</div>
	<%@ include file="../default/footer.jsp" %>
<style>
table  {
    width: 100%;
    border-top: 1px solid rgba(50, 50, 50, 0.2);
    border-collapse: collapse;
  }
th, td {
	background-color: white;
    border-bottom: 1px solid rgba(50, 50, 50, 0.2);
    padding: 10px;
    margin: 10px;
  }
</style>
</body>
</html>