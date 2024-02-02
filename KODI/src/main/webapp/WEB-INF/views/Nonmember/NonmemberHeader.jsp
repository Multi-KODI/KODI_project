<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/Nonmember/NonmemberHeader.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<title></title>
</head>

<body>
	<header>
		<div class="header-container">
			<div class="menu">
				<img src="/image/icon/menu.png" class="icon" id="menubtn">
			</div>

			<div class="end-btn">

				<button class="btn" id="registerbtn">회원가입</button>
				<button class="btn" id="loginbtn">로그인</button>
				<!-- <div class="language-selection">
					<select>
						<option value="ko">한국어</option>
						<option value="en">English</option>
					</select>
				</div> -->
			</div>
		</div>
	</header>

	<div class="menu-content">
		<a href="">모든 게시글</a> 
		<a href="">지도 서비스</a> 
		<a href="">여행 플래너</a> 
		<a href="">지역별 외식비</a>
	</div>
	
	<button id="topBtn">
		<img src="/image/icon/topicon.png"> 
	</button>



<script>
$(document).ready(function () {
	function updateMenuContentPosition() { //메뉴위치
	    var menuOffset = $(".menu").offset(); 
	    $(".menu-content").css({'left': menuOffset.left }); 
	}
	
	$("#menubtn").on("click", function () { //메뉴열기
		alert('로그인 후 이용하실 수 있습니다.');
		//updateMenuContentPosition();
	   // $(".menu-content").slideToggle(); 
	});
	
	$(window).on('resize', function(){ //윈도우창 크기에 따라 변화
	    if($(".menu-content").is(":visible")) {
	        updateMenuContentPosition();
	    }

	});
	
	$("#registerbtn").on("click", function (event) {
		window.location.href = "/api/join";
	});

    
    $("#loginbtn").on("click", function () {
    	window.location.href = "/api/login";
      });
    
    
    $("#chat").on("click", function () {
    	alert('로그인 후 이용하실 수 있습니다.');
      });
    
    let topBtn = document.getElementById("topBtn");

    function topFunction() {
        document.body.scrollTop = 0; // Safari 용
        document.documentElement.scrollTop = 0; // Chrome, Firefox, IE 및 Opera 용
    }

    topBtn.addEventListener("click", topFunction);

    window.onscroll = function() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            topBtn.style.display = "block";
        } else {
            topBtn.style.display = "none";
        }
    };
    
    
    
  }); //ready

</script>



</body>
</html>