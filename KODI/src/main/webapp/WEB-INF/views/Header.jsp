<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/Header.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="js/jquery-3.7.1.min.js"></script>
<title></title>
</head>

<body>
<script>
$(document).ready(function () {
    $("#menubtn").on("click", function () {
      $(".menu-content").slideToggle();
    });
    
    $("#mypagenbtn").on("click", function () {
        window.location.href = "/mypage";
      });
    
    $("#logoutbtn").on("click", function () {
    	if (confirm("로그아웃 하시겠습니까?")){
    		window.location.href = "/start";
    	}
    	else{}
      });
    
    
    $("#chat").on("click", function () {
        window.location.href = "/api/chat";
      });
    
    
  }); //ready

</script>

	<header>
		<div class="header-container">
			<div class="menu">
				<img src="/image/icon/menu.png" class="icon" id="menubtn">
			</div>

			<div class="end-btn">
				<img class="icon" id="notify" src="/image/icon/notify.png"> <img
					class="icon" id="chat" src="/image/icon/chat.png">
				<button class="btn" id="mypagenbtn">마이페이지</button>
				<button class="btn" id="logoutbtn">로그아웃</button>
				<div class="language-selection">
					<select>
						<option value="ko">한국어</option>
						<option value="en">English</option>
					</select>
				</div>
			</div>
		</div>
	</header>

	<div class="menu-content">
		<a href="/api/post">모든 게시글</a> 
		<a href="#">지도 서비스</a> 
		<a href="#">여행 플래너</a> 
		<a href="/api/diningcost">지역별 외식비</a>
	</div>







</body>
</html>