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
		alert("Please log in");
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
		//websocket = new WebSocket("ws://localhost:7777/home");
		websocket = new WebSocket("ws://192.168.0.13:7777/home"); // 추후 ncp 배포 공인 IP로 변경
		
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
	
	function sendMsg() {
		// 웹소켓 서버로 데이터 보내는 부분
		let sendMsgInput = document.getElementById("sendMsgInput");

		if(sendMsgInput.value == ""){
			$("#sendMsgBtn").attr("disabled", false);
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
					alert("Code: " + request.status + "Message: " + request.responseText + "Error: " + e);
				}
			});
			console.log("웹소켓 서버에게 송신성공");
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
			<div class="guidetitle">🚌 Transportation and Mobility Guide</div>

			<div class="guidetext" id="guidetext1">
				<ul>
					<li>You can use various modes of transportation such as buses, subways, trains, taxis, etc.</li>
					<li>Please note that public transportation fares vary by region.</li>
				</ul>
			</div>

			<div id="chargebox">
				<table>
					<thead>
						<tr>
							<th>Transportation</th>
							<th>Payment Method</th>
							<th>Seoul</th>
							<th>Gwangju</th>
							<th>Daegu</th>
							<th>Daejeon</th>
							<th>Busan</th>
							<th>Ulsan</th>
							<th>Incheon</th>
							<th>Gangwon</th>
							<th>Gyeonggi</th>
							<th>Gyeongnam</th>
							<th>Gyeongbuk</th>
							<th>Jeonnam</th>
							<th>Jeonbuk</th>
							<th>Chungnam</th>
							<th>Chungbuk</th>
							<th>Jeju</th>
							<th>Sejong</th>
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
			<div class="guidetitle">🍲 Dining Culture and Etiquette</div>
			<div class="guidetext">
				<ul>
					<li>Please place your spoon and chopsticks beside your rice bowl. After finishing the meal, kindly put them on top of the rice bowl.</li>
					<li>It is customary not to hold rice or soup bowls in your hands. For soupy dishes, you may lift the bowl for easier consumption.</li>
					<li>We kindly ask that you refrain from eating food with your hands. Finger foods are an exception, and please use a wet tissue to clean your hands.</li>
					<li>While chewing your food, please remember to close your mouth and avoid making noise. It's polite not to speak while chewing.</li>
					<li>When seated at the table, it's considered polite not to rest your chin on your hand. Please maintain a proper posture.</li>
					<li>During the meal, we suggest refraining from using mobile phones, watching TV, or engaging in other distractions. Engaging in conversation with your dining companions is appreciated.</li>
					<li>Traditionally, elders start using utensils first, and it's customary to adjust your eating pace to match theirs.</li>
				</ul>
			</div>
		</div>
		


		<div class="guide" id="guide3">
			<div class="guidetitle">🚨 Safety and Handling Emergencies</div>
			<div class="guidetext">
				<ul>
					<li>The police emergency number is 112. Please don't hesitate to call if needed.</li>
					<li>The emergency reporting center number is 119. In case of any safety concerns, reach out immediately.</li>
					<li>Purchasing travel insurance for foreign travelers before your trip ensures peace of mind during your travels. For more details, please refer to <a href="https://seoul.sta.or.kr/m/plan/137789/foreign/2">this link</a>.</li>
					<li>When using a vehicle, it's important to wear seat belts for your safety. Never drive under the influence of alcohol.</li>
					<li>Prior to engaging in water activities, it's advisable to do warm-up exercises. Swimming or water activities after consuming alcohol or overeating are not recommended.</li>
					<li>Valuables and cash should be securely stored in a pouch or bag that can be worn close to your body for safekeeping.</li>
				</ul>
			</div>
		</div>
		

	</div>

	<div id="chatTitle">
		<img id="chatIcon" src="/image/icon/live-chat.png" align="center">Live Chatroom
	</div>
	<div id="allMsgList"></div>

	<div id="sendMsgDiv">
		<input id="sendMsgInput" type="text" placeholder="Please enter a message">
		<button id="sendMsgBtn" type="button">Send</button>
	</div>
</main>
</body>
</html>