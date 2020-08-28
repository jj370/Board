<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<script src="resources/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
function chk_loginUser() {
	if ('${loginUser}' != null) {
		if ('${loginUser.id}' == "admin") {
			console.log("admin 접근 확인")
		}else {
			alert("관리자가 아니라면 사용하실 수 없습니다.")
			location.href="/Travelers/"
		}
	} else {
		alert("로그인 후 사용해주세요.")
		location.href="login"
	}
}
// 정보 게시판 신고글 전체 선택
$(function(){
	$("#infochkall").click(function(){
		if($("#infochkall").prop("checked")) {
			$("input[name=infochk]:checkbox").prop("checked",true);
		} else { //해당화면에 모든 checkbox들의 체크를해제시킨다. 
			$("input[name=infochk]:checkbox").prop("checked",false);
		} 
	}) 
});
//리뷰 게시판 신고글 전체 선택
$(function(){
	$("#reviewchkall").click(function(){
		if($("#reviewchkall").prop("checked")) {
			$("input[name=reviewchk]:checkbox").prop("checked",true);
		} else {
			$("input[name=reviewchk]:checkbox").prop("checked",false);
		} 
	}) 
});
//자유 게시판 신고글 전체 선택
$(function(){ 
	$("#freechkall").click(function(){
		if($("#freechkall").prop("checked")) {
			$("input[name=freechk]:checkbox").prop("checked",true);
		} else {
			$("input[name=freechk]:checkbox").prop("checked",false);
		} 
	}) 
});
//동행 게시판 신고글 전체 선택
$(function(){
	$("#matechkall").click(function(){
		if($("#matechkall").prop("checked")) {
			$("input[name=matechk]:checkbox").prop("checked",true);
		} else {
			$("input[name=matechk]:checkbox").prop("checked",false);
		} 
	}) 
});
</script>
<script>
//정보 게시판 신고글 관리
//댓글 보이기
function infoview_show(cnt) {
	$("#infoview"+cnt).show();
	console.log()
	var html="<img src='resources/main_image/more.png' onclick='infoview_hide("+cnt+")' style='width:22px; vertical-align: middle;'>"
	$('#infoshow'+cnt).html(html)
}
// 댓글 숨기기
function infoview_hide(cnt) {
	$("#infoview"+cnt).hide();
	var html="<img src='resources/main_image/more.png' onclick='infoview_show("+cnt+")' style='width:22px; vertical-align: middle;'>"
	$('#infoshow'+cnt).html(html)
}
//정보 게시판 신고글 삭제
function infodelete_chk(cnt) {
	var result = Array();
	var cnt = 0;
	var chkbox = $(".infochk");
	for(i=0;i<chkbox.length;i++) {
		if(chkbox[i].checked == true) {
			result[cnt] = chkbox[i].value;
			cnt++;
		}
	}
	var form = {
		result:result
	}
	if(result.length==0) {
		alert("삭제할 글을 선택해주세요.")
	}else{
		$.ajax({
			url : "infodelete_chk",
			type : "POST",
			data : form,
			traditional : true,
			success : function(list) {
				console.log("성공")
				var html=""
					html+="<tr style='vertical-align: middle;' >"
					html+="<td class='checks etrans' style='width:60px;text-align: center;'>"
					html+="<input type='checkbox' name='infochkall' value='infochkall' id='infochkall'> <label for='infochkall'></label></td>"
					html+="<td style='width:90px;text-align: center;'>글번호</td>"
					html+="<td style='width:400px;text-align: center;'>제목</td>"
					html+="<td style='width:200px;text-align: center;'>작성자</td>"
					html+="<td style='width:150px;text-align: center;'>신고건수</td></tr>"
				var cnt=0
				if(list.length==0) {
					html+="<tr><td colspan='5'></td></tr>"	
				}
				$.each(list, function(index,item) {
					html+="<tr><td class='checks etrans'>"
					html+="<input type='checkbox' class='infochk' name='infochk' value='"+item.num+"' id='infochk"+cnt+"'> <label for='infochk"+cnt+"'></label></td>"
					html+="<td>"+item.num+"</td>"
					html+="<td style='text-overflow: ellipsis;text-align: left;'>"+item.title+"</td>"
					html+="<td>작성자</td><td>"
					html+="<span id='infoshow"+cnt+"'><img src='resources/main_image/more.png' onclick='infoview_show("+cnt+")' style='width:22px; vertical-align: middle;'></span>"
					html+="</td></tr>"
					html+="<tr id='infoview"+cnt+"' style='display:none;'><td colspan='7'>"
					html+="<fieldset style='border: 1px solid rgba(50, 50, 50, 0.3);margin: 10px;padding: 10px;'>"
					html+=item.content+"</fieldset></td></tr>"
					cnt++;
				});
				html+="<tr><td colspan='7' style='text-align: right;'>"
				html+="<input type='button' value='선택삭제' onclick='infodelete_chk()'>"
				html+="</td></tr>"
				$("#info_report_list").html(html)
			},
			error : function(request, status, error) {
				console.log("실패")
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	}
}

//리뷰 게시판 신고글 관리
//댓글 보이기
function reviewview_show(cnt) {
	$("#reviewview"+cnt).show();
	console.log()
	var html="<img src='resources/main_image/more.png' onclick='reviewview_hide("+cnt+")' style='width:22px; vertical-align: middle;'>"
	$('#reviewshow'+cnt).html(html)
}
// 댓글 숨기기
function reviewview_hide(cnt) {
	$("#reviewview"+cnt).hide();
	var html="<img src='resources/main_image/more.png' onclick='reviewview_show("+cnt+")' style='width:22px; vertical-align: middle;'>"
	$('#reviewshow'+cnt).html(html)
}

function reviewdelete_chk(cnt) {
	var result = Array();
	var cnt = 0;
	var chkbox = $(".reviewchk");
	for(i=0;i<chkbox.length;i++) {
		if(chkbox[i].checked == true) {
			result[cnt] = chkbox[i].value;
			cnt++;
		}
	}
	var form = {
		result:result
	}
	if(result.length==0) {
		alert("삭제할 글을 선택해주세요.")
	}else{
		$.ajax({
			url : "reviewdelete_chk",
			type : "POST",
			data : form,
			traditional : true,
			success : function(list) {
				console.log("성공")
				var html=""
					html+="<tr style='vertical-align: middle;' >"
					html+="<td class='checks etrans' style='width:60px;text-align: center;'>"
					html+="<input type='checkbox' name='reviewchkall' value='reviewchkall' id='reviewchkall'> <label for='reviewchkall'></label></td>"
					html+="<td style='width:90px;text-align: center;'>글번호</td>"
					html+="<td style='width:400px;text-align: center;'>제목</td>"
					html+="<td style='width:200px;text-align: center;'>작성자</td>"
					html+="<td style='width:150px;text-align: center;'>신고건수</td></tr>"
				var cnt=0
				if(list.length==0) {
					html+="<tr><td colspan='5'></td></tr>"	
				}
				$.each(list, function(index,item) {
					html+="<tr><td class='checks etrans'>"
					html+="<input type='checkbox' class='reviewchk' name='reviewchk' value='"+item.num+"' id='reviewchk"+cnt+"'> <label for='reviewchk"+cnt+"'></label></td>"
					html+="<td>"+item.num+"</td>"
					html+="<td style='text-overflow: ellipsis;text-align: left;'>"+item.title+"</td>"
					html+="<td>작성자</td><td>"
					html+="<span id='reviewshow"+cnt+"'><img src='resources/main_image/more.png' onclick='reviewview_show("+cnt+")' style='width:22px; vertical-align: middle;'></span>"
					html+="</td></tr>"
					html+="<tr id='reviewview"+cnt+"' style='display:none;'><td colspan='7'>"
					html+="<fieldset style='border: 1px solid rgba(50, 50, 50, 0.3);margin: 10px;padding: 10px;'>"
					html+=item.content+"</fieldset></td></tr>"
					cnt++;
				});
				html+="<tr><td colspan='7' style='text-align: right;'>"
				html+="<input type='button' value='선택삭제' onclick='reviewdelete_chk()'>"
				html+="</td></tr>"
				$("#review_report_list").html(html)
			},
			error : function(request, status, error) {
				console.log("실패")
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	}
}
//댓글 보이기
function freeview_show(cnt) {
	$("#freeview"+cnt).show();
	console.log()
	var html="<img src='resources/main_image/more.png' onclick='freeview_hide("+cnt+")' style='width:22px; vertical-align: middle;'>"
	$('#freeshow'+cnt).html(html)
}
// 댓글 숨기기
function freeview_hide(cnt) {
	$("#freeview"+cnt).hide();
	var html="<img src='resources/main_image/more.png' onclick='freeview_show("+cnt+")' style='width:22px; vertical-align: middle;'>"
	$('#freeshow'+cnt).html(html)
}

function freedelete_chk(cnt) {
	var result = Array();
	var cnt = 0;
	var chkbox = $(".freechk");
	for(i=0;i<chkbox.length;i++) {
		if(chkbox[i].checked == true) {
			result[cnt] = chkbox[i].value;
			cnt++;
		}
	}
	var form = {
		result:result
	}
	if(result.length==0) {
		alert("삭제할 글을 선택해주세요.")
	}else{
		$.ajax({
			url : "freedelete_chk",
			type : "POST",
			data : form,
			traditional : true,
			success : function(list) {
				console.log("성공")
				var html=""
					html+="<tr style='vertical-align: middle;' >"
					html+="<td class='checks etrans' style='width:60px;text-align: center;'>"
					html+="<input type='checkbox' name='freechkall' value='freechkall' id='freechkall'> <label for='freechkall'></label></td>"
					html+="<td style='width:90px;text-align: center;'>글번호</td>"
					html+="<td style='width:400px;text-align: center;'>제목</td>"
					html+="<td style='width:200px;text-align: center;'>작성자</td>"
					html+="<td style='width:150px;text-align: center;'>신고건수</td></tr>"
				var cnt=0
				if(list.length==0) {
					html+="<tr><td colspan='5'></td></tr>"	
				}
				$.each(list, function(index,item) {
					html+="<tr><td class='checks etrans'>"
					html+="<input type='checkbox' class='freechk' name='freechk' value='"+item.num+"' id='freechk"+cnt+"'> <label for='freechk"+cnt+"'></label></td>"
					html+="<td>"+item.num+"</td>"
					html+="<td style='text-overflow: ellipsis;text-align: left;'>"+item.title+"</td>"
					html+="<td>작성자</td><td>"
					html+="<span id='freeshow"+cnt+"'><img src='resources/main_image/more.png' onclick='freeview_show("+cnt+")' style='width:22px; vertical-align: middle;'></span>"
					html+="</td></tr>"
					html+="<tr id='freeview"+cnt+"' style='display:none;'><td colspan='7'>"
					html+="<fieldset style='border: 1px solid rgba(50, 50, 50, 0.3);margin: 10px;padding: 10px;'>"
					html+=item.content+"</fieldset></td></tr>"
					cnt++;
				});
				html+="<tr><td colspan='7' style='text-align: right;'>"
				html+="<input type='button' value='선택삭제' onclick='freedelete_chk()'>"
				html+="</td></tr>"
				$("#free_report_list").html(html)
			},
			error : function(request, status, error) {
				console.log("실패")
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	}
}
//댓글 보이기
function mateview_show(cnt) {
	$("#mateview"+cnt).show();
	console.log()
	var html="<img src='resources/main_image/more.png' onclick='mateview_hide("+cnt+")' style='width:22px; vertical-align: middle;'>"
	$('#mateshow'+cnt).html(html)
}
// 댓글 숨기기
function mateview_hide(cnt) {
	$("#mateview"+cnt).hide();
	var html="<img src='resources/main_image/more.png' onclick='mateview_show("+cnt+")' style='width:22px; vertical-align: middle;'>"
	$('#mateshow'+cnt).html(html)
}

function matedelete_chk(cnt) {
	var result = Array();
	var cnt = 0;
	var chkbox = $(".matechk");
	for(i=0;i<chkbox.length;i++) {
		if(chkbox[i].checked == true) {
			result[cnt] = chkbox[i].value;
			cnt++;
		}
	}
	var form = {
		result:result
	}
	if(result.length==0) {
		alert("삭제할 글을 선택해주세요.")
	}else{
		$.ajax({
			url : "matedelete_chk",
			type : "POST",
			data : form,
			traditional : true,
			success : function(list) {
				console.log("성공")
				var html=""
					html+="<tr style='vertical-align: middle;' >"
					html+="<td class='checks etrans' style='width:60px;text-align: center;'>"
					html+="<input type='checkbox' name='matechkall' value='matechkall' id='matechkall'> <label for='matechkall'></label></td>"
					html+="<td style='width:90px;text-align: center;'>글번호</td>"
					html+="<td style='width:400px;text-align: center;'>제목</td>"
					html+="<td style='width:200px;text-align: center;'>작성자</td>"
					html+="<td style='width:150px;text-align: center;'>신고건수</td></tr>"
				var cnt=0
				if(list.length==0) {
					html+="<tr><td colspan='5'></td></tr>"	
				}
				$.each(list, function(index,item) {
					html+="<tr><td class='checks etrans'>"
					html+="<input type='checkbox' class='matechk' name='matechk' value='"+item.num+"' id='matechk"+cnt+"'> <label for='matechk"+cnt+"'></label></td>"
					html+="<td>"+item.num+"</td>"
					html+="<td style='text-overflow: ellipsis;text-align: left;'>"+item.title+"</td>"
					html+="<td>작성자</td><td>"
					html+="<span id='mateshow"+cnt+"'><img src='resources/main_image/more.png' onclick='mateview_show("+cnt+")' style='width:22px; vertical-align: middle;'></span>"
					html+="</td></tr>"
					html+="<tr id='mateview"+cnt+"' style='display:none;'><td colspan='7'>"
					html+="<fieldset style='border: 1px solid rgba(50, 50, 50, 0.3);margin: 10px;padding: 10px;'>"
					html+=item.content+"</fieldset></td></tr>"
					cnt++;
				});
				html+="<tr><td colspan='7' style='text-align: right;'>"
				html+="<input type='button' value='선택삭제' onclick='matedelete_chk()'>"
				html+="</td></tr>"
				$("#mate_report_list").html(html)
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
<body class="is-preload" onload="chk_loginUser()">
	<%@ include file="../default/header.jsp"%>
	<!-- Page Wrapper -->
	<div id="page-wrapper">
		<!-- Main -->
		<article id="main">
			<section class="wrapper style5">
				<div class="inner">
					<section>
					<!--<section style="margin-left: -100px;"> -->
						<h2>Admin Page</h2>
						<div class="row">
							<div class="col-6 col-12-medium" style="width:250px;">
								<ul class="alt">
									<li><a href="myPost?page=1&nick=${loginUser.nick }">작성한 글 관리</a></li>
									<li><a href="report_post">신고 글 관리</a></li>
									<li><a href="chk_pwd?page=change_userinfo">회원정보 수정</a></li>
									<li><a href="chk_pwd?page=change_pwd">비밀번호 수정</a></li>
									<li><a href="withdrawal">회원탈퇴</a></li>
								</ul>
							</div>
							<div class="col-6 col-12-medium" style="margin-left: 50px;">
								<div>
									<hr style="width: 900px;" id="top">
									<h3> 여행 정보 공유 게시판 </h3>
									<table id="info_report_list">
										<tr style="vertical-align: middle;" >
											<td class="checks etrans" style="width:60px;text-align: center;">
												<input type="checkbox" name="infochkall" value="infochkall" id="infochkall"> <label for="infochkall"></label>
											</td>
											<td style="width:90px;text-align: center;">글번호</td>
											<td style="width:400px;text-align: center;">제목</td>
											<td style="width:200px;text-align: center;">작성자</td>
											<td style="width:150px;text-align: center;">신고건수</td>
										</tr>
										<c:set var="cnt" value="0" />
										<c:forEach var="list" items="${info }">
										<tr>
											<td class="checks etrans">
												<input type="checkbox" class="infochk" name="infochk" value="${list.num }" id="infochk${cnt}"> <label for="infochk${cnt}"></label>
											</td>
											<td>${list.num }</td>
											<td style="text-overflow: ellipsis;text-align: left;">${list.title }</td>
											<td>작성자</td>
											<td>
												<span id="infoshow${cnt}"><img src="resources/main_image/more.png" onclick="infoview_show(${cnt})" style="width:22px; vertical-align: middle;"></span>
											</td>
										</tr>
										<tr id="infoview${cnt}" style="display:none;">
											<td colspan="7">
												<fieldset style="border: 1px solid rgba(50, 50, 50, 0.3);margin: 10px;padding: 10px;">
												${list.content }
												</fieldset>
											</td>
										</tr>
										<c:set var="cnt" value="${cnt+1 }" />
										</c:forEach>
										<tr>
											<td colspan="7" style="text-align: right;">
												<input type="button" value="선택삭제" onclick="infodelete_chk()">
											</td>
										</tr>
									</table>
								</div><Br><Br>
								<div>
									<h3> 여행 리뷰 게시판 </h3>
									<table id="review_report_list">
										<tr style="vertical-align: middle;" >
											<td class="checks etrans" style="width:60px;text-align: center;">
												<input type="checkbox" name="reviewchkall" value="reviewchkall" id="reviewchkall"> <label for="reviewchkall"></label>
											</td>
											<td style="width:90px;text-align: center;">글번호</td>
											<td style="width:400px;text-align: center;">제목</td>
											<td style="width:200px;text-align: center;">작성자</td>
											<td style="width:150px;text-align: center;">신고건수</td>
										</tr>
										<c:set var="cnt" value="0" />
										<c:forEach var="list" items="${review }">
										<tr>
											<td class="checks etrans">
												<input type="checkbox" class="reviewchk" name="reviewchk" value="${list.num }" id="reviewchk${cnt}"> <label for="reviewchk${cnt}"></label>
											</td>
											<td>${list.num }</td>
											<td style="text-overflow: ellipsis;text-align: left;">${list.title }</td>
											<td>작성자</td>
											<td>
												<span id="reviewshow${cnt}"><img src="resources/main_image/more.png" onclick="reviewview_show(${cnt})" style="width:22px; vertical-align: middle;"></span>
											</td>
										</tr>
										<tr id="reviewview${cnt}" style="display:none;">
											<td colspan="7">
												<fieldset style="border: 1px solid rgba(50, 50, 50, 0.3);margin: 10px;padding: 10px;">
												${list.content }
												</fieldset>
											</td>
										</tr>
										<c:set var="cnt" value="${cnt+1 }" />
										</c:forEach>
										<tr>
											<td colspan="7" style="text-align: right;">
												<input type="button" value="선택삭제" onclick="reviewdelete_chk()">
											</td>
										</tr>
									</table>
								</div><Br><Br>
								<div>
									<h3> 자유 게시판 </h3>
									<table id="free_report_list">
										<tr style="vertical-align: middle;" >
											<td class="checks etrans" style="width:60px;text-align: center;">
												<input type="checkbox" name="freechkall" value="freechkall" id="freechkall"> <label for="freechkall"></label>
											</td>
											<td style="width:90px;text-align: center;">글번호</td>
											<td style="width:400px;text-align: center;">제목</td>
											<td style="width:200px;text-align: center;">작성자</td>
											<td style="width:150px;text-align: center;">신고건수</td>
										</tr>
										<c:set var="cnt" value="0" />
										<c:forEach var="list" items="${free }">
										<tr>
											<td class="checks etrans">
												<input type="checkbox" class="freechk" name="freechk" value="${list.num }" id="freechk${cnt}"> <label for="freechk${cnt}"></label>
											</td>
											<td>${list.num }</td>
											<td style="text-overflow: ellipsis;text-align: left;">${list.title }</td>
											<td>작성자</td>
											<td>
												<span id="freeshow${cnt}"><img src="resources/main_image/more.png" onclick="freeview_show(${cnt})" style="width:22px; vertical-align: middle;"></span>
											</td>
										</tr>
										<tr id="freeview${cnt}" style="display:none;">
											<td colspan="7">
												<fieldset style="border: 1px solid rgba(50, 50, 50, 0.3);margin: 10px;padding: 10px;">
												${list.content }
												</fieldset>
											</td>
										</tr>
										<c:set var="cnt" value="${cnt+1 }" />
										</c:forEach>
										<tr>
											<td colspan="7" style="text-align: right;">
												<input type="button" value="선택삭제" onclick="freedelete_chk()">
											</td>
										</tr>
									</table>
								</div><Br><Br>
								<div>
									<h3> 여행 동행 찾기 게시판 </h3>
									<table id="mate_report_list">
										<tr style="vertical-align: middle;" >
											<td class="checks etrans" style="width:60px;text-align: center;">
												<input type="checkbox" name="matechkall" value="matechkall" id="matechkall"> <label for="matechkall"></label>
											</td>
											<td style="width:90px;text-align: center;">글번호</td>
											<td style="width:400px;text-align: center;">제목</td>
											<td style="width:200px;text-align: center;">작성자</td>
											<td style="width:150px;text-align: center;">신고건수</td>
										</tr>
										<c:set var="cnt" value="0" />
										<c:forEach var="list" items="${mate }">
										<tr>
											<td class="checks etrans">
												<input type="checkbox" class="matechk" name="matechk" value="${list.num }" id="matechk${cnt}"> <label for="matechk${cnt}"></label>
											</td>
											<td>${list.num }</td>
											<td style="text-overflow: ellipsis;text-align: left;">${list.title }</td>
											<td>작성자</td>
											<td>
												<span id="mateshow${cnt}"><img src="resources/main_image/more.png" onclick="mateview_show(${cnt})" style="width:22px; vertical-align: middle;"></span>
											</td>
										</tr>
										<tr id="mateview${cnt}" style="display:none;">
											<td colspan="7">
												<fieldset style="border: 1px solid rgba(50, 50, 50, 0.3);margin: 10px;padding: 10px;">
												${list.content }
												</fieldset>
											</td>
										</tr>
										<c:set var="cnt" value="${cnt+1 }" />
										</c:forEach>
										<tr>
											<td colspan="7" style="text-align: right;">
												<input type="button" value="선택삭제" onclick="matedelete_chk()">
											</td>
										</tr>
									</table>
								</div>
								<br>
								<br>
								<div style="text-align: center;width: 900px;">
								<a href="#top"><img alt="" src="resources/main_image/top.png" style="width:18px; vertical-align: middle;">&nbsp;TOP</a>
								</div>
							</div>
						</div>
					</section>
				</div>
			</section>
		</article>
	</div>
	<%@ include file="../default/footer.jsp"%>
<style>
table {
	width: 100%;
	border-top: 1px solid rgba(50, 50, 50, 0.2);
	border-collapse: collapse;
	font-size:0.8em; 
	text-align: center;
	margin: 0 auto; 
	background-color: white;
	width: 900px;
}
th, td {
	height: 60px;
	background-color: white;
	border-bottom: 1px solid rgba(50, 50, 50, 0.2);
	padding: 10px;
	margin: 10px;
	vertical-align: middle;
}

.checks {
	position: relative;
}

.checks input[type="checkbox"] { /* 실제 체크박스는 화면에서 숨김 */
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0
}

.checks input[type="checkbox"]+label {
	display: inline-block;
	position: relative;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
}

.checks input[type="checkbox"]+label:before { /* 가짜 체크박스 */
	content: ' ';
	display: inline-block;
	width: 21px; /* 체크박스의 너비를 지정 */
	height: 21px; /* 체크박스의 높이를 지정 */
	line-height: 21px; /* 세로정렬을 위해 높이값과 일치 */
	margin: -2px 8px 0 0;
	text-align: center;
	vertical-align: middle;
	background: #fafafa;
	border: 1px solid #cacece;
	border-radius: 3px;
	box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px
		rgba(0, 0, 0, 0.05);
}

.checks input[type="checkbox"]+label:active:before, .checks input[type="checkbox"]:checked+label:active:before
	{
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), inset 0px 1px 3px
		rgba(0, 0, 0, 0.1);
}

.checks input[type="checkbox"]:checked+label:before { /* 체크박스를 체크했을때 */
	content: '\2714'; /* 체크표시 유니코드 사용 */
	color: #99a1a7;
	text-shadow: 1px 1px #fff;
	border-color: #adb8c0;
	box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.05), inset 0px -15px 10px -12px
		rgba(0, 0, 0, 0.05), inset 15px 10px -12px rgba(255, 255, 255, 0.1);
}

.checks.etrans input[type="checkbox"]+label {
	padding-left: 30px;
}

.checks.etrans input[type="checkbox"]+label:before {
	position: absolute;
	left: 0;
	top: 0;
	margin-top: 0;
	opacity: .6;
	box-shadow: none;
	border-color: #6cc0e5;
	-webkit-transition: all .12s, border-color .08s;
	transition: all .12s, border-color .08s;
}

.checks.etrans input[type="checkbox"]:checked+label:before {
	position: absolute;
	content: "";
	width: 10px;
	top: -5px;
	left: 5px;
	border-radius: 0;
	opacity: 1;
	background: transparent;
	border-color: transparent #6cc0e5 #6cc0e5 transparent;
	border-top-color: transparent;
	border-left-color: transparent;
	-ms-transform: rotate(45deg);
	-webkit-transform: rotate(45deg);
	transform: rotate(45deg);
}

.no-csstransforms .checks.etrans input[type="checkbox"]:checked+label:before
	{
	/*content:"\2713";*/
	content: "\2714";
	top: 0;
	left: 0;
	width: 21px;
	line-height: 21px;
	color: #6cc0e5;
	text-align: center;
	border: 1px solid #6cc0e5;
}

input[type=checkbox]:checked+label {
	background-color: white;
}

input[type=checkbox] {
	display: none;
}
</style>
</body>
</html>