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
	var pwdchk=false
	var pwdokchk=false
	function change_pwd_save() {
		var id = '${loginUser.id}';
		var pwd = $('input[name=pwd]').val()
		var pwdok = $('input[name=pwdok]').val()
		var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,20}$/;
		var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		if (false === reg.test(pwd)) {
			console.log(pwd)
			alert('비밀번호는 8자 이상 20자 이하여야 하며, 숫자/대문자/소문자/특수문자를 모두 포함해야 합니다.');
		} else if (/(\w)\1\1\1/.test(pwd)) {
			alert('같은 문자를 4번 이상 사용하실 수 없습니다.');
			return false;
		} else if (pwd.search(id) > -1) {
			alert("비밀번호에 아이디가 포함되었습니다.");
			return false;
		} else if (pwd.search(/\s/) != -1) {
			alert("비밀번호는 공백 없이 입력해주세요.");
			return false;
		} else if (hangulcheck.test(pwd)) {
			alert("비밀번호에 한글을 사용 할 수 없습니다.");
		} else {
			console.log("통과");
			if( !( pwdokchk ) ) {
			    alert("비밀번호가 서로 다릅니다.\n비밀번호를 확인해주세요.");
			    $('input[name=pwd]').val("")
			    $('input[name=pwdok]').val("")
			    $('input[name=pwd]').focus();
			}else {
				var form = { id : id, pwd : pwd }
				let html=""
				$.ajax({
					url : "change_pwd_save",
					type : "POST",
					data : form,
					success : function(result) {
						if (result=='비밀번호를 변경했습니다.') {
							alert("비밀번호 변경에 성공하였습니다.\n다시 로그인해주시길 바랍니다.")
							location.href="/Travelers/"
						}else {
							alert(result)
							$('input[name=pwd]').val("")
						    $('input[name=pwdok]').val("")
						    $('input[name=pwd]').focus();
						}
					},
					error : function(request, status, error) {
						console.log("실패")
						alert("code:" + request.status + "\n" + "message:"
								+ request.responseText + "\n" + "error:" + error);
						alert("비밀번호 변경에 실페하였습니다.\n다시 시도해주세요.")
						$('input[name=pwd]').val("")
					    $('input[name=pwdok]').val("")
					    $('input[name=pwd]').focus();
					}
				})
			}
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
								<h3>새로운 비밀번호를 입력하세요.</h3>
								8~16자의 영문 대소문자, 숫자, 특수기호를 사용하세요.<br>
								<input type="password" name="pwd" id="pwd" autofocus="autofocus" placeholder="비밀번호"><br>
								<input type="password" name="pwdok" id="pwdok" placeholder="비밀번호 확인">
								<span id="pwc"></span>
								<span id="pwokc"></span><br>
								<input type="button" value="확인" onclick="change_pwd_save()">
								<!-- 비밀번호 유효성 실시간으로 확인하는 자바스크립트 -->
								<script type="text/javascript">
									document.getElementById('pwdok').onkeyup = function() {
										let html = ""
										var msg = '', val = this.value;
										if (($('input[name=pwd]').val() == $('input[name=pwdok]').val())) {
											pwdokchk = true
											html = "비밀번호가 서로 일치합니다."
											html += "<input type='hidden' value='"
													+ $('input[name=pwdok]').val()
													+ "' name='userpwd'>"
										} else {
											html = GetAjaxPWok(val);
										};
										$("#pwokc").html(html)
									};
							
									var GetAjaxPWok = function(val) {
										// ajax func....
										return "비밀번호가 일치하지 않습니다."
									}
								</script>
							</div>
						</div>
					</section>
				</div>
			</section>
		</article>
	</div>
	<%@ include file="../default/footer.jsp" %>
</body>
</html>