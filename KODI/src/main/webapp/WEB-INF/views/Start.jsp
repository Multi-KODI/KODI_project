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
				<button id="loginbtn">로그인</button>
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
			<button class="joinbtn" id="joinbtn">회원가입</button>
			<button class="nonjoinbtn" id="nonjoinbtn">비회원</button>
		</div>
		<div class="image-container">
			환영합니다!<br> <br> KoDi(Korea-Director)는 여러분이 한국 여행을<br>
			더욱 편리하게 즐길 수 있도록<br> 경험을 공유하고 소통하는 플랫폼입니다.<br>
		</div>
	</main>


	<!--page -->
	<div class="page1-box">
		<div class="textbox">
			<p id="title">🗺 지도로 여행 정보 확인하기</p>
			<p id="content">
				한눈에 지역별 게시글 수, 친구의 마킹으로<br> 추천 핫플을 확인하세요!<br>
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
			<p id="title">📱 커뮤니티로 소통하기</p>
			<p id="content">
				나만 알고 있었던 맛집이나<br> 카페, 놀거리, 숙소에 대한 후기를를<br> 다양한 여행자들과
				공유하세요.<br>
			</p>
		</div>
	</div>

	<div class="page1-box">
		<div class="textbox">
			<p id="title">📅 일정 관리 서비스</p>
			<p id="content">
				여행 일정, 체크리스트,예산 등을<br> 손쉽게 관리하세요.<br>
			</p>
		</div>
		<div class="imgbox">
			<img src="/image/page3.jpg">
		</div>
	</div>

	<div class="page1-box">
		<div class="textbox">
			<p id="title">💬 다국어 실시간 채팅</p>
			<p id="content">
				언어의 장벽을 넘어, 여행 이야기를<br> 다양한 유저들과 즐겨보세요.<br> papago와 함께합니다!<br>
			</p>
		</div>

		<div class="textbox">
			<p id="title">💡 외식비 정보 제공</p>
			<p id="content">
				맛집을 찾아가기 전에 ..<br> 한국소비자원 데이터를 통해<br> 음식 가격 정보를 확인하세요.<br>
			</p>
		</div>
	</div>


	<div class="page2-box">
		<div class="textbox">
			<p id="title">
				KoDi는 기다리고 있어요<br>
			</p>
			준비가 되셨나요? 회원가입을 하려면 이메일 주소를 입력하세요.
		</div>
	</div>

	<div class="page3">
		<div class="join-input">
			<input type="text" placeholder="이메일을 입력하세요">
			<button class="joinbtn" id="joinbtn2">회원가입</button>
			<button class="nonjoinbtn" id="nonjoinbtn2">비회원</button>
		</div>
	</div>



	<footer>
		<img src="/image/icon/logo.png" alt="KoDi"
			style="height: 30px; width: auto;"> © 2024 KoDi_project
	</footer>

</body>
</html>