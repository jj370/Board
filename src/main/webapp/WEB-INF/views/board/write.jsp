<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성 중</title>
<script src="resources/jquery-3.5.1.min.js"></script>
<!-- <script src="resources/smarteditor2/photo-uploader/attach_photo.js" ></script> -->
<script type="text/javascript" src="resources/smarteditor/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script type="text/javascript" charset="utf-8">
		sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
</script>
 
</head>
<body   class="is-preload">
	<%@ include file="../default/header.jsp"%>
	<!-- Page Wrapper -->
	<div id="page-wrapper">
		<!-- Main -->
		<article id="main">
			<section class="wrapper style5">
				<div class="inner">
					<form action="write_save" id="frm">
						<!--  <input type="hidden" name="nick" value="${loginUser.nick }" >-->
						<h4><a href="#" style="border-bottom: 0;">>>  게시판</a></h4><br>
					<table>
						
						<tr>
							<td style="width:60px;text-align: center;">제목</td>
							<td><input type="text" placeholder="제목을 입력하세요." name="title" autofocus="autofocus"></td>
						</tr>
						<tr>
						<td colspan="2" style="margin: 0 auto;background: white;">
						<textarea rows="15" cols="50" id="content" name = "content"></textarea>
						<script type="text/javascript">
							$(function() {
								//전역변수선언
							    var editor_object = [];
							    var ctx = getContextPath();
				
							    nhn.husky.EZCreator.createInIFrame({
							        oAppRef: editor_object,
							        elPlaceHolder: "content",
							        sSkinURI: ctx + "/resources/smarteditor/SmartEditor2Skin.html",
							        htParams : {
							            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
							            bUseToolbar : true,             
							            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
							            bUseVerticalResizer : true,     
							            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
							            bUseModeChanger : true,
							            fOnBeforeUnload : function(){
							                
							            }
							        }
							    });
							    
							  //전송버튼 클릭이벤트
							    $("#contentRegBtn").click(function(){
								    editor_object.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
							        var content =  document.getElementById("content").value
							        content = content.replace(/<p>/gi,"");
							        content = content.replace(/<\/p>/gi,"");
							        content = content.replace(/<br>/gi,"");
							        content = content.replace(/&nbsp;/gi,"");
							        content = content.replace(/ /gi,"");
							    	if($('input[name=title]').val()=="") {
							    		alert("제목을 입력하세요.")
							    		$('input[name=title]').focus()
							    	}else if(content=="") {
							    		alert("내용을 입력하세요.")
							    		$('input[name=content]').focus()
							    	}else {
								        //id가 smarteditor인 textarea에 에디터에서 대입
								        $("#frm").submit();
							    	}
							    });
							    
							    function getContextPath() {
							    	return sessionStorage.getItem("contextpath");
							    }
							});
							</script>
						</td>
						</tr>
						<tr>
						<td style="text-align: left: ;">
						<input type="button" value="전체목록보기" onclick="location.href='#'">	
						</td>
						<td style="text-align: right;">
						<input type="button" value="완료" id="contentRegBtn">
						</td>
						</tr>
					</table>
					</form>
				</div>
			</section>
		</article>
	</div>
	<%@ include file="../default/footer.jsp"%>
</body>
</html>