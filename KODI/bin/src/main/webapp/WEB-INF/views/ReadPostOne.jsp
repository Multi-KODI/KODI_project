<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>KODI</title>

<link href="/css/ReadPostOne.css" rel="stylesheet">

<script src="/js/jquery-3.7.1.min.js"></script>
</head>

<script>
	// memberIdx 추후 session 값 받아오기
<%-- 	let sessionId = <%=session.getAttribute("memberIdx")%>; --%>	
 
	$(document).ready(function(){
		showPostData();
		likeBtnClick();
		markingBtnClick();
		shareBtnClick();
		showComments();
		addComment();
		updateDelMenu();
	});
	
	function showPostData() {		
		$("#postTitle").html("${readPostOne.postInfo.title}");
		$("#grade").html("평점 " + "${readPostOne.postInfo.grade}" + "/5.0");
		$("#flag").attr("src", "${readPostOne.flag}");
		$("#memberName").html("${readPostOne.memberName}");
		$("#date").html("${readPostOne.postInfo.regdate}");
		$("#postContent").html("${readPostOne.postInfo.content}" + "<br><br>");

		// 수정
		<c:forEach items="${readPostOne.postImages}" var="image">
			 $("#postContent").append("<img id='postImg' src='/image/db/" + "${image}" + "' width=150px height=150px>&nbsp;");		
		</c:forEach>
		
		$("#addrInfo").html("${readPostOne.postInfo.address}");

		<c:forEach items="${readPostOne.postTags}" var="tag">
			$("#tagDiv").append("<div style=\" display: inline; border: 2px solid #FF5656; background-color: #FF5656; border-radius: 10px; color: white; padding-left: 10px; padding-right: 10px; margin-left: 10px;\">" + "${tag}" + "</div>");
		</c:forEach>
	};
	
	function likeBtnClick() {
		$("#likeBtnText").html("${readPostOne.likeCnt}");
		
		$("#like").on("click", function(){
			// memberIdx 추후 수정
			var data = {postIdx: ${readPostOne.postInfo.postIdx}, memberIdx: 1};
			
			$.ajax({
				url: "/api/post/like",
				type: "post",
				data: JSON.stringify(data),
				contentType: "application/json",
				dataType: "json",
				success: function(res){
					$("#likeBtnText").html(res);
				},
				error: function(res, e){
					alert("코드: " + res.status + "메시지: " + res.responseText + "오류: " + e);
				}
			});
		});
	};
	
	function markingBtnClick(){
		$("#marker").on("click", function(){
			// memberIdx 추후 수정
			var data = {postIdx: ${readPostOne.postInfo.postIdx}, memberIdx: 1};
			
			// 이미 마킹한 게시물인지 확인
			$.ajax({
				url: "/api/post/ismarking",
				type: "post",
				data: JSON.stringify(data),
				contentType: "application/json",
				dataType: "json",
				success: function(response){
					if(response == 1){
						alert("이미 마킹 등록하였습니다.");
						
						// 마킹 삭제
						let isDeleteMarking = confirm("마킹 취소하시겠습니까?");
						
						if(isDeleteMarking){
							$.ajax({
								url: "/api/post/deletemarking",
								type: "post",
								data: JSON.stringify(data),
								contentType: "application/json",
								dataType: "json",
								success: function(deleteRes){
									if(deleteRes == 1){
										alert("마킹 취소되었습니다.");
									}
								},
								error: function(res, e){
									alert("코드: " + res.status + "메시지: " + res.responseText + "오류: " + e);
								}
							});
						}
					} else {
						// 마킹 등록
						let isMarking = confirm("마킹 등록하시겠습니까?");
						
						if(isMarking){
							$.ajax({
								url: "/api/post/insertmarking",
								type: "post",
								data: JSON.stringify(data),
								contentType: "application/json",
								dataType: "json",
								success: function(insertRes){
									if(insertRes == 1){
										alert("마킹 등록되었습니다.");
									}
								},
								error: function(res, e){
									alert("코드: " + res.status + "메시지: " + res.responseText + "오류: " + e);
								}
							});
						};
					}
				},
				error: function(res, e){
					alert("코드: " + res.status + "메시지: " + res.responseText + "오류: " + e);
				}
			});
			
		});
	};
	
	function shareBtnClick(){
		$("#share").on("click", function(){
			let currentUrl = location.href;
			let dummy = document.createElement("textarea");
			
			document.body.appendChild(dummy);
			dummy.value = currentUrl;
			dummy.select();
			
			document.execCommand("copy");
			document.body.removeChild(dummy);
			
			alert("해당 URL이 복사되었습니다.");
		});
	};

	function showComments(){
		let postBtn = document.getElementById("postBtn");
		let inputComment = document.getElementById("inputComment");
		let showComment = document.getElementById("showComment");
		
		let comments = document.createElement("div");
		comments.setAttribute("id", "comments");
		
		let num = 1;
		let comment;
		let commentText;
		let deleteBtn;
		
		
		// 기존 데이터베이스에 있는 댓글 먼저 정렬
		if(${readPostOne.comments.size() > 0}){
			<c:forEach items="${readPostOne.comments}" var="one">            
				comment = document.createElement("span");
				comment.setAttribute("id", `${one.memberIdx}`);
				
				commentMemberName = document.createElement("p");
				commentMemberName.setAttribute("id", "commentMemberName");
				commentMemberName.setAttribute("style", "display: inline;");

				commentText = document.createElement("p");
				commentText.setAttribute("id", "commentText");
				commentText.setAttribute("style", "display: inline;");

				commentRegdate = document.createElement("p");
				commentRegdate.setAttribute("id", "commentRegdate");
				commentRegdate.setAttribute("style", "color:grey;");
				
				deleteBtn = document.createElement("input");
				deleteBtn.setAttribute("type", "button");
				deleteBtn.setAttribute("id", "deleteBtn");
				deleteBtn.setAttribute("value", "삭제");
				deleteBtn.setAttribute("style", "display: inline; border:none; background-color:#EDF2F6; color:grey; float:right;");
				deleteBtn.setAttribute("onclick", `deleteCommentBtn(${one.commentIdx})`);
								
				comment.appendChild(commentMemberName);
				comment.appendChild(commentText);
				comment.appendChild(deleteBtn);
				comment.appendChild(commentRegdate);
				
				<c:forEach items="${commentMemberInfo}" var="memberInfo">  					
					if("${memberInfo.memberIdx}" == "${one.memberIdx}"){
						commentMemberName.innerHTML = "<img src=\"/image/icon/user.png\" width=16px height=16px align= \"center\">&nbsp;&nbsp;" + "${memberInfo.memberName}&nbsp;&nbsp;|&nbsp;&nbsp;";
					}
				</c:forEach>
				
				commentText.innerHTML += "${one.content}";
				commentRegdate.innerHTML += "${one.regdate}"
				comment.innerHTML += "<hr>";
				
				comments.appendChild(comment);
				showComment.appendChild(comments);
				
				inputComment.value = "";
				num++;
			</c:forEach>
		};
	};
	
	// 새로운 댓글 추가
	function addComment(){
		$("#postBtn").on("click", function(){
			// memberIdx 추후 수정
			var data = {content: $("#inputComment").val(), memberIdx: 1, postIdx: ${readPostOne.postInfo.postIdx}}
			
			if (inputComment.value != "") {            
				$.ajax({
					url: "/api/post/comment",
					data: JSON.stringify(data),
					type: "post",
					contentType: "application/json",
					dataType: "json",
					success: function(response){
						if(response == 1){
							//alert("댓글 작성완료");
							location.reload();
						}else{
							alert("댓글 작성실패");
						}
					},
					error: function(request, e){
						alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
					}
				});
			} else {
				alert("댓글을 입력해주세요.");
			}
		});
	};
	
	function deleteCommentBtn(commentIdx) {
		// 추후 세션 추가, memberIdx 값 수정
		//if(sessionId == ${readPostOne.postInfo.memberIdx}){
		if(1 == ${readPostOne.postInfo.memberIdx}){
			let isDelete = confirm("해당 댓글을 삭제하시겠습니까?");
			
			if (isDelete){
				$(`#${'${commentIdx}'}`).remove();
				$.ajax({
					url: "/api/post/comment/delete",
					data: {"commentIdx": `${'${commentIdx}'}`},
					type: "post",
					dataType: "json",
					success: function(response){
						location.reload();
					},
					error: function(request, e){
						alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
					}
				});
			};
		} else{
			alert("해당 댓글을 삭제할 수 있는 권한이 없습니다.");
		}
	};
	
	function updateDelMenu() {
		$("#updatePostBtn").on("click", function(){
			// 추후 세션 추가, memberIdx 값 수정
			//if(sessionId == ${readPostOne.postInfo.memberIdx}){
			if(1 == ${readPostOne.postInfo.memberIdx}){
				let isUpdate = confirm("해당 게시물을 수정하시겠습니까?");
            
				if (isUpdate) {
					location.href = "/api/post/modify/" + ${readPostOne.postInfo.postIdx};
				};
			} else {
				alert("해당 게시글을 수정할 수 있는 권한이 없습니다.");
			}
         
		});
      
		$("#deletePostBtn").on("click", function(){         
			var data = {postIdx: ${readPostOne.postInfo.postIdx}};
			
			// 추후 세션 추가, memberIdx 값 수정
			//if(sessionId == ${readPostOne.postInfo.memberIdx}){
			if(1 == ${readPostOne.postInfo.memberIdx}){
				let isDelete = confirm("해당 게시물을 삭제하시겠습니까?");
				
				if (isDelete) {
					$.ajax({
						url: "/api/post/delete",
						data: JSON.stringify(data),
						type: "post",
						dataType: "json",
						contentType: "application/json",
						success: function(response){
							alert("게시물을 삭제하였습니다.");
							location.href = "/api/post";
						},
						error: function(request, e){
							alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
						}
					});
				};   
			} else {
				alert("해당 게시물을 삭제할 수 있는 권한이 없습니다.");
			}
		});
	};
	
	
