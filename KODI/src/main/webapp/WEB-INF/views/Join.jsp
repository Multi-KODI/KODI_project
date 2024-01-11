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


</head>

<body>
<script>
$(document).ready(function(){
	
	let confirmFlag = false;
	
	$("#confirmBtn").on('click', function(){
		$.ajax({
			url:"email",
			data:{"email": $("#inputEmail").val()+"@"+$("#emailLocation").val()},
			contentType : 'application/json; charset=utf-8',
			type:"post",
			dataType:"json",
			success: function(response) {
		        if (response) {
		            $("#confirmCodeForm").html("<input type=\"text\" id=\"inputConfirmCode\" name=\"inputConfirmCode\" placeholder=\"인증코드 입력\" required>&nbsp;"
		            +"<input type=\"button\" id=\"confirmCodeBtn\" value=\"확인\">");
		        } else {
		            //인증코드 전송 실패
		            alert("이미 사용중인 이메일 입니다.");
		        }
		    },
		    error: function(xhr, textStatus, errorThrown) {
		        console.error("Error during login:", textStatus, errorThrown);
		    }
		});//ajax	
	});	//btn
	
	$("#confirmCodeForm").on('click', "#confirmCodeBtn", function(){
		$.ajax({
			url:"verify",
			data:{"otp": $("#inputConfirmCode").val()},
			type:"post",
			dataType:"json",
			success: function(response) {
		        if (response) {
		            alert("인증되었습니다.")
		            confirmFlag = true;
		        } else {
		            //인증코드 전송 실패
		            alert("코드를 확인해주세요.");
		        }
		    },
		    error: function(xhr, textStatus, errorThrown) {
		        console.error("Error during login:", textStatus, errorThrown);
		    }
		});//ajax	
	});	//btn
	
	$("#joinBtn").on('click', function(){
		if(confirmFlag == true){
			$.ajax({
			    url:"register",
			    data:{
			        "email": $("#inputEmail").val() + "@" + $("#emailLocation").val(),
			        "pw": $("#inputPassword").val(),
			        "membername": $("#inputNickname").val(),
			        "flagIdx": $("#nation").val()
			    },
			    type:"post",
			    dataType:"json",
			    success: function(response) {
			        if (response) {
			        	alert("회원가입 완료하였습니다.");
			            location.href = "Login";
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
				//$("#inputConfirmCode").focus();
				//!!!!인증코드 폼 안 연 상태에서 회원가입 버튼 누르면?
			}
		});	//btn
		
		$("#loginBtn").on('click', function(){
			location.href = "Login";	
		});	//btn
		
});	//ready

</script>
	<div id="inner">
		<form>
		<h4>이메일</h4>
	    <input type="text" id="inputEmail" name="inputEmail" placeholder="이메일" required>
	    &nbsp;<label>@</label>&nbsp;
	    <select name="emailLocation" id="emailLocation">
		    <option value="google">google.com</option>
		    <option value="naver" hidden>naver.com</option>
		    <option value="daum" hidden>daum.net</option>
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
	</div>
</body>
</html>