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
	});
	
	function showData(){
		let friendList = document.getElementById("friendList");

		let oneFriend;
		let chatBtn;
		
		<c:forEach items="${chatListInfo.friendInfo}" var="one">
			/* $("#friendList").append("<div id=\"${one.friendMemberIdx}\">" + "${one.friendMemberName}" + "</div><hr>"); */
			oneFriend = document.createElement("div");
			oneFriend.setAttribute("id", "${one.friendMemberIdx}");
			oneFriend.setAttribute("style", "padding-top: 5px; padding-left: 5px; padding-right: 5px;");
			oneFriend.innerHTML += "${one.friendMemberName}";
			
			chatBtn = document.createElement("input");
			chatBtn.setAttribute("type", "button");
			chatBtn.setAttribute("id", "chatBtn");
			chatBtn.setAttribute("value", "채팅");
			chatBtn.setAttribute("style", "display: inline-block; border:none; border-radius: 5px; background-color:#EDF2F6; color:gray; width: 50px; float:right;");
			chatBtn.setAttribute("onclick", `clickChatBtn(${one.friendMemberIdx})`);
			
			oneFriend.appendChild(chatBtn);
			
			oneFriend.innerHTML += "<hr>";
			
			friendList.appendChild(oneFriend);
		</c:forEach>
	};
	
	function clickChatBtn(friendMemberIdx){
		
		
		location.href="/api/chating/" + `${'${friendMemberIdx}'}`;
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

			<div id="friendList">
				<!-- <div id="friend">친구1</div> 추후 수정 -->
			</div>
		</div>

		<div id="chatListDiv">
			<img id="chatListIcon" src="/image/icon/live-chat.png" align="center">
			<p id="title">채팅방</p>

			<div id="chatList">
				<div id="oneChat">
					<div id="chatInfo">
						<p id="friendName">친구 1</p>
						<p id="chatContent">안녕</p>
					</div>
					<button id="deleteChat">삭제</button>
				</div>
				<div id="oneChat">
					<div id="chatInfo">
						<p id="friendName">친구 2</p>
						<p id="chatContent">안녕</p>
					</div>
					<button id="deleteChat">삭제</button>
				</div>
				<div id="oneChat">
					<div id="chatInfo">
						<p id="friendName">친구 2</p>
						<p id="chatContent">안녕</p>
					</div>
					<button id="deleteChat">삭제</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>