</script>

<body>
	<!-- 헤더 -->
	<%@ include file="/WEB-INF/views/Header.jsp" %>
	<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>

	<div id="allElement">
		<!-- 게시물 정보 -->
		<div class="moreHoriz">
			<button class="moreHorizBtn">
				<img class="moreHorizImg" src="/image/icon/more_horiz.svg" width="24"
					height="24"></img>
			</button>
			<div class="option">
				<button class="optionBtn" id="updatePostBtn" value="update">게시글
					수정</button>
				<hr>
				<button class="optionBtn" id="deletePostBtn" value="delete">게시글
					삭제</button>
			</div>
		</div>

		<div id="postAllInfo">

			<h2 id="postTitle">게시글 제목</h2>

			<div id="postInfo">
				<p id="grade" style="display: inline;">평점 3.5/5</p>
				<img id="flag" src="/image/love.png" width=15px height=15px align= "center">
				<p id="memberName" style="display: inline;">작성자</p>
				<p id="date" style="display: inline;">2023.11.08. 15:48</p>
			</div>

			<hr width="100%" align="center" />

			<div id="postContent">
				<p>게시글 내용</p>
			</div>

			<div id="addrDiv">
				주소
				<p id="addrInfo">서울시 강남구</p>
			</div>

			<div id="tagDiv">
				태그
				<!-- <div id="tag1">예시</div> -->
			</div>
		</div>

		<!-- 좋아요, 마킹, 공유 -->
		<div id="btns">
			<button id="like" type="button">
				<span> <img src="/image/icon/love.png" align= "center">
					<p id="likeBtnText" style="display: inline;">0</p>
				</span>
			</button>
			<button id="marker" type="button">
				<img src="/image/icon/marker.png" align= "center">
			</button>
			<button id="share" type="button">
				<img src="/image/icon/export.png" align= "center">
			</button>
		</div>

		<!-- 댓글 -->
		<div id="commentInfo">
			<p>댓글</p>
			<hr width="100%" align="center">
			<textarea id="inputComment" rows="5" placeholder="댓글을 입력하세요."></textarea>
			<br> <input type="button" id="postBtn" value="등록">
			<div id="showComment"></div>
		</div>
	</div>
</body>
</html>