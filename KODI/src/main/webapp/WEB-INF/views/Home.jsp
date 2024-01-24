<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/Home.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<title>KODI</title>
</head>
<body>
	<script>
		let sessionId = <%=session.getAttribute("memberIdx")%>;
		
		$(document).ready(function() {
			$("#menubar1").on("click", function() {
				window.location.href = "/api/post";
			});

			$("#menubar2").on("click", function() {
				window.location.href = "#";
			});

			$("#menubar3").on("click", function() {
				window.location.href = "#";
			});

			$("#menubar4").on("click", function() {
				window.location.href = "/api/diningcost";
			});
			
			webSocket();

		}); //ready
		
		function webSocket(){
			websocket = null;

			if(websocket == null){
				websocket = new WebSocket("ws://localhost:7777/home");
				
				websocket.onopen = function(){console.log("웹소켓 연결성공");};
				websocket.onclose = function(){console.log("웹소켓 해제성공");};
				websocket.onmessage = function(event){ // 서버로부터 데이터 받는 부분
					console.log("웹소켓 서버로부터 수신성공");
					
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
						data: {"memberIdx": sessionId},
						type: "post",
						dataType: "text",
						success: function(response){
							oneMsg = document.createElement("div");
							
							friendName = document.createElement("p");
							friendName.setAttribute("id", "friendName");
							friendName.innerHTML = response;
							
							content = document.createElement("p");
							content.setAttribute("id", "content");
							content.innerHTML = event.data;

							regdate = document.createElement("p");
							regdate.setAttribute("id", "regdate");
							regdate.innerHTML = dateString + " " + timeString;
							
							oneMsg.appendChild(friendName);
							oneMsg.appendChild(content);
							oneMsg.appendChild(regdate);

							oneMsg.innerHTML += "<hr>";
							
							allMsgList.appendChild(oneMsg);
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
					let msg = sendMsgInput.value;			
					websocket.send(msg);
					sendMsgInput.value = "";
					console.log("웹소켓 서버에게 송신성공");
				};			
			});
		};
	</script>

	<%@ include file="/WEB-INF/views/Header.jsp"%>
	<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

	<main>

		<div class="menubox">
			<div class="menubar" id="menubar1">
				<img class="menuicon" id="pageicon" src="/image/icon/blank-page.png">
			</div>

			<div class="menubar" id="menubar2">
				<img class="menuicon" id="mapicon" src="/image/icon/map.png">

			</div>

			<div class="menubar" id="menubar3">
				<img class="menuicon" id="palnicon" src="/image/icon/planer.png">
			</div>

			<div class="menubar" id="menubar4">
				<img class="menuicon" id="moneyicon" src="/image/icon/money.png">
			</div>
		</div>

		<div class="guidebox">
			<div class="guide" id="guide1">
				<div class="guidetitle">교통 및 이동 수단 안내</div>

				<div class="guidetext">
					<ul>
						<li>이용 가능 이동 수단</li>
						<li>버스, 지하철, 기차, 택시</li>
					</ul>
				</div>

				<div id="chargebox">
					<img src="/image/charge.png">
				</div>
			</div>

			<div class="guide" id="guide2">
				<div class="guidetitle">식사 문화와 에티켓</div>
				<div class="guidetext">
					<ul>
						<li>식사 중 숟가락과 젓가락은 반찬 그릇 위에 걸쳐 놓지 않는다.</li>
						<li>밥그릇, 국그릇을 손으로 들고 먹지 않는다.</li>
						<li>음식을 손으로 집어 먹지 않는다.</li>
						<li>음식을 씹을 때는 입을 다물고 씹으며, 소리를 내지 않는다.</li>
						<li>식탁에서 턱을 괴지 않는다.</li>
						<li>식사 중에 책, 신문, TV 등을 보지 않는다.</li>
						<li>어른이 먼저 수저를 드신 후에 식사를 시작하고 속도를 맞춘다.</li>
					</ul>
				</div>
			</div>


			<div class="guide" id="guide3">
				<div class="guidetitle">안전 및 응급 상황 대처</div>
				<div class="guidetext">
					<ul>
						<li>경찰서 - 112</li>
						<li>안전신고센터 - 119</li>
						<li>외국인여행자보험</li>
						<li><a href="https://seoul.sta.or.kr/m/plan/137789/foreign/2">https://seoul.sta.or.kr/m/plan/137789/foreign/2</a></li>
						<li>차량 이용 시 반드시 안전벨트 착용</li>
						<li>물놀이 전 준비운동은 필수</li>
						<li>음주, 과식 후 물놀이는 절대 금지</li>
						<li>귀중품 및 현금 등의 분실사고에 유의</li>
					</ul>
				</div>
			</div>

		</div>

		<div id="chatTitle">
			<img id="chatIcon" src="/image/icon/live-chat.png" align="center">실시간
			채팅방
		</div>
		<div id="allMsgList"></div>

		<div id="sendMsgDiv">
			<input id="sendMsgInput" type="text" placeholder="메시지를 입력하시오">
			<button id="sendMsgBtn" type="button">전송</button>
		</div>
	</main>
</body>
</html>