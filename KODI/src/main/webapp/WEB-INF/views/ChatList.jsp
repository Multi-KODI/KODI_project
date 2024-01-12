<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>KODI</title>

<link href="/css/ChatList.css" rel="stylesheet">

<script src="/js/jquery-3.7.1.min.js"></script>

</head>

<script>
	//memberIdx 추후 session 값 받아오기
	<%-- 	let sessionId = <%=session.getAttribute("memberIdx")%>; --%>	
	$(document).ready(function(){
		showData();
		searchFriend();
	});
	
	function showData(){
		// 전체 친구 리스트
		let friendList = document.getElementById("friendList");

		let oneFriend;
		let chatBtn;
	
		<c:forEach items="${chatListInfo.friendInfo}" var="one">
			oneFriend = document.createElement("div");
			oneFriend.setAttribute("id", "${one.friendMemberIdx}");
			oneFriend.setAttribute("style", "padding-top: 5px; padding-left: 5px; padding-right: 5px;");
			oneFriend.innerHTML += "${one.friendMemberName}";
			
			chatBtn = document.createElement("input");
			chatBtn.setAttribute("type", "button");
			chatBtn.setAttribute("id", "chatBtn");
			chatBtn.setAttribute("value", "채팅");
			chatBtn.setAttribute("style", "display: inline-block; border:none; border-radius: 5px; background-color:#EDF2F6; color:gray; width: 50px; float:right; cursor: pointer;");
			chatBtn.setAttribute("onclick", `clickChatBtn(${one.friendMemberIdx})`);
			
			oneFriend.appendChild(chatBtn);
			
			oneFriend.innerHTML += "<hr>";
			
			friendList.appendChild(oneFriend);
		</c:forEach>
		
		// 전체 채팅방 리스트
		let chatList = document.getElementById("chatList");

		let oneChat;
		let friendName;
		let chatContent;
		let deleteChat;
		
		<c:forEach items="${chatListInfo.chatingRoomInfo}" var="one">
			oneChat = document.createElement("div");
			oneChat.setAttribute("id", "${one.chatIdx}");
			oneChat.setAttribute("style", "margin-bottom: 10px;");
	
			chatInfo = document.createElement("button");
			chatInfo.setAttribute("id", "chatInfo");
			chatInfo.setAttribute("style", "display: inline-block; border: 2px solid #B6BBC4; border-radius: 10px; cursor: pointer; width: 64%; background-color: white;");
			chatInfo.setAttribute("onclick", `clickChatInfo(${one.chatIdx})`);

			friendName = document.createElement("p");
			friendName.setAttribute("id", "friendName");
			friendName.setAttribute("style", "display: inline-block; margin: 15px; font-weight: bold; font-size: small; float: left;");
			friendName.innerHTML += "${one.memberName}";
	
			chatContent = document.createElement("p");
			chatContent.setAttribute("id", "chatContent");
			chatContent.setAttribute("style", "display: flex; font-size: small;");
			
			if("${one.content}" == ""){
				chatContent.innerHTML += "...";				
			} else {
				chatContent.innerHTML += "${one.content}";
			}
			
			deleteChat = document.createElement("input");
			deleteChat.setAttribute("type", "button");
			deleteChat.setAttribute("id", "deleteChat");
			deleteChat.setAttribute("value", "삭제");
			deleteChat.setAttribute("style", "display: inline-block; cursor: pointer; margin-left: 10px; background-color: #EDF2F6; border: 2px solid #EDF2F6; border-radius: 5px; width: 60px; height: 30px; color: gray;");
			deleteChat.setAttribute("onclick", `deleteChatBtn(${one.chatIdx})`);
			
			chatInfo.appendChild(friendName);
			chatInfo.appendChild(chatContent);
			
			oneChat.appendChild(chatInfo);
			oneChat.appendChild(deleteChat);
						
			chatList.appendChild(oneChat);
		</c:forEach>
	};
	
	function searchFriend() {
		let searchInput = document.getElementById("searchInput");

		$("#searchBtn").on("click", function(){
			// 추후 세션 비교 추가
			//if(sessionId == ${chatListInfo.memberIdx}){
			if(1 == ${chatListInfo.memberIdx}){
				if(searchInput.value == ""){
					alert("검색할 친구를 입력해주세요");
				} else {
					var data = {memberIdx: 1, friendName: searchInput.value};
					
					$.ajax({
						url: "/api/chatlist/search",
						data: JSON.stringify(data),
						type: "post",
						contentType: "application/json",
						dataType: "json",
						success: function(response){
							let friendList = document.getElementById("friendList");
							
							friendList.innerHTML = "";
							
							let oneFriend;
							let chatBtn;
							
							for (var i = 0; i < response.length; i++) {
								oneFriend = document.createElement("div");
								oneFriend.setAttribute("id", response[i].friendMemberIdx);
								oneFriend.setAttribute("style", "padding-top: 5px; padding-left: 5px; padding-right: 5px;");
								oneFriend.innerHTML += response[i].friendMemberName;
								
								chatBtn = document.createElement("input");
								chatBtn.setAttribute("type", "button");
								chatBtn.setAttribute("id", "chatBtn");
								chatBtn.setAttribute("value", "채팅");
								chatBtn.setAttribute("style", "display: inline-block; border:none; border-radius: 5px; background-color:#EDF2F6; color:gray; width: 50px; float:right; cursor: pointer;");
								chatBtn.setAttribute("onclick", `clickChatBtn(${"${response[i].friendMemberIdx}"})`);
								
								oneFriend.appendChild(chatBtn);
								
								oneFriend.innerHTML += "<hr>";
								
								friendList.appendChild(oneFriend);
							}
						},
						error: function(request, e){
							alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
						}
					});
				}
			} else {
				alert("친구 검색할 수 없습니다.");
			}
		});
	};
	
	function clickChatBtn(friendMemberIdx){
		// 추후 세션 비교 추가
		//if(sessionId == ${chatListInfo.memberIdx}){
		if(1 == ${chatListInfo.memberIdx}){
			// 추후 memberIdx 세션 값으로 변경
			var data = {memberIdx: 1, friendMemberIdx: `${'${friendMemberIdx}'}`}
			// 채팅방 여부 조회
			$.ajax({
				url: "/api/chatlist/clickchat",
				data: JSON.stringify(data),
				type: "post",
				contentType: "application/json",
				dataType: "json",
				success: function(response){
					if(response == true){ // 이미 채팅방 존재
						// 채팅방 번호 조회
						$.ajax({
							url: "/api/chatlist/chatidx",
							data: JSON.stringify(data),
							type: "post",
							contentType: "application/json",
							dataType: "json",
							success: function(response){
								location.href="/api/chatroom/" + response;
							},
							error: function(request, e){
								alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
							}
						});
					} else { // 채팅방 존재 X
						// 새로운 채팅방 생성 및 채팅방 번호 조회
						$.ajax({
							url: "/api/chatlist/createchatroom",
							data: JSON.stringify(data),
							type: "post",
							contentType: "application/json",
							dataType: "json",
							success: function(response){
								location.href="/api/chatroom/" + response;
							},
							error: function(request, e){
								alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
							}
						});
					}
				},
				error: function(request, e){
					alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
				}
			});
		} else {
			alert("채팅방에 들어갈 수 없습니다.");
		}
	};
	
	function clickChatInfo(chatIdx){
		// 추후 세션 비교 추가
		//if(sessionId == ${chatListInfo.memberIdx}){
		if(1 == ${chatListInfo.memberIdx}){
			location.href="/api/chatroom/" + `${'${chatIdx}'}`;
		} else {
			alert("채팅방에 들어갈 수 없습니다.");
		}
	};
	
	function deleteChatBtn(chatIdx){
		// 추후 세션 비교 추가
		//if(sessionId == ${chatListInfo.memberIdx}){
		if(1 == ${chatListInfo.memberIdx}){
			let isDelete = confirm("해당 채팅방을 삭제하시겠습니까?");
			
			if(isDelete){
				$(`#${'${chatIdx}'}`).remove();
				$.ajax({
					url: "/api/chatlist/deletechat",
					data: {"chatIdx": `${'${chatIdx}'}`},
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
		} else {
			alert("해당 채팅방을 삭제할 수 있는 권한이 없습니다.");
		}	
	};
	
</script>

<body>
	<!-- 헤더 -->
	<%@ include file="/WEB-INF/views/Header.jsp"%>
	<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

	<div id="allElement">
		<div id="searchFriendDiv">
			<img id="friendIcon" src="/image/icon/friends.png" align="center">
			<p id="title">친구 검색</p>

			<div id="searchInputDiv">
				<input id="searchInput" type="search" placeholder="친구 검색">
				<button id="searchBtn" type="button">
					<img id="searchIcon" src="/image/icon/search.png" align="center">
				</button>
			</div>

			<div id="friendList"></div>
		</div>

		<div id="chatListDiv">
			<img id="chatListIcon" src="/image/icon/live-chat.png" align="center">
			<p id="title">채팅방</p>

			<div id="chatList"></div>
		</div>
	</div>

</body>
</html>