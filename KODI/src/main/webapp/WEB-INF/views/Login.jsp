<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">

<link rel="stylesheet" href="/css/Login.css">
<script src="/js/jquery-3.7.1.min.js"></script>
<title>로그인</title>
<script>
$(document).ready(function(){
	
	
	$("#inputPassword").on('click', function(){
		$("#inputPassword").val("");
	});
	
	 $("#loginBtn").on('click', function(){
		 var data = {
					email: $("#inputEmail").val(),
		            pw: $("#inputPassword").val()
		            };
		 
	        $.ajax({
	            url: "/api/login",
	            data: JSON.stringify(data),
	            contentType : 'application/json; charset=utf-8',
	            type: "post",
	            success: function(response) {
	               		
	                    if (response == "로그인에 성공하였습니다") {// 로그인이 성공
	                    	location.href = "/api/home";
	                    } else if(response == "비밀번호를 확인해 주세요") {// 로그인이 실패(비밀번호 잘못입력)
	                    	alert(response);
	                    	$("#inputPassword").focus();
	                    }else if(response == "회원이 존재하지 않습니다"){
	                    	alert(response);
	                    	$("#inputEmail").focus();
	                    }else if(response == "관리자로 로그인 하였습니다"){
	                    	location.href = "/api/admin/allposts";
	                    }else{
	                    	alert("알 수 없는 오류");
	                    }
	                
	            },
	            error: function(request, e){
					console.log("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
				}
	        }); //ajax
	    });//btn
	
	
	$("#joinBtn").on('click', function(){
		location.href = "/api/join";	
	});	//btn
	
	

});	//ready
</script>
</head>
<body>
<header>
	<div class="header-container">
	
				<select id="languageSelect">
					<option value="ko">한국어</option>
					<option value="en">English</option>
				</select>
				<a href="nonhome" id = "logo"><img id="logoImage" src="/image/icon/logo.png" ></a>
			
	</div>
</header>
	<div id="inner">
	<img src="/image/icon/friends.png">
		<form id="loginForm" method="post">
			<h3>이메일</h3>
		    <input type="text" id="inputEmail" name="inputEmail" placeholder="이메일" required><br><br>
		    
		    <h3>비밀번호</h3>
		    <input type="password" id="inputPassword" name="inputPassword" placeholder="비밀번호" required><br><br>
		    
		    <div id="garoBtns">
		    	<input type="button" id="loginBtn" class="btn" value="로그인">
		    	&nbsp;&nbsp;|&nbsp;&nbsp;
		    	<input type="button" id="joinBtn" class="btn" value="회원가입">
			</div>
		</form><br><br><br>
	</div>
</body>
</html>