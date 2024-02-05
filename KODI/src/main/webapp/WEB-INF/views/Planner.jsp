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
    <script src="/js/Planner.js" defer></script>
    <script>
    if (${isSession}==false){
        alert("Please log in");
        location.href = "/";
  }
    
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
			<div class="pop-planner">
			</div>
		</div>
	
	</div>
	<div class="right-side">
		<div id="checklist">
		<img id="check-image"src='/image/icon/check.png'>
		<label class='left-side-title'>Checklist</label>
		<button class="checkListInsertBtn" onclick="makeCheckListModal()">Add</button>
		<ul class="checkList"></ul>
		</div>
		
		
		<div id="modal">
			<div class="pop">
				<input id="inputCheckList" type="text">
				<button id="inputCheckListBtn" type="button" onclick="addLi()">Input</button>
				<button id ="closeCheckkList" type="button" onclick="closeCheckListModal()">Close</button>
			</div>
		</div>
		
		<div id="app">
		<img id="app-image"src='/image/icon/app.png'>
		<label class='left-side-title'>Useful Apps</label>
		<ul>
		    <li>Delivery
		 		<ul>
		            <li>Baemin</li>
		            <li>Yogiyo</li>
		        </ul>   
		    </li>
		    
		    <li>
		        Accommodation Booking
		        <ul>
		            <li>HotelsCombined</li>
					<li>Yanolja</li>
					<li>GC Company</li>
					<li>Airbnb</li>
		        </ul>
		    </li>
		    <li>Transportation
				<ul>
				   <li>KakaoMap</li>
				   <li>KakaoTaxi</li>
				   <li>TmoneyGO</li>
				   <li>NaverMap</li>
				</ul>
			</li>
		</ul>
		</div> 
	</div>

</div>
</main>
</body>
</html>