<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>
<!DOCTYPE html>
<!-- Coding By CodingNepal - youtube.com/codingnepal -->
<html lang="en" dir="ltr">
<head>
    <title>Planner</title>
    <link rel="stylesheet" href="/css/Planner.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
    <script src="/js/Planner.js" defer></script>
    <script>
    if (${isSession}==false){
        alert("로그인하세요");
        location.href = "/";
  }
    
    </script>
</head>
<body>
<div class="wrapper">
      <header>
        <p class="current-date"></p>
        <div class="icons">
          <span id="prev" class="material-symbols-rounded">chevron_left</span>
          <span id="next" class="material-symbols-rounded">chevron_right</span>
        </div>
      </header>
      <div class="calendar">
        <ul class="weeks">
          <li>Sun</li>
          <li>Mon</li>
          <li>Tue</li>
          <li>Wed</li>
          <li>Thu</li>
          <li>Fri</li>
          <li>Sat</li>
        </ul>
        <ul class="days"></ul>
      </div>
    <div class="modal"></div>
</div>
<div id="checklist">
<h5>체크리스트</h5>
<button class="checkListInsertBtn" onclick="makeCheckListModal()">추가</button>
<ul class="checkList"></ul>
</div>


<div id="modal">
	<div class="pop">
		<input id="inputCheckList" type="text">
		<button id="inputCheckListBtn" type="button" onclick="addLi()">입력</button>
		<button id ="closeCheckkList" type="button" onclick="closeCheckListModal()">닫기</button>
	</div>
</div>

<div id="app">
<h5>유용한 어플</h5>
<ul>
    <li>배달
 		<ul>
            <li>배달의민족</li>
            <li>요기요</li>
        </ul>   
    </li>
    
    <li>
        숙소예약
        <ul>
            <li>호텔스컴바인</li>
            <li>야놀자</li>
            <li>여기어때</li>
            <li>에어비앤비</li>
        </ul>
    </li>
    <li>교통
		<ul>
	       <li>카카오맵</li>
	       <li>카카오택시</li>
	       <li>티머니GO</li>
	       <li>네이버맵</li>
		</ul>
    </li>
</ul>
</div> 
</body>
</html>