<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="is-preload">
	<%@ include file="../default/header.jsp"%>
	<!-- Page Wrapper -->
	<div id="page-wrapper">
		<!-- Main -->
		<article id="main">
			<section class="wrapper style5">
				<div class="inner">
					<div style="text-align: center;margin: 0 auto;">
					<h2> 가입완료 </h2><br>
					<img src="resources/main_image/reg03.png" style="width:700px;">
					</div>
					<br><br><br>
					<h2 style="text-align: center;">
						회원가입을 완료하였습니다. 환영합니다!
					</h2>
					<br><br>
					<div  style="text-align: center;">
					<button onclick="location.href='login'">로그인하러 가기</button>
					</div>
					<br><br><br>
					<img src="resources/main_image/password.png" style="text-align: center;">
				</div>
			</section>
		</article>
	</div>
	<%@ include file="../default/footer.jsp"%>
</body>
</html>