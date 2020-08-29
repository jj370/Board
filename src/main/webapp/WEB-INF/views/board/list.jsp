<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
 
</head>
<body class="is-preload">
	<%@ include file="../default/header.jsp"%>
	<!-- Page Wrapper -->
	<div id="page-wrapper">
		<!-- Main -->
		<article id="main">
			<section class="wrapper style5">
				<div class="inner">
					<div class="row" style="width:1400px;display: flex;">
					<div class="col-6 col-12-medium" style="width:200px;">
					<%@ include file="../default/menu.jsp"%>

					</div>
					<div class="col-6 col-12-medium" style="margin-left: 50px;">
					<form action="#">
						<input type="hidden" name="page" value="1">
						<h2 style="text-align: center;">게시판</h2><br>
						<hr style="width: 1070px; margin: 0 auto;">
						<table style="font-size:0.9em; text-align: center;width: 1070px; margin: 0 auto; height : 60px;">
							<tr style="vertical-align: middle;" >
								<td style="width:100px;text-align: center;">번호</td>
								<td style="width:460px;text-align: center;">제목</td>
								<td style="width:200px;text-align: center;">닉네임</td>
								<td style="width:170px;text-align: center;">작성일</td>
								<td style="width:100px;text-align: center;">조회</td>
								<td style="width:100px;text-align: center;">추천</td>
							</tr>
						
							
							<c:choose >
								<c:when test="${list==null }">
									<tr>
										<td colspan="6">등록된 게시글이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="list" items="${list }">
										<tr>
											<jsp:useBean id="now" class="java.util.Date" />
											<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
											<fmt:formatDate var="savedate" value="${list.savedate }" pattern="yyyy-MM-dd"/>
											<td>${list.num }</td>
											
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							<tr style="border-bottom:0;">
								<td colspan="4"></td>
								<td colspan="4">
									<c:choose>
										<c:when test="${loginUser.nick ne null }">
											<input type="button" value="글작성" onclick="location.href=''">
										</c:when>
										<c:otherwise>
											<input type="button" value="글작성" onclick="loginConfirm()">
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</table><br>
						
					</form>	
					</div>				
				</div>
			</section>
		</article>
	</div>
	<%@ include file="../default/footer.jsp"%>
<style>
a{
border-bottom:0;
}
td  {
background-color: white;
}
</style>
</body>
</html>