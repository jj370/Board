<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지함</title>
<script type="text/javascript">
function chk_loginUser() {
	if ('${loginUser}' == "") {
		alert("로그인 후 사용 가능합니다.")
		location.href="login"
	}else {
		console.log("로그인 확인 성공")
	}
}
</script>
</head>
<body class="is-preload" onload="chk_loginUser()">
	<%@ include file="../default/header.jsp"%>
	<!-- Page Wrapper -->
	<div id="page-wrapper">
		<!-- Main -->
		<article id="main">
			<section class="wrapper style5">
				<div class="inner" style="height: 600px;">
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
							<div class="col-6 col-12-medium" style="margin-left: 50px;">
								<h2> 회원 정보</h2>
								<table>
									<tr>
										<th>아이디</th>
										<th>${loginUser.id }</th>
									</tr>
									<tr>
										<th>닉네임</th>
										<th>${loginUser.nick }</th>
									</tr>
									<tr>
										<th>이메일</th>
										<th>${loginUser.email }</th>
									</tr>
									<tr>
										<th>성별</th>
										<th>${loginUser.gender }</th>
									</tr>
									<tr>
										<th>생년월일</th>
										<th>${loginUser.birth }</th>
									</tr>
								</table>
							</div>
						</div>
					</section>
				</div>
			</section>
		</article>
	</div>
	<%@ include file="../default/footer.jsp"%>
</body>
</html>