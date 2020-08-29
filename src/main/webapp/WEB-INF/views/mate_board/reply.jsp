<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css"> 
#input{display:none;}
#h{display:none;} 
#comment_table{border-collapse:collapse; }
#showreply{border-collapse:collapse; }
</style>
<script src="resources/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	function hide() {
		$("#input").hide();
		$("#h").hide();
		$("#s").show();
	}
	function show() {
		$("#here").show();
		$("#h").show();
		$("#s").hide();
		$("#input").show();
		
	}
	function showshow() {
		var nick=$("#nick").val();
		var re=$("#reply").val();
		var time=$("#savetime")
		var data={nick:nick, reply:re}
		showReplyList(data);
		
	}

	// 댓글 목록
	function showReplyList(data) {
		//let rep="";
		//$("#test").text("dd");
		console.log("showReplyList");
	
		var cnt=1;
		var userNick = '${loginUser}'
		console.log("userNick="+userNick)
		let rep="<table id='showreply' border='1'>";
		//rep+="<tr><td>nick</td><td>reply</td></tr>";
		rep+="<tr><td>bnum</td><td>rnum</td><td>nick</td><td>reply</td><td>savetime</td><td>rgroup</td><td>step</td></tr>";
		$.each(data, function(index,item){
			rep+="<tr id='modify_area"+cnt+"'>";
		if(item.step>0) {
			rep+="<th> -> </th>"
		} else {
			rep+="  "
		}
			rep+="<input type='hidden' id='bnum"+cnt+"' value='"+item.bnum+"'>";
			rep+="<input type='hidden' id='rnum"+cnt+"' value='"+item.rnum+"'>";
			rep+="<input type='hidden' id='nick"+cnt+"' value='"+item.nick+"'>";
			rep+="<input type='hidden' id='reply"+cnt+"' value='"+item.reply+"'>";
			rep+="<input type='hidden' id='rgroup"+cnt+"' value='"+item.rgroup+"'>";
			rep+="<input type='hidden' id='step"+cnt+"' value='"+item.step+"'>";
			rep+="<th id='modify_bnum"+cnt+"'>"+item.bnum+"</th>"
			rep+="<td id='modify_rnum"+cnt+"'>"+item.rnum+"</td>";
			rep+="<th id='modify_nick"+cnt+"'>"+item.nick+"</th>"
			rep+="<th id='modify_reply"+cnt+"'>"+item.reply+"</th>"
			rep+="<th id='modify_savetime"+cnt+"'>"+item.savetime+"</th>"
			rep+="<th id='modify_rgroup"+cnt+"'>"+item.rgroup+"</th>"
			rep+="<th id='modify_step"+cnt+"'>"+item.step+"</th>"
			//rep+="<input type='hidden' id='rnumrnum' value='"+item.rnum+"'>";
			//var number=item.rnum;
			//rep+="<td>"+item.reply+"</td>";
			//rep+="<td>"+item.savetime+"</td>";
			//rep+="<td>"+item.rgroup+"</td>";
			//rep+="<td>"+item.step+"</td>";
			//rep+="<td><button onclick='reply_delete()'><button type='submit'><input type='hidden' name='rnumrnum' value='"+item.rnum+"'></button>삭제</button></td>";
			if(userNick == item.nick) {
			rep+="<td><button id='double_chk' onclick='reply_modify_form("+cnt+")'>수정</button></td>";
			//rep+="<td><button onclick='reply_delete("+cnt+")'><input type='hidden' name='numtest' value='"+item.rnum+"'>삭제</button></td>";
			rep+="<td><button onclick='reply_delete("+cnt+")'> 삭제</button></td>";
			} else if(userNick == "관리자") {
			rep+="<td><button onclick='reply_delete("+cnt+")'> 삭제</button></td>";
			}
			if(item.step==0) {
				rep+="<th><input type='button' value='대댓글' onclick='reply_reply("+cnt+")'></th>"
				rep+="<tr id='reply_reply_area"+cnt+"'></tr>"
			} else {
				rep+="</tr>"
			}
			cnt++;
		})
		
		rep+="</table>";
		$("#here").html(rep)
	}
	// 댓글 저장
	function reply_reg() {
		var re=$("#reply").val();
		var savetime=$("#savetime").val();
		var step=$("#step").val();
		//$("#test").text(nick) // 출력안됨
		var form={  reply:re, step:step  }
		$.ajax({
			url:"mate_reply_save",
			type:"POST",
			//type:"GET",
			data:form,
			success:function(data) {
				console.log("성공");
				console.log("reply :"+re)
				//$("#here").text(data);
				showReplyList(data);
			},
			error:function() {
				console.log()
			}
		})
	}
	
	var chk=true;
	
	// 댓글 수정 폼
	function reply_modify_form(cnt) {
		console.log("수정 폼 cnt : "+cnt)
		if(chk) {
		chk=false;
			let rep=""
			rep+="<input type='hidden' id='bnum"+cnt+"' value='"+$("#bnum"+cnt).val()+"'>";
			rep+="<input type='hidden' id='rnum"+cnt+"' value='"+$("#rnum"+cnt).val()+"'>";
			rep+="<input type='hidden' id='rgroup"+cnt+"' value='"+$("#rgroup"+cnt).val()+"'>";
			rep+="<input type='hidden' id='nick"+cnt+"' value='"+$("#nick"+cnt).val()+"'>";
			rep+="<input type='hidden' id='step"+cnt+"' value='"+$("#step"+cnt).val()+"'>";
			//rep+="<input type='hidden' id='savetime"+cnt+"' value='"+$("#savetime"+cnt).val()+"'>";
			rep+="<td><textarea rows='3' cols='50' id='reply"+cnt+"'>"+$("#reply"+cnt).val()+"</textarea>"
			rep+="<input type='button' value='수정완료' onclick='reply_modify_save("+cnt+")'><br>"
			rep+="<input type='button' value='취소' onclick='reply_modify_save("+cnt+")'></td>"
			$("#modify_area"+cnt).html(rep)
		}
	}
	// 수정한 댓글 저장
	function reply_modify_save(cnt) {
		chk=true;
		var bnum=$("#bnum"+cnt).val();
		var rnum=$("#rnum"+cnt).val();
		var rgroup = $("#rgroup" + cnt).val();
		//var nick=$("#nick" + cnt).val();
		var re=$("#reply" + cnt).val();
		var savetime=$("#savetime" + cnt).val();
		console.log("CNT : "+cnt)
		//console.log("nick : "+nick)
		console.log("bnum : "+bnum)
		console.log("rnum : "+rnum)
		var form={bnum:bnum, rnum:rnum, rgroup:rgroup,reply:re,rnum:rnum  }
		$.ajax({
			url:"mate_reply_modify_save",
			type:"POST",
			data:form,
			success:function(data) {
				showReplyList(data);
				console.log("수정 성공");
				console.log(re)
			},
			error : function(request, status, error) {
				console.log("수정 실패")
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	}
	
	
	function reply_delete(cnt) {
		//var number=$("#number").val();
		//var r=115;
		//var rnumrnum=$("#rnumrnum").val();
		//var r=parseInt(rnum);
		var bnum=$("#bnum"+cnt).val();
		var rnum=$("#rnum"+cnt).val();
		console.log(rnum);
		console.log(cnt);
		var nick=$("#nick"+cnt).val();
		var reply=$("#reply"+cnt).val();
		var form={bnum:bnum, rnum:rnum, nick:nick, reply:reply}
		$.ajax({
			//url:"mate_reply_delete?rnum="+number,
			url:"mate_reply_delete",
			type:"POST",
			data:form,
			success:function(data) {
				console.log("삭제 성공");
				showReplyList(data);
				//$("#here").text(data);
			},
			error:function(request, status, error) {
				console.log("삭제 실패");
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		})
		
	}
	
	// 대댓글 툴
	function reply_reply(cnt) {
		console.log("대댓글 툴")
		var bnum=$("#bnum"+cnt).val();
		var rnum=$("#rnum"+cnt).val();
		var nick=$("#nick"+cnt).val();
		var reply=$("#reply"+cnt).val();
		var step=$('#step'+cnt).val() + 1;
		var rgroup=$('#rgroup'+cnt).val();
		console.log("대댓글 툴2")
		let rep="";
		rep+="<tr>";
		rep+="<input type='hidden' id='rebnum"+cnt+"' value='"+bnum+"'>"
		rep+="<input type='hidden' id='rernum"+cnt+"' value='"+rnum+"'>"
		rep+="<input type='hidden' id='renick"+cnt+"' value='"+nick+"'>"
		//rep+="<input type='hidden' id='rereply"+cnt+"' value='"+reply+"'>"
		rep+="<input type='hidden' id='restep"+cnt+"' value='"+step+"'>"
		rep+="<input type='hidden' id='rergroup"+cnt+"' value='"+rgroup+"'>"
		rep+="<td id='renick"+cnt+"'>"+nick+"</td>"
		rep+="<td><textarea rows='4' cols='50' id='rereply"+cnt+"'></textarea></td>"
		rep+="<td><input type='button' value='댓글저장' onclick='reply_reply_save("+cnt+")'></td></tr>"
		$("#reply_reply_area"+cnt).html(rep)
		console.log("대댓글 3")
	}
	
	// 대댓글 저장
	function reply_reply_save(cnt) {
		var bnum=$("#rebnum"+cnt).val();
		var rnum=$("#rernum"+cnt).val();
		var nick=$("#renick"+cnt).val();
		var reply=$("#rereply"+cnt).val();
		var rgroup=$("#rergroup"+cnt).val();
		var step=$('#restep'+cnt).val();
		var form={bnum:bnum, rnum:rnum, nick:nick, reply:reply, rgroup:rgroup, step:step}
		$.ajax({
			url:"mate_reply_reply_save",
			type:"POST",
			data:form,
			success:function(data) {
				showReplyList(data)
				console.log("대댓글 성공")
				console.log("step : "+step);
				console.log(reply)
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
<body>mate_reply.jsp<Br>
	<hr>
 		<!-- <button onclick="show()">댓글보이기</button>-->

	<label id="h">
		<button onclick="hide()">댓글숨기기</button>
	</label>
	<label id="s">
		<button onclick="show()">댓글보이기</button>
	</label>
	 <label id="test">test</label>
	 
	<label id="input">
		<input type="hidden" id="step" value="0">
		<textarea id="reply" name="reply" rows="10" cols="50" placeholder="댓글을 입력하세요"></textarea>
		<button onclick="reply_reg()">등록</button>
		<label id="here">
			<table border="1" id="comment_table">
			<tr>
				<th>bnum</th> <th>rnum </th> <th>시간</th>
				<th>닉네임</th> <th>댓글내용</th> 
				<th>rgroup</th> <th>step</th> 
			</tr>
			<c:set var="cnt" value="1" />
			<c:forEach items="${mate_reply_list }" var="reply_list">
			<tr id="modify_area${cnt}">

			<input type="hidden" id="rnum${cnt}" value="${reply_list.rnum}">
			<input type="hidden" id="bnum${cnt}" value="${reply_list.bnum}">
		 	<input type="hidden" id="nick${cnt}" value="${reply_list.nick}">
		 	<input type="hidden" id="reply${cnt}" value="${reply_list.reply}">
		 	<input type="hidden" id="savetime${cnt}" value="${reply_list.savetime}">
		 	<input type="hidden" id="rgroup${cnt}" value="${reply_list.rgroup}">
		 	<input type="hidden" id="step${cnt}" value="${reply_list.step}">
			
			<c:choose>
				<c:when test="${reply_list.step>0 }">
					<th> -> </th>
				</c:when>
				<c:otherwise>
					<th>  </th>
				</c:otherwise>
			</c:choose>
				<td id="modify_bnum${cnt}">${reply_list.bnum }</td>
				<td id="modify_rnum${cnt}">${reply_list.rnum }</td>
				<td id="modify_nick${cnt}">${reply_list.nick }</td> 
				<td id="modify_reply${cnt}">${reply_list.reply }</td> 
				<td id="modify_savetime${cnt}">${reply_list.savetime }</td> 
				<td id="modify_rgroup${cnt}">${reply_list.rgroup }</td> 
				<td id="modify_step${cnt}">${reply_list.step }</td> 
				<c:choose>
					<c:when test="${reply_list.wnick eq loginUser }">
						<td><button onclick="reply_modify_form(${cnt})">수정</button></td>
						<td><button onclick="reply_delete(${cnt})">삭제</button></td>
						</th>
					</c:when>
					<c:when test="${admin eq '관리자' }">
						<td><button onclick="reply_delete(${cnt})">삭제</button></td>
					</c:when>
				</c:choose>

				<c:choose>
					<c:when test="${reply_list.step==0 }">
						<td><input type="button" value="대댓글" onclick="reply_reply(${cnt })"></td>
						<td><button onclick="reply_reply(${cnt })">대댓글</button></td>
						<tr id="reply_reply_area"></tr>
					</c:when>
				</c:choose>
			</tr>
			<!-- 대댓글 위치할 공간 -->
			<tr id="reply_reply_area${cnt}"></tr>
			<c:set var="cnt" value="${cnt+1}" />
			</c:forEach>
			</table>
		</label>
	</label>
	
	
	
	
	
</body>



</html>