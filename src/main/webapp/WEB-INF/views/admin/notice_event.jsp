<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<script type="text/javascript">
function chk_loginUser() {
	if ('${loginUser.id}' == "admin") {
		console.log("admin 접근 확인")
	}else if ('${loginUser}' != null) {
		alert("관리자가 아니라면 사용하실 수 없습니다.")
		location.href="/Travelers/"
	} else {
		alert("로그인 후 사용해주세요.")
		location.href="login"
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
						<h2>Admin Page</h2>
						<div class="row">
							<div class="col-6 col-12-medium" style="width:250px;">
								<ul class="alt">
									<li><a href="notice_event">Admin 글 관리</a></li>
									<li><a href="report_post">신고 글 관리</a></li>
									<li><a href="chk_pwd?page=change_userinfo">회원정보 수정</a></li>
									<li><a href="chk_pwd?page=change_pwd">비밀번호 수정</a></li>
									<li><a href="withdrawal">회원탈퇴</a></li>
								</ul>
							</div>
							<div class="col-6 col-12-medium" style="margin-left: 50px;width:400px;">
								<h2> 공지 및 이벤트 글 관리 </h2>
								<hr>
								<h2> 패키지 글 추가 및 삭제 </h2>
								<input type="button" value="추가" onclick="location.href='package_write'" style="width:100%">
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