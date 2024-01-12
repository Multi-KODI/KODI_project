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

</script>

<body>
	<!-- 헤더 -->
	<%@ include file="/WEB-INF/views/Header.jsp"%>
	<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

	<button id="exitChat" type="button">
		<img id="exitIcon" src="/image/icon/exit-chat.png" align="center">
		<p id="exitMsg">채팅방 나가기</p>
	</button>

	<div id="allMsgList">
		<div id="oneMsg">
			<p id="friendName">친구 1</p>
			<p id="content">안녕</p>
		</div>
		<hr>
		<div id="oneMsg">
			<p id="friendName">나</p>
			<p id="content">잘지내?</p>
		</div>
		<hr>
	</div>
	
	<div id="sendMsgDiv">
		<input id="sendMsgInput" type="text" placeholder="메시지를 입력하시오">
		<button id="sendMsgBtn" type="button">전송</button>
	</div>
	
</body>
</html>