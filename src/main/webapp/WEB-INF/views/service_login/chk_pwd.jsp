<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
					$('input[name=pwd]').focus
				} else {
					console.log("성공")
					switch ('${param.page}') {
					case 'change_pwd':
						location.href = "change_pwd"
						break;
					case 'change_userinfo':
						location.href = "change_userinfo"
						break;
					default:
						alert("잘못된 겅로입니다.\n메인페이지로 돌아갑니다.")
						location.href = "/Travelers/"
						break;
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
								해당 서비스를 이용하려면 확인이 필요합니다.<br>비밀번호를 한 번 더 확인해주세요.<br><br>
								<table>
									<tr style="border: none;">
										<td style="width:500px;background: white;">
											<input type="password" name="pwd" autofocus="autofocus" placeholder="비밀번호를 입력하세요.">
										</td>
										<td style="width:180px;background: white;">
											<input type="button" value="확인" onclick="chk_pwd()">
										</td>
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