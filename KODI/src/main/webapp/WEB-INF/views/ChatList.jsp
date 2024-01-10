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
					<img id="searchIcon" src="/image/icon/search.png">
				</button>
			</div>
		</div>
	</div>

	<div id="chatListDiv"></div>
	</div>
</body>
</html>