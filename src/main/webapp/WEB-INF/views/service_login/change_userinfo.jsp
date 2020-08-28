<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
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
</script>
<script type="text/javascript">
	var usernick_ok=false
	var useremail_ok=false
	var useremail_use=true
	// 이메일 인증번호 보내기
	function sendEmail() {
		var useremail = $('input[name=useremail]').val()
		var email='${loginUser.email}'
		var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; //이메일 유효성 검사
		if(email==useremail) {
			useremail_ok=false
			useremail_use=true
			alert("현재 사용중인 이메일입니다.")
			$('input[name=useremail]').focus()
		}else if(useremail=="") {
			useremail_ok=false
			useremail_use=false
			alert("이메일을 입력해주세요!")
			$('input[name=useremail]').focus()
		}else if (hangulcheck.test(useremail)) {
			useremail_ok=false
			useremail_use=false
		    alert("유효하지 않은 이메일입니다. 이메일을 확인해주세요.");
		    $('input[name=useremail]').val("")
		    $('input[name=useremail]').focus();
		}else {
			var form = { email : useremail }
			let html=""
			$.ajax({
				url : "email_chk",
				type : "POST",
				data : form,
				success : function(result) {
					if (result=="중복") {
						console.log("이미 사용 중인 이메일")
						useremail_ok=false
						useremail_use=false
						alert("이미 사용 중인 이메일입니다. 다른 이메일를 입력해주세요.")
						$('input[name=useremail]').val("");
						$('input[name=useremail]').focus()
					} else {
						console.log("사용 가능한 이메일")
						$.ajax({
							url : "send_email",
							type : "POST",
							data : form,
							success : function(code) {
								useremail_ok=true
								console.log("성공 : "+code)
							},
							error : function(request, status, error) {
								useremail_ok=false
								useremail_use=false
								console.log("실패")
								alert("code:" + request.status + "\n" + "message:"
										+ request.responseText + "\n" + "error:" + error);
								alert("유효하지 않은 이메일입니다. 이메일을 확인해주세요.");
							}
						})
					}
				},
				error : function(request, status, error) {
					useremail_ok=false
					useremail_use=false
					console.log("실패")
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
					alert("유효하지 않은 이메일입니다. 이메일을 확인해주세요.");
				}
			})
		}
	}
	// 이메일 인증번호 확인
	function code_chk() {
		var usercode = $('input[name=usercode]').val()
		let html = ""
		var form = { usercode : usercode }
		if(usercode=="") {
			alert("인증코드를 입력해주세요.")
		}else {
			$.ajax({
				url : "code_chk",
				type : "POST",
				data : form,
				success : function(result) {
					if (result=="인증 완료") {
						useremail_ok=true
						html += "&nbsp;&nbsp;<img src='resources/main_image/okay.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;<span>이메일 인증이 완료되었습니다.</span><br>"
						$("#code_chk_ok").html(html)
					} else {
						html += "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;<span>인증 실패</span>"
						$("#code_chk_ok").html(html)
						$('input[name=usercode]').focus
					}
				},
				error : function(request, status, error) {
					console.log("실패")
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
					html += "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;<span>인증 실패</span>"
					$("#code_chk_ok").html(html)
					$('input[name=usercode]').focus
				}
			})
		}
	}
	// 닉네임 중복 확인
	function nick_chk() {
		var usernick = $('input[name=usernick]').val()
		let html = ""
		if (usernick==null)  {
			alert("닉네임을 입력해주세요!")
			$("#input_nick").html(html)
			$('input[name=usernick]').focus
		}else {	
			var nickNameCheck = RegExp(/^[가-힣a-zA-Z0-9]{2,10}$/);
			if ( usernick=='${loginUser.nick}' ) {
				alert("현재 사용중인 닉네임입니다.")
				$("#input_nick").html(html)
				$('input[name=usernick]').focus
			} else {
			    if (!nickNameCheck.test(usernick)) {
				    alert("닉네임은  2 ~ 10자의 영어와 한글, 숫자를 사용하세요.");
					$("#input_nick").html(html)
				    $('input[name=usernick]').val("")
				    $('input[name=usernick]').focus();
				}else {
					var form = { usernick : usernick }
					$.ajax({
						url : "nick_chk",
						type : "POST",
						data : form,
						success : function(result) {
							console.log("닉네임 체크 성공")
							if (result=="중복") {
								html += "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;<span>이미 사용 중인 닉네임입니다.</span>"
								$("#input_nick").html(html)
								$('input[name=usernick]').val("")
							} else {
								usernick_ok=true
								html += "&nbsp;&nbsp;<img src='resources/main_image/okay.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;<span>사용 가능한 닉네임</span>"
								html += "<input type='hidden' value='"+usernick+"' name='usernick'>"
								$("#input_nick").html(html)
								nickchk=true
								$('input[name=usernick]').focus
							}
						},
						error : function(request, status, error) {
							console.log("실패")
							alert("code:" + request.status + "\n" + "message:"
									+ request.responseText + "\n" + "error:"
									+ error);
								html += "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;<span>이미 사용 중인 닉네임입니다.</span><br>"
								$("#input_nick").html(html)
								$('input[name=nick]').focus
						}
					})
				}
			}
		}
	}
	// 회원가입
	function reg_chk() {
		var userid = $('input[name=userid]').val()
		var usernick = $('input[name=usernick]').val()
		var useremail = $('input[name=useremail]').val()
		var usergender = $('input:radio[name=gender]:checked').val()
		var userbirth = $('input[name=birth]').val()
		console.log(userid)
		console.log(usernick)
		console.log(useremail)
		console.log(usergender)
		console.log(userbirth)
		console.log($('input:radio[name=gender]:checked').val())
		if(userid=='${loginUser.id}' && usernick=='${loginUser.nick}' && useremail=='${loginUser.email}' 
				&& usergender=='${loginUser.gender}' && userbirth=='${loginUser.birth}') {
			alert("수정된 정보가 없습니다. 마이페이지로 돌아갑니다.")
			location.href="mypage"
		}else {
		if(usernick=='${loginUser.nick}') {
			nickchk=true
		}
		if(usernick==null) {
			alert("닉네임을 확인해주세요.")
			$('input[name=nick]').focus()
		}else if(nickchk==false) {
			alert("닉네임 중복확인을 확인해주세요.")
			$('input[name=nick]').focus()
		}else if(useremail==null) {
			alert("이메일을 확인해주세요.")
			$('input[name=email]').focus()
		}else if(useremail_ok==false && useremail_use==false) {
			alert("이메일 인증을 해주세요.")
			$('input[name=email]').focus()
		}else if(usergender==null) {
			alert("성별을 선택해주세요.")
		}else if(userbirth.length==0) {
			alert("생년월일을 입력해주세요.")
			$('input:date[name=birth]').focus()
		}else {
			let html = ""
			var form = { id : userid, nick : usernick, email : useremail,
					gender : usergender, birth : userbirth }
			$.ajax({
				url : "update_user",
				type : "POST",
				data : form,
				success : function(result) {
					console.log(result)
					if(result!=null) {
						alert("회원 정보가 수정되었습니다.\n다시 로그인해주세요.");
						location.href="login"
					}else {
						console.log("수정 실패")
					}
				},
				error : function(request, status, error) {
					console.log("실패")
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
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
							<div class="col-6 col-12-medium" style="margin-left: 50px;width:1050px;">
								<h3>회원 정보 수정</h3>
								<table class="form" border="1">
									<tr style="height: 100px;vertical-align: middle;">
										<td style="text-align: center;height:100px; vertical-align: middle;width:100px;">아이디</td>
										<td>&nbsp;&nbsp;${loginUser.id }</td>
										<input type="hidden" name="userid" value="${loginUser.id }">
										</tr>
									<tr id="none">
										<td rowspan="2" style="text-align: center;height:100px; vertical-align: middle;width:100px;">닉네임</td>
										<td>&nbsp;&nbsp;2자 이상의 영어와 한글, 숫자를 사용하세요.</td>
									</tr>
									<tr>
										<td>
											<div style="display: flex;margin: 10px;"><input type="text" name="usernick" id="usernick" placeholder="닉네임" style="width:330px;" value="${loginUser.nick }">
												&nbsp;&nbsp;<input type="button" value="중복확인" onclick="nick_chk()"><span id="input_nick"></span>
											</div>
										</td>
									</tr>
									<tr>
										<td rowspan="2" style="text-align: center;height:100px; vertical-align: middle;width:100px;">Email</td>
										<td>
											<div style="display: flex;margin: 10px; vertical-align: middle;">
											<input type="text" name="useremail" placeholder="이메일" style="width:380px;" value="${loginUser.email }">
											&nbsp;&nbsp;<input type="button" value="인증코드발송" onclick="sendEmail()">
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<span>&nbsp;&nbsp;이메일 발송시 최대 5분의 시간이 소요 될 수 있습니다.</span><br>
											<div style="display:flex;">&nbsp;&nbsp;<input type="text" name="usercode" style="width:250px;" placeholder="인증번호">
											&nbsp;&nbsp;<input type="button" value="인증코드확인" onclick="code_chk()"><span id="code_chk_ok"></span></div>
										</td>
									</tr>
									<tr style="background: white;">
										<td style="text-align: center;height:100px; vertical-align: middle;width:100px;">성별</td>
										<td style="display: flex;height: 28px; vertical-align: middle;border: 0px solid 0.0;">
											<c:choose>
												<c:when test="${loginUser.gender eq '여자' }">
													<label class="box-radio-input" style="height: 28px;">
														<input type="radio" name="gender" value="여자" checked="checked"><span>여자</span>
													</label>
													<label class="box-radio-input">
														<input type="radio" name="gender" value="남자"><span>남자</span>
													</label>
												</c:when>
												<c:otherwise>
													<label class="box-radio-input">
														<input type="radio" name="gender" value="여자"><span>여자</span>
													</label>
													<label class="box-radio-input">
														<input type="radio" name="gender" value="남자" checked="checked"><span>남자</span>
													</label>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;height:100px; vertical-align: middle;width:100px;">생년월일</td>
										<td style="height:100px; vertical-align: middle;">
											<input type="date" name="birth" max="2001-12-31" min="1940-01-01" style="color:black; width:200px;text-align: center;"  value="${loginUser.birth }">
										</td>
									</tr>
									<tr>
										<td colspan="2" style="text-align: center;">
											<br>
											<input type="button" value="수정" onclick="reg_chk()"> 
											<input type="button" value="취소" onclick="location.href='/Travelers/'">
											<br><br>
										</td>
									</tr>
								</table>
								
							</div>
						</div>
					</section>
					<script type="text/javascript">
						var nickchk=false
						var pwdokchk=false
						document.getElementById('usernick').onkeyup = function() {
							var msg = '', val = this.value;
							var id = '${loginUser.id}';
							if(val=='${loginUser.nick}') {
								msg = "&nbsp;&nbsp;<img src='resources/main_image/okay.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;현재 사용중인 닉네임입니다."
								nickchk=true
							} else if(usernick!=val) {
								msg = "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;닉네임 중복확인을 해주세요."
								nickchk=true
							}
							
							/* if (false === reg.test(pwd)) {
								msg = "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;유효하지 않는 비밀번호입니다."
							} else if (/(\w)\1\1\1/.test(pwd)) {
								msg = "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;같은 문자를 4번 이상 사용하실 수 없습니다."
							} else if ( (pwd.search(id) > -1 ) && id!="") {
								msg = "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;비밀번호에 아이디가 포함되었습니다."
							} else if (pwd.search(/\s/) != -1) {
								msg = "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;비밀번호는 공백 없이 입력해주세요."
							} else if (hangulcheck.test(pwd)) {
								msg = "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;비밀번호에 한글을 사용 할 수 없습니다."
							} else {
									pwdchk=true
									msg = GetAjaxPW(val);
							} */
							$("#input_nick").html(msg)
						};
						var GetAjaxPW = function(val) {
							// ajax func....
							return "&nbsp;&nbsp;<img src='resources/main_image/okay.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;사용 가능한 비밀번호입니다."
						}
						/* document.getElementById('pwdok').onkeyup = function() {
							let html = ""
							var msg = '', val = this.value;
							if (($('input[name=pwd]').val() == $('input[name=pwdok]').val())) {
								if(pwdchk) {
									html = "&nbsp;&nbsp;<img src='resources/main_image/okay.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;비밀번호가 서로 일치합니다."
									html += "<input type='hidden' value='"
											+ $('input[name=pwdok]').val() + "' name='userpwd'>"
								}
							} else {
								html = GetAjaxPWok(val);
							};
							$("#pwokc").html(html)
						};
				
						var GetAjaxPWok = function(val) {
							// ajax func....
							return "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;비밀번호가 일치하지 않습니다."
						} */
					</script>
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
    vertical-align: middle;
  }
#none {border-bottom: 0px solid 0.0;}
.box-radio-input input[type="radio"]{
    display:none;
}

.box-radio-input input[type="radio"] + span{
    display:inline-block;
    background:none;
    border:1px solid #dfdfdf;    
    padding:0px 10px;
    text-align:center;
    height:35px;
    line-height:33px;
    font-weight:500;
    cursor:pointer;
}

.box-radio-input input[type="radio"]:checked + span{
    border:1px solid #23a3a7;
    background:#23a3a7;
    color:#fff;
}
</style>
</body>
</html>