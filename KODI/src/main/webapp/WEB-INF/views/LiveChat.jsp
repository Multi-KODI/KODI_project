<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>KODI</title>

<link href="/css/LiveChat.css" rel="stylesheet">

<script src="/js/jquery-3.7.1.min.js"></script>
</head>

<script>
	//memberIdx 추후 session 값 받아오기
	<%-- 	let sessionId = <%=session.getAttribute("memberIdx")%>; --%>	
	$(document).ready(function(){
		showData();
	});
	
	function showData() {
		let allMsgList = document.getElementById("allMsgList");
		
		let oneMsg;
		let friendName;
		let content;
		let regdate;
		
		<c:forEach items="${allChatMsg}" var="one">
			oneMsg = document.createElement("div");
			oneMsg.setAttribute("id", "${one.chatMsgDTO.chatMsgIdx}");
			
			friendName = document.createElement("p");
			friendName.setAttribute("id", "friendName");
			friendName.innerHTML = "${one.memberName}";
			
			content = document.createElement("p");
			content.setAttribute("id", "content");
			content.innerHTML = "${one.chatMsgDTO.content}";

			regdate = document.createElement("p");
			regdate.setAttribute("id", "regdate");
			regdate.innerHTML = "${one.chatMsgDTO.regdate}";
			
			oneMsg.appendChild(friendName);
			oneMsg.appendChild(content);
			oneMsg.appendChild(regdate);

			oneMsg.innerHTML += "<hr>";
			
			allMsgList.appendChild(oneMsg);
		</c:forEach>
	};
	
	
	
</script>

<body>
	<!-- 헤더 -->
	<%@ include file="/WEB-INF/views/Header.jsp"%>
	<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

	<button id="exitChat" type="button">
		<img id="exitIcon" src="/image/icon/exit-chat.png" align="center">
		<p id="exitMsg">채팅방 나가기</p>
	</button>

	<div id="allMsgList"></div>

	<div id="sendMsgDiv">
		<input id="sendMsgInput" type="text" placeholder="메시지를 입력하시오">
		<button id="sendMsgBtn" type="button">전송</button>
	</div>

</body>
</html>