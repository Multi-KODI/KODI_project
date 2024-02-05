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

				<button class="btn" id="registerbtn">Register</button>
				<button class="btn" id="loginbtn">Login</button>
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
		<a href="">All posts</a> 
		<a href="">Map service</a> 
		<a href="">Travel planner</a> 
		<a href="">Dining expenses by region</a>
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
		alert('You can use it after logging in');
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
    	alert('You can use it after logging in');
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