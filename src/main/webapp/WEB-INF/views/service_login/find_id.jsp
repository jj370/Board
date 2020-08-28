<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 페이지</title>
<script src="resources/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	function your_id() {
		console.log("qjxms")
		if($('input[name=email]').val()=="") {
			alert("이메일을 입력하세요!")
			$('input[name=email]').focus
		}else {
			var email = $('input[name=email]').val() + "@" + $('select[name=address]').val()
			var form = { email : email }
			let html = ""
			$.ajax({
				url : "get_id",
				type : "POST",
				data : form,
				success : function(result) {
					if (result == "아이디없음") {
						alert("해당 이메일로 가입한 아이디가 없습니다.")
					} else {
						html += "<label><h3>\""+email+"\"로 가입한 아이디</h3><hr></label>"
						html += ""+result+"<br><br><br>"
						html += "<h4><input type='button' onclick='location.href='find_pwd'' value='비밀번호 찾기'></h4>"
						$("#find_id").html(html)
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
</script>
</head>
<body>
<body class="is-preload">
	<%@ include file="../default/header.jsp"%>
	<!-- Main -->
	<article id="main">
		<section class="wrapper style5">
			<div class="inner" style="height: 600px;">
				<section>
				<form>
				<div id="find_id">
					<h3>아이디 찾기</h3>
					<hr />
					<section>
						<form method="post" action="#">
							<div class="row gtr-uniform">
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
					</section>
					<br>
					<input type="button" onclick="your_id()" value="아이디 찾기">
					<input type="button" onclick="location.href='find_pwd'" value="비밀번호 찾기"><br>
					<span id="none_id"></span><br>
				</div>
					<hr />
					<h4><a href="login">로그인</a> / <a href="reg_tos">회원가입</a></h4>
					<p></p>
				</form>
				</section>
			</div>
		</section>
	</article>
	<%@ include file="../default/footer.jsp"%>
</body>
</html>