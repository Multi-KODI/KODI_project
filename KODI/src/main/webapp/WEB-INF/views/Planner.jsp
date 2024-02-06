<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>
<!DOCTYPE html>

<html lang="en" dir="ltr">
<head>
    <title>Planner</title>
    <link rel="stylesheet" href="/css/Planner.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
    <script src="/js/jquery-3.7.1.min.js"></script>
	<script src="/js/Planner.js" defer></script> 
<script>
/* if (${isSession}==false){
   	alert("로그인하세요");
   	location.href = "/";
} */
</script>
</head>
<body>
<main>
<div class="wrapper">

	<div class='left-side'>
	    <header>
	       	<p class="current-date"></p>
	       	<div class="icons">
	         	<span id="prev" class="material-symbols-rounded"><img class="arrow" src="/image/icon/arrowleft.png"></span>
	         	<span id="next" class="material-symbols-rounded"><img class="arrow" src="/image/icon/arrowright.png"></span>
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
	   	<div class="modal">
	   		<div class="pop-modal">
				<button type="button" class="Btn" id="closePlannerModal" onclick="closePlannerModal()"><img id="closePlannerModalIcon" src="/image/icon/x.png"></button><br>
			<div class="pop-planner">
			</div>
	   		</div>
		</div>
	
	</div>
	<div class="right-side">
		<div id="checklist">
		<img id="check-image"src='/image/icon/check.png'>
		<label class='left-side-title'>체크리스트</label>
		<button class="checkListInsertBtn" onclick="makeCheckListModal()">추가</button>
		<ul class="checkList"></ul>
		</div>
		
		
		<div id="modal">
			<div class="pop">
				<input id="inputCheckList" type="text"><br><br>
				<button class="Btn" id="inputCheckListBtn" type="button" onclick="addLi()">입력</button>
				<button class="Btn" id ="closeCheckkList" type="button" onclick="closeCheckListModal()">닫기</button><br>
			</div>
		</div>
		
		<div id="app">
		<img id="app-image"src='/image/icon/app.png'>
		<label class='left-side-title'>유용한 어플</label>
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
	</div>

</div>
</main>
</body>
</html>