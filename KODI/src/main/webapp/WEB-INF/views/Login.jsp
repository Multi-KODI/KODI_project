<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<title>로그인</title>


</head>
<body>
	<script>
$(document).ready(function(){
	$("#loginBtn").on('click', function(){
		$.ajax({
			url:"login",
			data:{"email": $("#email").val(),
				   "pw": $("#password").val()},
			type:"post",
			dataType:"json",
			success: function(response) {
		        if (response) {
		            // 로그인 성공
		        	location.href="Home";
		        } else {
		            // 로그인 실패
		            console.log("로그인 실패");
		        }
		    },
		    error: function(xhr, textStatus, errorThrown) {
		        console.error("Error during login:", textStatus, errorThrown);
		    }
		});//ajax	
	});	//btn
	
	$("#joinBtn").on('click', function(){
		location.href = "Join";	
	});	//btn
	
});	//ready
</script>
	<div id="inner">
		<form>
			<h4>이메일</h4>
		    <input type="text" id="inputEmail" name="inputEmail" placeholder="이메일" required><br><br>
		    
		    <h4>비밀번호</h4>
		    <input type="password" id="inputPassword" name="inputPassword" placeholder="비밀번호" required><br><br>
		    
		    <div id="garoBtns">
		    	<input type="button" id="loginBtn" class="btn" value="로그인">
		    	&nbsp;&nbsp;|&nbsp;&nbsp;
		    	<input type="button" id="joinBtn" class="btn" value="회원가입">
			</div>
		</form>
	</div>
</body>
</html>