<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/Start.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<title>start</title>

<script>
$(document).ready(function () {
   	$("#loginbtn").on("click",function(){
   		window.location.href = "/api/login";
   	});
   
   	$(".joinbtn").on("click",function(){
   		window.location.href = "/api/join";
  	});
   	//email입력창에 넣은 값 가져오게 하기???ㅜㅜ
   
   	$(".nonjoinbtn").on("click",function(){
      	window.location.href = "/api/nonhome";
   	});
});

</script>
</head>



<body>
	<header>
		<!-- 고정형 헤더 -->
		<div class="header-container">
			<div class="login">
				<button id="loginbtn">Login</button>
			</div>
			<div class="language-selection">
				<select>
					<option value="ko">한국어</option>
					<option value="en">English</option>
				</select>
			</div>
		</div>
	</header>

	<main>
		<div class="logo-container">
			<img src="/image/icon/logo.png" alt="KoDi">
		</div>
		<!-- 회원가입 -->
		<div class="join-input">
			<input type="text" placeholder="이메일을 입력하세요">
			<button class="joinbtn" id="joinbtn">Register</button>
			<button class="nonjoinbtn" id="nonjoinbtn">Non-member</button>
		</div>
		<div class="image-container">
			Welcome!<br> <br> KoDi (Korea-Director) is a platform for you to<br>
			share and communicate experiences, making your<br> travel in Korea more convenient and enjoyable.<br>
		</div>
	</main>


	<!--page -->
	<div class="page1-box">
		<div class="textbox">
			<p id="title">🗺 Explore Travel Information on the Map</p>
			<p id="content">
				Get a quick overview of regional post counts and discover recommended hotspots<br> with your friends' markings on the map!<br>
			</p>
		</div>
		<div class="imgbox">
			<img src="/image/page1.jpg">
		</div>
	</div>
	

	<div class="page1-box">
		<div class="imgbox">
			<img src="/image/page2.jpg">
		</div>
		<div class="textbox">
			<p id="title">📱 Connect with the Community</p>
			<p id="content">
				Share your reviews of hidden gems in restaurants, cafes,<br> activities, and accommodations that you knew about<br> with various travelers.
			</p>
		</div>
	</div>

	<div class="page1-box">
		<div class="textbox">
			<p id="title">📅 Schedule Management Service</p>
			<p id="content">
				Easily manage your travel itinerary, checklists, budgets, and more.<br>
			</p>
		</div>
		<div class="imgbox">
			<img src="/image/page3.jpg">
		</div>
	</div>
	
	<div class="page1-box">
		<div class="textbox">
			<p id="title">💬 Multilingual Real-time Chat</p>
			<p id="content">
				Bridge the language gap and enjoy travel stories with diverse users.<br> Powered by Papago!<br>
			</p>
		</div>
	
		<div class="textbox">
			<p id="title">💡 Dining Cost Information</p>
			<p id="content">
				Before you head to a restaurant..<br> Check food price information<br> through Korea Consumer Agency data.<br>
			</p>
		</div>
	</div>
	
	<div class="page2-box">
		<div class="textbox">
			<p id="title">
				KoDi is waiting for you<br>
			</p>
			Are you ready? To sign up, please enter your email address.
		</div>
	</div>
	

	<div class="page3">
		<div class="join-input">
			<input type="text" placeholder="Please enter your email">
			<button class="joinbtn" id="joinbtn2">Register</button>
			<button class="nonjoinbtn" id="nonjoinbtn2">Non-Member</button>
		</div>
	</div>



	<footer>
		<img src="/image/icon/logo.png" alt="KoDi"
			style="height: 30px; width: auto;"> © 2024 KoDi_project
	</footer>

</body>
</html>