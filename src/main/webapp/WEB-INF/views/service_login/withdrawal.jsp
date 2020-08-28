<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<script src="resources/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	function chk_loginUser() {
		if ('${loginUser}' == "") {
			alert("로그인 후 사용 가능합니다.")
			location.href="login"
		}else {
			console.log("로그인 확인 성공")
		}
	}
	function chk_pwd() {
		var id = '${loginUser.id}'
		var pwd = $('input[name=pwd]').val()
		if(pwd=="") {
			alert("비밀번호를 입력하세요.")
			$('input[name=pwd]').focus()
		}else {
			var form = {
				id : id,
				pwd : pwd
			}
			$.ajax({
				url : "chk_dbpwd",
				type : "POST",
				data : form,
				success : function(result) {
					if (result == "비밀번호가 틀렸습니다!") {
						alert("비밀번호가 틀립니다.\n다시 입력해주세요.")
						$('input[name=pwd]').val("")
						$('input[name=pwd]').focus()
					} else {
						console.log("성공")
						var con_test = confirm("정말로 탈퇴하시겠습니까?")
						if(con_test) {
							delete_User()
						} else {
							alert("회원 탈퇴를 취소하였습니다.")
						}
					}
				},
				error : function(request, status, error) {
					console.log("실패")
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			})
		}
	}
	function delete_User() {
		var id = '${loginUser.id}'
		var pwd = '${loginUser.pwd}'
		var pwdok = $('input[name=pwdok]').val()
		let html = ""
		var form = {
			id : id
		}
		$.ajax({
			url : "delete_User",
			type : "POST",
			data : form,
			success : function(result) {
				console.log("성공")
				alert("회원 탈퇴를 했습니다.")
				location.href = "/Travelers/"
			},
			error : function(request, status, error) {
				console.log("실패")
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
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
							<div class="col-6 col-12-medium" style="margin-left: 50px;width:800px;">
								<h2>회원 탈퇴</h2>
								회원 탈퇴 시 Trevelers 사이트 내에 저장된 모든 개인 정보가 삭제되며,<br>
								이후 계정 복구가 불가합니다.<br>
								본인 확인을 위해 비밀번호를 입력하고, 이메일 인증을 진행해주세요.<br><br>
								<table border="1">	
									<caption><h3>회원 탈퇴를 요청한 아이디</h3></caption>
									<tr style="text-align: center;">
										<td>아이디</td>
										<td>닉네임</td>
										<td>이메일</td>
									</tr>
									<tr style="text-align: right;" >
										<td>${loginUser.id}</td>
										<td>${loginUser.nick}</td>
										<td>${loginUser.email}</td>
									</tr>
								</table>
								<input type="password" name="pwd" autofocus="autofocus" placeholder="비밀번호를 입력하세요."><br>
								<input style="text-align: right;" type="button" value="회원탈퇴" onclick="chk_pwd()">
							</div>
						</div>
					</section>
				</div>
			</section>
		</article>
	</div>
	<%@ include file="../default/footer.jsp" %>
<style>
td {
	text-align: center;
}
</style>
</body>
</html>