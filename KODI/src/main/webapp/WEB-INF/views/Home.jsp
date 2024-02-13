<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	if(${isSession} == false) {
		alert("로그인하세요");
		location.href = "/";
	} else {
		$("#menubar1").on("click", function() {
			window.location.href = "/api/posts/food";
		});

		$("#menubar2").on("click", function() {
			window.location.href = "/api/map";
		});

		$("#menubar3").on("click", function() {
			window.location.href = "/api/planner";
		});

		$("#menubar4").on("click", function() {
			window.location.href = "/api/diningcost";
		});
		
		showData();
		webSocket();
		
		$('#allMsgList').scrollTop($('#allMsgList')[0].scrollHeight);	
	}
}); //ready

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
	websocket = null;

	if(websocket == null){
		websocket = new WebSocket("ws://localhost:7777/home");
		//websocket = new WebSocket("ws://192.168.0.13:7777/home"); // 추후 ncp 배포 공인 IP로 변경
		
		websocket.onopen = function(){console.log("웹소켓 연결성공");};
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
	
	$("#sendMsgInput").on("keypress", function(e){
		if(e.keyCode == 13) {
			sendMsg();				
		};
	});
	
	$("#sendMsgBtn").on("click", function(){
		sendMsg();
	});
	
	function sendMsg() {
		// 웹소켓 서버로 데이터 보내는 부분
		let sendMsgInput = document.getElementById("sendMsgInput");

		if(sendMsgInput.value == ""){
			$("#sendMsgBtn").attr("disabled", false);
		} else {
			if(sendMsgInput.value.length > 100) {
				alert("100자 이하로 작성해주세요");
			} else {
				let sendData = [sendMsgInput.value, sessionId];
				websocket.send(sendData);
				
				$.ajax({
					url: "/api/home/savemsg",
					data: {"memberIdx": sessionId, "content": sendMsgInput.value},
					type: "post",
					success: function(response){
						sendMsgInput.value = "";
						console.log("메시지 DB 저장 성공");
					},
					error: function(request, e){
						alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
					}
				});
				console.log("웹소켓 서버에게 송신성공");
			}
		};
	};
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
			<div class="guidetitle">🚌 교통 및 이동 수단 안내</div>

			<div class="guidetext" id="guidetext1">
				<ul>
					<li>버스, 지하철, 기차, 택시 등 다양한 교통수단을 이용할 수 있습니다.</li>
					<li>대중교통은 지역별로 요금이 다르니 참고 하세요.</li>
				</ul>
			</div>

			<div id="chargebox">
				<table>
					<thead>
						<tr>
							<th>교통수단</th>
							<th>결제수단</th>
							<th>서울</th>
							<th>광주</th>
							<th>대구</th>
							<th>대전</th>
							<th>부산</th>
							<th>울산</th>
							<th>인천</th>
							<th>강원</th>
							<th>경기</th>
							<th>경남</th>
							<th>경북</th>
							<th>전남</th>
							<th>전북</th>
							<th>충남</th>
							<th>충북</th>
							<th>제주</th>
							<th>세종</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="vehicle" items="${vehicleList}">
						<tr>
							<td>${vehicle.vehicleType}</td>
							<td>${vehicle.paymentType}</td>
							<td>${vehicle.seoulCost == 0 ? '-' : vehicle.seoulCost}</td>
							<td>${vehicle.gwangjuCost == 0 ? '-' : vehicle.gwangjuCost}</td>
							<td>${vehicle.daeguCost == 0 ? '-' : vehicle.daeguCost}</td>
							<td>${vehicle.daejeonCost == 0 ? '-' : vehicle.daejeonCost}</td>
							<td>${vehicle.busanCost == 0 ? '-' : vehicle.busanCost}</td>
							<td>${vehicle.ulsanCost == 0 ? '-' : vehicle.ulsanCost}</td>
							<td>${vehicle.incheonCost == 0 ? '-' : vehicle.incheonCost}</td>
							<td>${vehicle.gangwonCost == 0 ? '-' : vehicle.gangwonCost}</td>
							<td>${vehicle.gyeonggiCost == 0 ? '-' : vehicle.gyeonggiCost}</td>
							<td>${vehicle.gyeongnamCost == 0 ? '-' : vehicle.gyeongnamCost}</td>
							<td>${vehicle.gyeongbukCost == 0 ? '-' : vehicle.gyeongbukCost}</td>
							<td>${vehicle.jeonnamCost == 0 ? '-' : vehicle.jeonnamCost}</td>
							<td>${vehicle.jeonbukCost == 0 ? '-' : vehicle.jeonbukCost}</td>
							<td>${vehicle.chungnamCost == 0 ? '-' : vehicle.chungnamCost}</td>
							<td>${vehicle.chungbukCost == 0 ? '-' : vehicle.chungbukCost}</td>
							<td>${vehicle.jejuCost == 0 ? '-' : vehicle.jejuCost}</td>
							<td>${vehicle.sejongCost == 0 ? '-' : vehicle.sejongCost}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="guide" id="guide2">
			<div class="guidetitle">🍲 식사 문화와 에티켓</div>
			<div class="guidetext">
				<ul>
					<li>숟가락과 젓가락은 밥그릇 옆에 놓습니다. 식사가 끝나면 밥그릇 위에 놓습니다.</li>
					<li>밥그릇이나 국그릇을 손으로 들고 먹지 않습니다. 국물이 많은 국이나 찌개는 들어서 먹을 수 있습니다.</li>
					<li>음식을 손으로 집어 먹지 않습니다. 손으로 먹을 수 있는 음식만 가능하며 물티슈로 손을 닦아야 합니다.</li>
					<li>음식을 씹을 때는 입을 다물고 소리를 내지 않습니다. 음식을 씹는 동안에는 말을 하지 않습니다.</li>
					<li>식탁에서 턱을 괴지 않습니다. 식탁에서는 바른 자세로 앉아야 합니다.</li>
					<li>식사 중에는 핸드폰, TV 등을 보지 않습니다. 함께 식사 중인 사람들과 대화를 나누는 것이 좋습니다.</li>
					<li>어른이 먼저 수저를 드신 후에 식사를 시작하고 속도를 맞춥니다.</li>
				</ul>
			</div>
		</div>


		<div class="guide" id="guide3">
			<div class="guidetitle">🚨 안전 및 응급 상황 대처</div>
			<div class="guidetext">
				<ul>
					<li>경찰서 전화번호는 112입니다.</li>
					<li>안전신고센터 전화번호는 119입니다.</li>
					<li>외국인 여행자 보험은 여행 전에 가입하면 여행 중에 안심하고 즐길 수 있습니다. 
					<a href="https://seoul.sta.or.kr/m/plan/137789/foreign/2">자세한
							내용은 여기를 참고하세요.</a></li>
					<li>차량 이용 시 안전벨트를 착용합니다. 음주운전은 절대 하지 않습니다.</li>
					<li>물놀이 전 준비운동은 필수입니다. 음주, 과식 후 물놀이는 금지입니다.</li>
					<li>귀중품 및 현금은 몸에 붙이는 보관용 주머니나 가슴에 걸 수 있는
						가방에 넣어 안전하게 보관합니다.</li>
				</ul>
			</div>
		</div>

	</div>

	<div id="chatTitle">
		<img id="chatIcon" src="/image/icon/live-chat.png" align="center">실시간 채팅방
	</div>
	<div id="allMsgList"></div>

	<div id="sendMsgDiv">
		<input id="sendMsgInput" type="text" placeholder="메시지를 입력하시오">
		<button id="sendMsgBtn" type="button">전송</button>
	</div>
</main>

<%@ include file="/WEB-INF/views/Footer.jsp" %>
</body>
</html>