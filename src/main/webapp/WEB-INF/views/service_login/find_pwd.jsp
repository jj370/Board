<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 페이지</title>
<script src="resources/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	function your_pwd() {
		if($('input[name=id]').val()=="") {
			alert("아이디를 입력하세요!")
			$('input[name=id]').focus
		}else if($('input[name=email]').val()=="") {
			alert("이메일을 입력하세요!")
			$('input[name=email]').focus
		}else {
			var id = $('input[name=id]').val()
			var email = $('input[name=email]').val() + "@" + $('select[name=address]').val()
			var form = { id : id, email : email }
			let html = ""
			$.ajax({
				url : "send_pwd",
				type : "POST",
				data : form,
				success : function(result) {
					console.log("성공")
					if (result == "아이디없음") {
						html += "<br><label>해당 아이디와 이메일로 가입한 정보가 없습니다.</label>"
						html += "<br><label>아이디와 이메일을 확인해주세요.</label><br><br>"
						html += "<a href='find_id'>아이디 찾기</a> "
						html += "<a href='reg_tos'>회원가입하기</a>"
						$("#none_id").html(html)
					} else {
						alert("해당 이메일로 임시 비밀번호를 발송하였습니다.\n이메일을 확인해주세요.")
						location.href="login"
					}
				},
				error : function(request, status, error) {
					console.log("실패")
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
					alert("아이디와 이메일을 확인해주세요.");
				}
			})
		}
	}
</script>
</head>
<body>
	<%@ include file="../default/header.jsp"%>
	<!-- Main -->
	<article id="main">
		<section class="wrapper style5">
			<div class="inner" style="height: 600px;">
				<div id="find_pwd">
					<h3>비밀번호 찾기</h3>
					<hr />
					<section>
						<form method="post" action="#">
							<div class="row gtr-uniform">
								<div class="col-12">
									<input type="text" name="id" placeholder="아이디를 입력하세요">
								</div><Br>
								<div class="col-6 col-12-xsmall">
									<input type="text" name="email" placeholder="이메일을 입력하세요">
								</div>
								<div class="col-6 col-12-xsmall">
									<select name="address">
										<option value="dreamwiz.com">@dreamwiz.com</option>
										<option value="empal.com">@empal.com</option>
										<option value="gmail.com">@gmail.com</option>
										<option value="hanmail.net">@hanmail.net</option>
										<option value="hanmir.com">@hanmir.com</option>
										<option value="hitel.net">@hitel.net</option>
										<option value="hotmail.com">@hotmail.com</option>
										<option value="kebi.com">@kebi.com</option>
										<option value="korea.com">@korea.com</option>
										<option value="nate.com">@nate.com</option>
										<option value="naver.com" selected="selected">@naver.com</option>
										<option value="orgio.net">@orgio.net</option>
										<option value="yahoo.co.kr">@yahoo.co.kr</option>
										<option value="yahoo.com">@yahoo.com</option>
									</select>
								</div>
							</div>
						</form>
					</section><br>
					<input type="button" onclick="your_pwd()" value="비밀번호 찾기"><br> 
					<span id="none_id"></span><br>
				</div>
				<hr />
					<h4><a href="login">로그인</a> / <a href="reg_tos">회원가입</a></h4>
					<p></p>
			</div>
		</section>
	</article>
	<%@ include file="../default/footer.jsp"%>
</body>
</html>