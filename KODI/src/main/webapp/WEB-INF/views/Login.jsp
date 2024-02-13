<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">

<link rel="stylesheet" href="/css/Login.css">
<script src="/js/jquery-3.7.1.min.js"></script>
<title>KODI</title>
<script>
$(document).ready(function(){
	let language = <%=session.getAttribute("loginLanguage")%>;

	if(language.value == "ko") {
		$("#languageSelect").val("ko").prop("selected", true);
	} else {
		$("#languageSelect").val("en").prop("selected", true);
		$("#email").text("Email");
		$("#inputEmail").attr("placeholder", "Email");
		$("#pw").text("Password");
		$("#inputPassword").attr("placeholder", "Password");
		$("#loginBtn").val("Login");
		$("#joinBtn").val("Join");
	}
	
	$("#languageSelect").change(function() {
		$.ajax({
			url: "/api/header/loginlanguage",
			data: {"language": $("#languageSelect").val()},
			type: "post",
			success: function(response){
				location.reload();
			},
			error: function(request, e){
				alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
			}
		});
    });
	
	document.getElementById('loginForm').addEventListener('submit', function(event) {
	  	var email = document.getElementById('inputEmail');
	  	if (email.value.length==0) { // 예를 들어 최대 100자로 제한
	    	alert('아이디를 입력해주세요');
	    	event.preventDefault(); // 제출을 막음
	  	}
	});
	
	$("#inputPassword").on('click', function(){
		$("#inputPassword").val("");
	});
	
	$(document).ready(function() {
	    $("#loginBtn").on('click', function(){
	        login();
	    });

	    $("#inputPassword").keypress(function(event) {
	        if (event.which === 13) { // 엔터 키를 눌렀을 때
	            login();
	        }
	    });

	    $("#inputEmail").keypress(function(event) {
	        if (event.which === 13) { // 엔터 키를 눌렀을 때
	            login();
	        }
	    });

	    function login() {
	    	/* 수정1 입력란 비었을 경우 */
	        if($("#inputEmail").val()==""){
	            alert("이메일을 입력해주세요");
	        } else if($("#inputPassword").val()==""){
	            alert("비밀번호를 입력해주세요");
	        } else {
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
	                    if (response == "로그인에 성공하였습니다") {
	                        location.href = "/api/home";
	                    } else if(response == "비밀번호를 확인해 주세요") {
	                        alert(response);
	                        $("#inputPassword").focus();
	                    } else if(response == "회원이 존재하지 않습니다"){
	                        alert(response);
	                        $("#inputEmail").focus();
	                    } else if(response == "관리자로 로그인 하였습니다"){
	                        location.href = "/api/admin/allposts";
	                    } else {
	                        alert("알 수 없는 오류");
	                    }
	                },
	                error: function(request, e){
	                    console.log("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
	                }
	            }); //ajax
	        }
	    }
	});

	/* 수정2 엔터키로 로그인 */
	/*  $("#loginBtn").on('click', function(){
		 
		 if($("#inputEmail").val()==""){
			 alert("이메일을 입력해주세요");
		 }else if($("#inputPassword").val()==""){
			 alert("비밀번호를 입력해주세요");
		 }else{
			 
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
		 }
	});//btn */
	
	
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
					<option id="ko" value="ko">한국어</option>
					<option id="en" value="en">English</option>
				</select>
				<a href="nonhome" id = "logo"><img id="logoImage" src="/image/icon/logo.png" ></a>
			
	</div>
</header>
	<div id="inner">
	<img src="/image/icon/friends.png">
		<form id="loginForm" method="post">
			<h3 id="email">이메일</h3>
		    <input type="text" id="inputEmail" name="inputEmail" placeholder="이메일" required><br><br>
		    
		    <h3 id="pw">비밀번호</h3>
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