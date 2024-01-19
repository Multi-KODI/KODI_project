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
<title>회원가입</title>

<script>
$(document).ready(function(){
	
	let confirmFlag = false;
	
	$("#confirmBtn").on('click', function(){
	    alert($("#inputEmail").val() + "@" + $("#emailLocation").val());
	    $.ajax({
	        url: "/api/email",
	        data: {
	            'email': $("#inputEmail").val() + "@" + $("#emailLocation").val()
	        },
	        type: "post",
	        success: function(response) {
	            if (response=="인증코드를 발송했습니다, 이메일을 확인해 주세요") {
	                alert(response);
	                $("#confirmCodeForm").html("<input type=\"text\" id=\"inputConfirmCode\" name=\"inputConfirmCode\" placeholder=\"인증코드 입력\" required>&nbsp;" +
	                    "<input type=\"button\" id=\"confirmCodeBtn\" value=\"확인\">");
	            } else {
	                alert("이미 사용중인 이메일 입니다.");
	            }
	        },
	        error: function(request, status, error) {
	            alert("코드: " + request.status + " 메시지: " + request.responseText + " 오류: " + error);
	        }
	    });
	});
	
 	$("#confirmCodeForm").on('click', "#confirmCodeBtn", function(){
		$.ajax({
			url:"/api/verify",
			data:{"inputOtp": $("#inputConfirmCode").val()},
			type:"post",
			success: function(response) {
		        if (response =="이메일이 인증되었습니다") {
		            alert(response);
		            confirmFlag = true;
		        } else {
		            alert("코드를 확인해주세요.");
		        }
		    },
		    error: function(xhr, textStatus, errorThrown) {
		        console.error("Error during login:", textStatus, errorThrown);
		    }
		});//ajax	
	});	//btn
	
	$("#joinBtn").on('click', function(){
		var dto = {
	        "email": $("#inputEmail").val() + "@" + $("#emailLocation").val(),
	        "pw": $("#inputPassword").val(),
	        "memberName": $("#inputNickname").val(),
	        "flagIdx": $("#nation").val()
	    };
		if(confirmFlag == true){
			$.ajax({
			    url:"/api/join",
			    data:  JSON.stringify(dto),
			    type:"post",
			    contentType : "application/json",
			    success: function(response) {
			        if (response=="회원등록이 완료되었습니다") {
			        	alert(response);
			            location.href = "login";
			        } else {
			            // 회원가입 실패
			            alert("회원가입 실패하였습니다.");
			        }
			    },
			    error: function(xhr, textStatus, errorThrown) {
			        console.error("Error during login:", textStatus, errorThrown);
			    }
			});//ajax

			}// if
			else{
				alert("이메일을 인증해주세요");	
			}
		});	//btn
		 
		$("#loginBtn").on('click', function(){
			location.href = "Login";	
		});	//btn
		
});	//ready

</script>
</head>
<body>
	<div id="inner">
		<form>
		<h4>이메일</h4>
	    <input type="text" id="inputEmail" name="inputEmail" placeholder="이메일" required>
	    &nbsp;<label>@</label>&nbsp;
	    <select name="emailLocation" id="emailLocation">
		    <option value="google.com">google.com</option>
		    <option value="naver.com" >naver.com</option>
		    <option value="daum.net" hidden>daum.net</option>
	  	</select>&nbsp;
	  	
	  	<input type="button" id="confirmBtn" value="인증코드"><br><br>
	    <div id="confirmCodeForm"></div>
	    
	    <h4>비밀번호</h4>
    	<input type="password" id="inputPassword" name="inputPassword" placeholder="비밀번호" required>
    	
	    <h4>닉네임</h4>
    	<input type="text" id="inputNickname" name="inputNikename" placeholder="닉네임" required>
    	
    	<h4>국적</h4>
    	<select name="nation" id="nation">
		    <option value="161">한국</option>
		    <option value="37">中国</option>
		    <option value="87">にほん</option>
		    <option value="8">USA</option>
		    <option value="184">UK</option>
	  	</select><br><br>
    	
    	<div id="garoBtns">
    		<input type="button" id="joinBtn" class="btn" value="회원가입">
    		&nbsp;&nbsp;&nbsp;&nbsp;
    		<input type="button" id="loginBtn" class="btn" value="로그인">
		</form>	
		</div>
</body>
</html>