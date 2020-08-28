<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<style>
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
<script src="resources/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	var useremail=""
	// 이메일 인증번호 보내기
	function sendEmail() {
		var email = $('input[name=email]').val()
		var address = $('select[name=address]').val()
		var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; //이메일 유효성 검사
		if(email==null) {
			alert("이메일을 입력해주세요!")
			$('input[name=email]').focus()
		}else if(email=="") {
			alert("이메일을 입력해주세요!")
			$('input[name=email]').focus()
		}else if (hangulcheck.test(email)) {
		    alert("유효하지 않은 이메일입니다. 이메일을 확인해주세요.");
		    $('input[name=email]').val("")
		    $('input[name=email]').focus();
		}else {
			var form = { email : email+"@"+address }
			let html=""
			$.ajax({
				url : "email_chk",
				type : "POST",
				data : form,
				success : function(result) {
					if (result=="중복") {
						console.log("이미 사용 중인 이메일")
						alert("이미 사용 중인 이메일입니다. 다른 이메일를 입력해주세요.")
						$('input[name=email]').val("")
						$('input[name=email]').focus()
					} else {
						console.log("사용 가능한 이메일")
						$.ajax({
							url : "send_email",
							type : "POST",
							data : form,
							success : function(code) {
								useremail=email+"@"+address
								html="&nbsp;&nbsp;<input type='button' value='인증코드재발송' onclick='sendEmail()'><br>"
								$("#input_code").html(html)
								console.log("성공 : "+code)
							},
							error : function(request, status, error) {
								console.log("실패")
								alert("code:" + request.status + "\n" + "message:"
										+ request.responseText + "\n" + "error:" + error);
								alert("이메일 발송에 실패했습니다.\n이메일을 확인하고 인증 코드 발송 버튼을 눌러주세요.")
							}
						})
					}
				},
				error : function(request, status, error) {
					console.log("실패")
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
					alert("이메일 발송에 실패했습니다.\n이메일을 확인하고 인증 코드 발송 버튼을 눌러주세요.")
				}
			})
		}
	}
	// 이메일 인증번호 확인
	function code_chk() {
		var usercode = $('input[name=usercode]').val()
		if(usercode=="") {
			alert("이메일 인증코드를 입력해주세요.")
		}else {
			let html = ""
			var form = { usercode : usercode }
			$.ajax({
				url : "code_chk",
				type : "POST",
				data : form,
				success : function(result) {
					if (result=="인증 완료") {
						html += "&nbsp;&nbsp;<img src='resources/main_image/okay.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;이메일 인증이 완료되었습니다."
						html += "<input type='hidden' value='"+useremail+"' name='useremail'>"
						$("#code_chk_ok").html(html)
					} else {
						html += "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;이메일 인증을 실패하였습니다."
						$("#code_chk_ok").html(html)
						alert("이메일 인증에 실패했습니다.\n이메일 주소를 확인하시고 인증코드 재발송 버튼을 눌러주세요.")
					}
				},
				error : function(request, status, error) {
					console.log("실패")
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
					html += "&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;이메일 인증을 실패하였습니다."
					$("#code_chk_ok").html(html)
					alert("이메일 인증에 실패했습니다.\n이메일 주소를 확인하시고 인증번호 재발송 버튼을 눌러주세요.")
				}
			})
		}
	}
	// 아이디 중복 확인
	function id_chk() {
		var userid = $('input[name=id]').val()
		if (userid=="")  {
			alert("아이디를 입력해주세요!")
			$('input[name=id]').focus()
		}else {
			var idRegExp = /^[a-z0-9]{5,20}$/; //아이디 유효성 검사
		    if (!idRegExp.test(userid)) {
			    alert("아이디는  5 ~ 20자의 영어 소문자와 숫자만 사용하세요.");
			    $('input[name=id]').val("")
			    $('input[name=id]').focus();
			}else {
				let html = ""
				var form = { userid : userid }
				$.ajax({
					url : "id_chk",
					type : "POST",
					data : form,
					success : function(result) {
						console.log("아이디 체크 성공")
						if (result=="중복") {
							html += "&nbsp;&nbsp;<input type='button' value='중복확인' onclick='id_chk()'>"
							html += "<span>&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;이미 사용 중인 아이디입니다.</span>"
							$("#input_id").html(html)
							$('input[name=id]').focus()
						} else {
							html += "&nbsp;&nbsp;<input type='button' value='중복확인' onclick='id_chk()'>"
							html += "<span>&nbsp;&nbsp;<img src='resources/main_image/okay.png' style='width:30px;vertical-align: middle;'>"
							html += "&nbsp;&nbsp;사용 가능한 아이디</span>"
							html += "<input type='hidden' value='"+userid+"' name='userid'>"
							$("#input_id").html(html)
						}
					},
					error : function(request, status, error) {
						console.log("실패")
						alert("code:" + request.status + "\n" + "message:"
								+ request.responseText + "\n" + "error:"
								+ error);
						html += "<input type='button' value='중복확인' onclick='id_chk()'>"
							html += "<span>&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>이미 사용 중인 아이디입니다.</span><br>"
							$("#input_id").html(html)
							$('input[name=id]').focus()
					}
				})
			}
		}
	}
	// 닉네임 중복 확인
	function nick_chk() {
		var usernick = $('input[name=nick]').val()
		let html = ""
		if (usernick=="")  {
			alert("닉네임을 입력해주세요!")
			$('input[name=nick]').focuss
		}else {	
			var nickNameCheck = RegExp(/^[가-힣a-zA-Z0-9]{2,10}$/);
			console.log(usernick)
		    if (!nickNameCheck.test(usernick)) {
			    alert("닉네임은  2 ~ 10자의 영어와 한글, 숫자를 사용하세요.");
			    html += "&nbsp;&nbsp;<input type='button' value='중복확인' onclick='nick_chk()'>"
				html += "<span>&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;사용할 수 없는 닉네임입니다.</span>"
				$("#input_nick").html(html)
			    $('input[name=nick]').val("")
			    $('input[name=nick]').focus();
			}else {
				var form = { usernick : usernick }
				$.ajax({
					url : "nick_chk",
					type : "POST",
					data : form,
					success : function(result) {
						console.log("닉네임 체크 성공")
						if (result=="중복") {
							html += "&nbsp;&nbsp;<input type='button' value='중복확인' onclick='nick_chk()'>"
							html += "<span>&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;이미 사용 중인 닉네임입니다.</span>"
							$("#input_nick").html(html)
							$('input[name=nick]').focus
						} else {
							html += "&nbsp;&nbsp;<input type='button' value='중복확인' onclick='nick_chk()'>"
							html += "<span>&nbsp;&nbsp;<img src='resources/main_image/okay.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;사용 가능한 닉네임</span>"
							html += "<input type='hidden' value='"+usernick+"' name='usernick'>"
							$("#input_nick").html(html)
						}
					},
					error : function(request, status, error) {
						console.log("실패")
						alert("code:" + request.status + "\n" + "message:"
								+ request.responseText + "\n" + "error:"
								+ error);
						html += "&nbsp;&nbsp;<input type='button' value='중복확인' onclick='nick_chk()'>"
							html += "<span>&nbsp;&nbsp;<img src='resources/main_image/x.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;사용할 수 없는 닉네임입니다.</span>"
							$("#input_nick").html(html)
							$('input[name=nick]').focus
					}
				})
			}
		}
	}
	// 회원가입
	function reg_chk() {
		var userid = $('input[name=userid]').val()
		var userpwd = $('input[name=userpwd]').val()
		var usernick = $('input[name=usernick]').val()
		var useremail = $('input[name=useremail]').val()
		var usergender = $('input[name=gender]:checked').val()
		var userbirth = $('input[name=birth]').val()
		if(userid==null) {
			alert("아이디를 확인해주세요.")
			$('input[name=id]').focus()
		}else if(userpwd==null) {
			alert("비밀번호를 확인해주세요.")
			$('input[name=pwd]').focus()
		}else if(usernick==null) {
			alert("닉네임을 확인해주세요.")
			$('input[name=nick]').focus()
		}else if(useremail==null) {
			alert("이메일을 확인해주세요.")
			$('input[name=email]').focus()
		}else if(usergender==null) {
			alert("성별을 선택해주세요.")
			$('input[name=gender]').focus()
		}else if(userbirth.length==0) {
			alert("생년월일을 입력해주세요.")
			$('input:date[name=birth]').focus()
		}else {
			let html = ""
			var form = { id : userid, pwd : userpwd, nick : usernick, email : useremail,
					gender : usergender, birth : userbirth }
			$.ajax({
				url : "insert_user",
				type : "POST",
				data : form,
				success : function(result) {
					console.log(result)
					if(result!=null) {
						location.href="reg_end"
					}else {
						console.log("회원가입 실패")
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
</script>
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
					<h2> 정보입력 </h2><br>
					<img src="resources/main_image/reg02.png" style="width:700px;">
					</div>
					<br><br><br>
					<table class="form" border="1">
						<tr>
							<td rowspan="2" style="text-align: center;height:100px; vertical-align: middle;width:130px;">아이디</td>
							<td>&nbsp;&nbsp;5자 이상의 영어 소문자나 숫자를 사용하세요.</td>
						</tr>
						<tr>
							<td style="display: flex;">
								<input type="text" name="id" placeholder="아이디" style="width:350px;">
								<span id="input_id">
									&nbsp;&nbsp;<input type="button" value="중복확인" onclick="id_chk()">
								</span>
							</td>
						</tr>
						<tr>
							<td rowspan="2" style="text-align: center;height:100px; vertical-align: middle;width:130px;">비밀번호</td>
							<td>&nbsp;&nbsp;8자 이상 20자 이하의 영어 대문자, 소문자, 숫자, 특수문자를 사용하세요.</td>
						</tr>
						<tr>
							<td>
								<div style="display: flex;margin: 10px;"><input type="password" name="pwd" id="pwd" placeholder="비밀번호" style="width:350px;"><span id="pwc"></span></div>
								<div style="display: flex;margin: 10px;"><input type="password" name="pwdok" id="pwdok" placeholder="비밀번호 확인" style="width:350px;"><span id="pwokc"></span></div>
							</td>
						</tr>
						<tr>
							<td rowspan="2" style="text-align: center;height:100px; vertical-align: middle;width:130px;">닉네임</td>
							<td style="border-bottom: 0;">&nbsp;&nbsp;2자 이상의 영어나 한글, 숫자를 사용하세요.</td>
						</tr>
						<tr>
							<td style="border-top: 0;">
								<div style="display: flex;margin: 10px;"><input type="text" name="nick" placeholder="닉네임" style="width:350px;">
									<span id="input_nick">&nbsp;&nbsp;<input type="button" value="중복확인" onclick="nick_chk()"></span>
								</div>
							</td>
						</tr>
						<tr>
							<td rowspan="2" style="text-align: center;height:100px; vertical-align: middle;width:180px;">Email</td>
							<td>
								<div style="display: flex;margin: 10px; vertical-align: middle;">
								<input type="text" name="email" placeholder="이메일" style="width:250px;">
								<img src="resources/main_image/at.png" style="width:40px; height: 40px; vertical-align: middle;opacity: 0.6">
								<select name="address" style="width:250px;">
									<option value="dreamwiz.com">dreamwiz.com</option>
									<option value="empal.com">empal.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="hanmir.com">hanmir.com</option>
									<option value="hitel.net">hitel.net</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="kebi.com">kebi.com</option>
									<option value="korea.com">korea.com</option>
									<option value="nate.com">nate.com</option>
									<option value="naver.com" selected="selected">naver.com</option>
									<option value="orgio.net">orgio.net</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="yahoo.com">yahoo.com</option>
								</select>
								<span id="input_code">
								&nbsp;&nbsp;<input type="button" value="인증코드발송" onclick="sendEmail()">
								</span>
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
						<tr style="background: white;border-bottom: 0;">
							<td style="text-align: center;vertical-align: middle;width:130px;">성별</td>
							<td style="display: flex;border-bottom: 0;padding-top: 15px;">
								<label class="box-radio-input">
									<input type="radio" name="gender" value="여자" checked="checked"><span>여자</span>
								</label>
								<label class="box-radio-input">
									<input type="radio" name="gender" value="남자"><span>남자</span>
								</label>
							</td>
						</tr>
						<tr>
							<td style="text-align: center;height:100px; vertical-align: middle;width:130px;">생년월일</td>
							<td style="height:100px; vertical-align: middle;">
								<input type="date" name="birth" max="2001-12-31" min="1940-01-01" style="color:black; width:200px;text-align: center;">
								<br>*각종 안정성 문제로 미성년자는 사용 불가하며, 2001년 이전의 출생자인 성인만 가입 가능합니다.
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center;">
								<br>
								<input type="button" value="회원가입" onclick="reg_chk()"> 
								<input type="button" value="취소" onclick="location.href='/Travelers/'"><br><br>
							</td>
						</tr>
					</table>
					<!-- 비밀번호 유효성 실시간으로 확인하는 자바스크립트 -->
					<script type="text/javascript">
						var pwdchk=false
						var pwdokchk=false
						document.getElementById('pwd').onkeyup = function() {
							var msg = '', val = this.value;
							var id = '${loginUser.id}';
							var pwd = $('input[name=pwd]').val()
							var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,20}$/;
							var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
							if (false === reg.test(pwd)) {
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
							}
							$("#pwc").html(msg)
						};
						var GetAjaxPW = function(val) {
							// ajax func....
							return "&nbsp;&nbsp;<img src='resources/main_image/okay.png' style='width:30px;vertical-align: middle;'>&nbsp;&nbsp;사용 가능한 비밀번호입니다."
						}
						document.getElementById('pwdok').onkeyup = function() {
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
						}
					</script>
				</div>
			</section>
		</article>
	</div>
	<%@ include file="../default/footer.jsp"%>
<style>
td  {
background-color: white;
}
</style>
</body>
</html>