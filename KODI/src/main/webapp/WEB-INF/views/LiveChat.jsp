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
		verifyMember();
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
					alert("해당 채팅방에 입장할 수 없습니다.");
					location.href = "/api/chatlist/" + sessionId;
				}
			},
			error: function(request, e){
				alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
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
			
			friendName = document.createElement("p");
			friendName.setAttribute("id", "friendName");
			friendName.innerHTML = "${one.memberName}";
			
			content = document.createElement("p");
			content.setAttribute("id", "content");
			
			json = JSON.parse('${one.chatMsgDTO.content}');
			
			content.innerHTML = json.message.result.translatedText;
			
			regdate = document.createElement("p");
			regdate.setAttribute("id", "regdate");
			regdate.innerHTML = "${one.chatMsgDTO.regdate}";
			
			oneMsg.appendChild(friendName);
			oneMsg.appendChild(content);
			oneMsg.appendChild(regdate);

			oneMsg.innerHTML += "<hr>";
			
			allMsgList.appendChild(oneMsg);
		</c:forEach>
	};
		
	function webSocket(){
		let websocket = null;
		
		if(websocket == null){
			//websocket = new WebSocket("ws://localhost:7777/chatroom");
			//websocket = new WebSocket("ws://192.168.0.13:7777/chatroom", "${chatIdx}");
			websocket = new WebSocket("ws://192.168.0.13:7777/chatroom");
			
			websocket.onopen = function(){
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
								let json = JSON.parse(translatemsg);
								
								oneMsg = document.createElement("div");
								
								friendName = document.createElement("p");
								friendName.setAttribute("id", "friendName");
								friendName.innerHTML = membername;
								
								content = document.createElement("p");
								content.setAttribute("id", "content");
								content.innerHTML = json.message.result.translatedText;

								regdate = document.createElement("p");
								regdate.setAttribute("id", "regdate");
								regdate.innerHTML = dateString + " " + timeString;
								
								oneMsg.appendChild(friendName);
								oneMsg.appendChild(content);
								oneMsg.appendChild(regdate);

								oneMsg.innerHTML += "<hr>";
								
								allMsgList.appendChild(oneMsg);
								//location.reload();
							},
							error: function(request, e){
								alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
							}
						});
					},
					error: function(request, e){
						alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
					}
				});
			};
		};
		
		$("#sendMsgBtn").on("click", function(){
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
						alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
					}
				});
				console.log("웹소켓 서버에게 송신성공");
			};			
		});
		
		$("#exitChat").on("click", function(){
			websocket.send(${chatIdx});
			websocket.close();
			location.href = "/api/chatlist/" + sessionId;
		});
	};
</script>

<body>
	<!-- 헤더 -->
	<%@ include file="/WEB-INF/views/Header.jsp"%>
	<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

	<button id="exitChat" type="button">
		<img id="exitIcon" src="/image/icon/exit-chat.png" align="center">
		<p id="exitMsg">채팅방 나가기</p>
	</button>

	<div id="allMsgList"></div>

	<div id="sendMsgDiv">
		<input id="sendMsgInput" type="text" placeholder="메시지를 입력하시오">
		<button id="sendMsgBtn" type="button">전송</button>
	</div>
</body>
</html>