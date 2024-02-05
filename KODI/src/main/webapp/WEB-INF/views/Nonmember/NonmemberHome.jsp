<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/Nonmember/NonmemberHome.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="/js/jquery-3.7.1.min.js"></script>
<title>home</title>
</head>
<body>
<%@ include file="/WEB-INF/views/Nonmember/NonmemberHeader.jsp" %>
<%@ include file="/WEB-INF/views/Nonmember/NonmemberSearchHeader.jsp" %>

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





</main>


<script>
$(document).ready(function () {
    $("#menubar1, #menubar2, #menubar3, #menubar4").on("click", function () {
        alert('You can use it after logging in');
    });
});


</script>



</body>
</html>