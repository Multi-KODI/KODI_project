<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>KODI</title>

<link href="/css/LiveChat.css" rel="stylesheet">

<script src="/js/jquery-3.7.1.min.js"></script>

</head>

<script>
	let sessionId = <%=session.getAttribute("memberIdx")%>;
	
	$(document).ready(function(){
		if(${isSession} == false) {
			alert("Please log in");
			location.href = "/";
		} else {
			verifyMember();			
		}
	});
	
	function verifyMember(){
		// 해당 채팅방에 들어올 수 있는 사용자 권한 제한
		$.ajax({
			url: "/api/chatroom/verifymember",
			data: {"memberIdx": sessionId, "chatIdx": ${chatIdx}},
			type: "post",
			success: function(response){
				if(response == 1){
					showData();
					webSocket();
			} else {
					alert("Access to this chat room is not possible.");
					location.href = "/api/chatlist/" + sessionId;
				}
			},
			error: function(request, e){
				alert("Code: " + request.status + "Message: " + request.responseText + "Error: " + e);
			}
		});
	};
	
	function showData() {
		let allMsgList = document.getElementById("allMsgList");
		
		let oneMsg;
		let friendName;
		let content;
		let regdate;
		let json;
		
		<c:forEach items="${allChatMsg}" var="one">
			oneMsg = document.createElement("div");
			oneMsg.setAttribute("id", "${one.chatMsgDTO.chatMsgIdx}");
			oneMsg.setAttribute("style", "display: inline;");
			
			friendName = document.createElement("p");
			friendName.setAttribute("id", "friendName");
			friendName.innerHTML = "${one.memberName}";
			
			content = document.createElement("p");
			content.setAttribute("id", "content");
			
			//json = JSON.parse('${one.chatMsgDTO.content}');
			//content.innerHTML = json.message.result.translatedText;
			
			content.innerHTML = '${one.chatMsgDTO.content}';
			
			if(sessionId == "${one.chatMsgDTO.memberIdx}"){
				friendName.setAttribute("style", "float: right;");
				
				if('${one.chatMsgDTO.content}'.length < 35) {
					content.setAttribute("style", "margin-bottom: 5px; border: 2px solid #F8E8EE; background-color: #F8E8EE; float: right;");					
				} else {
					content.setAttribute("style", "margin-bottom: 15px; text-align: left; width: 350px; word-break: break-all; border: 2px solid #F8E8EE; background-color: #F8E8EE; float: right;");
				}
			} else {
				friendName.setAttribute("style", "float: left;");
				
				if('${one.chatMsgDTO.content}'.length < 35) {
					content.setAttribute("style", "float: left;");
				} else {
					content.setAttribute("style", "text-align: left; width: 350px; float: left;");
				}
			}
			
			regdate = document.createElement("p");
			regdate.setAttribute("id", "regdate");
			regdate.innerHTML = "${one.chatMsgDTO.regdate}";
			
			if(sessionId == "${one.chatMsgDTO.memberIdx}"){
				regdate.setAttribute("style", "margin-right: 70px; float: right;");
			} else {
				regdate.setAttribute("style", "margin-left: 80px; float: left;");
			}
			
			oneMsg.appendChild(friendName);
			oneMsg.appendChild(content);

			oneMsg.innerHTML += "<br><br><br><br>";

			if('${one.chatMsgDTO.content}'.length >= 35 && '${one.chatMsgDTO.content}'.length < 40) {
				oneMsg.innerHTML += "<br>";
			};
			
			if('${one.chatMsgDTO.content}'.length >= 40 && '${one.chatMsgDTO.content}'.length < 45) {
				oneMsg.innerHTML += "<br><br>";
			};
			
			if('${one.chatMsgDTO.content}'.length >= 45 && '${one.chatMsgDTO.content}'.length < 61) {
				oneMsg.innerHTML += "<br><br><br>";
			};
			
			if('${one.chatMsgDTO.content}'.length >= 61 && '${one.chatMsgDTO.content}'.length < 70) {
				oneMsg.innerHTML += "<br><br><br><br>";
			};
			
			if('${one.chatMsgDTO.content}'.length >= 70 && '${one.chatMsgDTO.content}'.length < 89) {
				oneMsg.innerHTML += "<br><br><br>";
			};
			
			if('${one.chatMsgDTO.content}'.length >= 89 && '${one.chatMsgDTO.content}'.length < 100) {
				oneMsg.innerHTML += "<br><br><br><br>";
			};
			
			if('${one.chatMsgDTO.content}'.length >= 100) {
				oneMsg.innerHTML += "<br><br><br><br><br>";
			};
			
			oneMsg.appendChild(regdate);

			oneMsg.innerHTML += "<br><br>";
			
			allMsgList.appendChild(oneMsg);
		</c:forEach>
		
		$('#allMsgList').scrollTop($('#allMsgList')[0].scrollHeight);
	};

	function webSocket(){
		let websocket = null;
		
		if(websocket == null){
			//websocket = new WebSocket("ws://localhost:7777/chatroom");
			websocket = new WebSocket("ws://192.168.0.13:7777/chatroom"); // 추후 ncp 배포 공인 IP로 변경
			
			websocket.onopen = function() {
				console.log("웹소켓 연결성공");
				websocket.send(${chatIdx});
			};
			websocket.onclose = function(){console.log("웹소켓 해제성공");};
			websocket.onmessage = function(event){ // 서버로부터 데이터 받는 부분
				console.log("웹소켓 서버로부터 수신성공");
				
				let sendInfo = event.data.split(",");

				var nowDate = new Date();
				
				var year = nowDate.getFullYear();
				var month = ('0' + (nowDate.getMonth() + 1)).slice(-2);
				var day = ('0' + nowDate.getDate()).slice(-2);
				
				var hours = ('0' + nowDate.getHours()).slice(-2); 
				var minutes = ('0' + nowDate.getMinutes()).slice(-2);
				var seconds = ('0' + nowDate.getSeconds()).slice(-2); 

				var dateString = year + '-' + month  + '-' + day;
				var timeString = hours + ':' + minutes  + ':' + seconds;
								
				let allMsgList = document.getElementById("allMsgList");
				
				let oneMsg;
				let friendName;
				let content;
				let regdate;
												
				$.ajax({
					url: "/api/chatroom/showmembername",
					data: {"memberIdx": sendInfo[1]},
					type: "post",
					dataType: "text",
					success: function(membername){
						$.ajax({
							url: "/api/chatroom/translatemsg",
							data: {"sendMemberIdx": sendInfo[1] ,"msg": sendInfo[0]},
							type: "post",
							dataType: "text",
							success: function(translatemsg){
								//let json = JSON.parse(translatemsg);
								
								oneMsg = document.createElement("div");
								
								friendName = document.createElement("p");
								friendName.setAttribute("id", "friendName");
								friendName.innerHTML = membername;
								
								content = document.createElement("p");
								content.setAttribute("id", "content");
								
								//content.innerHTML = json.message.result.translatedText;
								content.innerHTML = translatemsg;
								
								if(sessionId == sendInfo[1]){
									friendName.setAttribute("style", "float: right;");
									
									if(translatemsg.length < 35) {
										content.setAttribute("style", "margin-bottom: 5px; border: 2px solid #F8E8EE; background-color: #F8E8EE; float: right;");					
									} else {
										content.setAttribute("style", "margin-bottom: 15px; text-align: left; width: 350px; word-break: break-all; border: 2px solid #F8E8EE; background-color: #F8E8EE; float: right;");
									}
								} else {
									friendName.setAttribute("style", "float: left;");
									
									if(translatemsg.length < 35) {
										content.setAttribute("style", "float: left;");
									} else {
										content.setAttribute("style", "text-align: left; width: 350px; float: left;");
									}
								}

								regdate = document.createElement("p");
								regdate.setAttribute("id", "regdate");
								regdate.innerHTML = dateString + " " + timeString;
								
								if(sessionId == sendInfo[1]){
									regdate.setAttribute("style", "margin-right: 70px; float: right;");
								} else {
									regdate.setAttribute("style", "margin-left: 80px; float: left;");
								}
								
								oneMsg.appendChild(friendName);
								oneMsg.appendChild(content);

								oneMsg.innerHTML += "<br><br><br><br>";
								
								if(translatemsg.length >= 35 && translatemsg.length < 40) {
									oneMsg.innerHTML += "<br>";
								};
								
								if(translatemsg.length >= 40 && translatemsg.length < 45) {
									oneMsg.innerHTML += "<br><br>";
								};
								
								if(translatemsg.length >= 45 && translatemsg.length < 61) {
									oneMsg.innerHTML += "<br><br><br>";
								};
								
								if(translatemsg.length >= 61 && translatemsg.length < 70) {
									oneMsg.innerHTML += "<br><br><br><br>";
								};
								
								if(translatemsg.length >= 70 && translatemsg.length < 89) {
									oneMsg.innerHTML += "<br><br><br>";
								};
								
								if(translatemsg.length >= 89 && translatemsg.length < 100) {
									oneMsg.innerHTML += "<br><br><br><br>";
								};
								
								if(translatemsg.length >= 100) {
									oneMsg.innerHTML += "<br><br><br><br><br>";
								};
								
								oneMsg.appendChild(regdate);

								oneMsg.innerHTML += "<br><br>";
								
								allMsgList.appendChild(oneMsg);
								
								$('#allMsgList').scrollTop($('#allMsgList')[0].scrollHeight);
							},
							error: function(request, e){
								alert("Code: " + request.status + "Message: " + request.responseText + "Error: " + e);
							}
						});
					},
					error: function(request, e){
						alert("Code: " + request.status + "Message: " + request.responseText + "Error: " + e);
					}
				});
			};
		};
		
		$("#sendMsgInput").on("keypress", function(e){
			if(e.keyCode == 13) {
				sendMsg();				
			};
		});
		
		$("#sendMsgBtn").on("click", function(){
			sendMsg();
		});
		
		$("#exitChat").on("click", function(){
			websocket.send(${chatIdx});
			websocket.close();
			location.href = "/api/chatlist/" + sessionId;
		});
		
		function sendMsg() {
			// 웹소켓 서버로 데이터 보내는 부분
			let sendMsgInput = document.getElementById("sendMsgInput");

			if(sendMsgInput.value == ""){
				$("#sendMsgBtn").attr("disabled", false);
			} else {
				let sendData = [sendMsgInput.value, sessionId, ${chatIdx}];
				websocket.send(sendData);
				
				var data = {memberIdx: sessionId, chatIdx: ${chatIdx}, content: sendMsgInput.value};

				$.ajax({
					url: "/api/chatroom/savemsg",
					data: JSON.stringify(data),
					type: "post",
					contentType: "application/json",
					dataType: "json",
					success: function(response){
						sendMsgInput.value = "";
						console.log("메시지 DB 저장 성공");
					},
					error: function(request, e){
						alert("Code: " + request.status + "Message: " + request.responseText + "Error: " + e);
					}
				});
				console.log("웹소켓 서버에게 송신성공");
			};
		};
	};
</script>

<body>
	<!-- 헤더 -->
	<%@ include file="/WEB-INF/views/Header.jsp"%>
	<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

	<button id="exitChat" type="button">
		<img id="exitIcon" src="/image/icon/exit-chat.png" align="center">
		<p id="exitMsg">Go back</p>
	</button>

	<div id="allMsgList"></div>

	<div id="sendMsgDiv">
		<input id="sendMsgInput" type="text" placeholder="Please enter a message">
		<button id="sendMsgBtn" type="button">Send</button>
	</div>
</body>
</html>